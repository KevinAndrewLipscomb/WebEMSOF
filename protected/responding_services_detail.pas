unit responding_services_detail;
  // Derived from KiAspdotnetFramework/protected/template~protected~nonlanding.pas~template

interface

uses
  System.Collections, System.ComponentModel,
  System.Data, System.Drawing, System.Web, System.Web.SessionState,
  System.Web.UI, System.Web.UI.WebControls, System.Web.UI.HtmlControls, system.configuration, system.web.security,
  ki_web_ui;

type
  TWebForm_responding_services_detail = class(ki_web_ui.page_class)
  {$REGION 'Designer Managed Code'}
  strict private
    procedure InitializeComponent;
    procedure TWebForm_responding_services_detail_PreRender(sender: System.Object;
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
    UpdatePanel_control: System.Web.UI.UpdatePanel;
  protected
    procedure OnInit(e: EventArgs); override;
  end;

implementation

{$REGION 'Designer Managed Code'}
/// <summary>
/// Required method for Designer support -- do not modify
/// the contents of this method with the code editor.
/// </summary>
procedure TWebForm_responding_services_detail.InitializeComponent;
begin
  Include(Self.PreRender, Self.TWebForm_responding_services_detail_PreRender);
  Include(Self.Load, Self.Page_Load);
end;
{$ENDREGION}

procedure TWebForm_responding_services_detail.Page_Load(sender: System.Object; e: System.EventArgs);
begin
  if not IsPostback then begin
    //
    Title.text := configurationmanager.appsettings['application_name'] + ' - responding_services_detail';
    //
  end;
end;

procedure TWebForm_responding_services_detail.OnInit(e: EventArgs);
begin
  //
  // Required for Designer support
  //
  InitializeComponent;
  inherited OnInit(e);
  //
  case NatureOfVisit('responding_services_detail.p') of
  VISIT_INITIAL:
    BEGIN
    END;
  VISIT_POSTBACK_STANDARD:
    BEGIN
    p := p_type(session['responding_services_detail.p']);
    END;
  end;
  //
end;

procedure TWebForm_responding_services_detail.TWebForm_responding_services_detail_PreRender(sender: System.Object;
  e: System.EventArgs);
begin
  SessionSet('responding_services_detail.p',p);
end;

end.

