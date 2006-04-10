
unit county_overview;

interface

uses
  System.Collections, System.ComponentModel,
  System.Data, System.Drawing, System.Web, System.Web.SessionState,
  System.Web.UI, System.Web.UI.WebControls, System.Web.UI.HtmlControls, AppCommon, 
  System.Data.Common, Borland.Data.Provider, System.Globalization, 
  Borland.Data.Common, system.configuration;

type
  TWebForm_account_overview = class(System.Web.UI.Page)
  {$REGION 'Designer Managed Code'}
  strict private
    procedure InitializeComponent;
    procedure LinkButton_profile_action_Click(sender: System.Object; e: System.EventArgs);
    procedure LinkButton_change_account_attributes_Click(sender: System.Object; 
      e: System.EventArgs);
    procedure LinkButton_change_email_address_Click(sender: System.Object; e: System.EventArgs);
    procedure LinkButton_this_fy_request_action_Click(sender: System.Object; 
      e: System.EventArgs);
    procedure LinkButton_last_fy_request_action_Click(sender: System.Object; 
      e: System.EventArgs);
  {$ENDREGION}
  strict private
    procedure Page_Load(sender: System.Object; e: System.EventArgs);
  strict protected
    Title: System.Web.UI.HtmlControls.HtmlGenericControl;
    PlaceHolder_precontent: System.Web.UI.WebControls.PlaceHolder;
    PlaceHolder_postcontent: System.Web.UI.WebControls.PlaceHolder;
    Label_county_name: System.Web.UI.WebControls.Label;
    LinkButton_last_fy_request_action: System.Web.UI.WebControls.LinkButton;
    LinkButton_this_fy_request_action: System.Web.UI.WebControls.LinkButton;
    Label_profile_status: System.Web.UI.WebControls.Label;
    Label_last_fy_request_status: System.Web.UI.WebControls.Label;
    Label_this_fy_request_status: System.Web.UI.WebControls.Label;
    Label_last_fy_request_value: System.Web.UI.WebControls.Label;
    Label_this_fy_request_value: System.Web.UI.WebControls.Label;
    LinkButton_profile_action: System.Web.UI.WebControls.LinkButton;
    Label_this_fy_row_leader: System.Web.UI.WebControls.Label;
    Label_last_fy_row_leader: System.Web.UI.WebControls.Label;
    LinkButton_change_password: System.Web.UI.WebControls.LinkButton;
    LinkButton_change_email_address: System.Web.UI.WebControls.LinkButton;
    Label_last_fy_request_id: System.Web.UI.WebControls.Label;
    Label_this_fy_request_id: System.Web.UI.WebControls.Label;
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
  Include(Self.LinkButton_profile_action.Click, Self.LinkButton_profile_action_Click);
  Include(Self.LinkButton_last_fy_request_action.Click, Self.LinkButton_last_fy_request_action_Click);
  Include(Self.LinkButton_this_fy_request_action.Click, Self.LinkButton_this_fy_request_action_Click);
  Include(Self.LinkButton_change_password.Click, Self.LinkButton_change_account_attributes_Click);
  Include(Self.LinkButton_change_email_address.Click, Self.LinkButton_change_email_address_Click);
  Include(Self.Load, Self.Page_Load);
end;
{$ENDREGION}

procedure TWebForm_account_overview.Page_Load(sender: System.Object; e: System.EventArgs);
var
  bdpCommand_get_profile_status: borland.data.provider.BdpCommand;
  bdpCommand_get_last_fy_request_attributes: borland.data.Provider.bdpcommand;
  max_fiscal_year_id_obj: System.Object;
  bdpCommand_get_max_fiscal_year_id: borland.data.provider.BdpCommand;
  bdr_last_fy_request_attributes: borland.data.provider.BdpDataReader;
  bdpCommand_get_this_fy_request_attributes: borland.data.Provider.bdpcommand;
  bdr_this_fy_request_attributes: borland.data.provider.BdpDataReader;
begin
  Title.InnerText := ConfigurationSettings.AppSettings['application_name'] + ' - account_overview';
  AppCommon.PopulatePlaceHolders(PlaceHolder_precontent,PlaceHolder_postcontent);
  if not IsPostback then
    begin
    //
    // Set Label_county_name
    //
    Label_county_name.Text := session.Item['county_name'].ToString;
    //
    // Set Label_profile_status
    //
    bdpCommand_get_profile_status := borland.data.provider.bdpCommand.Create
      (
      'select be_valid_profile from county where id = "' + session.Item['county_user_id'].ToString + '"'
      ,AppCommon.BdpConnection
      );
    AppCommon.BdpConnection.Open;
    if bdpCommand_get_profile_status.ExecuteScalar.ToString = '0' then
      begin
      Label_profile_status.Text := 'Not saved.';
      LinkButton_profile_action.Text := 'Create profile';
      end
    else
      begin
      Label_profile_status.Text := 'Saved.';
      LinkButton_profile_action.Text := 'Edit profile';
      //
      // Determine current fiscal year
      //
      bdpCommand_get_max_fiscal_year_id := borland.data.provider.bdpcommand.Create
        (
        'SELECT max(id) as max_id FROM fiscal_year',
        AppCommon.BdpConnection
        );
      max_fiscal_year_id_obj := bdpCommand_get_max_fiscal_year_id.ExecuteScalar;
      //
      // Set Label_last_fy_*
      //
      Label_last_fy_row_leader.Visible := TRUE;
      bdpCommand_get_last_fy_request_attributes := borland.data.provider.BdpCommand.Create
        (
        'SELECT emsof_request_master.id,'
        + 'request_status_code_description_map.description,'
        + 'emsof_request_master.value '
        + 'FROM emsof_request_master '
        +   'JOIN request_status_code_description_map on (emsof_request_master.status_code = request_status_code_description_map.code)'
        +  'WHERE emsof_request_master.county_dictated_appropriation_id = "' + session.Item['account_id'].ToString + '" '
        +    'and emsof_request_master.fiscal_year_id = (' + max_fiscal_year_id_obj.ToString + ' - 1)',
        AppCommon.BdpConnection
        );
      bdr_last_fy_request_attributes := bdpCommand_get_last_fy_request_attributes.ExecuteReader;
      if bdr_last_fy_request_attributes.Read then
        begin
        Label_last_fy_request_id.Text := bdr_last_fy_request_attributes['id'].tostring;
        Label_last_fy_request_status.Text := bdr_last_fy_request_attributes['description'].tostring + '.';
        Label_last_fy_request_value.Text := bdr_last_fy_request_attributes['value'].tostring;
        LinkButton_last_fy_request_action.Text := 'Review';
        end
      else
        begin
        Label_last_fy_request_id.Text := '0';
        Label_last_fy_request_status.Text := 'Blank.';
        Label_last_fy_request_value.Text := '--';
        end;
      //
      // Set Label_this_fy_*
      //
      Label_this_fy_row_leader.Visible := TRUE;
      bdpCommand_get_this_fy_request_attributes := borland.data.provider.BdpCommand.Create
        (
        'SELECT emsof_request_master.id,'
        + 'request_status_code_description_map.description,'
        + 'emsof_request_master.value '
        + 'FROM emsof_request_master '
        +   'JOIN request_status_code_description_map on (emsof_request_master.status_code = request_status_code_description_map.code)'
        +  'WHERE emsof_request_master.webemsof_account_id = "' + session.Item['account_id'].ToString + '" '
        +    'and emsof_request_master.fiscal_year_id = ' + max_fiscal_year_id_obj.ToString,
        AppCommon.BdpConnection
        );
      bdr_this_fy_request_attributes := bdpCommand_get_this_fy_request_attributes.ExecuteReader;
      if bdr_this_fy_request_attributes.Read then
        begin
        Label_this_fy_request_id.Text := bdr_this_fy_request_attributes['id'].ToString;
        Label_this_fy_request_status.Text := bdr_this_fy_request_attributes['description'].tostring + '.';
        Label_this_fy_request_value.Text := bdr_this_fy_request_attributes['value'].ToString;
        LinkButton_this_fy_request_action.Text := 'Review';
        end
      else
        begin
        Label_this_fy_request_id.Text := '0';
        Label_this_fy_request_status.Text := 'Blank.';
        Label_this_fy_request_value.Text := '--';
        LinkButton_this_fy_request_action.Text := 'Start';
        end;
      end;
    AppCommon.BdpConnection.Close;
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

procedure TWebForm_account_overview.LinkButton_last_fy_request_action_Click(sender: System.Object;
  e: System.EventArgs);
begin
  session.Remove('emsof_request_id');
  session.Add('emsof_request_id',Safe(Label_last_fy_request_id.Text,NUM));
  session.Remove('relative_fy');
  session.Add('relative_fy','LAST');
  server.Transfer('request_overview.aspx');
end;

procedure TWebForm_account_overview.LinkButton_this_fy_request_action_Click(sender: System.Object;
  e: System.EventArgs);
begin
  session.Remove('emsof_request_id');
  session.Add('emsof_request_id',Safe(Label_this_fy_request_id.Text,NUM));
  session.Remove('relative_fy');
  session.Add('relative_fy','THIS');
  server.Transfer('request_overview.aspx');
end;

procedure TWebForm_account_overview.LinkButton_change_email_address_Click(sender: System.Object;
  e: System.EventArgs);
begin
  server.Transfer('change_email_address.aspx');
end;

procedure TWebForm_account_overview.LinkButton_change_account_attributes_Click(sender: System.Object;
  e: System.EventArgs);
begin
  server.Transfer('change_password.aspx');
end;

procedure TWebForm_account_overview.LinkButton_profile_action_Click(sender: System.Object;
  e: System.EventArgs);
begin
  server.Transfer('profile.aspx');
end;

end.

