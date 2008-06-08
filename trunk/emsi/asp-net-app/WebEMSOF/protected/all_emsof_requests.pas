unit all_emsof_requests;

interface

uses
  System.Collections, System.ComponentModel,
  System.Data, System.Drawing, System.Web, System.Web.SessionState,
  system.web.ui, ki_web_ui, System.Web.UI.WebControls, System.Web.UI.HtmlControls, kix, system.configuration, system.web.security,
  mysql.data.mysqlclient,
  Class_biz_emsof_requests,
  Class_biz_user,
  UserControl_print_div;

type
  p_type =
    RECORD
    biz_emsof_requests: Class_biz_emsof_requests.TClass_biz_emsof_requests;
    be_datagrid_empty: boolean;
    be_sort_order_ascending: boolean;
    biz_user: TClass_biz_user;
    distribution_list: string;
    num_datagrid_rows: cardinal;
    sort_order: string;
    END;
  TWebForm_all_emsof_requests = class(ki_web_ui.page_class)
  {$REGION 'Designer Managed Code'}
  strict private
    procedure InitializeComponent;
    procedure TWebForm_all_emsof_requests_PreRender(sender: System.Object;
      e: System.EventArgs);
    procedure DataGrid_requests_ItemDataBound(sender: System.Object; e: System.Web.UI.WebControls.DataGridItemEventArgs);
    procedure DataGrid_requests_SortCommand(source: System.Object; e: System.Web.UI.WebControls.DataGridSortCommandEventArgs);
    procedure DataGrid_requests_ItemCommand(source: System.Object; e: System.Web.UI.WebControls.DataGridCommandEventArgs);
    procedure Button_send_Click(sender: System.Object; e: System.EventArgs);
  {$ENDREGION}
  strict private
    p: p_type;
    procedure Bind;
    procedure Page_Load(sender: System.Object; e: System.EventArgs);
  strict protected
    Title: System.Web.UI.HtmlControls.HtmlGenericControl;
    PlaceHolder_precontent: System.Web.UI.WebControls.PlaceHolder;
    PlaceHolder_postcontent: System.Web.UI.WebControls.PlaceHolder;
    TableRow_none: System.Web.UI.HtmlControls.HtmlTableRow;
    DataGrid_requests: System.Web.UI.WebControls.DataGrid;
    Label_num_datagrid_rows: System.Web.UI.WebControls.Label;
    UserControl_print_div: TWebUserControl_print_div;
    TableRow_data: System.Web.UI.HtmlControls.HtmlTableRow;
    TextBox_quick_message_subject: System.Web.UI.WebControls.TextBox;
    TextBox_quick_message_body: System.Web.UI.WebControls.TextBox;
    RequiredFieldValidator_quick_message_body: System.Web.UI.WebControls.RequiredFieldValidator;
    Button_send: System.Web.UI.WebControls.Button;
    Label_distribution_list: System.Web.UI.WebControls.Label;
    Table_quick_message: System.Web.UI.HtmlControls.HtmlTable;
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
procedure TWebForm_all_emsof_requests.InitializeComponent;
begin
  Include(Self.DataGrid_requests.ItemDataBound, Self.DataGrid_requests_ItemDataBound);
  Include(Self.DataGrid_requests.SortCommand, Self.DataGrid_requests_SortCommand);
  Include(Self.DataGrid_requests.ItemCommand, Self.DataGrid_requests_ItemCommand);
  Include(Self.Button_send.Click, Self.Button_send_Click);
  Include(Self.PreRender, Self.TWebForm_all_emsof_requests_PreRender);
  Include(Self.Load, Self.Page_Load);
end;
{$ENDREGION}

procedure TWebForm_all_emsof_requests.Page_Load(sender: System.Object; e: System.EventArgs);
begin
  if IsPostback and (session['p'].GetType.namespace = p.GetType.namespace) then begin
    p := p_type(session['p']);
  end else begin
    if request.servervariables['URL'] = request.currentexecutionfilepath then begin
      session.Clear;
      server.Transfer('~/login.aspx');
    end;
    //
    Title.InnerText := server.HtmlEncode(configurationmanager.AppSettings['application_name']) + ' - all_emsof_requests';
    //
    // Initialize private class instance vars.
    //
    p.biz_emsof_requests := TClass_biz_emsof_requests.Create;
    p.biz_user := TClass_biz_user.Create;
    p.be_sort_order_ascending := TRUE;
    p.num_datagrid_rows := 0;
    p.sort_order := 'service_name';
    //
    Bind;
    //
  end;
end;

procedure TWebForm_all_emsof_requests.OnInit(e: EventArgs);
begin
  //
  // Required for Designer support
  //
  InitializeComponent;
  inherited OnInit(e);
end;

procedure TWebForm_all_emsof_requests.Button_send_Click(sender: System.Object;
  e: System.EventArgs);
begin
  kix.SmtpMailSend
    (
    // from
    configurationmanager.appsettings['sender_email_address'],
    // to
    Label_distribution_list.text,
    // subject
    TextBox_quick_message_subject.text,
    // body
    '-- From ' + session[p.biz_user.Kind + '_name'].tostring + ' (via ' + configurationmanager.appsettings['application_name']
    + ')' + NEW_LINE
    + NEW_LINE
    + TextBox_quick_message_body.text
    );
  TextBox_quick_message_subject.text := EMPTY;
  TextBox_quick_message_body.text := EMPTY;
  Alert(LOGIC,NORMAL,'messagsnt','Message sent');
end;

procedure TWebForm_all_emsof_requests.DataGrid_requests_ItemCommand(source: System.Object;
  e: System.Web.UI.WebControls.DataGridCommandEventArgs);
begin
  if e.commandname = 'Select' then begin
    case p.biz_emsof_requests.StatusOf(e.item) of
    NEEDS_SENT_TO_PA_DOH_EMSO:
      BEGIN
      SessionSet('status_of_interest',NEEDS_SENT_TO_PA_DOH_EMSO);
      system.collections.stack(session['waypoint_stack']).Push('all_emsof_requests.aspx');
      DropCrumbAndTransferTo('state_required_report.aspx');
      END
    else
      BEGIN
      SessionSet('account_descriptor',session['regional_staffer_name'].tostring);
      SessionSet('e_item',e.item);
      system.collections.stack(session['waypoint_stack']).Push('all_emsof_requests.aspx');
      DropCrumbAndTransferTo('full_request_review_approve.aspx');
      END;
    end;
  end;
end;

procedure TWebForm_all_emsof_requests.DataGrid_requests_SortCommand(source: System.Object;
  e: System.Web.UI.WebControls.DataGridSortCommandEventArgs);
begin
  if e.SortExpression = p.sort_order then begin
    p.be_sort_order_ascending := not p.be_sort_order_ascending;
  end else begin
    p.sort_order := e.SortExpression;
    p.be_sort_order_ascending := TRUE;
  end;
  DataGrid_requests.EditItemIndex := -1;
  Bind;
end;

procedure TWebForm_all_emsof_requests.DataGrid_requests_ItemDataBound(sender: System.Object;
  e: System.Web.UI.WebControls.DataGridItemEventArgs);
begin
  if (e.item.itemtype = listitemtype.alternatingitem)
    or (e.item.itemtype = listitemtype.edititem)
    or (e.item.itemtype = listitemtype.item)
    or (e.item.itemtype = listitemtype.selecteditem)
  then begin
    //
    // We are dealing with a data row, not a header or footer row.
    //
    p.num_datagrid_rows := p.num_datagrid_rows + 1;
    if p.biz_emsof_requests.BeOkToDrillDown(status_type(convert.ToInt16(e.item.cells[p.biz_emsof_requests.TcciOfStatusCode].text)))
    then begin
      LinkButton(e.item.cells[p.biz_emsof_requests.TcciOfStatusDescription].controls.item[0]).enabled := TRUE;
      LinkButton(e.item.cells[p.biz_emsof_requests.TcciOfStatusDescription].controls.item[0]).forecolor := color.BLUE;
      if p.biz_emsof_requests.BeOkToApproveEmsofRequest
        (status_type(convert.ToInt16(e.item.cells[p.biz_emsof_requests.TcciOfStatusCode].text)))
      then begin
        LinkButton(e.item.cells[p.biz_emsof_requests.TcciOfStatusDescription].controls.item[0]).font.bold := TRUE;
        LinkButton(e.item.cells[p.biz_emsof_requests.TcciOfStatusDescription].controls.item[0]).text :=
          '>' + LinkButton(e.item.cells[p.biz_emsof_requests.TcciOfStatusDescription].controls.item[0]).text.ToUpper + '<';
      end;
    end else begin
      LinkButton(e.item.cells[p.biz_emsof_requests.TcciOfStatusDescription].controls.item[0]).enabled := FALSE;
    end;
    //
    if e.item.cells[p.biz_emsof_requests.TcciOfPasswordResetEmailAddress].text <> '&nbsp;' then begin
       p.distribution_list := p.distribution_list + e.item.cells[p.biz_emsof_requests.TcciOfPasswordResetEmailAddress].text + COMMA_SPACE;
    end;
    //
  end;
end;

procedure TWebForm_all_emsof_requests.TWebForm_all_emsof_requests_PreRender(sender: System.Object;
  e: System.EventArgs);
begin
  SessionSet('p',p);
end;

procedure TWebForm_all_emsof_requests.Bind;
begin
  p.biz_emsof_requests.BindOverviewAll
    (
    p.sort_order,
    p.be_sort_order_ascending,
    DataGrid_requests
    );
  //
  // Manage control visibilities.
  //
  p.be_datagrid_empty := (p.num_datagrid_rows = 0);
  TableRow_none.visible := p.be_datagrid_empty;
  TableRow_data.visible := not p.be_datagrid_empty;
  Table_quick_message.visible := not p.be_datagrid_empty;
  Label_distribution_list.text := (p.distribution_list + SPACE).TrimEnd([',',' ']);
  //
  // Clear aggregation vars for next bind, if any.
  //
  Label_num_datagrid_rows.text := p.num_datagrid_rows.tostring;
  p.num_datagrid_rows := 0;
  //
end;

end.

