unit analyses;

interface

uses
  System.Collections, System.ComponentModel,
  System.Data, System.Drawing, System.Web, System.Web.SessionState,
  system.web.ui, ki_web_ui, System.Web.UI.WebControls, System.Web.UI.HtmlControls, kix,
  System.Data.Common, mysql.data.mysqlclient, System.Globalization,
  system.configuration, system.web.security,
  UserControl_analyses_binder;

type
  TWebForm_analyses = class(ki_web_ui.page_class)
  {$REGION 'Designer Managed Code'}
  strict private
    procedure InitializeComponent;
    procedure TWebForm_analyses_PreRender(sender: System.Object;
      e: System.EventArgs);
  {$ENDREGION}
  strict private
    type
      p_type =
        RECORD
        END;
  strict private
    p: p_type;
    procedure Page_Load(sender: System.Object; e: System.EventArgs);
  strict protected
    Title: System.Web.UI.HtmlControls.HtmlTitle;
  protected
    procedure OnInit(e: EventArgs); override;
  end;

implementation

{$REGION 'Designer Managed Code'}
/// <summary>
/// Required method for Designer support -- do not modify
/// the contents of this method with the code editor.
/// </summary>
procedure TWebForm_analyses.InitializeComponent;
begin
  Include(Self.PreRender, Self.TWebForm_analyses_PreRender);
  Include(Self.Load, Self.Page_Load);
end;
{$ENDREGION}

procedure TWebForm_analyses.Page_Load(sender: System.Object; e: System.EventArgs);
begin
  if not IsPostback then begin
    //
    Title.text := configurationmanager.AppSettings['application_name'] + ' - analyses';
    //
  end;
end;

procedure TWebForm_analyses.OnInit(e: EventArgs);
begin
  //
  // Required for Designer support
  //
  InitializeComponent;
  inherited OnInit(e);
  //
  if IsPostback then begin
    if assigned(session['analyses.p']) then begin
      p := p_type(session['analyses.p']);
    end else begin
      server.Transfer('~/timeout.aspx');
    end;
  end else begin
    if (session['regional_staffer_name'] = nil) or (session['regional_staffer_user_id'] = nil) then begin
      session.Clear;
      server.Transfer('~/login.aspx');
    end;
    //
  end;
  //
end;

procedure TWebForm_analyses.TWebForm_analyses_PreRender(sender: System.Object;
  e: System.EventArgs);
begin
  SessionSet('analyses.p',p);
end;

end.

