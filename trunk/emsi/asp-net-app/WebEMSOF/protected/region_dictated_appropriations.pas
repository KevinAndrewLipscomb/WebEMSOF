
unit region_dictated_appropriations;

interface

uses
  System.Collections, System.ComponentModel,
  System.Data, System.Drawing, System.Web, System.Web.SessionState,
  system.web.ui, ki_web_ui, System.Web.UI.WebControls, System.Web.UI.HtmlControls, system.configuration, mysql.data.mysqlclient, kix,
  system.web.mail, system.web.security,
  Class_db,
  Class_db_trail;

const ID = '$Id$';

type
  p_type =
    RECORD
    be_before_deadline: boolean;
    be_sort_order_ascending: boolean;
    county_appropriations_sort_order: string;
    db: TClass_db;
    db_trail: TClass_db_trail;
    tcci_id: cardinal;
    tcci_password_reset_email_address: cardinal;
    tcci_county_code: cardinal;
    tcci_name: cardinal;
    tcci_amount: cardinal;
    tcci_linkbutton_edit: cardinal;
    tcci_linkbutton_delete: cardinal;
    num_appropriations: cardinal;
    saved_amount: decimal;
    state_dictated_appropriation_amount: decimal;
    sum_of_county_appropriations: decimal;
    unappropriated_amount: decimal;
    END;
  TWebForm_region_dictated_appropriations = class(ki_web_ui.page_class)
  {$REGION 'Designer Managed Code'}
  strict private
    procedure InitializeComponent;
    procedure DataGrid_county_appropriations_ItemDataBound(sender: System.Object;
      e: System.Web.UI.WebControls.DataGridItemEventArgs);
    procedure DataGrid_county_appropriations_DeleteCommand(source: System.Object;
      e: System.Web.UI.WebControls.DataGridCommandEventArgs);
    procedure LinkButton_region_dictated_deadline_Click(sender: System.Object;
      e: System.EventArgs);
    procedure DataGrid_county_appropriations_ItemCommand(source: System.Object;
      e: System.Web.UI.WebControls.DataGridCommandEventArgs);
    procedure LinkButton_new_appropriation_Click(sender: System.Object; e: System.EventArgs);
    procedure DataGrid_county_appropriations_CancelCommand(source: System.Object; 
      e: System.Web.UI.WebControls.DataGridCommandEventArgs);
    procedure DataGrid_county_appropriations_EditCommand(source: System.Object; 
      e: System.Web.UI.WebControls.DataGridCommandEventArgs);
    procedure DataGrid_county_appropriations_SortCommand(source: System.Object; 
      e: System.Web.UI.WebControls.DataGridSortCommandEventArgs);
    procedure DataGrid_county_appropriations_UpdateCommand(source: System.Object; 
      e: System.Web.UI.WebControls.DataGridCommandEventArgs);
    procedure TWebForm_region_dictated_appropriations_PreRender(sender: System.Object;
      e: System.EventArgs);
  {$ENDREGION}
  strict private
    p: p_type;
    procedure Bind_county_appropriations;
    procedure Page_Load(sender: System.Object; e: System.EventArgs);
  strict protected
    Title: System.Web.UI.HtmlControls.HtmlGenericControl;
    PlaceHolder_precontent: System.Web.UI.WebControls.PlaceHolder;
    PlaceHolder_postcontent: System.Web.UI.WebControls.PlaceHolder;
    Label_parent_appropriation_amount: System.Web.UI.WebControls.Label;
    Label_fiscal_year_designator: System.Web.UI.WebControls.Label;
    Label_unappropriated_amount: System.Web.UI.WebControls.Label;
    TableRow_unappropriated_amount: System.Web.UI.HtmlControls.HtmlTableRow;
    Label_no_appropriations: System.Web.UI.WebControls.Label;
    LinkButton_region_dictated_deadline: System.Web.UI.WebControls.LinkButton;
    Table_deadlines: System.Web.UI.HtmlControls.HtmlTable;
    LinkButton_new_appropriation: System.Web.UI.WebControls.LinkButton;
    Table_warning_forced_amount: System.Web.UI.HtmlControls.HtmlTable;
    Label_application_name: System.Web.UI.WebControls.Label;
    Label_account_descriptor: System.Web.UI.WebControls.Label;
    Label_sum_of_county_appropriations: System.Web.UI.WebControls.Label;
    DataGrid_county_appropriations: System.Web.UI.WebControls.DataGrid;
    TableRow_sum_of_county_appropriations: System.Web.UI.HtmlControls.HtmlTableRow;
    Table_appropriations: System.Web.UI.HtmlControls.HtmlTable;
    procedure SortCommand_county_appropriations(source: System.Object; e: System.Web.UI.WebControls.DataGridSortCommandEventArgs);
  protected
    procedure OnInit(e: EventArgs); override;
  public
    { Public Declarations }
  end;

implementation

{$REGION 'Designer Managed Code'}
/// <summary>
/// Required method for Designer support -- do not modify
/// the contents of this method with the code editor.
/// </summary>
procedure TWebForm_region_dictated_appropriations.InitializeComponent;
begin
  Include(Self.LinkButton_region_dictated_deadline.Click, Self.LinkButton_region_dictated_deadline_Click);
  Include(Self.LinkButton_new_appropriation.Click, Self.LinkButton_new_appropriation_Click);
  Include(Self.DataGrid_county_appropriations.ItemCommand, Self.DataGrid_county_appropriations_ItemCommand);
  Include(Self.DataGrid_county_appropriations.CancelCommand, Self.DataGrid_county_appropriations_CancelCommand);
  Include(Self.DataGrid_county_appropriations.EditCommand, Self.DataGrid_county_appropriations_EditCommand);
  Include(Self.DataGrid_county_appropriations.SortCommand, Self.DataGrid_county_appropriations_SortCommand);
  Include(Self.DataGrid_county_appropriations.UpdateCommand, Self.DataGrid_county_appropriations_UpdateCommand);
  Include(Self.DataGrid_county_appropriations.DeleteCommand, Self.DataGrid_county_appropriations_DeleteCommand);
  Include(Self.DataGrid_county_appropriations.ItemDataBound, Self.DataGrid_county_appropriations_ItemDataBound);
  Include(Self.Load, Self.Page_Load);
  Include(Self.PreRender, Self.TWebForm_region_dictated_appropriations_PreRender);
end;
{$ENDREGION}

procedure TWebForm_region_dictated_appropriations.Page_Load(sender: System.Object; e: System.EventArgs);
var
  dr_appropriation_attribs: mysqldatareader;
begin
  if IsPostback and (session['p'].GetType.namespace = p.GetType.namespace) then begin
    p := p_type(session['p']);
  end else begin
    if request.servervariables['URL'] = request.currentexecutionfilepath then begin
      session.Clear;
      server.Transfer('~/login.aspx');
    end;
    //
    // Initialize implementation-global variables.
    //
    p.be_before_deadline := TRUE;
    p.be_sort_order_ascending := TRUE;
    p.num_appropriations := 0;
    p.county_appropriations_sort_order := 'name';
    p.db := TClass_db.Create;
    p.db_trail := TClass_db_trail.Create;
    p.sum_of_county_appropriations := 0;
    p.unappropriated_amount := 0;
    //   Set up symbolic DataGrid Indices for use in other event handlers.
    p.tcci_id                           := 0;
    p.tcci_password_reset_email_address := 1;
    p.tcci_county_code                  := 2;
    p.tcci_name                         := 3;
    p.tcci_amount                       := 4;
    p.tcci_linkbutton_edit              := 5;
    p.tcci_linkbutton_delete            := 6;
    //
    Title.InnerText := configurationmanager.AppSettings['application_name'] + ' - region_dictated_appropriations';
    //
    Label_account_descriptor.Text := session['regional_staffer_name'].ToString;
    //
    p.db.Open;
    //
    // Disable Table_appropriations for now.
    //
    Table_appropriations.visible := FALSE;
    //
    // Set parent appropriation labels.
    //
    dr_appropriation_attribs := mysqlcommand.Create
      (
      'select designator,amount '
      + 'from state_dictated_appropriation '
      +   'join fiscal_year on (fiscal_year.id = fiscal_year_id) '
      + 'where state_dictated_appropriation.id = ' + session['state_dictated_appropriation_id'].ToString,
      p.db.connection
      )
      .ExecuteReader;
    dr_appropriation_attribs.Read;
    Label_fiscal_year_designator.Text := dr_appropriation_attribs['designator'].tostring;
    p.state_dictated_appropriation_amount := decimal(dr_appropriation_attribs['amount']);
    Label_parent_appropriation_amount.Text := p.state_dictated_appropriation_amount.ToString('C');
    dr_appropriation_attribs.Close;
    //
    // Code to set LinkButton_region_dictated_deadline.text should go here.
    //
    //
    Label_application_name.text := configurationmanager.appsettings['application_name'];
    Table_warning_forced_amount.visible := FALSE;
    //
    p.db.Close;
    //
    Bind_county_appropriations;  // also affected by p.be_before_deadline
  end;
end;

procedure TWebForm_region_dictated_appropriations.OnInit(e: EventArgs);
begin
  //
  // Required for Designer support
  //
  InitializeComponent;
  inherited OnInit(e);
end;

procedure TWebForm_region_dictated_appropriations.TWebForm_region_dictated_appropriations_PreRender(sender: System.Object;
  e: System.EventArgs);
begin
  session.Remove('p');
  session.Add('p',p);
end;

procedure TWebForm_region_dictated_appropriations.DataGrid_county_appropriations_UpdateCommand(source: System.Object;
  e: System.Web.UI.WebControls.DataGridCommandEventArgs);
var
  amount: decimal;
  amount_string: string;
  appropriation_id_string: string;
begin
  p.db.Open;
  //
  appropriation_id_string := Safe(e.Item.Cells[p.tcci_id].Text,NUM);
  amount_string := Safe(TextBox(e.Item.Cells[p.tcci_amount].controls[0]).Text.Trim,REAL_NUM);
  //
  if amount_string <> EMPTY then begin
    amount := decimal.Parse(amount_string);
    //
    if (amount - p.saved_amount) > p.unappropriated_amount then begin
      amount := p.saved_amount + p.unappropriated_amount;
      Table_warning_forced_amount.visible := TRUE;
    end else begin
      Table_warning_forced_amount.visible := FALSE;
    end;
    mysqlcommand.Create
      (
      p.db_trail.Saved
        ('update region_dictated_appropriation set amount = ' + amount.tostring + ' where id = ' + appropriation_id_string),
      p.db.connection
      )
      .ExecuteNonQuery;
    //
    kix.SmtpMailSend
      (
      configurationmanager.AppSettings['sender_email_address'],
      Safe(e.item.cells[p.tcci_password_reset_email_address].text,EMAIL_ADDRESS),
      'Modification of ' + configurationmanager.AppSettings['application_name'] + ' allocation for your county',
      'Regional staffer ' + session['regional_staffer_name'].ToString + ' has modified an EMSOF allocation for '
      + 'your county for ' + Safe(Label_fiscal_year_designator.text,ALPHANUM) + PERIOD + NEW_LINE
      + NEW_LINE
      + 'You can work on this allocation by visiting:' + NEW_LINE
      + NEW_LINE
      + '   http://' + configurationmanager.AppSettings['host_domain_name'] + '/'
      + configurationmanager.AppSettings['application_name'] + NEW_LINE
      + NEW_LINE
      + 'You can contact Regional Staffer ' + session['regional_staffer_name'].ToString + ' at:' + NEW_LINE
      + NEW_LINE
      + '   ' + session['regional_staffer_user_password_reset_email_address'].tostring + '  (mailto:' + session['regional_staffer_user_password_reset_email_address'].tostring + ')' + NEW_LINE
      + NEW_LINE
      + '-- ' + configurationmanager.AppSettings['application_name']
      );
    p.db.Close;
    //
    DataGrid_county_appropriations.EditItemIndex := -1;
    Bind_county_appropriations;
  end;
end;

procedure TWebForm_region_dictated_appropriations.DataGrid_county_appropriations_SortCommand(source: System.Object;
  e: System.Web.UI.WebControls.DataGridSortCommandEventArgs);
begin

end;

procedure TWebForm_region_dictated_appropriations.DataGrid_county_appropriations_EditCommand(source: System.Object;
  e: System.Web.UI.WebControls.DataGridCommandEventArgs);
begin
  DataGrid_county_appropriations.EditItemIndex := e.Item.ItemIndex;
  Bind_county_appropriations;
end;

procedure TWebForm_region_dictated_appropriations.DataGrid_county_appropriations_CancelCommand(source: System.Object;
  e: System.Web.UI.WebControls.DataGridCommandEventArgs);
begin
  Table_warning_forced_amount.visible := FALSE;
  DataGrid_county_appropriations.EditItemIndex := -1;
  Bind_county_appropriations;
end;

procedure TWebForm_region_dictated_appropriations.LinkButton_new_appropriation_Click(sender: System.Object;
  e: System.EventArgs);
begin
  session.Remove('parent_appropriation_amount');
  session.Add('parent_appropriation_amount',Safe(Label_parent_appropriation_amount.text,REAL_NUM));
  session.Remove('fiscal_year_designator');
  session.Add('fiscal_year_designator',Safe(Label_fiscal_year_designator.text,ALPHANUM));
  session.Remove('sum_of_county_appropriations');
  session.Add('sum_of_county_appropriations',Safe(Label_sum_of_county_appropriations.text,REAL_NUM));
  session.Remove('unappropriated_amount');
  session.Add('unappropriated_amount',p.unappropriated_amount);
  DropCrumbAndTransferTo('create_new_county_appropriation.aspx');
end;

procedure TWebForm_region_dictated_appropriations.DataGrid_county_appropriations_ItemCommand(source: System.Object;
  e: System.Web.UI.WebControls.DataGridCommandEventArgs);
begin
  if e.commandname = 'Select' then begin
    session.Remove('fiscal_year_designator');
    session.Add('fiscal_year_designator',Safe(Label_fiscal_year_designator.text,ALPHANUM));
    session.Remove('county_name');
    session.Add('county_name',Safe(e.item.cells[p.tcci_name].text,ORG_NAME));
    session.Remove('county_code');
    session.Add('county_code',Safe(e.item.cells[p.tcci_county_code].text,NUM));
    session.Remove('appropriation_amount');
    session.Add('appropriation_amount',Safe(e.item.cells[p.tcci_amount].text,REAL_NUM));
    session.Remove('region_dictated_appropriation_id');
    session.Add('region_dictated_appropriation_id',Safe(e.item.cells[p.tcci_id].text,NUM));
    DropCrumbAndTransferTo('region_dictated_appropriation_detail.aspx');
  end else if e.commandname = 'Edit' then begin
    p.saved_amount := decimal.Parse(Safe(e.item.cells[p.tcci_amount].text,REAL_NUM));
  end;
end;

procedure TWebForm_region_dictated_appropriations.LinkButton_region_dictated_deadline_Click(sender: System.Object;
  e: System.EventArgs);
begin
  session.Remove('region_dictated_deadline');
  session.Add('region_dictated_deadline',LinkButton_region_dictated_deadline.text);
  DropCrumbAndTransferTo('region_dictated_deadline.aspx');
end;

procedure TWebForm_region_dictated_appropriations.DataGrid_county_appropriations_DeleteCommand(source: System.Object;
  e: System.Web.UI.WebControls.DataGridCommandEventArgs);
var
  bc: mysqlcommand;
  id_string: string;
begin
  p.db.Open;
  id_string := Safe(e.Item.Cells[p.tcci_id].Text,NUM);
  bc := mysqlcommand.Create
    (
    'select count(master_id)'  // Leaving the star out prevents inclusion of nulls in count
    + ' from emsof_request_detail'
    +   ' join emsof_request_master on (emsof_request_master.id=emsof_request_detail.master_id)'
    +   ' join county_dictated_appropriation'
    +     ' on (county_dictated_appropriation.id=emsof_request_master.county_dictated_appropriation_id)'
    + ' where region_dictated_appropriation_id = ' + id_string,
    p.db.connection
    );
  if bc.ExecuteScalar.tostring <> '0' then begin
    p.db.Close;
    //
    // A service has already entered equipment requests against this appropriation.  Add relevant data to the session and send the
    // county coordinator to a confirmation page.
    //
    session.Remove('id_of_appropriation_selected_for_deletion');
    session.Add('id_of_appropriation_selected_for_deletion',id_string);
    //
    session.Remove('email_address_of_county_of_appropriation_selected_for_deletion');
    session.Add
      (
      'email_address_of_county_of_appropriation_selected_for_deletion',
      Safe(e.item.cells[p.tcci_password_reset_email_address].text,EMAIL_ADDRESS)
      );
    //
    session.Remove('county_name_of_appropriation_selected_for_deletion');
    session.Add('county_name_of_appropriation_selected_for_deletion',Safe(e.item.cells[p.tcci_name].text,ORG_NAME));
    //
    session.Remove('amount_of_appropriation_selected_for_deletion');
    session.Add('amount_of_appropriation_selected_for_deletion',Safe(e.item.cells[p.tcci_amount].text,REAL_NUM));
    //
    DropCrumbAndTransferTo('delete_county_appropriation.aspx');
  end else begin
    //
    // Nothing is linked to this appropriation, so go ahead and delete it.
    //
    mysqlcommand.Create
      (
      p.db_trail.Saved('delete from region_dictated_appropriation where id = ' + id_string),
      p.db.connection
      )
      .ExecuteNonQuery;
    //
    // Send a notification message.
    //
    kix.SmtpMailSend
      (
      configurationmanager.AppSettings['sender_email_address'],
      Safe(e.item.cells[p.tcci_password_reset_email_address].text,EMAIL_ADDRESS),
      'Deletion of ' + configurationmanager.AppSettings['application_name'] + ' allocation for your county',
      'The ' + session['region_name'].ToString + ' Regional Council EMSOF Coordinator has deleted an EMSOF allocation from '
      + 'your county for ' + Safe(Label_fiscal_year_designator.text,ALPHANUM) + PERIOD + NEW_LINE
      + NEW_LINE
      + 'For an overview of your EMSOF allocations, visit:' + NEW_LINE
      + NEW_LINE
      + '   http://' + configurationmanager.AppSettings['host_domain_name'] + '/'
      + configurationmanager.AppSettings['application_name'] + NEW_LINE
      + NEW_LINE
      + 'You can contact the ' + session['region_name'].ToString + ' Regional Council EMSOF Coordinator at:' + NEW_LINE
      + NEW_LINE
      + '   ' + session['regional_staffer_user_password_reset_email_address'].tostring + '  (mailto:' + session['regional_staffer_user_password_reset_email_address'].tostring + ')' + NEW_LINE
      + NEW_LINE
      + '-- ' + configurationmanager.AppSettings['application_name']
      );
    //
    p.db.Close;
  end;
  //
  Table_warning_forced_amount.visible := FALSE;
  DataGrid_county_appropriations.EditItemIndex := -1;
  Bind_county_appropriations;
end;

procedure TWebForm_region_dictated_appropriations.DataGrid_county_appropriations_ItemDataBound(sender: System.Object;
  e: System.Web.UI.WebControls.DataGridItemEventArgs);
begin
  //
  // Manage column visibility
  //
  e.item.cells[p.tcci_linkbutton_edit].visible := p.be_before_deadline;
  e.item.cells[p.tcci_linkbutton_delete].visible := p.be_before_deadline;
  //
  if (e.item.itemtype = listitemtype.alternatingitem)
    or (e.item.itemtype = listitemtype.edititem)
    or (e.item.itemtype = listitemtype.item)
    or (e.item.itemtype = listitemtype.selecteditem)
  then begin
    //
    // We are dealing with a data row, not a header or footer row.
    //
    p.num_appropriations := p.num_appropriations + 1;
    p.sum_of_county_appropriations :=
      p.sum_of_county_appropriations + decimal.Parse(databinder.Eval(e.item.dataitem,'amount').tostring);
  end;
end;

procedure TWebForm_region_dictated_appropriations.Bind_county_appropriations;
var
  be_datagrid_empty: boolean;
  cmdText: string;
begin
  p.db.Open;
  //
  // When changing this query, remember to make corresponding changes to DataGrid Index settings in Page_Load.
  //
  cmdText := 'select region_dictated_appropriation.id,' // column 0
  + ' password_reset_email_address,'                    // column 1
  + ' county_code,'                                     // column 2
  + ' name,'                                            // column 3
  + ' region_dictated_appropriation.amount'             // column 4
  + ' from region_dictated_appropriation'
  +   ' join county_code_name_map on (county_code_name_map.code=county_code)'
  +   ' join county_user on (county_user.id=county_code)'
  + ' where state_dictated_appropriation_id = ' + session['state_dictated_appropriation_id'].ToString
  + ' order by ' + p.county_appropriations_sort_order;
  if p.be_sort_order_ascending then begin
    cmdText := cmdText + ' asc';
  end else begin
    cmdText := cmdText + ' desc';
  end;
  //
  DataGrid_county_appropriations.DataSource :=
    mysqlcommand.Create(cmdText,p.db.connection).ExecuteReader;
  DataGrid_county_appropriations.DataBind;
  mysqldatareader(DataGrid_county_appropriations.datasource).Close;
  be_datagrid_empty := (p.num_appropriations = 0);
  //
  // Manage control visibilities.
  //
  Label_no_appropriations.Visible := be_datagrid_empty;
  Datagrid_county_appropriations.Visible := not be_datagrid_empty;
  //
  // Manage non-DataGrid control properties.
  //
  Label_sum_of_county_appropriations.text := p.sum_of_county_appropriations.ToString('C');
  p.unappropriated_amount := p.state_dictated_appropriation_amount - p.sum_of_county_appropriations;
  Label_unappropriated_amount.Text := p.unappropriated_amount.tostring('C');
  if p.unappropriated_amount < 0 then begin
    Label_unappropriated_amount.font.bold := TRUE;
    Label_unappropriated_amount.forecolor := color.red;
  end;
  //
  // Clear aggregation vars for next bind, if any.
  //
  p.num_appropriations := 0;
  p.sum_of_county_appropriations := 0;
  p.db.Close;
end;

procedure TWebForm_region_dictated_appropriations.SortCommand_county_appropriations(source: System.Object;
  e: System.Web.UI.WebControls.DataGridSortCommandEventArgs);
begin
  if e.SortExpression = p.county_appropriations_sort_order then begin
    p.be_sort_order_ascending := not p.be_sort_order_ascending;
  end else begin
    p.county_appropriations_sort_order := e.SortExpression;
    p.be_sort_order_ascending := TRUE;
  end;
  Table_warning_forced_amount.visible := FALSE;
  DataGrid_county_appropriations.EditItemIndex := -1;
  Bind_county_appropriations;
end;

end.

