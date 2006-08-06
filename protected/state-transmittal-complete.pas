
unit state_transmittal_complete;

interface

uses
  System.Collections, System.ComponentModel,
  System.Data, System.Drawing, System.Web, System.Web.SessionState,
  System.Web.UI, System.Web.UI.WebControls, System.Web.UI.HtmlControls, AppCommon, system.configuration, system.web.security;

const ID = '$Id$';

type
  p_type =
    RECORD
    END;
  TWebForm_state_transmittal_complete = class(System.Web.UI.Page)
  {$REGION 'Designer Managed Code'}
  strict private
    procedure InitializeComponent;
    procedure LinkButton_logout_Click(sender: System.Object; e: System.EventArgs);
    procedure TWebForm_state_transmittal_complete_PreRender(sender: System.Object;
      e: System.EventArgs);
    procedure LinkButton_back_Click(sender: System.Object; e: System.EventArgs);
  {$ENDREGION}
  //
  // Expected session objects:
  //
  //   waypoint_stack: system.collections.stack;
  //
  //
  strict private
    p: p_type;
    procedure Page_Load(sender: System.Object; e: System.EventArgs);
  strict protected
    Title: System.Web.UI.HtmlControls.HtmlGenericControl;
    PlaceHolder_precontent: System.Web.UI.WebControls.PlaceHolder;
    PlaceHolder_postcontent: System.Web.UI.WebControls.PlaceHolder;
    LinkButton_logout: System.Web.UI.WebControls.LinkButton;
    HyperLink_change_password: System.Web.UI.WebControls.HyperLink;
    HyperLink_change_email_address: System.Web.UI.WebControls.HyperLink;
    Label_account_descriptor: System.Web.UI.WebControls.Label;
    LinkButton_back: System.Web.UI.WebControls.LinkButton;
    LinkButton_drill_down: System.Web.UI.WebControls.LinkButton;
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
  Include(Self.LinkButton_logout.Click, Self.LinkButton_logout_Click);
  Include(Self.LinkButton_back.Click, Self.LinkButton_back_Click);
  Include(Self.LinkButton_drill_down.Click, Self.LinkButton_drill_down_Click);
  Include(Self.Load, Self.Page_Load);
  Include(Self.PreRender, Self.TWebForm_state_transmittal_complete_PreRender);
end;
{$ENDREGION}

procedure TWebForm_state_transmittal_complete.Page_Load(sender: System.Object; e: System.EventArgs);
begin
  AppCommon.PopulatePlaceHolders(PlaceHolder_precontent,PlaceHolder_postcontent);
  if IsPostback then begin
    p := p_type(session['p']);
  end else begin
    //
    Title.InnerText := server.HtmlEncode(ConfigurationSettings.AppSettings['application_name']) + ' - state_transmittal_complete';
    Label_account_descriptor.text := session.item['_name'].tostring;
    //
    {$REGION 'Keep this block iff the user lands on this form immediately after login.'}
    session.Remove('waypoint_stack');
    waypoint_stack := system.collections.stack.Create;
    waypoint_stack.Push('regional_staffer_overview.aspx');
    session.Add('waypoint_stack',waypoint_stack);
    {$ENDREGION}
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

{$REGION 'Waypoint management code for drill-down server.Transfer calls.'}
procedure TWebForm_regional_staffer_overview.LinkButton_drill_down_Click(sender: System.Object;
  e: System.EventArgs);
begin
  system.collections.stack(session['waypoint_stack']).Push('state_transmittal_complete.aspx');
  server.Transfer('detail.aspx');
end;
{$ENDREGION}

procedure TWebForm_emsof_request_status_filter.LinkButton_back_Click(sender: System.Object;
  e: System.EventArgs);
begin
  server.Transfer(stack(session['waypoint_stack']).Pop.tostring);
end;

procedure TWebForm_county_dictated_appropriations.TWebForm_county_dictated_appropriations_PreRender(sender: System.Object;
  e: System.EventArgs);
begin
  session.Remove('p');
  session.Add('p',p);
end;

procedure TWebForm_state_transmittal_complete.LinkButton_logout_Click(sender: System.Object;
  e: System.EventArgs);
begin
  formsauthentication.SignOut;
  session.Clear;
  server.Transfer('../Default.aspx');
end;

end.

