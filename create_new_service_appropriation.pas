
unit create_new_service_appropriation;

interface

uses
  System.Collections, System.ComponentModel,
  System.Data, System.Drawing, System.Web, System.Web.SessionState,
  System.Web.UI, System.Web.UI.WebControls, System.Web.UI.HtmlControls, AppCommon, system.configuration, borland.data.provider;

type
  TWebForm_create_new_service_appropriation = class(System.Web.UI.Page)
  {$REGION 'Designer Managed Code'}
  strict private
    procedure InitializeComponent;
    procedure Button_add_appropriation_Click(sender: System.Object; e: System.EventArgs);
  {$ENDREGION}
  strict private
    procedure Page_Load(sender: System.Object; e: System.EventArgs);
  strict protected
    Title: System.Web.UI.HtmlControls.HtmlGenericControl;
    PlaceHolder_precontent: System.Web.UI.WebControls.PlaceHolder;
    PlaceHolder_postcontent: System.Web.UI.WebControls.PlaceHolder;
    DropDownList_services: System.Web.UI.WebControls.DropDownList;
    RangeValidator_service: System.Web.UI.WebControls.RangeValidator;
    TextBox_new_amount: System.Web.UI.WebControls.TextBox;
    RequiredFieldValidator_new_amount: System.Web.UI.WebControls.RequiredFieldValidator;
    RegularExpressionValidator_new_amount: System.Web.UI.WebControls.RegularExpressionValidator;
    Button_add_appropriation_and_repeat: System.Web.UI.WebControls.Button;
    RequiredFieldValidator_service: System.Web.UI.WebControls.RequiredFieldValidator;
    Button_add_appropriation_and_stop: System.Web.UI.WebControls.Button;
    Button_cancel: System.Web.UI.WebControls.Button;
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
procedure TWebForm_create_new_service_appropriation.InitializeComponent;
begin
  Include(Self.Button_add_appropriation_and_repeat.Click, Self.Button_add_appropriation_Click);
  Include(Self.Load, Self.Page_Load);
end;
{$ENDREGION}

const ID = '$Id$';

procedure TWebForm_create_new_service_appropriation.Page_Load(sender: System.Object; e: System.EventArgs);
var
  bc_get_services: borland.data.provider.BdpCommand;
  bdr_services: borland.data.provider.BdpDataReader;
begin
  AppCommon.PopulatePlaceHolders(PlaceHolder_precontent,PlaceHolder_postcontent);
  if not IsPostback then
    begin
    Title.InnerText := server.HtmlEncode(ConfigurationSettings.AppSettings['application_name']) + ' - create_new_service_appropriation';
    //
    // Fill DropDownList_services.
    //
    DropDownList_services.Items.Add(listitem.Create('-- Select --','0'));
    bc_get_services := Borland.Data.Provider.BdpCommand.Create
      (
      'SELECT id,name FROM service_user JOIN service using (id) ORDER BY name',
      AppCommon.BdpConnection
      );
    appcommon.bdpconnection.Open;
    bdr_services := bc_get_services.ExecuteReader;
    while bdr_services.Read do
      DropDownList_services.Items.Add(listitem.Create(bdr_services['name'].tostring,bdr_services['id'].ToString));
    end;
    appcommon.bdpconnection.Close;
end;

procedure TWebForm_create_new_service_appropriation.OnInit(e: EventArgs);
begin
  //
  // Required for Designer support
  //
  InitializeComponent;
  inherited OnInit(e);
end;

procedure TWebForm_create_new_service_appropriation.Button_add_appropriation_Click(sender: System.Object;
  e: System.EventArgs);
var
  amount: decimal;
  amount_string: string;
  bc: borland.data.provider.bdpcommand;
begin
  amount_string := Safe(TextBox_new_amount.Text.Trim,REAL_NUM);
  if amount_string <> system.string.EMPTY then begin
    amount := decimal.Parse(amount_string);
    if amount > 0 then begin
      appcommon.bdpconnection.Open;
      bc := borland.data.provider.bdpcommand.Create
        (
        'insert into county_dictated_appropriation'
        + ' set region_dictated_appropriation_id = ' + session.Item['region_dictated_appropriation_id'].tostring + ','
        +   ' service_id = ' + Safe(DropDownList_services.SelectedValue,NUM) + ','
        +   ' amount = ' + amount.tostring,
        appcommon.bdpconnection
        );
      bc.ExecuteNonQuery;
      appcommon.bdpconnection.Close;
    end;
    server.Transfer('county_dictated_appropriations.aspx');
  end;
end;

end.

