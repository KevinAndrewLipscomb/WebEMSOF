unit report_equipment_procurement_overview;

interface

uses
  Class_biz_accounts,
  Class_biz_fiscal_years,
  System.Collections, System.ComponentModel,
  System.Data, System.Drawing, System.Web, System.Web.SessionState,
  System.Web.UI, System.Web.UI.WebControls, System.Web.UI.HtmlControls,
  UserControl_equipment_procurement_overview;

type
  p_type =
    RECORD
    biz_accounts: TClass_biz_accounts;
    biz_fiscal_years: TClass_biz_fiscal_years;
    END;
  TWebForm_report_equipment_procurement_overview = class(System.Web.UI.Page)
  {$REGION 'Designer Managed Code'}
  strict private
    procedure InitializeComponent;
  {$ENDREGION}
  strict private
    p: p_type;
    procedure Page_Load(sender: System.Object; e: System.EventArgs);
  strict protected
    Title: System.Web.UI.HtmlControls.HtmlGenericControl;
    Label_application_name_1: System.Web.UI.WebControls.Label;
    Label_application_name_2: System.Web.UI.WebControls.Label;
    HyperLink_web_site: System.Web.UI.WebControls.HyperLink;
    PlaceHolder_control: System.Web.UI.WebControls.PlaceHolder;
  protected
    procedure OnInit(e: EventArgs); override;
    procedure Render(writer: HtmlTextWriter); override;
  private
    { Private Declarations }
  public
    { Public Declarations }
  end;

implementation

uses
  kix,
  system.configuration,
  system.io,
  system.text;

{$REGION 'Designer Managed Code'}
/// <summary>
/// Required method for Designer support -- do not modify
/// the contents of this method with the code editor.
/// </summary>
procedure TWebForm_report_equipment_procurement_overview.InitializeComponent;
begin
  Include(Self.Load, Self.Page_Load);
end;
{$ENDREGION}

procedure TWebForm_report_equipment_procurement_overview.Page_Load(sender: System.Object; e: System.EventArgs);
var
  url: string;
begin
  //
  Title.InnerText := configurationmanager.AppSettings['application_name'] + ' - report_equipment_procurement_overview';
  Label_application_name_1.text := configurationmanager.appsettings['application_name'];
  //
  url :=
    'http://' + configurationmanager.appsettings['host_domain_name'] + '/' + configurationmanager.appsettings['application_name'];
  HyperLink_web_site.text := url;
  HyperLink_web_site.navigateurl := url;
  //
end;

procedure TWebForm_report_equipment_procurement_overview.OnInit(e: EventArgs);
begin
  //
  // Required for Designer support
  //
  InitializeComponent;
  inherited OnInit(e);
  //
  p.biz_accounts := TClass_biz_accounts.Create;
  p.biz_fiscal_years := TClass_biz_fiscal_years.Create;
  //
  // Set session objects referenced by UserControl_roster.
  //
  session.Add('mode:report',EMPTY);
  session.Add('mode:report/equipment-procurement-overview',EMPTY);
  //
  PlaceHolder_control.controls.Add
    (
    TWebUserControl_equipment_procurement_overview
      (LoadControl('~/usercontrol/app/UserControl_equipment_procurement_overview.ascx'))
    );
  //
end;

procedure TWebForm_report_equipment_procurement_overview.Render(writer: HtmlTextWriter);
var
  body: string;
  sb: StringBuilder;
begin
  //
  // Write the HTML stream into a StringBuilder.
  //
  sb := StringBuilder.Create;
  inherited Render(HtmlTextWriter.Create(StringWriter.Create(sb)));
//  //
//  writer.Write(sb.tostring);
//  //
  body := sb.tostring;
  //
  // Send output stream as an email message.
  //
  kix.SmtpMailSend
    (
    //from
    configurationmanager.appsettings['sender_email_address'],
    //to
    p.biz_accounts.EMailTargetByRole('director') + COMMA_SPACE + p.biz_accounts.EMailTargetByRole('emsof-planner'),
    //subject
    'Report: Equipment Procurement Overview, ' + p.biz_fiscal_years.DesignatorOfCurrent,
    //body
    body,
    //be_html
    TRUE
    );
  //
  session.Abandon;
  //
end;

end.

