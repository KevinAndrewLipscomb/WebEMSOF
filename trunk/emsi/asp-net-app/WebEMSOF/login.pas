
unit login;

interface

uses
  System.Collections, System.ComponentModel,
  System.Data, System.Drawing, System.Web, System.Web.SessionState,
  System.Web.UI, System.Web.UI.WebControls, System.Web.UI.HtmlControls,
  AppCommon, Borland.Data.Provider, System.Globalization, 
  System.Data.SqlClient, System.Data.Common;

type
  TWebForm_login = class(System.Web.UI.Page)
  {$REGION 'Designer Managed Code'}
  strict private
    procedure InitializeComponent;
    procedure Button_log_in_Click(sender: System.Object; e: System.EventArgs);
    procedure Button_new_password_Click(sender: System.Object; e: System.EventArgs);
    procedure DropDownList_account_descriptor_SelectedIndexChanged(sender: System.Object;
      e: System.EventArgs);
  {$ENDREGION}
  strict private
    procedure Page_Load(sender: System.Object; e: System.EventArgs);
  strict protected
    Title: System.Web.UI.HtmlControls.HtmlGenericControl;
    invalid_credentials_warning: System.Web.UI.HtmlControls.HtmlGenericControl;
    TextBox_password: System.Web.UI.WebControls.TextBox;
    Button_log_in: System.Web.UI.WebControls.Button;
    CheckBox_keep_me_logged_in: System.Web.UI.WebControls.CheckBox;
    DropDownList_account_descriptor: System.Web.UI.WebControls.DropDownList;
    PlaceHolder_precontent: System.Web.UI.WebControls.PlaceHolder;
    PlaceHolder_postcontent: System.Web.UI.WebControls.PlaceHolder;
    bdpConnection1: Borland.Data.Provider.BdpConnection;
    Button_new_password: System.Web.UI.WebControls.Button;
    RangeValidator_account: System.Web.UI.WebControls.RangeValidator;
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
procedure TWebForm_login.InitializeComponent;
begin
  Self.bdpConnection1 := Borland.Data.Provider.BdpConnection.Create;
  Include(Self.DropDownList_account_descriptor.SelectedIndexChanged, Self.DropDownList_account_descriptor_SelectedIndexChanged);
  Include(Self.TextBox_password.TextChanged, Self.Button_log_in_Click);
  Include(Self.Button_new_password.Click, Self.Button_new_password_Click);
  // 
  // bdpConnection1
  // 
  Self.bdpConnection1.ConnectionOptions := 'transaction isolation=ReadCommit' +
  'ted';
  Self.bdpConnection1.ConnectionString := 'assembly=CoreLab.Bdp.MySql, Versi' +
  'on=2.70.1.2500, Culture=neutral, PublicKeyToken=09af7300eec23701;vendorcl' +
  'ient=libmysql.dll;grow on demand=True;database=kalipso;username=kalipso;m' +
  'ax pool size=100;password=egalmess;provider=MySQL (Core Lab);min pool siz' +
  'e=0;hostname=db4free.org';
  //
  Include(Self.Load, Self.Page_Load);
end;
{$ENDREGION}

procedure TWebForm_login.Page_Load(sender: System.Object; e: System.EventArgs);
var
  bdpCommand_get_account_descriptors: Borland.Data.Provider.BdpCommand;
  BdpDataReader_account_descriptors: borland.data.provider.BdpDataReader;
begin
  Title.InnerText := 'WebEMSOF - login';
  AppCommon.PopulatePlaceHolders(PlaceHolder_precontent,PlaceHolder_postcontent);
  if not IsPostback then
    begin
    invalid_credentials_warning.Visible := FALSE;
    //
    // Load DropDownList_account
    //
    DropDownList_account_descriptor.Items.Add(listitem.Create('-- Select --',''));
    bdpCommand_get_account_descriptors := Borland.Data.Provider.BdpCommand.Create
      (
      'SELECT emsof_sponsorship.id,'
      + 'concat(response_agency.name," (", county_code_name_map.name,")") AS account '
      + 'FROM emsof_sponsorship '
      +   'JOIN county_code_name_map ON ( emsof_sponsorship.county_code = county_code_name_map.code ) '
      +     'JOIN response_agency ON (emsof_sponsorship.affiliate_num = response_agency.affiliate_num) '
      + 'ORDER BY account',
      bdpConnection1
      );
    bdpCommand_get_account_descriptors.Connection.Open;
    BdpDataReader_account_descriptors := bdpCommand_get_account_descriptors.ExecuteReader;
    while bdpDataReader_account_descriptors.Read do
      DropDownList_account_descriptor.Items.Add
        (
        listitem.Create
          (
          BdpDataReader_account_descriptors['account'].ToString,
          BdpDataReader_account_descriptors['id'].ToString
          )
        );
    bdpCommand_get_account_descriptors.Connection.Close;
    end;
end;

procedure TWebForm_login.OnInit(e: EventArgs);
begin
  //
  // Required for Designer support
  //
  InitializeComponent;
  inherited OnInit(e);
end;

procedure TWebForm_login.DropDownList_account_descriptor_SelectedIndexChanged(sender: System.Object;
  e: System.EventArgs);
begin
  session.Add('emsof_sponsorship_id',DropDownList_account_descriptor.SelectedValue);
  session.Add('account_descriptor',DropDownList_account_descriptor.SelectedItem.Text);
end;

procedure TWebForm_login.Button_new_password_Click(sender: System.Object;
  e: System.EventArgs);
begin
  server.Transfer('new_password.aspx');
end;

procedure TWebForm_login.Button_log_in_Click(sender: System.Object; e: System.EventArgs);
var
  bdpCommand_match_account: borland.data.provider.BdpCommand;
  be_stale_password_obj: System.Object;
begin
  bdpCommand_match_account := Borland.Data.Provider.BdpCommand.Create
    (
    'SELECT be_stale_password FROM emsof_sponsorship JOIN response_agency using (affiliate_num) '
    +  'where emsof_sponsorship.id="' + DropDownList_account_descriptor.SelectedValue + '" '
    +     'and encoded_password=sha("' + TextBox_password.Text + '")'
    ,bdpConnection1
    );
  bdpCommand_match_account.Connection.Open;
  be_stale_password_obj := bdpCommand_match_account.ExecuteScalar;
  bdpCommand_match_account.Connection.Close;
  if be_stale_password_obj <> nil then
    if be_stale_password_obj.ToString = '0' then
      server.Transfer('account_overview.aspx')
    else
      server.Transfer('change_password.aspx')
  else // be_stale_password_obj = nil
    if DropDownList_account_descriptor.SelectedIndex <> 0 then
      invalid_credentials_warning.Visible := TRUE;
  end;

end.
