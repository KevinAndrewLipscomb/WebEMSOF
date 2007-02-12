library WebEMSOF;

{%AspWebConfigContainer 'Web.config'}
{%DelphiDotNetAssemblyCompiler '$(SystemRoot)\microsoft.net\framework\v1.1.4322\System.dll'}
{%DelphiDotNetAssemblyCompiler '$(SystemRoot)\microsoft.net\framework\v1.1.4322\System.Data.dll'}
{%DelphiDotNetAssemblyCompiler '$(SystemRoot)\microsoft.net\framework\v1.1.4322\System.Drawing.dll'}
{%DelphiDotNetAssemblyCompiler '$(SystemRoot)\microsoft.net\framework\v1.1.4322\System.Web.dll'}
{%DelphiDotNetAssemblyCompiler '$(SystemRoot)\microsoft.net\framework\v1.1.4322\System.XML.dll'}
{%DelphiDotNetAssemblyCompiler 'c:\program files\common files\borland shared\bds\shared assemblies\4.0\Borland.Data.Provider.dll'}
{%DelphiDotNetAssemblyCompiler '$(SystemRoot)\microsoft.net\framework\v1.1.4322\System.Windows.Forms.dll'}
{%DelphiDotNetAssemblyCompiler '$(SystemRoot)\microsoft.net\framework\v1.1.4322\System.Design.dll'}
{%DelphiDotNetAssemblyCompiler 'c:\program files\common files\borland shared\bds\shared assemblies\4.0\Borland.Data.Common.dll'}
{%DelphiDotNetAssemblyCompiler '$(SystemRoot)\microsoft.net\framework\v1.1.4322\mscorlib.dll'}
{%File 'schema.sql'}
{%ConfigurationCompiler 'unpublished.config'}
{%File 'resource\terms-and-conditions.pdf'}
{%File 'testdata.sql'}
{%AspFolderContainer 'protected'}
{%TogetherDiagram 'ModelSupport_WebEMSOF\default.txaPackage'}
{%AspFolderContainer 'component'}
{%AspFolderContainer 'component\biz'}
{%AspFolderContainer 'component\db'}
{%AspMarkupContainer 'Default.aspx'}
{%AspMarkupContainer 'Global.asax'}
{%AspMarkupContainer 'new_password.aspx'}
{%AspMarkupContainer 'protected\withdraw_request_item.aspx'}
{%AspMarkupContainer 'protected\all_emsof_requests.aspx'}
{%AspMarkupContainer 'protected\change_email_address.aspx'}
{%AspMarkupContainer 'protected\change_password.aspx'}
{%AspMarkupContainer 'protected\county_dictated_appropriations.aspx'}
{%AspMarkupContainer 'protected\county_dictated_deadline.aspx'}
{%AspMarkupContainer 'protected\county_overview.aspx'}
{%AspMarkupContainer 'protected\create_new_service_appropriation.aspx'}
{%AspMarkupContainer 'protected\delete_service_appropriation.aspx'}
{%AspMarkupContainer 'protected\emsof_request_status_filter.aspx'}
{%AspMarkupContainer 'protected\finalize.aspx'}
{%AspMarkupContainer 'protected\full_request_review_approve.aspx'}
{%AspMarkupContainer 'protected\profile.aspx'}
{%AspMarkupContainer 'protected\region_dictated_appropriations.aspx'}
{%AspMarkupContainer 'protected\regional_staffer_fiscal_year_selection.aspx'}
{%AspMarkupContainer 'protected\regional_staffer_overview.aspx'}
{%AspMarkupContainer 'protected\request_item_detail.aspx'}
{%AspMarkupContainer 'protected\request_overview.aspx'}
{%AspMarkupContainer 'protected\service_overview.aspx'}
{%AspWebConfigContainer 'protected\Web.config'}
{%File 'resource\funding-priorities-epel-fy0607.pdf'}
{%File 'resource\emsi-emsof-allocations-memo-fy0607.pdf'}
{%AspMarkupContainer 'protected\state_required_report.aspx'}
{%AspMarkupContainer 'salogin.aspx'}
{%AspMarkupContainer 'login.aspx'}
{%AspMarkupContainer 'protected\state_transmittal_complete.aspx'}
{%AspFolderContainer 'protected\scratch'}
{%AspFolderContainer 'protected\image'}
{$R 'protected\image\logo_left.gif' 'protected\image\logo_left.gif'}
{$R 'protected\image\logo_right.gif' 'protected\image\logo_right.gif'}
{%AspFolderContainer 'dbscript'}
{%AspMarkupContainer 'exception.aspx'}
{%AspMarkupContainer 'timeout.aspx'}
{%DelphiDotNetAssemblyCompiler 'lib\ki\ki.dll'}
{%AspMarkupContainer 'protected\county_unrejection.aspx'}
{%File 'noninteractive\.crontab'}
{%AspMarkupContainer 'noninteractive\milestone_sweep.aspx'}
{%AspMarkupContainer 'protected\add_proof_of_payment.aspx'}

uses
  System.Reflection,
  System.Runtime.CompilerServices,
  Class_biz_user in 'component\biz\Class_biz_user.pas',
  Class_biz_accounts in 'component\biz\Class_biz_accounts.pas',
  Class_biz_appropriations in 'component\biz\Class_biz_appropriations.pas',
  Class_biz_emsof_requests in 'component\biz\Class_biz_emsof_requests.pas',
  Class_biz_fiscal_years in 'component\biz\Class_biz_fiscal_years.pas',
  Class_biz_services in 'component\biz\Class_biz_services.pas',
  Class_db_user in 'component\db\Class_db_user.pas',
  Class_db in 'component\db\Class_db.pas',
  Class_db_accounts in 'component\db\Class_db_accounts.pas',
  Class_db_appropriations in 'component\db\Class_db_appropriations.pas',
  Class_db_emsof_requests in 'component\db\Class_db_emsof_requests.pas',
  Class_db_fiscal_years in 'component\db\Class_db_fiscal_years.pas',
  Class_db_services in 'component\db\Class_db_services.pas',
  Default in 'Default.pas' {Default.TWebForm_Default: ki_web_ui.page_class},
  Global in 'Global.pas' {Global.TGlobal: System.Web.HttpApplication},
  salogin in 'salogin.pas' {salogin.TWebForm_salogin: ki_web_ui.page_class},
  new_password in 'new_password.pas' {new_password.TWebForm_new_password: ki_web_ui.page_class},
  withdraw_request_item in 'protected\withdraw_request_item.pas' {withdraw_request_item.TWebForm_withdraw_request_item: ki_web_ui.page_class},
  all_emsof_requests in 'protected\all_emsof_requests.pas' {all_emsof_requests.TWebForm_all_emsof_requests: ki_web_ui.page_class},
  change_email_address in 'protected\change_email_address.pas' {change_email_address.TWebForm_change_email_address: ki_web_ui.page_class},
  change_password in 'protected\change_password.pas' {change_password.TWebForm_change_password: ki_web_ui.page_class},
  county_dictated_appropriations in 'protected\county_dictated_appropriations.pas' {county_dictated_appropriations.TWebForm_county_dictated_appropriations: ki_web_ui.page_class},
  county_dictated_deadline in 'protected\county_dictated_deadline.pas' {county_dictated_deadline.TWebForm_county_dictated_deadline: ki_web_ui.page_class},
  county_overview in 'protected\county_overview.pas' {county_overview.TWebForm_county_overview: ki_web_ui.page_class},
  create_new_service_appropriation in 'protected\create_new_service_appropriation.pas' {create_new_service_appropriation.TWebForm_create_new_service_appropriation: ki_web_ui.page_class},
  delete_service_appropriation in 'protected\delete_service_appropriation.pas' {delete_service_appropriation.TWebForm_delete_service_appropriation: ki_web_ui.page_class},
  emsof_request_status_filter in 'protected\emsof_request_status_filter.pas' {emsof_request_status_filter.TWebForm_emsof_request_status_filter: ki_web_ui.page_class},
  finalize in 'protected\finalize.pas' {finalize.TWebForm_finalize: ki_web_ui.page_class},
  full_request_review_approve in 'protected\full_request_review_approve.pas' {full_request_review_approve.TWebForm_full_request_review_approve: ki_web_ui.page_class},
  profile in 'protected\profile.pas' {profile.TWebForm_profile: ki_web_ui.page_class},
  region_dictated_appropriations in 'protected\region_dictated_appropriations.pas' {region_dictated_appropriations.TWebForm_region_dictated_appropriations: ki_web_ui.page_class},
  regional_staffer_fiscal_year_selection in 'protected\regional_staffer_fiscal_year_selection.pas' {regional_staffer_fiscal_year_selection.TWebForm_regional_staffer_fiscal_year_selection: ki_web_ui.page_class},
  regional_staffer_overview in 'protected\regional_staffer_overview.pas' {regional_staffer_overview.TWebForm_regional_staffer_overview: ki_web_ui.page_class},
  request_item_detail in 'protected\request_item_detail.pas' {request_item_detail.TWebForm_request_item_detail: ki_web_ui.page_class},
  request_overview in 'protected\request_overview.pas' {request_overview.TWebForm_request_overview: ki_web_ui.page_class},
  service_overview in 'protected\service_overview.pas' {service_overview.TWebForm_service_overview: ki_web_ui.page_class},
  Class_biz_regional_staffers in 'component\biz\Class_biz_regional_staffers.pas',
  Class_db_regional_staffers in 'component\db\Class_db_regional_staffers.pas',
  state_required_report in 'protected\state_required_report.pas' {state_required_report.TWebForm_state_required_report: ki_web_ui.page_class},
  login in 'login.pas' {login.TWebForm_login: ki_web_ui.page_class},
  state_transmittal_complete in 'protected\state_transmittal_complete.pas' {state_transmittal_complete.TWebForm_state_transmittal_complete: ki_web_ui.page_class},
  exception in 'exception.pas' {exception.TWebForm_exception: ki_web_ui.page_class},
  timeout in 'timeout.pas' {timeout.TWebForm_timeout: system.web.ui.page},
  Class_db_equipment in 'component\db\Class_db_equipment.pas',
  Class_biz_match_level in 'component\biz\Class_biz_match_level.pas',
  Class_biz_equipment in 'component\biz\Class_biz_equipment.pas',
  county_unrejection in 'protected\county_unrejection.pas' {county_unrejection.TWebForm_county_unrejection: ki_web_ui.page_class},
  milestone_sweep in 'noninteractive\milestone_sweep.pas' {milestone_sweep.TWebForm_milestone_sweep: system.web.ui.page},
  Class_biz_milestones in 'component\biz\Class_biz_milestones.pas',
  Class_db_milestones in 'component\db\Class_db_milestones.pas',
  Class_biz_counties in 'component\biz\Class_biz_counties.pas',
  Class_db_counties in 'component\db\Class_db_counties.pas',
  Class_db_trail in 'component\db\Class_db_trail.pas',
  add_proof_of_payment in 'protected\add_proof_of_payment.pas' {add_proof_of_payment.TWebForm_add_proof_of_payment: ki_web_ui.page_class},
  Class_biz_payment_proof_methods in 'component\biz\Class_biz_payment_proof_methods.pas',
  Class_db_payment_proof_methods in 'component\db\Class_db_payment_proof_methods.pas';

const ID = '$Id$';

//
// General Information about an assembly is controlled through the following
// set of attributes. Change these attribute values to modify the information
// associated with an assembly.
//
[assembly: AssemblyDescription('')]
[assembly: AssemblyConfiguration('')]
[assembly: AssemblyCompany('')]
[assembly: AssemblyProduct('')]
[assembly: AssemblyCopyright('')]
[assembly: AssemblyTrademark('')]
[assembly: AssemblyCulture('')]

// The Delphi compiler controls the AssemblyTitleAttribute via the ExeDescription.
// You can set this in the IDE via the Project Options.
// Manually setting the AssemblyTitle attribute below will override the IDE
// setting.
// [assembly: AssemblyTitle('')]


//
// Version information for an assembly consists of the following four values:
//
//      Major Version
//      Minor Version
//      Build Number
//      Revision
//
// You can specify all the values or you can default the Revision and Build Numbers
// by using the '*' as shown below:

[assembly: AssemblyVersion('1.0.*')]

//
// In order to sign your assembly you must specify a key to use. Refer to the
// Microsoft .NET Framework documentation for more information on assembly signing.
//
// Use the attributes below to control which key is used for signing.
//
// Notes:
//   (*) If no key is specified, the assembly is not signed.
//   (*) KeyName refers to a key that has been installed in the Crypto Service
//       Provider (CSP) on your machine. KeyFile refers to a file which contains
//       a key.
//   (*) If the KeyFile and the KeyName values are both specified, the
//       following processing occurs:
//       (1) If the KeyName can be found in the CSP, that key is used.
//       (2) If the KeyName does not exist and the KeyFile does exist, the key
//           in the KeyFile is installed into the CSP and used.
//   (*) In order to create a KeyFile, you can use the sn.exe (Strong Name) utility.
//       When specifying the KeyFile, the location of the KeyFile should be
//       relative to the project output directory which is
//       %Project Directory%\bin\<configuration>. For example, if your KeyFile is
//       located in the project directory, you would specify the AssemblyKeyFile
//       attribute as [assembly: AssemblyKeyFile('..\\..\\mykey.snk')]
//   (*) Delay Signing is an advanced option - see the Microsoft .NET Framework
//       documentation for more information on this.
//
[assembly: AssemblyDelaySign(false)]
[assembly: AssemblyKeyFile('')]
[assembly: AssemblyKeyName('')]

begin
end.
