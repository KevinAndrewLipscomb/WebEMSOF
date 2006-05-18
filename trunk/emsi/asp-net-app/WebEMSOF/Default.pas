
unit Default;

interface

uses
  System.Collections, System.ComponentModel,
  System.Data, System.Drawing, System.Web, System.Web.SessionState,
  System.Web.UI, System.Web.UI.WebControls, System.Web.UI.HtmlControls, AppCommon, system.configuration;

type
  TWebForm_Default = class(System.Web.UI.Page)
  {$REGION 'Designer Managed Code'}
  strict private
    procedure InitializeComponent;
  {$ENDREGION}
  strict private
    procedure Page_Load(sender: System.Object; e: System.EventArgs);
  strict protected
    Title: System.Web.UI.HtmlControls.HtmlGenericControl;
    PlaceHolder_precontent: System.Web.UI.WebControls.PlaceHolder;
    PlaceHolder_postcontent: System.Web.UI.WebControls.PlaceHolder;
    Label_application_name: System.Web.UI.WebControls.Label;
    HyperLink_login: System.Web.UI.WebControls.HyperLink;
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
procedure TWebForm_Default.InitializeComponent;
begin
  Include(Self.Load, Self.Page_Load);
end;
{$ENDREGION}

const ID = '$Id$';

procedure TWebForm_Default.Page_Load(sender: System.Object; e: System.EventArgs);
begin
  AppCommon.PopulatePlaceHolders(PlaceHolder_precontent,PlaceHolder_postcontent);
  if not IsPostback then begin
    Title.InnerText := server.HtmlEncode(ConfigurationSettings.AppSettings['application_name']) + ' - Default';
    Label_application_name.text := ConfigurationSettings.AppSettings['application_name'];
    //
    if session.item['target_user_table'] <> nil then begin
      server.Transfer('protected/' + session.item['target_user_table'].tostring + '_overview.aspx');
    end;
    //
  end;
end;

procedure TWebForm_Default.OnInit(e: EventArgs);
begin
  //
  // Required for Designer support
  //
  InitializeComponent;
  inherited OnInit(e);
end;

end.

