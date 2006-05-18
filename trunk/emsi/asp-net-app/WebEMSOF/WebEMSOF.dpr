library WebEMSOF;

{%AspWebConfigContainer 'Web.config'}
{%DelphiDotNetAssemblyCompiler '$(SystemRoot)\microsoft.net\framework\v1.1.4322\System.dll'}
{%DelphiDotNetAssemblyCompiler '$(SystemRoot)\microsoft.net\framework\v1.1.4322\System.Data.dll'}
{%DelphiDotNetAssemblyCompiler '$(SystemRoot)\microsoft.net\framework\v1.1.4322\System.Drawing.dll'}
{%DelphiDotNetAssemblyCompiler '$(SystemRoot)\microsoft.net\framework\v1.1.4322\System.Web.dll'}
{%DelphiDotNetAssemblyCompiler '$(SystemRoot)\microsoft.net\framework\v1.1.4322\System.XML.dll'}
{%AspMarkupContainer 'Global.asax'}
{%AspMarkupContainer 'login.aspx'}
{%DelphiDotNetAssemblyCompiler 'c:\program files\common files\borland shared\bds\shared assemblies\4.0\Borland.Data.Provider.dll'}
{%DelphiDotNetAssemblyCompiler '$(SystemRoot)\microsoft.net\framework\v1.1.4322\System.Windows.Forms.dll'}
{%DelphiDotNetAssemblyCompiler '$(SystemRoot)\microsoft.net\framework\v1.1.4322\System.Design.dll'}
{%DelphiDotNetAssemblyCompiler 'c:\program files\common files\borland shared\bds\shared assemblies\4.0\Borland.Data.Common.dll'}
{%DelphiDotNetAssemblyCompiler '$(SystemRoot)\microsoft.net\framework\v1.1.4322\mscorlib.dll'}
{%TogetherDiagram 'ModelSupport_WebEMSOF\default.txaPackage'}
{%File 'schema.sql'}
{%AspFolderContainer 'protected'}
{%AspMarkupContainer 'protected\change_email_address.aspx'}
{%AspMarkupContainer 'protected\change_password.aspx'}
{%AspMarkupContainer 'protected\county_dictated_appropriations.aspx'}
{%AspMarkupContainer 'protected\county_dictated_deadline.aspx'}
{%AspMarkupContainer 'protected\create_new_service_appropriation.aspx'}
{%AspMarkupContainer 'protected\delete_service_appropriation.aspx'}
{%AspMarkupContainer 'protected\finalize.aspx'}
{%AspMarkupContainer 'protected\profile.aspx'}
{%AspMarkupContainer 'protected\regional_staffer_overview.aspx'}
{%AspMarkupContainer 'protected\request_item_detail.aspx'}
{%AspMarkupContainer 'protected\request_overview.aspx'}
{%AspMarkupContainer 'protected\service_overview.aspx'}
{%AspMarkupContainer 'protected\withdraw_request_item.aspx'}
{%ConfigurationCompiler 'unpublished.config'}
{%AspWebConfigContainer 'protected\Web.config'}
{%AspMarkupContainer 'new_password.aspx'}
{%AspMarkupContainer 'protected\county_overview.aspx'}
{%AspMarkupContainer 'default.aspx'}

uses
  System.Reflection,
  System.Runtime.CompilerServices,
  Global in 'Global.pas' {Global.TGlobal: System.Web.HttpApplication},
  login in 'login.pas' {login.TWebForm_login: System.Web.UI.Page},
  AppCommon in 'AppCommon.pas',
  change_email_address in 'protected\change_email_address.pas',
  change_password in 'protected\change_password.pas' {change_password.TWebForm_change_password: System.Web.UI.Page},
  county_dictated_appropriations in 'protected\county_dictated_appropriations.pas',
  county_dictated_deadline in 'protected\county_dictated_deadline.pas',
  create_new_service_appropriation in 'protected\create_new_service_appropriation.pas',
  delete_service_appropriation in 'protected\delete_service_appropriation.pas' {delete_service_appropriation.TWebForm_delete_service_appropriation: System.Web.UI.Page},
  finalize in 'protected\finalize.pas',
  profile in 'protected\profile.pas',
  regional_staffer_overview in 'protected\regional_staffer_overview.pas' {regional_staffer_overview.TWebForm_account_overview: System.Web.UI.Page},
  request_item_detail in 'protected\request_item_detail.pas',
  request_overview in 'protected\request_overview.pas',
  service_overview in 'protected\service_overview.pas' {service_overview.TWebForm_service_overview: System.Web.UI.Page},
  withdraw_request_item in 'protected\withdraw_request_item.pas',
  new_password in 'new_password.pas' {new_password.TWebForm_new_password: System.Web.UI.Page},
  county_overview in 'protected\county_overview.pas' {county_overview.TWebForm_county_appropriation: System.Web.UI.Page},
  default in 'default.pas' {default.TWebForm_default: System.Web.UI.Page};

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
