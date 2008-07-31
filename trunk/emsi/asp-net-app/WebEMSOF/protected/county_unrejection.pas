unit county_unrejection;

interface

uses
  System.Collections, System.ComponentModel,
  System.Data, System.Drawing, System.Web, System.Web.SessionState,
  System.Web.UI, System.Web.UI.WebControls, System.Web.UI.HtmlControls, system.configuration, system.web.security,
  mysql.data.mysqlclient,
  Class_biz_emsof_requests,
  kix,
  ki_web_ui;

const ID = '$Id$';

type
  p_type =
    RECORD
    be_datagrid_empty: boolean;
    be_sort_order_ascending: boolean;
    biz_emsof_requests: TClass_biz_emsof_requests;
    num_datagrid_rows: cardinal;
    sort_order: string;
    END;
  TWebForm_county_unrejection = class(ki_web_ui.page_class)
  {$REGION 'Designer Managed Code'}
  strict private
    procedure InitializeComponent;
    procedure Datagrid_unrejectable_requests_SortCommand(source: System.Object; e: System.Web.UI.WebControls.DataGridSortCommandEventArgs);
    procedure Datagrid_unrejectable_requests_ItemDataBound(sender: System.Object; e: System.Web.UI.WebControls.DataGridItemEventArgs);
    procedure Datagrid_unrejectable_requests_ItemCommand(source: System.Object; e: System.Web.UI.WebControls.DataGridCommandEventArgs);
    procedure TWebForm_county_unrejection_PreRender(sender: System.Object;
      e: System.EventArgs);
    procedure LinkButton_county_dictated_appropriations_Click(sender: System.Object; 
      e: System.EventArgs);
    procedure LinkButton_unreject_all_Click(sender: System.Object; e: System.EventArgs);
  {$ENDREGION}
  strict private
    p: p_type;
    procedure Bind;
    procedure Page_Load(sender: System.Object; e: System.EventArgs);
  strict protected
    Title: System.Web.UI.HtmlControls.HtmlGenericControl;
    PlaceHolder_precontent: System.Web.UI.WebControls.PlaceHolder;
    PlaceHolder_postcontent: System.Web.UI.WebControls.PlaceHolder;
    Label_account_descriptor: System.Web.UI.WebControls.Label;
    TableRow_none: System.Web.UI.HtmlControls.HtmlTableRow;
    LinkButton_done: System.Web.UI.WebControls.LinkButton;
    LinkButton_unreject_all: System.Web.UI.WebControls.LinkButton;
    DataGrid_unrejectable_requests: System.Web.UI.WebControls.DataGrid;
    LinkButton_county_dictated_appropriations: System.Web.UI.WebControls.LinkButton;
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
procedure TWebForm_county_unrejection.InitializeComponent;
begin
  Include(Self.LinkButton_county_dictated_appropriations.Click, Self.LinkButton_county_dictated_appropriations_Click);
  Include(Self.LinkButton_unreject_all.Click, Self.LinkButton_unreject_all_Click);
  Include(Self.LinkButton_done.Click, Self.LinkButton_county_dictated_appropriations_Click);
  Include(Self.DataGrid_unrejectable_requests.ItemCommand, Self.DataGrid_unrejectable_requests_ItemCommand);
  Include(Self.DataGrid_unrejectable_requests.SortCommand, Self.DataGrid_unrejectable_requests_SortCommand);
  Include(Self.DataGrid_unrejectable_requests.ItemDataBound, Self.DataGrid_unrejectable_requests_ItemDataBound);
  Include(Self.Load, Self.Page_Load);
  Include(Self.PreRender, Self.TWebForm_county_unrejection_PreRender);
end;
{$ENDREGION}

procedure TWebForm_county_unrejection.Page_Load(sender: System.Object; e: System.EventArgs);
begin
  if IsPostback and (session['p'].GetType.namespace = p.GetType.namespace) then begin
    p := p_type(session['p']);
  end else begin
    if request.servervariables['URL'] = request.currentexecutionfilepath then begin
      //
      // The request for this page could not have been the result of a server.Transfer call, and the session state is therefore unknown.  This is rarely allowed.
      //
      session.Clear;
      server.Transfer('~/login.aspx');
    end else begin
      //
      Title.InnerText := server.HtmlEncode(configurationmanager.AppSettings['application_name']) + ' - county_unrejection';
      Label_account_descriptor.text := session['county_name'].tostring + ' County';
      //
      // Initialize implementation-wide vars.
      //
      p.be_sort_order_ascending := TRUE;
      p.biz_emsof_requests := TClass_biz_emsof_requests.Create;
      p.num_datagrid_rows := 0;
      p.sort_order := 'service_name';
      //
      Bind;
      //
    end;
  end;
end;

procedure TWebForm_county_unrejection.OnInit(e: EventArgs);
begin
  //
  // Required for Designer support
  //
  InitializeComponent;
  inherited OnInit(e);
end;

procedure TWebForm_county_unrejection.LinkButton_unreject_all_Click(sender: System.Object;
  e: System.EventArgs);
var
  i: cardinal;
begin
  if DataGrid_unrejectable_requests.items.count > 0 then begin
    for i := 0 to DataGrid_unrejectable_requests.items.count - 1 do begin
      p.biz_emsof_requests.Unreject
        (DataGrid_unrejectable_requests.items[i],'county','The ' + Label_account_descriptor.text + ' EMSOF Coordinator');
    end;
    Bind;
  end;
end;

procedure TWebForm_county_unrejection.LinkButton_county_dictated_appropriations_Click(sender: System.Object;
  e: System.EventArgs);
begin
  BackTrack(2);
end;

procedure TWebForm_county_unrejection.Datagrid_unrejectable_requests_ItemCommand(source: System.Object;
  e: System.Web.UI.WebControls.DataGridCommandEventArgs);
begin
  if e.commandname = 'Unreject' then begin
    p.biz_emsof_requests.Unreject(e.item,'county','The ' + Label_account_descriptor.text + ' EMSOF Coordinator');
    Bind;
  end;
end;

procedure TWebForm_county_unrejection.TWebForm_county_unrejection_PreRender(sender: System.Object;
  e: System.EventArgs);
begin
  SessionSet('p',p);
end;

procedure TWebForm_county_unrejection.Datagrid_unrejectable_requests_ItemDataBound(sender: System.Object;
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
  end;
end;

procedure TWebForm_county_unrejection.Datagrid_unrejectable_requests_SortCommand(source: System.Object;
  e: System.Web.UI.WebControls.DataGridSortCommandEventArgs);
begin
  if e.SortExpression = p.sort_order then begin
    p.be_sort_order_ascending := not p.be_sort_order_ascending;
  end else begin
    p.sort_order := e.SortExpression;
    p.be_sort_order_ascending := TRUE;
  end;
  Datagrid_unrejectable_requests.EditItemIndex := -1;
  Bind;
end;

procedure TWebForm_county_unrejection.Bind;
begin
  p.biz_emsof_requests.BindOverviewByRegionDictatedAppropriationAndStatus
    (
    session['region_dictated_appropriation_id'].tostring,
    REJECTED,
    p.sort_order,
    p.be_sort_order_ascending,
    Datagrid_unrejectable_requests
    );
  //
  // Manage control visibilities.
  //
  p.be_datagrid_empty := (p.num_datagrid_rows = 0);
  TableRow_none.visible := p.be_datagrid_empty;
  Datagrid_unrejectable_requests.visible := not p.be_datagrid_empty;
  //
  // Clear aggregation vars for next bind, if any.
  //
  p.num_datagrid_rows := 0;
  //
end;

end.

