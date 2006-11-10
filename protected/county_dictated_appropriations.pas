
unit county_dictated_appropriations;

interface

uses
  System.Collections, System.ComponentModel,
  System.Data, System.Drawing, System.Web, System.Web.SessionState,
  system.Web.UI, System.Web.UI.WebControls, System.Web.UI.HtmlControls,
  ki.common,
  borland.data.provider,
  Class_biz_appropriations,
  Class_biz_emsof_requests,
  Class_db,
  system.configuration,
  system.web.mail,
  system.web.security;

const ID = '$Id$';

type
  p_type =
    RECORD
    biz_appropriations: TClass_biz_appropriations;
    biz_emsof_requests: TClass_biz_emsof_requests;
    be_before_deadline: boolean;
    be_filtered: boolean;
    be_sort_order_ascending: boolean;
    db: TClass_db;
    num_appropriations: cardinal;
    region_dictated_appropriation_amount: decimal;
    saved_amount: decimal;
    sort_order: string;
    sum_of_service_appropriations: decimal;
    unappropriated_amount: decimal;
    END;
  TWebForm_county_dictated_appropriations = class(System.Web.UI.Page)
  {$REGION 'Designer Managed Code'}
  strict private
    procedure InitializeComponent;
    procedure DataGrid_service_appropriations_ItemDataBound(sender: System.Object;
      e: System.Web.UI.WebControls.DataGridItemEventArgs);
    procedure DataGrid_service_appropriations_DeleteCommand(source: System.Object;
      e: System.Web.UI.WebControls.DataGridCommandEventArgs);
    procedure LinkButton_county_dictated_deadline_Click(sender: System.Object;
      e: System.EventArgs);
    procedure LinkButton_logout_Click(sender: System.Object; e: System.EventArgs);
    procedure DataGrid_service_appropriations_ItemCommand(source: System.Object;
      e: System.Web.UI.WebControls.DataGridCommandEventArgs);
    procedure LinkButton_new_appropriation_Click(sender: System.Object; e: System.EventArgs);
    procedure DataGrid_service_appropriations_SortCommand(source: System.Object;
      e: System.Web.UI.WebControls.DataGridSortCommandEventArgs);
    procedure TWebForm_county_dictated_appropriations_PreRender(sender: System.Object; 
      e: System.EventArgs);
    procedure DataGrid_service_appropriations_EditCommand(source: System.Object; 
      e: System.Web.UI.WebControls.DataGridCommandEventArgs);
    procedure DataGrid_service_appropriations_CancelCommand(source: System.Object; 
      e: System.Web.UI.WebControls.DataGridCommandEventArgs);
    procedure DataGrid_service_appropriations_UpdateCommand(source: System.Object; 
      e: System.Web.UI.WebControls.DataGridCommandEventArgs);
    procedure CheckBox_hide_nonapproval_requests_CheckedChanged(sender: System.Object; 
      e: System.EventArgs);
    procedure LinkButton_change_password_Click(sender: System.Object; e: System.EventArgs);
    procedure LinkButton_change_email_address_Click(sender: System.Object; e: System.EventArgs);
  {$ENDREGION}
  strict private
    p: p_type;
    procedure Bind_service_appropriations;
    procedure Page_Load(sender: System.Object; e: System.EventArgs);
  strict protected
    Title: System.Web.UI.HtmlControls.HtmlGenericControl;
    PlaceHolder_precontent: System.Web.UI.WebControls.PlaceHolder;
    PlaceHolder_postcontent: System.Web.UI.WebControls.PlaceHolder;
    Label_county_name: System.Web.UI.WebControls.Label;
    DataGrid_service_appropriations: System.Web.UI.WebControls.DataGrid;
    Label_literal_county: System.Web.UI.WebControls.Label;
    Label_make_appropriations_deadline: System.Web.UI.WebControls.Label;
    Label_parent_appropriation_amount: System.Web.UI.WebControls.Label;
    Label_region_name: System.Web.UI.WebControls.Label;
    Label_fiscal_year_designator: System.Web.UI.WebControls.Label;
    Label_sum_of_service_appropriations: System.Web.UI.WebControls.Label;
    Label_unappropriated_amount: System.Web.UI.WebControls.Label;
    TableRow_sum_of_service_appropriations: System.Web.UI.HtmlControls.HtmlTableRow;
    TableRow_unappropriated_amount: System.Web.UI.HtmlControls.HtmlTableRow;
    LinkButton_change_password: System.Web.UI.WebControls.LinkButton;
    LinkButton_change_email_address: System.Web.UI.WebControls.LinkButton;
    Label_no_appropriations: System.Web.UI.WebControls.Label;
    LinkButton_county_dictated_deadline: System.Web.UI.WebControls.LinkButton;
    Table_deadlines: System.Web.UI.HtmlControls.HtmlTable;
    LinkButton_logout: System.Web.UI.WebControls.LinkButton;
    LinkButton_new_appropriation: System.Web.UI.WebControls.LinkButton;
    Table_warning_forced_amount: System.Web.UI.HtmlControls.HtmlTable;
    Label_application_name: System.Web.UI.WebControls.Label;
    CheckBox_hide_nonapproval_requests: System.Web.UI.WebControls.CheckBox;
    procedure OnInit(e: EventArgs); override;
  public
    { Public Declarations }
  end;

implementation

const
  TCCI_LINKBUTTON_EDIT = 14;
  TCCI_LINKBUTTON_DELETE = 15;

{$REGION 'Designer Managed Code'}
/// <summary>
/// Required method for Designer support -- do not modify
/// the contents of this method with the code editor.
/// </summary>
procedure TWebForm_county_dictated_appropriations.InitializeComponent;
begin
  Include(Self.LinkButton_logout.Click, Self.LinkButton_logout_Click);
  Include(Self.LinkButton_change_password.Click, Self.LinkButton_change_password_Click);
  Include(Self.LinkButton_change_email_address.Click, Self.LinkButton_change_email_address_Click);
  Include(Self.LinkButton_county_dictated_deadline.Click, Self.LinkButton_county_dictated_deadline_Click);
  Include(Self.CheckBox_hide_nonapproval_requests.CheckedChanged, Self.CheckBox_hide_nonapproval_requests_CheckedChanged);
  Include(Self.LinkButton_new_appropriation.Click, Self.LinkButton_new_appropriation_Click);
  Include(Self.DataGrid_service_appropriations.ItemCommand, Self.DataGrid_service_appropriations_ItemCommand);
  Include(Self.DataGrid_service_appropriations.CancelCommand, Self.DataGrid_service_appropriations_CancelCommand);
  Include(Self.DataGrid_service_appropriations.EditCommand, Self.DataGrid_service_appropriations_EditCommand);
  Include(Self.DataGrid_service_appropriations.SortCommand, Self.DataGrid_service_appropriations_SortCommand);
  Include(Self.DataGrid_service_appropriations.UpdateCommand, Self.DataGrid_service_appropriations_UpdateCommand);
  Include(Self.DataGrid_service_appropriations.DeleteCommand, Self.DataGrid_service_appropriations_DeleteCommand);
  Include(Self.DataGrid_service_appropriations.ItemDataBound, Self.DataGrid_service_appropriations_ItemDataBound);
  Include(Self.Load, Self.Page_Load);
  Include(Self.PreRender, Self.TWebForm_county_dictated_appropriations_PreRender);
end;
{$ENDREGION}

procedure TWebForm_county_dictated_appropriations.Page_Load(sender: System.Object; e: System.EventArgs);
var
  bdr_appropriation_attribs: borland.data.provider.BdpDataReader;
  county_dictated_deadline: system.datetime;
  make_appropriations_deadline: system.datetime;
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
    // Initialize implementation-global variables.
    //
    p.biz_appropriations := TClass_biz_appropriations.Create;
    p.biz_emsof_requests := TClass_biz_emsof_requests.Create;
    p.be_before_deadline := TRUE;
    p.be_filtered := FALSE;
    p.be_sort_order_ascending := TRUE;
    p.db := TClass_db.Create;
    p.num_appropriations := 0;
    p.sort_order := 'service_name';
    p.sum_of_service_appropriations := 0;
    p.unappropriated_amount := 0;
    //   Set up symbolic DataGrid Indices for use in other event handlers.
    //
    Title.InnerText := ConfigurationSettings.AppSettings['application_name'] + ' - county_dictated_appropriations';
    Label_county_name.Text := session['county_name'].ToString;
    //
    p.db.Open;
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
      + 'where region_dictated_appropriation.id = ' + session['region_dictated_appropriation_id'].ToString,
      p.db.connection
      )
      .ExecuteReader;
    bdr_appropriation_attribs.Read;
    Label_fiscal_year_designator.Text := bdr_appropriation_attribs['designator'].tostring;
    p.region_dictated_appropriation_amount := decimal(bdr_appropriation_attribs['amount']);
    Label_parent_appropriation_amount.Text := p.region_dictated_appropriation_amount.ToString('C');
    Label_region_name.Text := bdr_appropriation_attribs['name'].tostring;
    Label_application_name.text := configurationsettings.appsettings['application_name'];
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
        p.db.connection
        )
        .ExecuteScalar
      );
    county_dictated_deadline := datetime
      (
      borland.data.provider.bdpcommand.Create
        (
        'select service_to_county_submission_deadline from region_dictated_appropriation'
        + ' where id = ' + session['region_dictated_appropriation_id'].tostring,
        p.db.connection
        )
        .ExecuteScalar
      );
    session.Remove('county_dictated_deadline');
    session.Add('county_dictated_deadline',county_dictated_deadline);
    //
    if datetime.Now > make_appropriations_deadline then begin
      p.be_before_deadline := FALSE;
      TableRow_sum_of_service_appropriations.visible := FALSE;
      TableRow_unappropriated_amount.visible := FALSE;
      Table_deadlines.visible := FALSE;
      LinkButton_new_appropriation.visible := FALSE;
    end else begin
      Label_make_appropriations_deadline.text := make_appropriations_deadline.tostring('HH:mm:ss dddd, MMMM d, yyyy');
      LinkButton_county_dictated_deadline.text := county_dictated_deadline.tostring('HH:mm:ss dddd, MMMM d, yyyy');
    end;
    //
    p.db.Close;
    //
    Table_warning_forced_amount.visible := FALSE;
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

procedure TWebForm_county_dictated_appropriations.LinkButton_change_email_address_Click(sender: System.Object;
  e: System.EventArgs);
begin
  server.Transfer('change_email_address.aspx');
end;

procedure TWebForm_county_dictated_appropriations.LinkButton_change_password_Click(sender: System.Object;
  e: System.EventArgs);
begin
  server.Transfer('change_password.aspx');
end;

procedure TWebForm_county_dictated_appropriations.CheckBox_hide_nonapproval_requests_CheckedChanged(sender: System.Object;
  e: System.EventArgs);
begin
  p.be_filtered := not p.be_filtered;
  Bind_service_appropriations;
end;

procedure TWebForm_county_dictated_appropriations.TWebForm_county_dictated_appropriations_PreRender(sender: System.Object;
  e: System.EventArgs);
begin
  session.Remove('p');
  session.Add('p',p);
end;

procedure TWebForm_county_dictated_appropriations.DataGrid_service_appropriations_SortCommand(source: System.Object;
  e: System.Web.UI.WebControls.DataGridSortCommandEventArgs);
begin
  if e.SortExpression = p.sort_order then begin
    p.be_sort_order_ascending := not p.be_sort_order_ascending;
  end else begin
    p.sort_order := e.SortExpression;
    p.be_sort_order_ascending := TRUE;
  end;
  Table_warning_forced_amount.visible := FALSE;
  DataGrid_service_appropriations.EditItemIndex := -1;
  Bind_service_appropriations;
end;

procedure TWebForm_county_dictated_appropriations.LinkButton_new_appropriation_Click(sender: System.Object;
  e: System.EventArgs);
begin
  session.Remove('parent_appropriation_amount');
  session.Add('parent_appropriation_amount',Safe(Label_parent_appropriation_amount.text,REAL_NUM));
  session.Remove('region_name');
  session.Add('region_name',Safe(Label_region_name.text,ORG_NAME));
  session.Remove('fiscal_year_designator');
  session.Add('fiscal_year_designator',Safe(Label_fiscal_year_designator.text,ALPHANUM));
  session.Remove('sum_of_service_appropriations');
  session.Add('sum_of_service_appropriations',Safe(Label_sum_of_service_appropriations.text,REAL_NUM));
  session.Remove('unappropriated_amount');
  session.Add('unappropriated_amount',p.unappropriated_amount);
  server.Transfer('create_new_service_appropriation.aspx');
end;

procedure TWebForm_county_dictated_appropriations.DataGrid_service_appropriations_ItemCommand(source: System.Object;
  e: System.Web.UI.WebControls.DataGridCommandEventArgs);
var
  waypoint_stack: stack;
begin
  if e.commandname = 'Select' then begin
    session.Remove('calling_form');
    session.Add('calling_form','county_dictated_appropriations.aspx');
    session.Remove('account_descriptor');
    session.Add('account_descriptor',session['county_name'].ToString + ' County');
    session.Remove('e_item');
    session.Add('e_item',e.item);
    session.Remove('waypoint_stack');
    waypoint_stack := system.collections.stack.Create;
    waypoint_stack.Push('county_dictated_appropriations.aspx');
    session.Add('waypoint_stack',waypoint_stack);
    server.Transfer('full_request_review_approve.aspx');
  end else if e.commandname = 'Edit' then begin
    p.saved_amount := decimal.Parse(Safe(e.item.cells[p.biz_emsof_requests.TcciOfAppropriation].text,REAL_NUM));
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
  p.db.Open;
  id_string := Safe(e.Item.Cells[p.biz_emsof_requests.TcciOfId].Text,NUM);
  bc := borland.data.provider.bdpcommand.Create
    (
    'select count(master_id)'  // Leaving the star out prevents inclusion of nulls in count
    + ' from emsof_request_detail'
    +   ' join emsof_request_master on (emsof_request_master.id=emsof_request_detail.master_id)'
    + ' where county_dictated_appropriation_id = ' + id_string,
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
    session.Remove('email_address_of_service_of_appropriation_selected_for_deletion');
    session.Add
      (
      'email_address_of_service_of_appropriation_selected_for_deletion',
      Safe(e.item.cells[p.biz_emsof_requests.TcciOfPasswordResetEmailAddress].text,EMAIL_ADDRESS)
      );
    //
    session.Remove('service_name_of_appropriation_selected_for_deletion');
    session.Add
      (
      'service_name_of_appropriation_selected_for_deletion',
      Safe(e.item.cells[p.biz_emsof_requests.TcciOfServiceName].text,ORG_NAME)
      );
    //
    session.Remove('amount_of_appropriation_selected_for_deletion');
    session.Add
      (
      'amount_of_appropriation_selected_for_deletion',
      Safe(e.item.cells[p.biz_emsof_requests.TcciOfAppropriation].text,REAL_NUM)
      );
    //
    server.Transfer('delete_service_appropriation.aspx');
  end else begin
    //
    // Nothing is linked to this appropriation, so go ahead and delete it.
    //
    borland.data.provider.bdpcommand.Create
      (
      'delete from county_dictated_appropriation where id = ' + id_string,
      p.db.connection
      )
      .ExecuteNonQuery;
    //
    // Send a notification message.
    //
    ki.common.SmtpMailSend
      (
      ConfigurationSettings.AppSettings['sender_email_address'],
      Safe(e.item.cells[p.biz_emsof_requests.TcciOfPasswordResetEmailAddress].text,EMAIL_ADDRESS),
      'Deletion of ' + ConfigurationSettings.AppSettings['application_name'] + ' allocation for your service',
      'The ' + session['county_name'].ToString + ' County EMSOF Coordinator has deleted an EMSOF allocation from your '
      + 'service for ' + Safe(Label_fiscal_year_designator.text,ALPHANUM) + '.' + NEW_LINE
      + NEW_LINE
      + 'For an overview of your EMSOF allocations, visit:' + NEW_LINE
      + NEW_LINE
      + '   http://' + ConfigurationSettings.AppSettings['host_domain_name'] + '/'
      + ConfigurationSettings.AppSettings['application_name'] + NEW_LINE
      + NEW_LINE
      + 'You can contact the ' + session['county_name'].ToString + ' County EMSOF Coordinator at:' + NEW_LINE
      + NEW_LINE
      + '   ' + session['county_user_password_reset_email_address'].tostring + '  (mailto:' + session['county_user_password_reset_email_address'].tostring + ')' + NEW_LINE
      + NEW_LINE
      + '-- ' + ConfigurationSettings.AppSettings['application_name']
      );
    //
    p.db.Close;
  end;
  //
  Table_warning_forced_amount.visible := FALSE;
  DataGrid_service_appropriations.EditItemIndex := -1;
  Bind_service_appropriations;
end;

procedure TWebForm_county_dictated_appropriations.DataGrid_service_appropriations_ItemDataBound
  (
  sender: System.Object;
  e: System.Web.UI.WebControls.DataGridItemEventArgs
  );
var
  leftover_or_shortage: decimal;
begin
  //
  // Manage column visibility
  //
  e.item.cells[TCCI_LINKBUTTON_EDIT].visible := p.be_before_deadline;
  e.item.cells[TCCI_LINKBUTTON_DELETE].visible := p.be_before_deadline;
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
    //
    // Manage the way some of the row values are rendered.
    //
    //   By default, do not display the Leftover / Shortage value.  But save it off just in case.
    //
    leftover_or_shortage := decimal.parse(Safe(e.item.cells[p.biz_emsof_requests.TcciOfLeftoverOrShortage].text,REAL_NUM_INCLUDING_NEGATIVE));
    e.item.cells[p.biz_emsof_requests.TcciOfLeftoverOrShortage].text := system.string.EMPTY;
    //
    if convert.ToInt16(e.item.cells[p.biz_emsof_requests.TcciOfStatusCode].text) > 2 then begin
      LinkButton(e.item.cells[p.biz_emsof_requests.TcciOfStatusDescription].controls.item[0]).enabled := TRUE;
      LinkButton(e.item.cells[p.biz_emsof_requests.TcciOfStatusDescription].controls.item[0]).forecolor := color.BLUE;
      if convert.ToInt16(e.item.cells[p.biz_emsof_requests.TcciOfStatusCode].text) >= 3 then begin
        if convert.ToInt16(e.item.cells[p.biz_emsof_requests.TcciOfStatusCode].text) = 3 then begin
          //
          // Make the need for county approval abundantly conspicuous.
          //
          LinkButton(e.item.cells[p.biz_emsof_requests.TcciOfStatusDescription].controls.item[0]).font.bold := TRUE;
          LinkButton(e.item.cells[p.biz_emsof_requests.TcciOfStatusDescription].controls.item[0]).text :=
            '>' + LinkButton(e.item.cells[p.biz_emsof_requests.TcciOfStatusDescription].controls.item[0]).text.ToUpper + '<';
          //
          // Manage the way the Leftover / Shortage is rendered, if at all.
          //
          if (leftover_or_shortage <> 0) then begin
            e.item.cells[p.biz_emsof_requests.TcciOfLeftoverOrShortage].text := leftover_or_shortage.tostring('N2');
              // Must use N format above to preserve unary minus sign on shortages, else approval code won't work.
            if (leftover_or_shortage < 0) then begin
              e.item.cells[p.biz_emsof_requests.TcciOfLeftoverOrShortage].forecolor := color.red;
            end;
          end;
          //
        end;
        LinkButton(e.item.cells[TCCI_LINKBUTTON_EDIT].controls.item[0]).visible := FALSE;
        LinkButton(e.item.cells[TCCI_LINKBUTTON_DELETE].controls.item[0]).visible := FALSE;
      end;
    end else begin
      LinkButton(e.item.cells[p.biz_emsof_requests.TcciOfStatusDescription].controls.item[0]).enabled := FALSE;
    end;
    //
  end;
end;

procedure TWebForm_county_dictated_appropriations.DataGrid_service_appropriations_UpdateCommand(source: System.Object;
  e: System.Web.UI.WebControls.DataGridCommandEventArgs);
var
  amount: decimal;
  amount_string: string;
  appropriation_id_string: string;
begin
  p.db.Open;
  //
  appropriation_id_string := Safe(e.Item.Cells[p.biz_emsof_requests.TcciOfId].Text,NUM);
  amount_string := Safe(TextBox(e.Item.Cells[p.biz_emsof_requests.TcciOfAppropriation].controls[0]).Text.Trim,REAL_NUM);
  //
  if amount_string <> system.string.EMPTY then begin
    amount := decimal.Parse(amount_string);
    //
    if (amount - p.saved_amount) > p.unappropriated_amount then begin
      amount := p.saved_amount + p.unappropriated_amount;
      Table_warning_forced_amount.visible := TRUE;
    end else begin
      Table_warning_forced_amount.visible := FALSE;
    end;
    borland.data.provider.bdpcommand.Create
      (
      'update county_dictated_appropriation set amount = ' + amount.tostring + ' where id = ' + appropriation_id_string,
      p.db.connection
      )
      .ExecuteNonQuery;
    //
    ki.common.SmtpMailSend
      (
      ConfigurationSettings.AppSettings['sender_email_address'],
      Safe(e.item.cells[p.biz_emsof_requests.TcciOfPasswordResetEmailAddress].text,EMAIL_ADDRESS),
      'Modification of ' + ConfigurationSettings.AppSettings['application_name'] + ' allocation for your service',
      'The ' + session['county_name'].ToString + ' County EMSOF Coordinator has modified an EMSOF allocation for your '
      + 'service for ' + Safe(Label_fiscal_year_designator.text,ALPHANUM) + '.' + NEW_LINE
      + NEW_LINE
      + 'You can work on this allocation by visiting:' + NEW_LINE
      + NEW_LINE
      + '   http://' + ConfigurationSettings.AppSettings['host_domain_name'] + '/'
      + ConfigurationSettings.AppSettings['application_name'] + NEW_LINE
      + NEW_LINE
      + 'You can contact the ' + session['county_name'].ToString + ' County EMSOF Coordinator at:' + NEW_LINE
      + NEW_LINE
      + '   ' + session['county_user_password_reset_email_address'].tostring + '  (mailto:' + session['county_user_password_reset_email_address'].tostring + ')' + NEW_LINE
      + NEW_LINE
      + '-- ' + ConfigurationSettings.AppSettings['application_name']
      );
    p.db.Close;
    //
    DataGrid_service_appropriations.EditItemIndex := -1;
    Bind_service_appropriations;
  end;
end;

procedure TWebForm_county_dictated_appropriations.DataGrid_service_appropriations_CancelCommand(source: System.Object;
  e: System.Web.UI.WebControls.DataGridCommandEventArgs);
begin
  Table_warning_forced_amount.visible := FALSE;
  DataGrid_service_appropriations.EditItemIndex := -1;
  Bind_service_appropriations;
end;

procedure TWebForm_county_dictated_appropriations.DataGrid_service_appropriations_EditCommand(source: System.Object;
  e: System.Web.UI.WebControls.DataGridCommandEventArgs);
begin
  DataGrid_service_appropriations.EditItemIndex := e.Item.ItemIndex;
  Bind_service_appropriations;
end;

procedure TWebForm_county_dictated_appropriations.Bind_service_appropriations;
var
  be_datagrid_empty: boolean;
begin
  if p.be_filtered then begin
    p.biz_emsof_requests.BindOverviewByRegionDictatedAppropriationAndStatus
      (
      session['region_dictated_appropriation_id'].tostring,
      Class_biz_emsof_requests.NEEDS_COUNTY_APPROVAL,
      p.sort_order,
      p.be_sort_order_ascending,
      DataGrid_service_appropriations
      );
  end else begin
    p.biz_emsof_requests.BindOverviewByRegionDictatedAppropriation
      (
      session['region_dictated_appropriation_id'].tostring,
      p.sort_order,
      p.be_sort_order_ascending,
      DataGrid_service_appropriations
      );
  end;
  //
  // Manage control visibilities.
  //
  be_datagrid_empty := (p.num_appropriations = 0);
  Label_no_appropriations.Visible := be_datagrid_empty;
  Datagrid_service_appropriations.Visible := not be_datagrid_empty;
  //
  // Manage non-DataGrid control properties.
  //
  p.sum_of_service_appropriations := p.biz_appropriations.SumOfSelfDictatedAppropriations;
  Label_sum_of_service_appropriations.text := p.sum_of_service_appropriations.tostring('C');
  p.unappropriated_amount := p.region_dictated_appropriation_amount - p.sum_of_service_appropriations;
  Label_unappropriated_amount.Text := p.unappropriated_amount.tostring('C');
  if p.unappropriated_amount < 0 then begin
    Label_unappropriated_amount.font.bold := TRUE;
    Label_unappropriated_amount.forecolor := color.red;
  end;
  //
  // Clear aggregation vars for next bind, if any.
  //
  p.num_appropriations := 0;
  p.sum_of_service_appropriations := 0;
end;

end.

