unit regional_staffer_overview;

interface

uses
  System.Collections, System.ComponentModel,
  System.Data, System.Drawing, System.Web, System.Web.SessionState,
  system.web.ui, ki_web_ui, System.Web.UI.WebControls, System.Web.UI.HtmlControls, kix, system.configuration, system.web.security,
  system.text;

type
  TWebForm_regional_staffer_overview = class(ki_web_ui.page_class)
  {$REGION 'Designer Managed Code'}
  strict private
    procedure InitializeComponent;
  {$ENDREGION}
  strict private
    procedure Page_Load(sender: System.Object; e: System.EventArgs);
  strict protected
    Title: htmltitle;
    PlaceHolder_precontent: System.Web.UI.WebControls.PlaceHolder;
    PlaceHolder_postcontent: System.Web.UI.WebControls.PlaceHolder;
  protected
    procedure OnInit(e: EventArgs); override;
  end;

implementation

{$REGION 'Designer Managed Code'}
/// <summary>
/// Required method for Designer support -- do not modify
/// the contents of this method with the code editor.
/// </summary>
procedure TWebForm_regional_staffer_overview.InitializeComponent;
begin
  Include(Self.Load, Self.Page_Load);
end;
{$ENDREGION}

procedure TWebForm_regional_staffer_overview.Page_Load
  (
  sender: System.Object;
  e: System.EventArgs
  );
begin
  if not IsPostback then begin
    if (session['regional_staffer_name'] = nil) or (session['regional_staffer_user_id'] = nil) then begin
      session.Clear;
      DropCrumbAndTransferTo('~/login.aspx');
    end;
    //
    Title.text := server.HtmlEncode(configurationmanager.AppSettings['application_name']) + ' - regional_staffer_overview';
    //
    BeginBreadCrumbTrail;
    //
  end;
end;

procedure TWebForm_regional_staffer_overview.OnInit(e: EventArgs);
begin
  //
  // Required for Designer support
  //
  InitializeComponent;
  inherited OnInit(e);
end;

end.

