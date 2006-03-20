
unit account_overview;

interface

uses
  System.Collections, System.ComponentModel,
  System.Data, System.Drawing, System.Web, System.Web.SessionState,
  System.Web.UI, System.Web.UI.WebControls, System.Web.UI.HtmlControls, AppCommon, 
  System.Data.Common, Borland.Data.Provider, System.Globalization, 
  Borland.Data.Common;

type
  TWebForm_account_overview = class(System.Web.UI.Page)
  {$REGION 'Designer Managed Code'}
  strict private
    procedure InitializeComponent;
    procedure LinkButton_profile_action_Click(sender: System.Object; e: System.EventArgs);
  {$ENDREGION}
  strict private
    procedure Page_Load(sender: System.Object; e: System.EventArgs);
  strict protected
    Title: System.Web.UI.HtmlControls.HtmlGenericControl;
    PlaceHolder_precontent: System.Web.UI.WebControls.PlaceHolder;
    PlaceHolder_postcontent: System.Web.UI.WebControls.PlaceHolder;
    Label_service_name: System.Web.UI.WebControls.Label;
    LinkButton_last_fy_request_action: System.Web.UI.WebControls.LinkButton;
    LinkButton_this_fy_request_action: System.Web.UI.WebControls.LinkButton;
    Label_profile_status: System.Web.UI.WebControls.Label;
    Label_last_fy_request_status: System.Web.UI.WebControls.Label;
    Label_this_fy_request_status: System.Web.UI.WebControls.Label;
    Label_last_fy_request_value: System.Web.UI.WebControls.Label;
    Label_this_fy_request_value: System.Web.UI.WebControls.Label;
    LinkButton_change_password: System.Web.UI.WebControls.LinkButton;
    BdpConnection1: Borland.Data.Provider.BdpConnection;
    LinkButton_profile_action: System.Web.UI.WebControls.LinkButton;
    Label_this_fy_row_leader: System.Web.UI.WebControls.Label;
    Label_last_fy_row_leader: System.Web.UI.WebControls.Label;
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
  Self.BdpConnection1 := Borland.Data.Provider.BdpConnection.Create;
  Include(Self.LinkButton_profile_action.Click, Self.LinkButton_profile_action_Click);
  // 
  // BdpConnection1
  // 
  Self.BdpConnection1.ConnectionOptions := 'transaction isolation=ReadCommit' +
  'ted';
  Self.BdpConnection1.ConnectionString := 'assembly=CoreLab.Bdp.MySql, Versi' +
  'on=2.70.1.2500, Culture=neutral, PublicKeyToken=09af7300eec23701;vendorcl' +
  'ient=libmysql.dll;grow on demand=True;database=kalipso;username=kalipso;m' +
  'ax pool size=100;password=egalmess;provider=MySQL (Core Lab);min pool siz' +
  'e=0;hostname=db4free.org';
  Include(Self.Load, Self.Page_Load);
end;
{$ENDREGION}

procedure TWebForm_account_overview.Page_Load(sender: System.Object; e: System.EventArgs);
var
  bdpCommand_get_profile_status: borland.data.provider.BdpCommand;
  bdpCommand_get_last_fy_request_attributes: borland.data.Provider.bdpcommand;
  max_fiscal_year_id_obj: System.Object;
  bdpCommand_get_max_fiscal_year_id: borland.data.provider.BdpCommand;
  bdpDataReader_last_fy_request_attributes: borland.data.provider.BdpDataReader;
  bdpCommand_get_this_fy_request_attributes: borland.data.Provider.bdpcommand;
  bdpDataReader_this_fy_request_attributes: borland.data.provider.BdpDataReader;
begin
  Title.InnerText := 'WebEMSOF - account_overview';
  AppCommon.PopulatePlaceHolders(PlaceHolder_precontent,PlaceHolder_postcontent);
  if not IsPostback then
    begin
    //
    // Set Label_service_name
    //
    Label_service_name.Text := session.Item['account_descriptor'].ToString;
    //
    // Set Label_profile_status
    //
    bdpCommand_get_profile_status := borland.data.provider.bdpCommand.Create
      (
      'select be_profile_valid from response_agency JOIN emsof_sponsorship using (affiliate_num) '
      + 'where emsof_sponsorship.id = "' + session.Item['emsof_sponsorship_id'].ToString + '"'
      ,bdpConnection1
      );
    BdpConnection1.Open;
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
        bdpConnection1
        );
      max_fiscal_year_id_obj := bdpCommand_get_max_fiscal_year_id.ExecuteScalar;
      //
      // Set Label_last_fy_*
      //
      Label_last_fy_row_leader.Visible := TRUE;
      bdpCommand_get_last_fy_request_attributes := borland.data.provider.BdpCommand.Create
        (
        'SELECT request_status_code_description_map.description,'
        + 'emsof_request.value '
        + 'FROM request_status_code_description_map '
        +   'JOIN emsof_request on (emsof_request.status_code = request_status_code_description_map.code)'
        +   'JOIN emsof_sponsorship on (emsof_sponsorship.id = emsof_request.id) '
        +  'WHERE emsof_request.emsof_sponsorship_id = "' + session.Item['emsof_sponsorship_id'].ToString + '" '
        +    'and emsof_request.fiscal_year_id = (' + max_fiscal_year_id_obj.ToString + ' - 1)',
        bdpConnection1
        );
      bdpDataReader_last_fy_request_attributes := bdpCommand_get_last_fy_request_attributes.ExecuteReader;
      if bdpDataReader_last_fy_request_attributes.Read then
        begin
        Label_last_fy_request_status.Text := bdpDataReader_last_fy_request_attributes.GetString(0) + '.';
        Label_last_fy_request_value.Text := bdpDataReader_last_fy_request_attributes.GetString(1);
        LinkButton_last_fy_request_action.Text := 'Review';
        end
      else
        begin
        Label_last_fy_request_status.Text := 'Blank.';
        Label_last_fy_request_value.Text := '--';
        end;
      //
      // Set Label_this_fy_*
      //
      Label_this_fy_row_leader.Visible := TRUE;
      bdpCommand_get_this_fy_request_attributes := borland.data.provider.BdpCommand.Create
        (
        'SELECT request_status_code_description_map.description,'
        + 'emsof_request.value '
        + 'FROM request_status_code_description_map '
        +   'JOIN emsof_request on (emsof_request.status_code = request_status_code_description_map.code)'
        +   'JOIN emsof_sponsorship on (emsof_sponsorship.id = emsof_request.id) '
        +  'WHERE emsof_request.emsof_sponsorship_id = "' + session.Item['emsof_sponsorship_id'].ToString + '" '
        +    'and emsof_request.fiscal_year_id = ' + max_fiscal_year_id_obj.ToString,
        bdpConnection1
        );
      bdpDataReader_this_fy_request_attributes := bdpCommand_get_this_fy_request_attributes.ExecuteReader;
      if bdpDataReader_this_fy_request_attributes.Read then
        begin
        Label_this_fy_request_status.Text := bdpDataReader_this_fy_request_attributes.GetString(0) + '.';
        Label_this_fy_request_value.Text := bdpDataReader_this_fy_request_attributes.GetString(1);
        LinkButton_this_fy_request_action.Text := 'Review';
        end
      else
        begin
        Label_this_fy_request_status.Text := 'Blank.';
        Label_this_fy_request_value.Text := '--';
        LinkButton_this_fy_request_action.Text := 'Start';
        end;
      end;
    bdpConnection1.Close;
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

procedure TWebForm_account_overview.LinkButton_profile_action_Click(sender: System.Object;
  e: System.EventArgs);
begin
  server.Transfer('profile.aspx');
end;

end.

