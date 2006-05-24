
unit county_overview;

interface

uses
  System.Collections, System.ComponentModel,
  System.Data, System.Drawing, System.Web, System.Web.SessionState,
  System.Web.UI, System.Web.UI.WebControls, System.Web.UI.HtmlControls, AppCommon, system.configuration, borland.data.provider,
  system.web.security;

type
  TWebForm_county_appropriation = class(System.Web.UI.Page)
  {$REGION 'Designer Managed Code'}
  strict private
    procedure InitializeComponent;
    procedure Button_continue_Click(sender: System.Object; e: System.EventArgs);
    procedure LinkButton_logout_Click(sender: System.Object; e: System.EventArgs);
  {$ENDREGION}
  strict private
    procedure Page_Load(sender: System.Object; e: System.EventArgs);
  strict protected
    Title: System.Web.UI.HtmlControls.HtmlGenericControl;
    PlaceHolder_precontent: System.Web.UI.WebControls.PlaceHolder;
    PlaceHolder_postcontent: System.Web.UI.WebControls.PlaceHolder;
    Label_county_name: System.Web.UI.WebControls.Label;
    RadioButtonList_appropriation: System.Web.UI.WebControls.RadioButtonList;
    Button_continue: System.Web.UI.WebControls.Button;
    RequiredFieldValidator_appropriation: System.Web.UI.WebControls.RequiredFieldValidator;
    Label_literal_county: System.Web.UI.WebControls.Label;
    LinkButton_logout: System.Web.UI.WebControls.LinkButton;
    HyperLink_change_password: System.Web.UI.WebControls.HyperLink;
    HyperLink_change_email_address: System.Web.UI.WebControls.HyperLink;
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
procedure TWebForm_county_appropriation.InitializeComponent;
begin
  Include(Self.LinkButton_logout.Click, Self.LinkButton_logout_Click);
  Include(Self.Button_continue.Click, Self.Button_continue_Click);
  Include(Self.Load, Self.Page_Load);
end;
{$ENDREGION}

const ID = '$Id$';

procedure TWebForm_county_appropriation.Page_Load(sender: System.Object; e: System.EventArgs);
var
  bdr: borland.data.provider.BdpDataReader;
  county_user_email_address: string;
  max_fiscal_year_id_string: string;
begin
  AppCommon.PopulatePlaceHolders(PlaceHolder_precontent,PlaceHolder_postcontent);
  if not IsPostback then begin
    Title.InnerText := ConfigurationSettings.AppSettings['application_name'] + ' - county_overview';
    //
    Label_county_name.Text := session.Item['county_name'].ToString;
    //
    appcommon.DbOpen;
    bdr := Borland.Data.Provider.BdpCommand.Create
      (
      'SELECT be_stale_password, password_reset_email_address FROM county_user'
      + ' where id = ' + session.item['county_user_id'].tostring,
      appcommon.db
      )
      .ExecuteReader;
    bdr.Read;
    if bdr['be_stale_password'].ToString = '0' then begin
      //
      // Get anything else needed from this reader, then close it.  We have another reader to open, and only one can be open at a
      // time.
      //
      county_user_email_address := bdr['password_reset_email_address'].tostring;
      bdr.Close;
      //
      // Where we go next depends on how many appropriations have been made to this county.
      //
      // Determine current fiscal year
      //
      max_fiscal_year_id_string := borland.data.provider.bdpcommand.Create
        (
        'SELECT max(id) as max_id FROM fiscal_year',
        appcommon.db
        )
        .ExecuteScalar.tostring;
      //
      bdr := borland.data.provider.bdpcommand.Create
        (
        'SELECT region_dictated_appropriation.id,'
        + ' concat(designator,"  ($",format(region_dictated_appropriation.amount,2)," from ",name,")")'
        +   ' as appropriation_description'
        + ' FROM region_dictated_appropriation'
        +   ' JOIN state_dictated_appropriation on (state_dictated_appropriation.id=state_dictated_appropriation_id)'
        +   ' JOIN region_code_name_map on (region_code_name_map.code=region_code)'
        +   ' JOIN fiscal_year on (fiscal_year.id = fiscal_year_id)'
        + ' WHERE county_code = ' + session.Item['county_user_id'].ToString
        +   ' and fiscal_year_id >= (' + max_fiscal_year_id_string + ' - 1)',
        appcommon.db
        )
        .ExecuteReader;
      while bdr.Read do begin
        RadioButtonList_appropriation.Items.Add(listitem.Create(bdr['appropriation_description'].tostring,bdr['id'].ToString));
      end;
      appcommon.DbClose;
      if RadioButtonList_appropriation.items.Count = 0 then begin
        server.Transfer('no_appropriation.aspx');
      end else begin
        //
        // Add the county's email address to the session, as it will be needed by county_dictated_appropriations however we
        // get there.
        //
        session.Remove('county_user_password_reset_email_address');
        session.Add('county_user_password_reset_email_address',county_user_email_address);
        if RadioButtonList_appropriation.items.Count = 1 then begin
          session.Remove('region_dictated_appropriation_id');
          session.Add('region_dictated_appropriation_id',bdr['id'].tostring);
          server.Transfer('county_dictated_appropriations.aspx');
        end;
      end;
    end else begin
      appcommon.DbClose;
      server.Transfer('change_password.aspx');
    end;
  end;
end;

procedure TWebForm_county_appropriation.OnInit(e: EventArgs);
begin
  //
  // Required for Designer support
  //
  InitializeComponent;
  inherited OnInit(e);
end;

procedure TWebForm_county_appropriation.LinkButton_logout_Click(sender: System.Object;
  e: System.EventArgs);
begin
  formsauthentication.SignOut;
  session.Clear;
  server.Transfer('../Default.aspx');
end;

procedure TWebForm_county_appropriation.Button_continue_Click(sender: System.Object;
  e: System.EventArgs);
begin
  session.Remove('region_dictated_appropriation_id');
  session.Add('region_dictated_appropriation_id',Safe(RadioButtonList_appropriation.SelectedValue,NUM));
  server.Transfer('county_dictated_appropriations.aspx');
end;

end.

