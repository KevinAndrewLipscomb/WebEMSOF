
unit all_emsof_requests;

interface

uses
  System.Collections, System.ComponentModel,
  System.Data, System.Drawing, System.Web, System.Web.SessionState,
  System.Web.UI, System.Web.UI.WebControls, System.Web.UI.HtmlControls, ki.common, system.configuration, system.web.security,
  borland.data.provider,
  Class_biz_emsof_requests;

const ID = '$Id$';

type
  p_type =
    RECORD
    biz_emsof_requests: Class_biz_emsof_requests.TClass_biz_emsof_requests;
    be_datagrid_empty: boolean;
    be_sort_order_ascending: boolean;
    num_datagrid_rows: cardinal;
    sort_order: string;
    END;
  TWebForm_all_emsof_requests = class(System.Web.UI.Page)
  {$REGION 'Designer Managed Code'}
  strict private
    procedure InitializeComponent;
    procedure LinkButton_logout_Click(sender: System.Object; e: System.EventArgs);
    procedure LinkButton_back_Click(sender: System.Object; e: System.EventArgs);
    procedure TWebForm_all_emsof_requests_PreRender(sender: System.Object;
      e: System.EventArgs);
    procedure DataGrid_requests_ItemDataBound(sender: System.Object; e: System.Web.UI.WebControls.DataGridItemEventArgs);
    procedure DataGrid_requests_SortCommand(source: System.Object; e: System.Web.UI.WebControls.DataGridSortCommandEventArgs);
    procedure DataGrid_requests_ItemCommand(source: System.Object; e: System.Web.UI.WebControls.DataGridCommandEventArgs);
    procedure LinkButton_change_password_Click(sender: System.Object; e: System.EventArgs);
    procedure LinkButton_change_email_address_Click(sender: System.Object; e: System.EventArgs);
  {$ENDREGION}
  strict private
    p: p_type;
    procedure Bind;
    procedure Page_Load(sender: System.Object; e: System.EventArgs);
  strict protected
    Title: System.Web.UI.HtmlControls.HtmlGenericControl;
    PlaceHolder_precontent: System.Web.UI.WebControls.PlaceHolder;
    PlaceHolder_postcontent: System.Web.UI.WebControls.PlaceHolder;
    LinkButton_logout: System.Web.UI.WebControls.LinkButton;
    LinkButton_change_password: System.Web.UI.WebControls.LinkButton;
    LinkButton_change_email_address: System.Web.UI.WebControls.LinkButton;
    Label_account_descriptor: System.Web.UI.WebControls.Label;
    LinkButton_back: System.Web.UI.WebControls.LinkButton;
    TableRow_none: System.Web.UI.HtmlControls.HtmlTableRow;
    DataGrid_requests: System.Web.UI.WebControls.DataGrid;
    Label_num_datagrid_rows: System.Web.UI.WebControls.Label;
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
  Include(Self.LinkButton_logout.Click, Self.LinkButton_logout_Click);
  Include(Self.LinkButton_back.Click, Self.LinkButton_back_Click);
  Include(Self.LinkButton_change_password.Click, Self.LinkButton_change_password_Click);
  Include(Self.LinkButton_change_email_address.Click, Self.LinkButton_change_email_address_Click);
  Include(Self.DataGrid_requests.ItemCommand, Self.DataGrid_requests_ItemCommand);
  Include(Self.DataGrid_requests.SortCommand, Self.DataGrid_requests_SortCommand);
  Include(Self.DataGrid_requests.ItemDataBound, Self.DataGrid_requests_ItemDataBound);
  Include(Self.Load, Self.Page_Load);
  Include(Self.PreRender, Self.TWebForm_all_emsof_requests_PreRender);
end;
{$ENDREGION}

procedure TWebForm_all_emsof_requests.Page_Load(sender: System.Object; e: System.EventArgs);
begin
  ki.common.PopulatePlaceHolders(PlaceHolder_precontent,PlaceHolder_postcontent);
  if IsPostback and (session['p'].GetType.namespace = p.GetType.namespace) then begin
    p := p_type(session['p']);
  end else begin
    if request.servervariables['URL'] = request.currentexecutionfilepath then begin
      session.Clear;
      server.Transfer('~/login.aspx');
    end;
    //
    Title.InnerText := server.HtmlEncode(ConfigurationSettings.AppSettings['application_name']) + ' - all_emsof_requests';
    Label_account_descriptor.text := session['regional_staffer_name'].tostring;
    //
    // Initialize private class instance vars.
    //
    p.biz_emsof_requests := TClass_biz_emsof_requests.Create;
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

procedure TWebForm_all_emsof_requests.LinkButton_change_email_address_Click(sender: System.Object;
  e: System.EventArgs);
begin
  server.Transfer('change_email_address.aspx');
end;

procedure TWebForm_all_emsof_requests.LinkButton_change_password_Click(sender: System.Object;
  e: System.EventArgs);
begin
  server.Transfer('change_password.aspx');
end;

procedure TWebForm_all_emsof_requests.DataGrid_requests_ItemCommand(source: System.Object;
  e: System.Web.UI.WebControls.DataGridCommandEventArgs);
begin
  if e.commandname = 'Select' then begin
    session.Remove('account_descriptor');
    session.Add('account_descriptor',session['regional_staffer_name'].tostring);
    session.Remove('e_item');
    session.Add('e_item',e.item);
    system.collections.stack(session['waypoint_stack']).Push('all_emsof_requests.aspx');
    server.Transfer('full_request_review_approve.aspx');
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
  end;
end;

procedure TWebForm_all_emsof_requests.TWebForm_all_emsof_requests_PreRender(sender: System.Object;
  e: System.EventArgs);
begin
  session.Remove('p');
  session.Add('p',p);
end;

procedure TWebForm_all_emsof_requests.LinkButton_back_Click(sender: System.Object;
  e: System.EventArgs);
begin
  server.Transfer(stack(session['waypoint_stack']).Pop.tostring);
end;

procedure TWebForm_all_emsof_requests.LinkButton_logout_Click(sender: System.Object;
  e: System.EventArgs);
begin
  formsauthentication.SignOut;
  session.Clear;
  server.Transfer('../Default.aspx');
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
  DataGrid_requests.visible := not p.be_datagrid_empty;
  //
  // Clear aggregation vars for next bind, if any.
  //
  Label_num_datagrid_rows.text := p.num_datagrid_rows.tostring;
  p.num_datagrid_rows := 0;
  //
end;

end.

