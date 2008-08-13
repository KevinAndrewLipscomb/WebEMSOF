unit regional_staffer_fiscal_year_selection;

interface

uses
  System.Collections, System.ComponentModel,
  System.Data, System.Drawing, System.Web, System.Web.SessionState,
  system.web.ui, ki_web_ui, System.Web.UI.WebControls, System.Web.UI.HtmlControls, kix,
  System.Data.Common, mysql.data.mysqlclient, System.Globalization,
  system.configuration, system.web.security,
  Class_db;

const ID = '$Id$';

type
  p_type =
    RECORD
    db: TClass_db;
    END;
  TWebForm_regional_staffer_fiscal_year_selection = class(ki_web_ui.page_class)
  {$REGION 'Designer Managed Code'}
  strict private
    procedure InitializeComponent;
    procedure Button_continue_Click(sender: System.Object; e: System.EventArgs);
    procedure TWebForm_regional_staffer_fiscal_year_selection_PreRender(sender: System.Object;
      e: System.EventArgs);
  {$ENDREGION}
  strict private
    p: p_type;
    procedure Page_Load(sender: System.Object; e: System.EventArgs);
  strict protected
    Title: System.Web.UI.HtmlControls.HtmlGenericControl;
    PlaceHolder_precontent: System.Web.UI.WebControls.PlaceHolder;
    PlaceHolder_postcontent: System.Web.UI.WebControls.PlaceHolder;
    Label_regional_staffer_name: System.Web.UI.WebControls.Label;
    RequiredFieldValidator_appropriation: System.Web.UI.WebControls.RequiredFieldValidator;
    RadioButtonList_appropriation: System.Web.UI.WebControls.RadioButtonList;
    Button_continue: System.Web.UI.WebControls.Button;
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
procedure TWebForm_regional_staffer_fiscal_year_selection.InitializeComponent;
begin
  Include(Self.Button_continue.Click, Self.Button_continue_Click);
  Include(Self.Load, Self.Page_Load);
  Include(Self.PreRender, Self.TWebForm_regional_staffer_fiscal_year_selection_PreRender);
end;
{$ENDREGION}

procedure TWebForm_regional_staffer_fiscal_year_selection.Page_Load(sender: System.Object; e: System.EventArgs);
var
  dr: mysqldatareader;
  regional_staffer_user_email_address: string;
  max_fiscal_year_id_string: string;
begin
  if IsPostback then begin
    if assigned(session['regional_staffer_fiscal_year_selection.p']) then begin
      p := p_type(session['regional_staffer_fiscal_year_selection.p']);
    end else begin
      server.Transfer('~/timeout.aspx');
    end;
  end else begin
    if request.servervariables['URL'] = request.currentexecutionfilepath then begin
      session.Clear;
      server.Transfer('~/login.aspx');
    end;
    //
    Title.InnerText := configurationmanager.AppSettings['application_name'] + ' - account_overview';
    //
    Label_regional_staffer_name.Text := session['regional_staffer_name'].ToString;
    //
    p.db := TClass_db.Create;
    p.db.Open;
    //
    dr := mysqlcommand.Create
      (
      'SELECT be_stale_password, password_reset_email_address FROM regional_staffer_user'
      + ' where id = ' + session['regional_staffer_user_id'].tostring,
      p.db.connection
      )
      .ExecuteReader;
    dr.Read;
    if dr['be_stale_password'].ToString = '0' then begin
      //
      // Get anything else needed from this reader, then close it.  We have another reader to open, and only one can be open at a
      // time.
      //
      regional_staffer_user_email_address := dr['password_reset_email_address'].tostring;
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
        'SELECT state_dictated_appropriation.id,'
        + ' concat(designator,"  ($",format(state_dictated_appropriation.amount,2)," from PA DOH EMSO)")'
        +   ' as appropriation_description'
        + ' FROM state_dictated_appropriation'
        +   ' JOIN fiscal_year on (fiscal_year.id = fiscal_year_id)'
        +   ' JOIN regional_staffer on (regional_staffer.region_code=state_dictated_appropriation.region_code)'
        + ' WHERE regional_staffer.id = ' + session['regional_staffer_user_id'].ToString
        +   ' and fiscal_year_id >= (' + max_fiscal_year_id_string + ' - 1)',
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
        // Add the regional staffer's email address to the session, as it will be needed by region_dictated_appropriations however
        // we get there.
        //
        SessionSet('regional_staffer_user_password_reset_email_address',regional_staffer_user_email_address);
        if RadioButtonList_appropriation.items.Count = 1 then begin
          SessionSet('state_dictated_appropriation_id',dr['id'].tostring);
          DropCrumbAndTransferTo('regional_compliance_check_overview.aspx');
        end;
      end;
    end else begin
      dr.Close;
      p.db.Close;
      DropCrumbAndTransferTo('change_password.aspx');
    end;
  end;
end;

procedure TWebForm_regional_staffer_fiscal_year_selection.OnInit(e: EventArgs);
begin
  //
  // Required for Designer support
  //
  InitializeComponent;
  inherited OnInit(e);
end;

procedure TWebForm_regional_staffer_fiscal_year_selection.TWebForm_regional_staffer_fiscal_year_selection_PreRender(sender: System.Object;
  e: System.EventArgs);
begin
  SessionSet('regional_staffer_fiscal_year_selection.p',p);
end;

procedure TWebForm_regional_staffer_fiscal_year_selection.Button_continue_Click(sender: System.Object;
  e: System.EventArgs);
begin
  SessionSet('state_dictated_appropriation_id',Safe(RadioButtonList_appropriation.SelectedValue,NUM));
  DropCrumbAndTransferTo('regional_compliance_check_overview.aspx');
end;

end.

