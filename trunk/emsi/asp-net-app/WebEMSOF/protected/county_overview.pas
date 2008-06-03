
unit county_overview;

interface

uses
  System.Collections, System.ComponentModel,
  System.Data, System.Drawing, System.Web, System.Web.SessionState,
  system.web.ui, ki_web_ui, System.Web.UI.WebControls, System.Web.UI.HtmlControls, kix, system.configuration, mysql.data.mysqlclient,
  system.web.security,
  Class_db;

const ID = '$Id$';

type
  p_type =
    RECORD
    db: TClass_db;
    END;
  TWebForm_county_overview = class(ki_web_ui.page_class)
  {$REGION 'Designer Managed Code'}
  strict private
    procedure InitializeComponent;
    procedure Button_continue_Click(sender: System.Object; e: System.EventArgs);
    procedure TWebForm_county_overview_PreRender(sender: System.Object;
      e: System.EventArgs);
  {$ENDREGION}
  strict private
    p: p_type;
    procedure Page_Load(sender: System.Object; e: System.EventArgs);
  strict protected
    Title: System.Web.UI.HtmlControls.HtmlGenericControl;
    PlaceHolder_precontent: System.Web.UI.WebControls.PlaceHolder;
    PlaceHolder_postcontent: System.Web.UI.WebControls.PlaceHolder;
    RadioButtonList_appropriation: System.Web.UI.WebControls.RadioButtonList;
    Button_continue: System.Web.UI.WebControls.Button;
    RequiredFieldValidator_appropriation: System.Web.UI.WebControls.RequiredFieldValidator;
  protected
    procedure OnInit(e: EventArgs); override;
  private
    { Private Declarations }
  public
    { Public Declarations }
  end;

implementation

{$REGION 'Designer Managed Code'}
/// <summary>
/// Required method for Designer support -- do not modify
/// the contents of this method with the code editor.
/// </summary>
procedure TWebForm_county_overview.InitializeComponent;
begin
  Include(Self.Button_continue.Click, Self.Button_continue_Click);
  Include(Self.Load, Self.Page_Load);
  Include(Self.PreRender, Self.TWebForm_county_overview_PreRender);
end;
{$ENDREGION}

procedure TWebForm_county_overview.Page_Load(sender: System.Object; e: System.EventArgs);
var
  dr: mysqldatareader;
  county_user_email_address: string;
  max_fiscal_year_id_string: string;
begin
  if IsPostback and (session['p'].GetType.namespace = p.GetType.namespace) then begin
    p := p_type(session['p']);
  end else begin
    if (session['county_user_id'] = nil) or (session['county_name'] = nil) then begin
      session.Clear;
      server.Transfer('~/login.aspx');
    end;
    Title.InnerText := configurationmanager.AppSettings['application_name'] + ' - county_overview';
    p.db := TClass_db.Create;
    //
    p.db.Open;
    dr := mysqlcommand.Create
      (
      'SELECT be_stale_password, password_reset_email_address FROM county_user'
      + ' where id = ' + session['county_user_id'].tostring,
      p.db.connection
      )
      .ExecuteReader;
    dr.Read;
    if dr['be_stale_password'].ToString = '0' then begin
      //
      // Get anything else needed from this reader, then close it.  We have another reader to open, and only one can be open at a
      // time.
      //
      county_user_email_address := dr['password_reset_email_address'].tostring;
      dr.Close;
      //
      // Where we go next depends on how many appropriations have been made to this county.
      //
      // Determine current fiscal year
      //
      max_fiscal_year_id_string := mysqlcommand.Create
        (
        'SELECT max(id) as max_id FROM fiscal_year',
        p.db.connection
        )
        .ExecuteScalar.tostring;
      //
      dr := mysqlcommand.Create
        (
        'SELECT region_dictated_appropriation.id,'
        + ' concat("$",format(region_dictated_appropriation.amount,2)," from the ",name," ",designator," contract (amendment ",amendment_num,")")'
        +   ' as appropriation_description'
        + ' FROM region_dictated_appropriation'
        +   ' JOIN state_dictated_appropriation on (state_dictated_appropriation.id=state_dictated_appropriation_id)'
        +   ' JOIN region_code_name_map on (region_code_name_map.code=region_code)'
        +   ' JOIN fiscal_year on (fiscal_year.id = fiscal_year_id)'
        + ' WHERE county_code = ' + session['county_user_id'].ToString
        +   ' and fiscal_year_id = ' + max_fiscal_year_id_string,
        p.db.connection
        )
        .ExecuteReader;
      while dr.Read do begin
        RadioButtonList_appropriation.Items.Add(listitem.Create(dr['appropriation_description'].tostring,dr['id'].ToString));
      end;
      dr.Close;
      p.db.Close;
      if RadioButtonList_appropriation.items.Count = 0 then begin
        DropCrumbAndTransferTo('no_appropriation.aspx');
      end else begin
        //
        // Add the county's email address to the session, as it will be needed by county_dictated_appropriations however we
        // get there.
        //
        session.Remove('county_user_password_reset_email_address');
        session.Add('county_user_password_reset_email_address',county_user_email_address);
        if RadioButtonList_appropriation.items.Count = 1 then begin
          session.Remove('region_dictated_appropriation_id');
          session.Add('region_dictated_appropriation_id',RadioButtonList_appropriation.items[0].value);
          DropCrumbAndTransferTo('county_dictated_appropriations.aspx');
        end;
      end;
    end else begin
      dr.Close;
      p.db.Close;
      DropCrumbAndTransferTo('change_password.aspx');
    end;
  end;
end;

procedure TWebForm_county_overview.OnInit(e: EventArgs);
begin
  //
  // Required for Designer support
  //
  InitializeComponent;
  inherited OnInit(e);
  //
  BeginBreadCrumbTrail;
  //
end;

procedure TWebForm_county_overview.TWebForm_county_overview_PreRender(sender: System.Object;
  e: System.EventArgs);
begin
  session.Remove('p');
  session.Add('p',p);
end;

procedure TWebForm_county_overview.Button_continue_Click(sender: System.Object;
  e: System.EventArgs);
begin
  session.Remove('region_dictated_appropriation_id');
  session.Add('region_dictated_appropriation_id',Safe(RadioButtonList_appropriation.SelectedValue,NUM));
  DropCrumbAndTransferTo('county_dictated_appropriations.aspx');
end;

end.

