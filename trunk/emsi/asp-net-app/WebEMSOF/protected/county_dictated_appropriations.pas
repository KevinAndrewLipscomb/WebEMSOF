
unit county_dictated_appropriations;

interface

uses
  System.Collections, System.ComponentModel,
  System.Data, System.Drawing, System.Web, System.Web.SessionState,
  System.Web.UI, System.Web.UI.WebControls, System.Web.UI.HtmlControls, system.configuration, borland.data.provider, appcommon,
  system.web.mail, system.web.security;

type
  TWebForm_county_dictated_appropriations = class(System.Web.UI.Page)
  {$REGION 'Designer Managed Code'}
  strict private
    procedure InitializeComponent;
    procedure EditCommand_service_appropriations(source: System.Object; e: System.Web.UI.WebControls.DataGridCommandEventArgs);
    procedure CancelCommand_service_appropriations(source: System.Object; e: System.Web.UI.WebControls.DataGridCommandEventArgs);
    procedure UpdateCommand_service_appropriations(source: System.Object; e: System.Web.UI.WebControls.DataGridCommandEventArgs);
    procedure DataGrid_service_appropriations_ItemDataBound(sender: System.Object; 
      e: System.Web.UI.WebControls.DataGridItemEventArgs);
    procedure DataGrid_service_appropriations_DeleteCommand(source: System.Object; 
      e: System.Web.UI.WebControls.DataGridCommandEventArgs);
    procedure LinkButton_county_dictated_deadline_Click(sender: System.Object; 
      e: System.EventArgs);
    procedure LinkButton_logout_Click(sender: System.Object; e: System.EventArgs);
    procedure DataGrid_service_appropriations_ItemCommand(source: System.Object; 
      e: System.Web.UI.WebControls.DataGridCommandEventArgs);
  {$ENDREGION}
  strict private
    procedure Page_Load(sender: System.Object; e: System.EventArgs);
    procedure Bind_service_appropriations;
  strict protected
    Title: System.Web.UI.HtmlControls.HtmlGenericControl;
    PlaceHolder_precontent: System.Web.UI.WebControls.PlaceHolder;
    PlaceHolder_postcontent: System.Web.UI.WebControls.PlaceHolder;
    Label_county_name: System.Web.UI.WebControls.Label;
    DataGrid_service_appropriations: System.Web.UI.WebControls.DataGrid;
    Label_literal_county: System.Web.UI.WebControls.Label;
    HyperLink_new_appropriation: System.Web.UI.WebControls.HyperLink;
    Label_make_appropriations_deadline: System.Web.UI.WebControls.Label;
    Label_parent_appropriation_amount: System.Web.UI.WebControls.Label;
    Label_region_name: System.Web.UI.WebControls.Label;
    Label_fiscal_year_designator: System.Web.UI.WebControls.Label;
    Label_sum_of_service_appropriations: System.Web.UI.WebControls.Label;
    Label_unappropriated_amount: System.Web.UI.WebControls.Label;
    TableRow_sum_of_service_appropriations: System.Web.UI.HtmlControls.HtmlTableRow;
    TableRow_unappropriated_amount: System.Web.UI.HtmlControls.HtmlTableRow;
    HyperLink_change_password: System.Web.UI.WebControls.HyperLink;
    HyperLink_change_email_address: System.Web.UI.WebControls.HyperLink;
    Label_no_appropriations: System.Web.UI.WebControls.Label;
    LinkButton_county_dictated_deadline: System.Web.UI.WebControls.LinkButton;
    Table_deadlines: System.Web.UI.HtmlControls.HtmlTable;
    LinkButton_logout: System.Web.UI.WebControls.LinkButton;
    procedure SortCommand_service_appropriations(source: System.Object; e: System.Web.UI.WebControls.DataGridSortCommandEventArgs);
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
procedure TWebForm_county_dictated_appropriations.InitializeComponent;
begin
  Include(Self.LinkButton_logout.Click, Self.LinkButton_logout_Click);
  Include(Self.LinkButton_county_dictated_deadline.Click, Self.LinkButton_county_dictated_deadline_Click);
  Include(Self.DataGrid_service_appropriations.ItemCommand, Self.DataGrid_service_appropriations_ItemCommand);
  Include(Self.DataGrid_service_appropriations.CancelCommand, Self.CancelCommand_service_appropriations);
  Include(Self.DataGrid_service_appropriations.EditCommand, Self.EditCommand_service_appropriations);
  Include(Self.DataGrid_service_appropriations.UpdateCommand, Self.UpdateCommand_service_appropriations);
  Include(Self.DataGrid_service_appropriations.DeleteCommand, Self.DataGrid_service_appropriations_DeleteCommand);
  Include(Self.DataGrid_service_appropriations.ItemDataBound, Self.DataGrid_service_appropriations_ItemDataBound);
  Include(Self.Load, Self.Page_Load);
end;
{$ENDREGION}

const ID = '$Id$';

var
  be_before_deadline: boolean;
  be_sort_order_ascending: boolean;
  dgi_id: cardinal;
  dgi_password_reset_email_address: cardinal;
  dgi_affiliate_num: cardinal;
  dgi_name: cardinal;
  dgi_amount: cardinal;
  dgi_status_code: cardinal;
  dgi_status_description: cardinal;
  dgi_linkbutton_edit: cardinal;
  dgi_linkbutton_delete: cardinal;
  num_appropriations: cardinal;
  region_dictated_appropriation_amount: decimal;
  service_appropriations_sort_order: string;
  sum_of_service_appropriations: decimal;

procedure TWebForm_county_dictated_appropriations.Page_Load(sender: System.Object; e: System.EventArgs);
var
  bdr_appropriation_attribs: borland.data.provider.BdpDataReader;
  make_appropriations_deadline: system.datetime;
begin
  AppCommon.PopulatePlaceHolders(PlaceHolder_precontent,PlaceHolder_postcontent);
  if not IsPostback then begin
    //
    // Initialize implementation-global variables.
    //
    be_before_deadline := TRUE;
    be_sort_order_ascending := TRUE;
    num_appropriations := 0;
    service_appropriations_sort_order := 'name';
    sum_of_service_appropriations := 0;
    //   Set up symbolic DataGrid Indices for use in other event handlers.
    dgi_id                           := 0;
    dgi_password_reset_email_address := 1;
    dgi_affiliate_num                := 2;
    dgi_name                         := 3;
    dgi_amount                       := 4;
    dgi_status_code                  := 5;
    dgi_status_description           := 6;
    dgi_linkbutton_edit              := 7;
    dgi_linkbutton_delete            := 8;
    //
    Title.InnerText := ConfigurationSettings.AppSettings['application_name'] + ' - county_dictated_appropriations';
    Label_county_name.Text := session.Item['county_name'].ToString;
    //
    appcommon.DbOpen;
    //
    // Set parent appropriation labels.
    //
    bdr_appropriation_attribs := borland.data.provider.bdpcommand.Create
      (
      'select fiscal_year.designator,region_dictated_appropriation.amount,region_code_name_map.name '
      + 'from region_dictated_appropriation '
      +   'join state_dictated_appropriation on (state_dictated_appropriation.id=state_dictated_appropriation_id) '
      +   'join fiscal_year on (fiscal_year.id = fiscal_year_id) '
      +   'join region_code_name_map on (region_code_name_map.code = region_code) '
      + 'where region_dictated_appropriation.id = ' + session.Item['region_dictated_appropriation_id'].ToString,
      appcommon.db
      )
      .ExecuteReader;
    bdr_appropriation_attribs.Read;
    Label_fiscal_year_designator.Text := bdr_appropriation_attribs['designator'].tostring;
    region_dictated_appropriation_amount := decimal(bdr_appropriation_attribs['amount']);
    Label_parent_appropriation_amount.Text := region_dictated_appropriation_amount.ToString('C');
    Label_region_name.Text := bdr_appropriation_attribs['name'].tostring;
    bdr_appropriation_attribs.Close;
    //
    // All further rendering is deadline-dependent.
    //
    make_appropriations_deadline := system.datetime
      (
      borland.data.provider.bdpcommand.Create
        (
        'select value'
        + ' from fy_calendar'
        +   ' join fiscal_year on (fiscal_year.id = fiscal_year_id)'
        +   ' join milestone_code_name_map on (code = milestone_code)'
        + ' where designator = "' + Safe(Label_fiscal_year_designator.Text,ALPHANUM) + '"'
        +   ' and name = "emsof-county-dictated-appropriation-deadline"',
        appcommon.db
        )
        .ExecuteScalar
      );
    //
    if datetime.Now > make_appropriations_deadline then begin
      be_before_deadline := FALSE;
      TableRow_sum_of_service_appropriations.visible := FALSE;
      TableRow_unappropriated_amount.visible := FALSE;
      Table_deadlines.visible := FALSE;
      HyperLink_new_appropriation.visible := FALSE;
    end else begin
      Label_make_appropriations_deadline.text := make_appropriations_deadline.tostring('HH:mm:ss dddd, MMMM d, yyyy');
      LinkButton_county_dictated_deadline.text := datetime
        (
        borland.data.provider.bdpcommand.Create
          (
          'select service_to_county_submission_deadline from region_dictated_appropriation'
          + ' where id = ' + session.item['region_dictated_appropriation_id'].tostring,
          appcommon.db
          )
          .ExecuteScalar
        )
        .tostring('HH:mm:ss dddd, MMMM d, yyyy');
      //
    end;
    //
    appcommon.DbClose;
    //
    Bind_service_appropriations;  // also affected by be_before_deadline
  end;
end;

procedure TWebForm_county_dictated_appropriations.OnInit(e: EventArgs);
begin
  //
  // Required for Designer support
  //
  InitializeComponent;
  inherited OnInit(e);
end;

procedure TWebForm_county_dictated_appropriations.DataGrid_service_appropriations_ItemCommand(source: System.Object;
  e: System.Web.UI.WebControls.DataGridCommandEventArgs);
begin
  if e.commandname = 'Select' then begin
    session.Remove('fiscal_year_designator');
    session.Add('fiscal_year_designator',Safe(Label_fiscal_year_designator.text,ALPHANUM));
    session.Remove('service_name');
    session.Add('service_name',Safe(e.item.cells[dgi_name].text,ORG_NAME));
    session.Remove('affiliate_num');
    session.Add('affiliate_num',Safe(e.item.cells[dgi_affiliate_num].text,NUM));
    session.Remove('appropriation_amount');
    session.Add('appropriation_amount',Safe(e.item.cells[dgi_amount].text,REAL_NUM));
    session.Remove('county_dictated_appropriation_id');
    session.Add('county_dictated_appropriation_id',Safe(e.item.cells[dgi_id].text,NUM));
    server.Transfer('county_dictated_appropriation_detail.aspx');
  end;
end;

procedure TWebForm_county_dictated_appropriations.LinkButton_logout_Click(sender: System.Object;
  e: System.EventArgs);
begin
  formsauthentication.SignOut;
  session.Clear;
  server.Transfer('../Default.aspx');
end;

procedure TWebForm_county_dictated_appropriations.LinkButton_county_dictated_deadline_Click(sender: System.Object;
  e: System.EventArgs);
begin
  session.Remove('county_dictated_deadline');
  session.Add('county_dictated_deadline',LinkButton_county_dictated_deadline.text);
  server.Transfer('county_dictated_deadline.aspx');
end;

procedure TWebForm_county_dictated_appropriations.DataGrid_service_appropriations_DeleteCommand(source: System.Object;
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
    + ' where county_dictated_appropriation_id = ' + id_string,
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
    session.Remove('email_address_of_service_of_appropriation_selected_for_deletion');
    session.Add
      (
      'email_address_of_service_of_appropriation_selected_for_deletion',
      Safe(e.item.cells[dgi_password_reset_email_address].text,EMAIL_ADDRESS)
      );
    //
    session.Remove('service_name_of_appropriation_selected_for_deletion');
    session.Add('service_name_of_appropriation_selected_for_deletion',Safe(e.item.cells[dgi_name].text,ORG_NAME));
    //
    session.Remove('amount_of_appropriation_selected_for_deletion');
    session.Add('amount_of_appropriation_selected_for_deletion',Safe(e.item.cells[dgi_amount].text,REAL_NUM));
    //
    server.Transfer('delete_service_appropriation.aspx');
  end else begin
    //
    // Nothing is linked to this appropriation, so go ahead and delete it.
    //
    borland.data.provider.bdpcommand.Create
      (
      'delete from county_dictated_appropriation where id = ' + id_string,
      appcommon.db
      )
      .ExecuteNonQuery;
    //
    // Send a notification message.
    //
    smtpmail.SmtpServer := ConfigurationSettings.AppSettings['smtp_server'];
    smtpmail.Send
      (
      session.item['county_user_password_reset_email_address'].tostring,
      Safe(e.item.cells[dgi_password_reset_email_address].text,EMAIL_ADDRESS),
      'Deletion of ' + ConfigurationSettings.AppSettings['application_name'] + ' appropriation for your service',
      'The ' + session.Item['county_name'].ToString + ' County EMSOF Coordinator has deleted an EMSOF appropriation from your '
      + 'service for ' + Safe(Label_fiscal_year_designator.text,ALPHANUM) + '.' + NEW_LINE
      + NEW_LINE
      + 'For an overview of your EMSOF appropriations, visit:' + NEW_LINE
      + NEW_LINE
      + '   http://' + ConfigurationSettings.AppSettings['ssl_base_path'] + '/'
      + server.UrlEncode(ConfigurationSettings.AppSettings['application_name'])
      + '/protected/service_overview.aspx' + NEW_LINE
      + NEW_LINE
        + 'Replies to this message will be addressed to the ' + session.Item['county_name'].ToString + ' County EMSOF Coordinator.'
        + NEW_LINE
        + NEW_LINE
      + '-- ' + ConfigurationSettings.AppSettings['application_name']
      );
    //
    appcommon.DbClose;
  end;
  //
  DataGrid_service_appropriations.EditItemIndex := -1;
  Bind_service_appropriations;
end;

procedure TWebForm_county_dictated_appropriations.DataGrid_service_appropriations_ItemDataBound(sender: System.Object;
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
    num_appropriations := num_appropriations + 1;
    sum_of_service_appropriations :=
      sum_of_service_appropriations + decimal.Parse(databinder.Eval(e.item.dataitem,'amount').tostring);
    if e.item.cells[dgi_status_code].text > '2' then begin
      LinkButton(e.item.cells[dgi_status_description].controls.item[0]).enabled := TRUE;
      LinkButton(e.item.cells[dgi_status_description].controls.item[0]).forecolor := color.BLUE;
      if e.item.cells[dgi_status_code].text = '3' then begin
        LinkButton(e.item.cells[dgi_status_description].controls.item[0]).font.bold := TRUE;
        LinkButton(e.item.cells[dgi_status_description].controls.item[0]).text :=
          '>' + LinkButton(e.item.cells[dgi_status_description].controls.item[0]).text.ToUpper + '<';
      end;
    end else begin
      LinkButton(e.item.cells[dgi_status_description].controls.item[0]).enabled := FALSE;
    end;
    e.item.Cells[dgi_linkbutton_edit].controls.item[0].visible := be_before_deadline;
    e.item.Cells[dgi_linkbutton_delete].controls.item[0].visible := be_before_deadline;
  end;
end;

procedure TWebForm_county_dictated_appropriations.UpdateCommand_service_appropriations(source: System.Object;
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
    borland.data.provider.bdpcommand.Create
      (
      'update county_dictated_appropriation set amount = ' + amount.tostring + ' where id = ' + appropriation_id_string,
      appcommon.db
      )
      .ExecuteNonQuery;
    //
    smtpmail.SmtpServer := ConfigurationSettings.AppSettings['smtp_server'];
    smtpmail.Send
      (
      session.item['county_user_password_reset_email_address'].tostring,
      Safe(e.item.cells[dgi_password_reset_email_address].text,EMAIL_ADDRESS),
      'Modification of ' + ConfigurationSettings.AppSettings['application_name'] + ' appropriation for your service',
      'The ' + session.Item['county_name'].ToString + ' County EMSOF Coordinator has modified an EMSOF appropriation for your '
      + 'service for ' + Safe(Label_fiscal_year_designator.text,ALPHANUM) + '.' + NEW_LINE
      + NEW_LINE
      + 'You can work on this appropriation by visiting:' + NEW_LINE
      + NEW_LINE
      + '   http://' + ConfigurationSettings.AppSettings['host_domain_name'] + '/'
      + server.UrlEncode(ConfigurationSettings.AppSettings['application_name']) + '.htm' + NEW_LINE
      + NEW_LINE
        + 'Replies to this message will be addressed to the ' + session.Item['county_name'].ToString + ' County EMSOF Coordinator.'
        + NEW_LINE
        + NEW_LINE
      + '-- ' + ConfigurationSettings.AppSettings['application_name']
      );
    appcommon.DbClose;
    //
    DataGrid_service_appropriations.EditItemIndex := -1;
    Bind_service_appropriations;
  end;
end;

procedure TWebForm_county_dictated_appropriations.CancelCommand_service_appropriations(source: System.Object;
  e: System.Web.UI.WebControls.DataGridCommandEventArgs);
begin
  DataGrid_service_appropriations.EditItemIndex := -1;
  Bind_service_appropriations;
end;

procedure TWebForm_county_dictated_appropriations.EditCommand_service_appropriations(source: System.Object;
  e: System.Web.UI.WebControls.DataGridCommandEventArgs);
begin
  DataGrid_service_appropriations.EditItemIndex := e.Item.ItemIndex;
  Bind_service_appropriations;
end;

procedure TWebForm_county_dictated_appropriations.Bind_service_appropriations;
var
  be_datagrid_empty: boolean;
  cmdText: string;
begin
  appcommon.DbOpen;
  //
  // When changing this query, remember to make corresponding changes to DataGrid Index settings in Page_Load.
  //
  cmdText := 'select county_dictated_appropriation.id,' // column 0
  + ' password_reset_email_address,'                    // column 1
  + ' affiliate_num,'                                   // column 2
  + ' name,'                                            // column 3
  + ' county_dictated_appropriation.amount,'            // column 4
  + ' status_code,'                                     // column 5
  + ' description as status_description'                // column 6
  + ' from county_dictated_appropriation'
  +   ' join service on (service.id=service_id)'
  +   ' join service_user on (service_user.id=service.id)'
  +   ' join emsof_request_master on (emsof_request_master.county_dictated_appropriation_id=county_dictated_appropriation.id)'
  +   ' join request_status_code_description_map on (request_status_code_description_map.code=emsof_request_master.status_code)'
  + ' where region_dictated_appropriation_id = ' + session.Item['region_dictated_appropriation_id'].ToString
  + ' order by ' + service_appropriations_sort_order;
  if be_sort_order_ascending then begin
    cmdText := cmdText + ' asc';
  end else begin
    cmdText := cmdText + ' desc';
  end;
  //
  DataGrid_service_appropriations.DataSource :=
    borland.data.provider.bdpcommand.Create(cmdText,appcommon.db).ExecuteReader;
  DataGrid_service_appropriations.DataBind;
  be_datagrid_empty := (num_appropriations = 0);
  //
  // Manage control visibilities.
  //
  Label_no_appropriations.Visible := be_datagrid_empty;
  Datagrid_service_appropriations.Visible := not be_datagrid_empty;
  //
  // Manage non-DataGrid control properties.
  //
  Label_sum_of_service_appropriations.text := sum_of_service_appropriations.ToString('C');
  Label_unappropriated_amount.Text := (region_dictated_appropriation_amount - sum_of_service_appropriations).tostring('C');
  //
  // Clear aggregation vars for next bind, if any.
  //
  num_appropriations := 0;
  sum_of_service_appropriations := 0;
  appcommon.DbClose;
end;

procedure TWebForm_county_dictated_appropriations.SortCommand_service_appropriations(source: System.Object;
  e: System.Web.UI.WebControls.DataGridSortCommandEventArgs);
begin
  if e.SortExpression = service_appropriations_sort_order then begin
    be_sort_order_ascending := not be_sort_order_ascending;
  end else begin
    service_appropriations_sort_order := e.SortExpression;
    be_sort_order_ascending := TRUE;
  end;
  DataGrid_service_appropriations.EditItemIndex := -1;
  Bind_service_appropriations;
end;

end.

