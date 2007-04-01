unit emsof_request_status_filter;

interface

uses
  System.Collections, System.ComponentModel,
  System.Data, System.Drawing, System.Web, System.Web.SessionState,
  system.web.ui, ki_web_ui, System.Web.UI.WebControls, System.Web.UI.HtmlControls, ki, system.configuration, system.web.security,
  borland.data.provider,
  system.io,
  Class_biz_emsof_requests,
  Class_biz_user,
  UserControl_print_div;

type
  p_type =
    RECORD
    be_sort_order_ascending: boolean;
    biz_emsof_requests: TClass_biz_emsof_requests;
    biz_user: TClass_biz_user;
    distribution_list: string;
    num_qualifying_requests: cardinal;
    sort_order: string;
    END;
  TWebForm_emsof_request_status_filter = class(ki_web_ui.page_class)
  {$REGION 'Designer Managed Code'}
  strict private
    procedure InitializeComponent;
    procedure LinkButton_logout_Click(sender: System.Object; e: System.EventArgs);
    procedure DataGrid_requests_SortCommand(source: System.Object; e: System.Web.UI.WebControls.DataGridSortCommandEventArgs);
    procedure DataGrid_requests_ItemCommand(source: System.Object; e: System.Web.UI.WebControls.DataGridCommandEventArgs);
    procedure DataGrid_requests_ItemDataBound(sender: System.Object; e: System.Web.UI.WebControls.DataGridItemEventArgs);
    procedure TWebForm_emsof_request_status_filter_PreRender(sender: System.Object;
      e: System.EventArgs);
    procedure LinkButton_back_Click(sender: System.Object; e: System.EventArgs);
    procedure LinkButton_retransmit_to_state_Click(sender: System.Object; e: System.EventArgs);
    procedure LinkButton_change_password_Click(sender: System.Object; e: System.EventArgs);
    procedure LinkButton_change_email_address_Click(sender: System.Object; e: System.EventArgs);
    procedure Button_send_Click(sender: System.Object; e: System.EventArgs);
  {$ENDREGION}
  strict private
    p: p_type;
    procedure BindOverview;
    procedure Page_Load(sender: System.Object; e: System.EventArgs);
  strict protected
    Title: System.Web.UI.HtmlControls.HtmlGenericControl;
    PlaceHolder_precontent: System.Web.UI.WebControls.PlaceHolder;
    PlaceHolder_postcontent: System.Web.UI.WebControls.PlaceHolder;
    LinkButton_logout: System.Web.UI.WebControls.LinkButton;
    LinkButton_change_password: System.Web.UI.WebControls.LinkButton;
    LinkButton_change_email_address: System.Web.UI.WebControls.LinkButton;
    Label_account_descriptor: System.Web.UI.WebControls.Label;
    DataGrid_requests: System.Web.UI.WebControls.DataGrid;
    TableRow_none: System.Web.UI.HtmlControls.HtmlTableRow;
    Label_status: System.Web.UI.WebControls.Label;
    LinkButton_back: System.Web.UI.WebControls.LinkButton;
    TableRow_spreadsheet: System.Web.UI.HtmlControls.HtmlTableRow;
    LinkButton_retransmit_to_state: System.Web.UI.WebControls.LinkButton;
    UserControl_print_div: TWebUserControl_print_div;
    TableRow_data: System.Web.UI.HtmlControls.HtmlTableRow;
    TextBox_quick_message_subject: System.Web.UI.WebControls.TextBox;
    TextBox_quick_message_body: System.Web.UI.WebControls.TextBox;
    RequiredFieldValidator_quick_message_body: System.Web.UI.WebControls.RequiredFieldValidator;
    Button_send: System.Web.UI.WebControls.Button;
    Label_distribution_list: System.Web.UI.WebControls.Label;
    Table_quick_message: System.Web.UI.HtmlControls.HtmlTable;
    procedure OnInit(e: EventArgs); override;
  private
    { Private Declarations }
  end;

implementation

uses
  appcommon;

const
  TCCI_LINKBUTTON_SELECT = 14;

{$REGION 'Designer Managed Code'}
/// <summary>
/// Required method for Designer support -- do not modify
/// the contents of this method with the code editor.
/// </summary>
procedure TWebForm_emsof_request_status_filter.InitializeComponent;
begin
  Include(Self.LinkButton_logout.Click, Self.LinkButton_logout_Click);
  Include(Self.LinkButton_back.Click, Self.LinkButton_back_Click);
  Include(Self.LinkButton_change_password.Click, Self.LinkButton_change_password_Click);
  Include(Self.LinkButton_change_email_address.Click, Self.LinkButton_change_email_address_Click);
  Include(Self.LinkButton_retransmit_to_state.Click, Self.LinkButton_retransmit_to_state_Click);
  Include(Self.DataGrid_requests.ItemCommand, Self.DataGrid_requests_ItemCommand);
  Include(Self.DataGrid_requests.SortCommand, Self.DataGrid_requests_SortCommand);
  Include(Self.DataGrid_requests.ItemDataBound, Self.DataGrid_requests_ItemDataBound);
  Include(Self.Button_send.Click, Self.Button_send_Click);
  Include(Self.Load, Self.Page_Load);
  Include(Self.PreRender, Self.TWebForm_emsof_request_status_filter_PreRender);
end;
{$ENDREGION}

procedure TWebForm_emsof_request_status_filter.Page_Load(sender: System.Object; e: System.EventArgs);
begin
  appcommon.PopulatePlaceHolders(PlaceHolder_precontent,PlaceHolder_postcontent);
  if IsPostback and (session['p'].GetType.namespace = p.GetType.namespace) then begin
    p := p_type(session['p']);
  end else begin
    if request.servervariables['URL'] = request.currentexecutionfilepath then begin
      session.Clear;
      server.Transfer('~/login.aspx');
    end;
    //
    Title.InnerText := server.HtmlEncode(ConfigurationSettings.AppSettings['application_name']) + ' - emsof_request_status_filter';
    
    Label_account_descriptor.text := session[session['target_user_table'].tostring + '_name'].tostring;
    Label_status.text := session['status_of_interest'].tostring;
    LinkButton_retransmit_to_state.visible := (status_type(session['status_of_interest']) = NEEDS_PA_DOH_EMSO_APPROVAL);
    //
    // Initialize instance private data members.
    //
    p.biz_emsof_requests := TClass_biz_emsof_requests.Create;
    p.biz_user := TClass_biz_user.Create;
    p.be_sort_order_ascending := TRUE;
    p.num_qualifying_requests := 0;
    p.sort_order := 'affiliate_num';
    //
    UserControl_print_div.text := '[print]';
    BindOverview;
    //
  end;
end;

procedure TWebForm_emsof_request_status_filter.OnInit(e: EventArgs);
begin
  //
  // Required for Designer support
  //
  InitializeComponent;
  inherited OnInit(e);
end;

procedure TWebForm_emsof_request_status_filter.Button_send_Click(sender: System.Object;
  e: System.EventArgs);
begin
  ki.SmtpMailSend
    (
    // from
    configurationsettings.appsettings['sender_email_address'],
    // to
    Label_distribution_list.text,
    // subject
    TextBox_quick_message_subject.text,
    // body
    '-- From ' + session[p.biz_user.Kind + '_name'].tostring + ' (via ' + configurationsettings.appsettings['application_name']
    + ')' + NEW_LINE
    + NEW_LINE
    + TextBox_quick_message_body.text
    );
  TextBox_quick_message_subject.text := system.string.EMPTY;
  TextBox_quick_message_body.text := system.string.EMPTY;
  Alert('Button_send_Click_alert','Message sent');
end;

procedure TWebForm_emsof_request_status_filter.LinkButton_change_email_address_Click(sender: System.Object;
  e: System.EventArgs);
begin
  server.Transfer('change_email_address.aspx');
end;

procedure TWebForm_emsof_request_status_filter.LinkButton_change_password_Click(sender: System.Object;
  e: System.EventArgs);
begin
  server.Transfer('change_password.aspx');
end;

procedure TWebForm_emsof_request_status_filter.LinkButton_retransmit_to_state_Click(sender: System.Object;
  e: System.EventArgs);
begin
  server.Transfer('state_required_report.aspx');
end;

procedure TWebForm_emsof_request_status_filter.LinkButton_back_Click
  (
  sender: System.Object;
  e: System.EventArgs
  );
begin
  server.Transfer(stack(session['waypoint_stack']).Pop.tostring);
end;

procedure TWebForm_emsof_request_status_filter.TWebForm_emsof_request_status_filter_PreRender
  (
  sender: System.Object;
  e: System.EventArgs
  );
begin
  session.Remove('p');
  session.Add('p',p);
end;

procedure TWebForm_emsof_request_status_filter.DataGrid_requests_ItemDataBound
  (
  sender: System.Object;
  e: System.Web.UI.WebControls.DataGridItemEventArgs
  );
begin
  //
  // Manage column visibility
  //
  e.item.cells[tcci_linkbutton_select].visible :=
    p.biz_emsof_requests.BeOkToDrillDown(Class_biz_emsof_requests.status_type(session['status_of_interest']));
  //
  if (e.item.itemtype = listitemtype.alternatingitem)
    or (e.item.itemtype = listitemtype.edititem)
    or (e.item.itemtype = listitemtype.item)
    or (e.item.itemtype = listitemtype.selecteditem)
  then begin
    //
    // We are dealing with a data row, not a header or footer row.
    //
    if e.item.cells[p.biz_emsof_requests.TcciOfPasswordResetEmailAddress].text <> '&nbsp;' then begin
       p.distribution_list := p.distribution_list + e.item.cells[p.biz_emsof_requests.TcciOfPasswordResetEmailAddress].text + ', ';
    end;
    //
    p.num_qualifying_requests := p.num_qualifying_requests + 1;
    //
  end;
end;

procedure TWebForm_emsof_request_status_filter.DataGrid_requests_ItemCommand
  (
  source: System.Object;
  e: System.Web.UI.WebControls.DataGridCommandEventArgs
  );
begin
  //
  if (e.item.itemtype = listitemtype.alternatingitem)
    or (e.item.itemtype = listitemtype.edititem)
    or (e.item.itemtype = listitemtype.item)
    or (e.item.itemtype = listitemtype.selecteditem)
  then begin
    //
    // We are dealing with a data row, not a header or footer row.
    //
    system.collections.stack(session['waypoint_stack']).Push('emsof_request_status_filter.aspx');
    session.Remove('account_descriptor');
    session.Add('account_descriptor',session['regional_staffer_name'].ToString);
    session.Remove('e_item');
    session.Add('e_item',e.item);
    //
    server.Transfer('full_request_review_approve.aspx');
  end;
  //
end;

procedure TWebForm_emsof_request_status_filter.DataGrid_requests_SortCommand
  (
  source: System.Object;
  e: System.Web.UI.WebControls.DataGridSortCommandEventArgs
  );
begin
  if e.SortExpression = p.sort_order then begin
    p.be_sort_order_ascending := not p.be_sort_order_ascending;
  end else begin
    p.sort_order := e.SortExpression;
    p.be_sort_order_ascending := TRUE;
  end;
  DataGrid_requests.EditItemIndex := -1;
  BindOverview;
end;

procedure TWebForm_emsof_request_status_filter.LinkButton_logout_Click
  (
  sender: System.Object;
  e: System.EventArgs
  );
begin
  formsauthentication.SignOut;
  session.Clear;
  server.Transfer('../Default.aspx');
end;

procedure TWebForm_emsof_request_status_filter.BindOverview;
var
  be_datagrid_empty: boolean;
begin
  //
  p.biz_emsof_requests.BindOverviewByStatus
    (
    Class_biz_emsof_requests.status_type(session['status_of_interest']),
    p.sort_order,
    p.be_sort_order_ascending,
    DataGrid_requests
    );
  //
  // Manage control visibilities.
  //
  be_datagrid_empty := (p.num_qualifying_requests = 0);
  TableRow_none.visible := be_datagrid_empty;
  TableRow_data.visible := not be_datagrid_empty;
  LinkButton_retransmit_to_state.enabled := not be_datagrid_empty;
  Table_quick_message.visible := not be_datagrid_empty;
  Label_distribution_list.text := (p.distribution_list + SPACE).TrimEnd([',',' ']);
  //
  // Clear aggregation vars for next bind, if any.
  //
  p.num_qualifying_requests := 0;
  //
end;

end.

