unit analyses;

interface

uses
  System.Collections, System.ComponentModel,
  System.Data, System.Drawing, System.Web, System.Web.SessionState,
  system.web.ui, ki_web_ui, System.Web.UI.WebControls, System.Web.UI.HtmlControls, kix,
  System.Data.Common, mysql.data.mysqlclient, System.Globalization,
  system.configuration, system.web.security,
  Class_biz_accounts,
  Class_biz_user,
  UserControl_print_div,
  UserControl_analyses_binder;

type
  p_type =
    RECORD
    biz_accounts: TClass_biz_accounts;
    biz_user: TClass_biz_user;
    END;
  TWebForm_analyses = class(ki_web_ui.page_class)
  {$REGION 'Designer Managed Code'}
  strict private
    procedure InitializeComponent;
    procedure TWebForm_analyses_PreRender(sender: System.Object;
      e: System.EventArgs);
  {$ENDREGION}
  strict private
    p: p_type;
    procedure Page_Load(sender: System.Object; e: System.EventArgs);
  strict protected
    Title: System.Web.UI.HtmlControls.HtmlGenericControl;
    PlaceHolder_analyses_binder: System.Web.UI.WebControls.PlaceHolder;
  protected
    procedure OnInit(e: EventArgs); override;
  private
    { Private Declarations }
  public
  end;

implementation

{$REGION 'Designer Managed Code'}
/// <summary>
/// Required method for Designer support -- do not modify
/// the contents of this method with the code editor.
/// </summary>
procedure TWebForm_analyses.InitializeComponent;
begin
  Include(Self.Load, Self.Page_Load);
  Include(Self.PreRender, Self.TWebForm_analyses_PreRender);
end;
{$ENDREGION}

procedure TWebForm_analyses.Page_Load(sender: System.Object; e: System.EventArgs);
begin
  if not IsPostback then begin
    //
    Title.InnerText := configurationmanager.AppSettings['application_name'] + ' - analyses';
    //
  end;
end;

procedure TWebForm_analyses.OnInit(e: EventArgs);
var
  waypoint_stack: stack;
begin
  //
  // Required for Designer support
  //
  InitializeComponent;
  inherited OnInit(e);
  //
  if IsPostback and (session['analyses.p'].GetType.namespace = p.GetType.namespace) then begin
    p := p_type(session['analyses.p']);
  end else begin
    if (session['regional_staffer_name'] = nil) or (session['regional_staffer_user_id'] = nil) then begin
      session.Clear;
      server.Transfer('~/login.aspx');
    end;
    //
    p.biz_user := TClass_biz_user.Create;
    p.biz_accounts := TClass_biz_accounts.Create;
    p.biz_accounts := TClass_biz_accounts.Create;
    //
    if p.biz_accounts.BeStalePassword(p.biz_user.Kind,p.biz_user.IdNum) then begin
      server.Transfer('change_password.aspx');
    end;
    //
    session.Remove('waypoint_stack');
    waypoint_stack := system.collections.stack.Create;
    session.Add('waypoint_stack',waypoint_stack);
    //
  end;
  //
  AddIdentifiedControlToPlaceHolder
    (
    TWebUserControl_analyses_binder(LoadControl('~/usercontrol/app/UserControl_analyses_binder.ascx')),
    'UserControl_analyses_binder',
    PlaceHolder_analyses_binder
    );
  //
end;

procedure TWebForm_analyses.TWebForm_analyses_PreRender(sender: System.Object;
  e: System.EventArgs);
begin
  session.Remove('analyses.p');
  session.Add('analyses.p',p);
end;

end.

