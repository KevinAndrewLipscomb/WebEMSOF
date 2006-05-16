
unit main;

interface

uses
  System.Collections, System.ComponentModel,
  System.Data, System.Drawing, System.Web, System.Web.SessionState,
  System.Web.UI, System.Web.UI.WebControls, System.Web.UI.HtmlControls, AppCommon, system.configuration;

type
  TWebForm_main = class(System.Web.UI.Page)
  {$REGION 'Designer Managed Code'}
  strict private
    procedure InitializeComponent;
    procedure LinkButton_service_Click(sender: System.Object; e: System.EventArgs);
    procedure LinkButton_county_Click(sender: System.Object; e: System.EventArgs);
    procedure LinkButton_regional_staffer_Click(sender: System.Object; e: System.EventArgs);
  {$ENDREGION}
  strict private
    procedure Page_Load(sender: System.Object; e: System.EventArgs);
  strict protected
    Title: System.Web.UI.HtmlControls.HtmlGenericControl;
    PlaceHolder_precontent: System.Web.UI.WebControls.PlaceHolder;
    PlaceHolder_postcontent: System.Web.UI.WebControls.PlaceHolder;
    Label_application_name: System.Web.UI.WebControls.Label;
    LinkButton_service: System.Web.UI.WebControls.LinkButton;
    LinkButton_county: System.Web.UI.WebControls.LinkButton;
    LinkButton_regional_staffer: System.Web.UI.WebControls.LinkButton;
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
procedure TWebForm_main.InitializeComponent;
begin
  Include(Self.LinkButton_service.Click, Self.LinkButton_service_Click);
  Include(Self.LinkButton_county.Click, Self.LinkButton_county_Click);
  Include(Self.LinkButton_regional_staffer.Click, Self.LinkButton_regional_staffer_Click);
  Include(Self.Load, Self.Page_Load);
end;
{$ENDREGION}

const ID = '$Id$';

procedure TWebForm_main.Page_Load(sender: System.Object; e: System.EventArgs);
begin
  AppCommon.PopulatePlaceHolders(PlaceHolder_precontent,PlaceHolder_postcontent);
  if not IsPostback then
    begin
    Title.InnerText := ConfigurationSettings.AppSettings['application_name'] + ' - main';
    Label_application_name.Text := ConfigurationSettings.AppSettings['application_name'];
    end;
end;

procedure TWebForm_main.OnInit(e: EventArgs);
begin
  //
  // Required for Designer support
  //
  InitializeComponent;
  inherited OnInit(e);
end;

procedure TWebForm_main.LinkButton_regional_staffer_Click(sender: System.Object;
  e: System.EventArgs);
begin
  session.Remove('target_user_table');
  session.Add('target_user_table','regional_staffer');
  response.Redirect('protected/regional_staffer_overview.aspx');
end;

procedure TWebForm_main.LinkButton_county_Click(sender: System.Object; e: System.EventArgs);
begin
  session.Remove('target_user_table');
  session.Add('target_user_table','county');
  response.Redirect('protected/choose_county_appropriation.aspx');
end;

procedure TWebForm_main.LinkButton_service_Click(sender: System.Object; e: System.EventArgs);
begin
  session.Remove('target_user_table');
  session.Add('target_user_table','service');
  response.Redirect('protected/service_overview.aspx');
end;

end.

