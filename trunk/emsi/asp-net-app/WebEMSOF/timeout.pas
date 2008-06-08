unit timeout;

interface

uses
  System.Collections, System.ComponentModel,
  System.Data, System.Drawing, System.Web, System.Web.SessionState,
  system.web.ui, System.Web.UI.WebControls, System.Web.UI.HtmlControls, kix, system.configuration,
  Class_biz_user,
  ki_web_ui,
  system.web.mail;

const ID = '$Id$';

type
  p_type =
    RECORD
    END;
  TWebForm_timeout = class(ki_web_ui.page_class)
  {$REGION 'Designer Managed Code'}
  strict private
    procedure InitializeComponent;
    procedure TWebForm_timeout_PreRender(sender: System.Object;
      e: System.EventArgs);
  {$ENDREGION}
  strict private
    p: p_type;
    procedure Page_Load(sender: System.Object; e: System.EventArgs);
  strict protected
    Title: System.Web.UI.HtmlControls.HtmlGenericControl;
    PlaceHolder_precontent: System.Web.UI.WebControls.PlaceHolder;
    PlaceHolder_postcontent: System.Web.UI.WebControls.PlaceHolder;
    HyperLink_login: System.Web.UI.WebControls.HyperLink;
  protected
    procedure OnInit(e: EventArgs); override;
  private
    { Private Declarations }
  public
    { Public Declarations }
  published
    property UICulture;
  end;

implementation
      
{$REGION 'Designer Managed Code'}
/// <summary>
/// Required method for Designer support -- do not modify
/// the contents of this method with the code editor.
/// </summary>
procedure TWebForm_timeout.InitializeComponent;
begin
  Include(Self.Load, Self.Page_Load);
  Include(Self.PreRender, Self.TWebForm_timeout_PreRender);
end;
{$ENDREGION}

procedure TWebForm_timeout.Page_Load(sender: System.Object; e: System.EventArgs);
begin
  if IsPostback and (session['p'].GetType.namespace = p.GetType.namespace) then begin
    p := p_type(session['p']);
  end else begin
    if request.servervariables['URL'] = request.currentexecutionfilepath then begin
      session.Clear;
      server.Transfer('~/login.aspx');
    end;
    Title.InnerText := server.HtmlEncode(configurationmanager.AppSettings['application_name']) + ' - timeout';
  end;
end;

procedure TWebForm_timeout.OnInit(e: EventArgs);
begin
  //
  // Required for Designer support
  //
  InitializeComponent;
  inherited OnInit(e);
end;

procedure TWebForm_timeout.TWebForm_timeout_PreRender(sender: System.Object;
  e: System.EventArgs);
begin
  SessionSet('p',p);
end;

end.

