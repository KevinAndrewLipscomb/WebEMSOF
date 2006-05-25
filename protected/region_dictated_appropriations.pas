
unit region_dictated_appropriations;

interface

uses
  System.Collections, System.ComponentModel,
  System.Data, System.Drawing, System.Web, System.Web.SessionState,
  System.Web.UI, System.Web.UI.WebControls, System.Web.UI.HtmlControls, system.configuration, borland.data.provider, appcommon,
  system.web.mail, system.web.security;

type
  TWebForm_region_dictated_appropriations = class(System.Web.UI.Page)
  {$REGION 'Designer Managed Code'}
  strict private
    procedure InitializeComponent;
    procedure DataGrid_county_appropriations_ItemDataBound(sender: System.Object;
      e: System.Web.UI.WebControls.DataGridItemEventArgs);
    procedure DataGrid_county_appropriations_DeleteCommand(source: System.Object;
      e: System.Web.UI.WebControls.DataGridCommandEventArgs);
    procedure LinkButton_region_dictated_deadline_Click(sender: System.Object;
      e: System.EventArgs);
    procedure LinkButton_logout_Click(sender: System.Object; e: System.EventArgs);
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
  {$ENDREGION}
  strict private
    procedure Page_Load(sender: System.Object; e: System.EventArgs);
    procedure Bind_county_appropriations;
  strict protected
    Title: System.Web.UI.HtmlControls.HtmlGenericControl;
    PlaceHolder_precontent: System.Web.UI.WebControls.PlaceHolder;
    PlaceHolder_postcontent: System.Web.UI.WebControls.PlaceHolder;
    Label_parent_appropriation_amount: System.Web.UI.WebControls.Label;
    Label_fiscal_year_designator: System.Web.UI.WebControls.Label;
    Label_unappropriated_amount: System.Web.UI.WebControls.Label;
    TableRow_unappropriated_amount: System.Web.UI.HtmlControls.HtmlTableRow;
    HyperLink_change_password: System.Web.UI.WebControls.HyperLink;
    HyperLink_change_email_address: System.Web.UI.WebControls.HyperLink;
    Label_no_appropriations: System.Web.UI.WebControls.Label;
    LinkButton_region_dictated_deadline: System.Web.UI.WebControls.LinkButton;
    Table_deadlines: System.Web.UI.HtmlControls.HtmlTable;
    LinkButton_logout: System.Web.UI.WebControls.LinkButton;
    LinkButton_new_appropriation: System.Web.UI.WebControls.LinkButton;
    Table_warning_forced_amount: System.Web.UI.HtmlControls.HtmlTable;
    Label_application_name: System.Web.UI.WebControls.Label;
    Label_account_descriptor: System.Web.UI.WebControls.Label;
    Label_sum_of_county_appropriations: System.Web.UI.WebControls.Label;
    DataGrid_county_appropriations: System.Web.UI.WebControls.DataGrid;
    TableRow_sum_of_county_appropriations: System.Web.UI.HtmlControls.HtmlTableRow;
    Table_appropriations: System.Web.UI.HtmlControls.HtmlTable;
    procedure SortCommand_county_appropriations(source: System.Object; e: System.Web.UI.WebControls.DataGridSortCommandEventArgs);
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
  Include(Self.LinkButton_logout.Click, Self.LinkButton_logout_Click);
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
end;
{$ENDREGION}

const ID = '$Id$';

var
  be_before_deadline: boolean;
  be_sort_order_ascending: boolean;
  dgi_id: cardinal;
  dgi_password_reset_email_address: cardinal;
  dgi_county_code: cardinal;
  dgi_name: cardinal;
  dgi_amount: cardinal;
  dgi_linkbutton_edit: cardinal;
  dgi_linkbutton_delete: cardinal;
  num_appropriations: cardinal;
  state_dictated_appropriation_amount: decimal;
  saved_amount: decimal;
  county_appropriations_sort_order: string;
  sum_of_county_appropriations: decimal;
  unappropriated_amount: decimal;

procedure TWebForm_region_dictated_appropriations.Page_Load(sender: System.Object; e: System.EventArgs);
var
  bdr_appropriation_attribs: borland.data.provider.BdpDataReader;
begin
  AppCommon.PopulatePlaceHolders(PlaceHolder_precontent,PlaceHolder_postcontent);
  if not IsPostback then begin
    //
    // Initialize implementation-global variables.
    //
    be_before_deadline := TRUE;
    be_sort_order_ascending := TRUE;
    num_appropriations := 0;
    county_appropriations_sort_order := 'name';
    sum_of_county_appropriations := 0;
    unappropriated_amount := 0;
    //   Set up symbolic DataGrid Indices for use in other event handlers.
    dgi_id                           := 0;
    dgi_password_reset_email_address := 1;
    dgi_county_code                  := 2;
    dgi_name                         := 3;
    dgi_amount                       := 4;
    dgi_linkbutton_edit              := 5;
    dgi_linkbutton_delete            := 6;
    //
    Title.InnerText := ConfigurationSettings.AppSettings['application_name'] + ' - region_dictated_appropriations';
    Label_account_descriptor.Text := session.Item['regional_staffer_name'].ToString;
    //
    appcommon.DbOpen;
    //
    // Disable Table_appropriations for now.
    //
    Table_appropriations.visible := FALSE;
    //
    // Set parent appropriation labels.
    //
    bdr_appropriation_attribs := borland.data.provider.bdpcommand.Create
      (
      'select designator,amount '
      + 'from state_dictated_appropriation '
      +   'join fiscal_year on (fiscal_year.id = fiscal_year_id) '
      + 'where state_dictated_appropriation.id = ' + session.Item['state_dictated_appropriation_id'].ToString,
      appcommon.db
      )
      .ExecuteReader;
    bdr_appropriation_attribs.Read;
    Label_fiscal_year_designator.Text := bdr_appropriation_attribs['designator'].tostring;
    state_dictated_appropriation_amount := decimal(bdr_appropriation_attribs['amount']);
    Label_parent_appropriation_amount.Text := state_dictated_appropriation_amount.ToString('C');
    bdr_appropriation_attribs.Close;
    //
    // Code to set LinkButton_region_dictated_deadline.text should go here.
    //
    //
    Label_application_name.text := configurationsettings.appsettings['application_name'];
    Table_warning_forced_amount.visible := FALSE;
    //
    appcommon.DbClose;
    //
    Bind_county_appropriations;  // also affected by be_before_deadline
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

procedure TWebForm_region_dictated_appropriations.DataGrid_county_appropriations_UpdateCommand(source: System.Object;
  e: System.Web.UI.WebControls.DataGridCommandEventArgs);
var
  amount: decimal;
  amount_string: string;
  appropriation_id_string: string;
begin
  appcommon.DbOpen;
  //
  appropriation_id_string := Safe(e.Item.Cells[dgi_id].Text,NUM);
  amount_string := Safe(TextBox(e.Item.Cells[dgi_amount].controls[0]).Text.Trim,REAL_NUM);
  //
  if amount_string <> system.string.EMPTY then begin
    amount := decimal.Parse(amount_string);
    //
    if (amount - saved_amount) > unappropriated_amount then begin
      amount := saved_amount + unappropriated_amount;
      Table_warning_forced_amount.visible := TRUE;
    end else begin
      Table_warning_forced_amount.visible := FALSE;
    end;
    borland.data.provider.bdpcommand.Create
      (
      'update region_dictated_appropriation set amount = ' + amount.tostring + ' where id = ' + appropriation_id_string,
      appcommon.db
      )
      .ExecuteNonQuery;
    //
    smtpmail.SmtpServer := ConfigurationSettings.AppSettings['smtp_server'];
    smtpmail.Send
      (
      session.item['regional_staffer_user_password_reset_email_address'].tostring,
      Safe(e.item.cells[dgi_password_reset_email_address].text,EMAIL_ADDRESS),
      'Modification of ' + ConfigurationSettings.AppSettings['application_name'] + ' appropriation for your county',
      'Regional staffer ' + session.Item['regional_staffer_name'].ToString + ' has modified an EMSOF appropriation for '
      + 'your county for ' + Safe(Label_fiscal_year_designator.text,ALPHANUM) + '.' + NEW_LINE
      + NEW_LINE
      + 'You can work on this appropriation by visiting:' + NEW_LINE
      + NEW_LINE
      + '   http://' + ConfigurationSettings.AppSettings['host_domain_name'] + '/'
      + server.UrlEncode(ConfigurationSettings.AppSettings['application_name'])
      + '/protected/county_overview.aspx' + NEW_LINE
      + NEW_LINE
      + 'Replies to this message will be addressed to Regional Staffer ' + session.Item['regional_staffer_name'].ToString + '.'
      + NEW_LINE
      + NEW_LINE
      + '-- ' + ConfigurationSettings.AppSettings['application_name']
      );
    appcommon.DbClose;
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
  session.Add('unappropriated_amount',unappropriated_amount);
  server.Transfer('create_new_county_appropriation.aspx');
end;

procedure TWebForm_region_dictated_appropriations.DataGrid_county_appropriations_ItemCommand(source: System.Object;
  e: System.Web.UI.WebControls.DataGridCommandEventArgs);
begin
  if e.commandname = 'Select' then begin
    session.Remove('fiscal_year_designator');
    session.Add('fiscal_year_designator',Safe(Label_fiscal_year_designator.text,ALPHANUM));
    session.Remove('county_name');
    session.Add('county_name',Safe(e.item.cells[dgi_name].text,ORG_NAME));
    session.Remove('county_code');
    session.Add('county_code',Safe(e.item.cells[dgi_county_code].text,NUM));
    session.Remove('appropriation_amount');
    session.Add('appropriation_amount',Safe(e.item.cells[dgi_amount].text,REAL_NUM));
    session.Remove('region_dictated_appropriation_id');
    session.Add('region_dictated_appropriation_id',Safe(e.item.cells[dgi_id].text,NUM));
    server.Transfer('region_dictated_appropriation_detail.aspx');
  end else if e.commandname = 'Edit' then begin
    saved_amount := decimal.Parse(Safe(e.item.cells[dgi_amount].text,REAL_NUM));
  end;
end;

procedure TWebForm_region_dictated_appropriations.LinkButton_logout_Click(sender: System.Object;
  e: System.EventArgs);
begin
  formsauthentication.SignOut;
  session.Clear;
  server.Transfer('../Default.aspx');
end;

procedure TWebForm_region_dictated_appropriations.LinkButton_region_dictated_deadline_Click(sender: System.Object;
  e: System.EventArgs);
begin
  session.Remove('region_dictated_deadline');
  session.Add('region_dictated_deadline',LinkButton_region_dictated_deadline.text);
  server.Transfer('region_dictated_deadline.aspx');
end;

procedure TWebForm_region_dictated_appropriations.DataGrid_county_appropriations_DeleteCommand(source: System.Object;
  e: System.Web.UI.WebControls.DataGridCommandEventArgs);
var
  bc: borland.data.provider.bdpcommand;
  id_string: string;
begin
  appcommon.DbOpen;
  id_string := Safe(e.Item.Cells[dgi_id].Text,NUM);
  bc := borland.data.provider.bdpcommand.Create
    (
    'select count(master_id)'  // Leaving the star out prevents inclusion of nulls in count
    + ' from emsof_request_detail'
    +   ' join emsof_request_master on (emsof_request_master.id=emsof_request_detail.master_id)'
    +   ' join county_dictated_appropriation'
    +     ' on (county_dictated_appropriation.id=emsof_request_master.county_dictated_appropriation_id)'
    + ' where region_dictated_appropriation_id = ' + id_string,
    appcommon.db
    );
  if bc.ExecuteScalar.tostring <> '0' then begin
    appcommon.DbClose;
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
      Safe(e.item.cells[dgi_password_reset_email_address].text,EMAIL_ADDRESS)
      );
    //
    session.Remove('county_name_of_appropriation_selected_for_deletion');
    session.Add('county_name_of_appropriation_selected_for_deletion',Safe(e.item.cells[dgi_name].text,ORG_NAME));
    //
    session.Remove('amount_of_appropriation_selected_for_deletion');
    session.Add('amount_of_appropriation_selected_for_deletion',Safe(e.item.cells[dgi_amount].text,REAL_NUM));
    //
    server.Transfer('delete_county_appropriation.aspx');
  end else begin
    //
    // Nothing is linked to this appropriation, so go ahead and delete it.
    //
    borland.data.provider.bdpcommand.Create
      (
      'delete from region_dictated_appropriation where id = ' + id_string,
      appcommon.db
      )
      .ExecuteNonQuery;
    //
    // Send a notification message.
    //
    smtpmail.SmtpServer := ConfigurationSettings.AppSettings['smtp_server'];
    smtpmail.Send
      (
      session.item['regional_staffer_user_password_reset_email_address'].tostring,
      Safe(e.item.cells[dgi_password_reset_email_address].text,EMAIL_ADDRESS),
      'Deletion of ' + ConfigurationSettings.AppSettings['application_name'] + ' appropriation for your county',
      'The ' + session.Item['region_name'].ToString + ' Regional Council EMSOF Coordinator has deleted an EMSOF appropriation from '
      + 'your county for ' + Safe(Label_fiscal_year_designator.text,ALPHANUM) + '.' + NEW_LINE
      + NEW_LINE
      + 'For an overview of your EMSOF appropriations, visit:' + NEW_LINE
      + NEW_LINE
      + '   http://' + ConfigurationSettings.AppSettings['ssl_base_path'] + '/'
      + server.UrlEncode(ConfigurationSettings.AppSettings['application_name'])
      + '/protected/county_overview.aspx' + NEW_LINE
      + NEW_LINE
        + 'Replies to this message will be addressed to the ' + session.Item['region_name'].ToString + ' Regional Council EMSOF '
        + 'Coordinator.' + NEW_LINE
        + NEW_LINE
      + '-- ' + ConfigurationSettings.AppSettings['application_name']
      );
    //
    appcommon.DbClose;
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
  e.item.cells[dgi_linkbutton_edit].visible := be_before_deadline;
  e.item.cells[dgi_linkbutton_delete].visible := be_before_deadline;
  //
  if (e.item.itemtype = listitemtype.alternatingitem)
    or (e.item.itemtype = listitemtype.edititem)
    or (e.item.itemtype = listitemtype.item)
    or (e.item.itemtype = listitemtype.selecteditem)
  then begin
    //
    // We are dealing with a data row, not a header or footer row.
    //
    num_appropriations := num_appropriations + 1;
    sum_of_county_appropriations :=
      sum_of_county_appropriations + decimal.Parse(databinder.Eval(e.item.dataitem,'amount').tostring);
  end;
end;

procedure TWebForm_region_dictated_appropriations.Bind_county_appropriations;
var
  be_datagrid_empty: boolean;
  cmdText: string;
begin
  appcommon.DbOpen;
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
  + ' where state_dictated_appropriation_id = ' + session.Item['state_dictated_appropriation_id'].ToString
  + ' order by ' + county_appropriations_sort_order;
  if be_sort_order_ascending then begin
    cmdText := cmdText + ' asc';
  end else begin
    cmdText := cmdText + ' desc';
  end;
  //
  DataGrid_county_appropriations.DataSource :=
    borland.data.provider.bdpcommand.Create(cmdText,appcommon.db).ExecuteReader;
  DataGrid_county_appropriations.DataBind;
  be_datagrid_empty := (num_appropriations = 0);
  //
  // Manage control visibilities.
  //
  Label_no_appropriations.Visible := be_datagrid_empty;
  Datagrid_county_appropriations.Visible := not be_datagrid_empty;
  //
  // Manage non-DataGrid control properties.
  //
  Label_sum_of_county_appropriations.text := sum_of_county_appropriations.ToString('C');
  unappropriated_amount := state_dictated_appropriation_amount - sum_of_county_appropriations;
  Label_unappropriated_amount.Text := unappropriated_amount.tostring('C');
  if unappropriated_amount < 0 then begin
    Label_unappropriated_amount.font.bold := TRUE;
    Label_unappropriated_amount.forecolor := color.red;
  end;
  //
  // Clear aggregation vars for next bind, if any.
  //
  num_appropriations := 0;
  sum_of_county_appropriations := 0;
  appcommon.DbClose;
end;

procedure TWebForm_region_dictated_appropriations.SortCommand_county_appropriations(source: System.Object;
  e: System.Web.UI.WebControls.DataGridSortCommandEventArgs);
begin
  if e.SortExpression = county_appropriations_sort_order then begin
    be_sort_order_ascending := not be_sort_order_ascending;
  end else begin
    county_appropriations_sort_order := e.SortExpression;
    be_sort_order_ascending := TRUE;
  end;
  Table_warning_forced_amount.visible := FALSE;
  DataGrid_county_appropriations.EditItemIndex := -1;
  Bind_county_appropriations;
end;

end.

