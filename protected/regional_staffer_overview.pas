
unit regional_staffer_overview;

interface

uses
  System.Collections, System.ComponentModel,
  System.Data, System.Drawing, System.Web, System.Web.SessionState,
  System.Web.UI, System.Web.UI.WebControls, System.Web.UI.HtmlControls, AppCommon, 
  System.Data.Common, Borland.Data.Provider, System.Globalization, 
  Borland.Data.Common, system.configuration, system.web.security;

type
  TWebForm_account_overview = class(System.Web.UI.Page)
  {$REGION 'Designer Managed Code'}
  strict private
    procedure InitializeComponent;
    procedure LinkButton_logout_Click(sender: System.Object; e: System.EventArgs);
    procedure Button_continue_Click(sender: System.Object; e: System.EventArgs);
  {$ENDREGION}
  strict private
    procedure Page_Load(sender: System.Object; e: System.EventArgs);
  strict protected
    Title: System.Web.UI.HtmlControls.HtmlGenericControl;
    PlaceHolder_precontent: System.Web.UI.WebControls.PlaceHolder;
    PlaceHolder_postcontent: System.Web.UI.WebControls.PlaceHolder;
    Label_regional_staffer_name: System.Web.UI.WebControls.Label;
    LinkButton_logout: System.Web.UI.WebControls.LinkButton;
    HyperLink_change_password: System.Web.UI.WebControls.HyperLink;
    HyperLink_change_email_address: System.Web.UI.WebControls.HyperLink;
    RequiredFieldValidator_appropriation: System.Web.UI.WebControls.RequiredFieldValidator;
    RadioButtonList_appropriation: System.Web.UI.WebControls.RadioButtonList;
    Button_continue: System.Web.UI.WebControls.Button;
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
procedure TWebForm_account_overview.InitializeComponent;
begin
  Include(Self.LinkButton_logout.Click, Self.LinkButton_logout_Click);
  Include(Self.Button_continue.Click, Self.Button_continue_Click);
  Include(Self.Load, Self.Page_Load);
end;
{$ENDREGION}

const ID = '$Id$';

procedure TWebForm_account_overview.Page_Load(sender: System.Object; e: System.EventArgs);
var
  bdr: borland.data.provider.BdpDataReader;
  regional_staffer_user_email_address: string;
  max_fiscal_year_id_string: string;
begin
  AppCommon.PopulatePlaceHolders(PlaceHolder_precontent,PlaceHolder_postcontent);
  if not IsPostback then begin
    //
    Title.InnerText := ConfigurationSettings.AppSettings['application_name'] + ' - account_overview';
    //
    Label_regional_staffer_name.Text := session.Item['regional_staffer_name'].ToString;
    //
    appcommon.DbOpen;
    //
    bdr := Borland.Data.Provider.BdpCommand.Create
      (
      'SELECT be_stale_password, password_reset_email_address FROM regional_staffer_user'
      + ' where id = ' + session.item['regional_staffer_user_id'].tostring,
      appcommon.db
      )
      .ExecuteReader;
    bdr.Read;
    if bdr['be_stale_password'].ToString = '0' then begin
      //
      // Get anything else needed from this reader, then close it.  We have another reader to open, and only one can be open at a
      // time.
      //
      regional_staffer_user_email_address := bdr['password_reset_email_address'].tostring;
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
        'SELECT state_dictated_appropriation.id,'
        + ' concat(designator,"  ($",format(state_dictated_appropriation.amount,2)," from PA DOH EMSO)")'
        +   ' as appropriation_description'
        + ' FROM state_dictated_appropriation'
        +   ' JOIN fiscal_year on (fiscal_year.id = fiscal_year_id)'
        +   ' JOIN regional_staffer on (regional_staffer.region_code=state_dictated_appropriation.region_code)'
        + ' WHERE regional_staffer.id = ' + session.Item['regional_staffer_user_id'].ToString
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
        // Add the regional staffer's email address to the session, as it will be needed by region_dictated_appropriations however
        // we get there.
        //
        session.Remove('regional_staffer_user_password_reset_email_address');
        session.Add('regional_staffer_user_password_reset_email_address',regional_staffer_user_email_address);
        if RadioButtonList_appropriation.items.Count = 1 then begin
          session.Remove('state_dictated_appropriation_id');
          session.Add('state_dictated_appropriation_id',bdr['id'].tostring);
          server.Transfer('regional_compliance_check_overview.aspx');
        end;
      end;
    end else begin
      appcommon.DbClose;
      server.Transfer('change_password.aspx');
    end;
  end;
end;

procedure TWebForm_account_overview.OnInit(e: EventArgs);
begin
  //
  // Required for Designer support
  //
  InitializeComponent;
  inherited OnInit(e);
end;

procedure TWebForm_account_overview.Button_continue_Click(sender: System.Object;
  e: System.EventArgs);
begin
  session.Remove('state_dictated_appropriation_id');
  session.Add('state_dictated_appropriation_id',Safe(RadioButtonList_appropriation.SelectedValue,NUM));
  server.Transfer('regional_compliance_check_overview.aspx');
end;

procedure TWebForm_account_overview.LinkButton_logout_Click(sender: System.Object;
  e: System.EventArgs);
begin
  formsauthentication.SignOut;
  session.Clear;
  server.Transfer('../Default.aspx');
end;

end.

