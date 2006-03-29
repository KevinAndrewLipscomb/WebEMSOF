
unit service_appropriation;

interface

uses
  System.Collections, System.ComponentModel,
  System.Data, System.Drawing, System.Web, System.Web.SessionState,
  System.Web.UI, System.Web.UI.WebControls, System.Web.UI.HtmlControls, AppCommon, system.configuration, borland.data.provider;

type
  TWebForm_service_appropriation = class(System.Web.UI.Page)
  {$REGION 'Designer Managed Code'}
  strict private
    procedure InitializeComponent;
    procedure Button_continue_Click(sender: System.Object; e: System.EventArgs);
  {$ENDREGION}
  strict private
    procedure Page_Load(sender: System.Object; e: System.EventArgs);
  strict protected
    Title: System.Web.UI.HtmlControls.HtmlGenericControl;
    PlaceHolder_precontent: System.Web.UI.WebControls.PlaceHolder;
    PlaceHolder_postcontent: System.Web.UI.WebControls.PlaceHolder;
    Label_service_name: System.Web.UI.WebControls.Label;
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
procedure TWebForm_service_appropriation.InitializeComponent;
begin
  Include(Self.Button_continue.Click, Self.Button_continue_Click);
  Include(Self.Load, Self.Page_Load);
end;
{$ENDREGION}

procedure TWebForm_service_appropriation.Page_Load(sender: System.Object; e: System.EventArgs);
var
  bdpCommand_get_appropriations: Borland.Data.Provider.BdpCommand;
  BdpDataReader_appropriations: borland.data.provider.BdpDataReader;
begin
  Title.InnerText := ConfigurationSettings.AppSettings['application_name'] + ' - service_appropriation';
  AppCommon.PopulatePlaceHolders(PlaceHolder_precontent,PlaceHolder_postcontent);
  if not IsPostback then
    begin
    AppCommon.BdpConnection.Open;
    //
    Label_service_name.Text := session.Item['service_name'].ToString;
    //
    // Load RadioButtonList_appropriation
    //
    bdpCommand_get_appropriations := Borland.Data.Provider.BdpCommand.Create
      (
      'SELECT unique id,name '
      + 'FROM county_dictated_appropriation '
      +   'JOIN county_code_name_map on (county_code_name_map.code=county_dictated_appropriation.county_code) '
      + 'WHERE service_id = ' + session.Item['session_user_id'].ToString
      + 'ORDER BY name',
      AppCommon.BdpConnection
      );
    BdpDataReader_appropriations := bdpCommand_get_appropriations.ExecuteReader;
    while bdpDataReader_appropriations.Read do
      RadioButtonList_appropriation.Items.Add
        (
        listitem.Create
          (
          BdpDataReader_appropriations['name'].ToString + ' County',
          BdpDataReader_appropriations['id'].ToString
          )
        );
    AppCommon.BdpConnection.Close;
    end;
end;

procedure TWebForm_service_appropriation.OnInit(e: EventArgs);
begin
  //
  // Required for Designer support
  //
  InitializeComponent;
  inherited OnInit(e);
end;

procedure TWebForm_service_appropriation.Button_continue_Click(sender: System.Object;
  e: System.EventArgs);
begin
  session.Remove('county_dictated_appropriation_id');
  session.Add('county_dictated_appropriation_id',RadioButtonList_appropriation.SelectedValue);
end;

end.

