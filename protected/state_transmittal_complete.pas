unit state_transmittal_complete;

interface

uses
  System.Collections, System.ComponentModel,
  System.Data, System.Drawing, System.Web, System.Web.SessionState,
  system.web.ui, ki_web_ui, System.Web.UI.WebControls, System.Web.UI.HtmlControls, kix, system.configuration, system.web.security;

const ID = '$Id$';

type
  p_type =
    RECORD
    END;
  TWebForm_state_transmittal_complete = class(ki_web_ui.page_class)
  {$REGION 'Designer Managed Code'}
  strict private
    procedure InitializeComponent;
    procedure TWebForm_state_transmittal_complete_PreRender(sender: System.Object;
      e: System.EventArgs);
    procedure Button_return_to_overview_Click(sender: System.Object; e: System.EventArgs);
  {$ENDREGION}
  strict private
    p: p_type;
    procedure Page_Load(sender: System.Object; e: System.EventArgs);
  strict protected
    Title: System.Web.UI.HtmlControls.HtmlGenericControl;
    PlaceHolder_precontent: System.Web.UI.WebControls.PlaceHolder;
    PlaceHolder_postcontent: System.Web.UI.WebControls.PlaceHolder;
    Label_account_descriptor: System.Web.UI.WebControls.Label;
    LinkButton_back: System.Web.UI.WebControls.LinkButton;
    Label_application_name: System.Web.UI.WebControls.Label;
    Button_return_to_overview: System.Web.UI.WebControls.Button;
  protected
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
procedure TWebForm_state_transmittal_complete.InitializeComponent;
begin
  Include(Self.Button_return_to_overview.Click, Self.Button_return_to_overview_Click);
  Include(Self.Load, Self.Page_Load);
  Include(Self.PreRender, Self.TWebForm_state_transmittal_complete_PreRender);
end;
{$ENDREGION}

procedure TWebForm_state_transmittal_complete.Page_Load(sender: System.Object; e: System.EventArgs);
begin
  if IsPostback then begin
    if assigned(session['state_transmittal_complete.p']) then begin
      p := p_type(session['state_transmittal_complete.p']);
    end else begin
      server.Transfer('~/timeout.aspx');
    end;
  end else begin
    if request.servervariables['URL'] = request.currentexecutionfilepath then begin
      session.Clear;
      server.Transfer('~/login.aspx');
    end;
    //
    Title.InnerText := server.HtmlEncode(configurationmanager.AppSettings['application_name']) + ' - state_transmittal_complete';
    Label_account_descriptor.text := session.item['regional_staffer_name'].tostring;
    Label_application_name.text := configurationmanager.appsettings['application_name'];
    //
  end;
end;

procedure TWebForm_state_transmittal_complete.OnInit(e: EventArgs);
begin
  //
  // Required for Designer support
  //
  InitializeComponent;
  inherited OnInit(e);
end;

procedure TWebForm_state_transmittal_complete.Button_return_to_overview_Click(sender: System.Object;
  e: System.EventArgs);
begin
  BackTrack(2);
end;

procedure TWebForm_state_transmittal_complete.TWebForm_state_transmittal_complete_PreRender(sender: System.Object;
  e: System.EventArgs);
begin
  SessionSet('state_transmittal_complete.p',p);
end;

end.

