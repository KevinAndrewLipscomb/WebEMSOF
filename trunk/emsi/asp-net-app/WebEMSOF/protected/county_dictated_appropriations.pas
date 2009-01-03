unit county_dictated_appropriations;

interface

uses
  System.Collections, System.ComponentModel,
  System.Data, System.Drawing, System.Web, System.Web.SessionState,
  system.web.ui, ki_web_ui, System.Web.UI.WebControls, System.Web.UI.HtmlControls,
  kix,
  mysql.data.mysqlclient,
  Class_biz_accounts,
  Class_biz_appropriations,
  Class_biz_emsof_requests,
  Class_biz_services,
  Class_biz_user,
  Class_db,
  Class_db_trail,
  system.configuration,
  system.web.mail,
  system.web.security;

type
  TWebForm_county_dictated_appropriations = class(ki_web_ui.page_class)
  {$REGION 'Designer Managed Code'}
  strict private
    procedure InitializeComponent;
    procedure DataGrid_service_appropriations_ItemDataBound(sender: System.Object;
      e: System.Web.UI.WebControls.DataGridItemEventArgs);
    procedure DataGrid_service_appropriations_DeleteCommand(source: System.Object;
      e: System.Web.UI.WebControls.DataGridCommandEventArgs);
    procedure LinkButton_county_dictated_deadline_Click(sender: System.Object;
      e: System.EventArgs);
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
    procedure Button_send_Click(sender: System.Object; e: System.EventArgs);
    procedure DropDownList_quick_message_targets_SelectedIndexChanged(sender: System.Object; 
      e: System.EventArgs);
  {$ENDREGION}
  strict private
    type
      p_type =
        RECORD
        biz_accounts: TClass_biz_accounts;
        biz_appropriations: TClass_biz_appropriations;
        biz_emsof_requests: TClass_biz_emsof_requests;
        biz_services: TClass_biz_services;
        biz_user: TClass_biz_user;
        be_before_deadline: boolean;
        be_filtered: boolean;
        be_sort_order_ascending: boolean;
        db: TClass_db;
        db_trail: TClass_db_trail;
        distribution_list_for_services_with_allocations: string;
        num_appropriations: cardinal;
        region_dictated_appropriation_amount: decimal;
        saved_amount: decimal;
        sort_order: string;
        sum_of_service_appropriations: decimal;
        unappropriated_amount: decimal;
        END;
  strict private
    p: p_type;
    procedure Bind_distribution_target;
    procedure Bind_service_appropriations;
    procedure Page_Load(sender: System.Object; e: System.EventArgs);
  strict protected
    Title: System.Web.UI.HtmlControls.HtmlGenericControl;
    PlaceHolder_precontent: System.Web.UI.WebControls.PlaceHolder;
    PlaceHolder_postcontent: System.Web.UI.WebControls.PlaceHolder;
    DataGrid_service_appropriations: System.Web.UI.WebControls.DataGrid;
    Label_make_appropriations_deadline: System.Web.UI.WebControls.Label;
    Label_parent_appropriation_amount: System.Web.UI.WebControls.Label;
    Label_region_name: System.Web.UI.WebControls.Label;
    Label_fiscal_year_designator: System.Web.UI.WebControls.Label;
    Label_sum_of_service_appropriations: System.Web.UI.WebControls.Label;
    Label_unappropriated_amount: System.Web.UI.WebControls.Label;
    TableRow_sum_of_service_appropriations: System.Web.UI.HtmlControls.HtmlTableRow;
    TableRow_unappropriated_amount: System.Web.UI.HtmlControls.HtmlTableRow;
    Label_no_appropriations: System.Web.UI.WebControls.Label;
    LinkButton_county_dictated_deadline: System.Web.UI.WebControls.LinkButton;
    Table_deadlines: System.Web.UI.HtmlControls.HtmlTable;
    LinkButton_new_appropriation: System.Web.UI.WebControls.LinkButton;
    Table_warning_forced_amount: System.Web.UI.HtmlControls.HtmlTable;
    Label_application_name: System.Web.UI.WebControls.Label;
    CheckBox_hide_nonapproval_requests: System.Web.UI.WebControls.CheckBox;
    Label_distribution_list: System.Web.UI.WebControls.Label;
    Button_send: System.Web.UI.WebControls.Button;
    RequiredFieldValidator_quick_message_body: System.Web.UI.WebControls.RequiredFieldValidator;
    TextBox_quick_message_body: System.Web.UI.WebControls.TextBox;
    TextBox_quick_message_subject: System.Web.UI.WebControls.TextBox;
    DropDownList_quick_message_targets: System.Web.UI.WebControls.DropDownList;
    Table_quick_message: System.Web.UI.HtmlControls.HtmlTable;
  protected
    procedure OnInit(e: EventArgs); override;
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
  Include(Self.LinkButton_county_dictated_deadline.Click, Self.LinkButton_county_dictated_deadline_Click);
  Include(Self.CheckBox_hide_nonapproval_requests.CheckedChanged, Self.CheckBox_hide_nonapproval_requests_CheckedChanged);
  Include(Self.LinkButton_new_appropriation.Click, Self.LinkButton_new_appropriation_Click);
  Include(Self.DataGrid_service_appropriations.ItemDataBound, Self.DataGrid_service_appropriations_ItemDataBound);
  Include(Self.DataGrid_service_appropriations.CancelCommand, Self.DataGrid_service_appropriations_CancelCommand);
  Include(Self.DataGrid_service_appropriations.EditCommand, Self.DataGrid_service_appropriations_EditCommand);
  Include(Self.DataGrid_service_appropriations.SortCommand, Self.DataGrid_service_appropriations_SortCommand);
  Include(Self.DataGrid_service_appropriations.ItemCommand, Self.DataGrid_service_appropriations_ItemCommand);
  Include(Self.DataGrid_service_appropriations.DeleteCommand, Self.DataGrid_service_appropriations_DeleteCommand);
  Include(Self.DataGrid_service_appropriations.UpdateCommand, Self.DataGrid_service_appropriations_UpdateCommand);
  Include(Self.DropDownList_quick_message_targets.SelectedIndexChanged, Self.DropDownList_quick_message_targets_SelectedIndexChanged);
  Include(Self.Button_send.Click, Self.Button_send_Click);
  Include(Self.PreRender, Self.TWebForm_county_dictated_appropriations_PreRender);
  Include(Self.Load, Self.Page_Load);
end;
{$ENDREGION}

procedure TWebForm_county_dictated_appropriations.Page_Load(sender: System.Object; e: System.EventArgs);
var
  dr_appropriation_attribs: mysqldatareader;
  county_dictated_deadline: system.datetime;
  make_appropriations_deadline: system.datetime;
begin
  if IsPostback then begin
    if assigned(session['county_dictated_appropriations.p']) then begin
      p := p_type(session['county_dictated_appropriations.p']);
    end else begin
      server.Transfer('~/timeout.aspx');
    end;
  end else begin
    if request.servervariables['URL'] = request.currentexecutionfilepath then begin
      session.Clear;
      server.Transfer('~/login.aspx');
    end;
    //
    p.biz_accounts := TClass_biz_accounts.Create;
    p.biz_appropriations := TClass_biz_appropriations.Create;
    p.biz_emsof_requests := TClass_biz_emsof_requests.Create;
    p.biz_services := TClass_biz_services.Create;
    p.biz_user := TClass_biz_user.Create;
    p.be_before_deadline := TRUE;
    p.be_filtered := FALSE;
    p.be_sort_order_ascending := TRUE;
    p.db := TClass_db.Create;
    p.db_trail := TClass_db_trail.Create;
    p.num_appropriations := 0;
    p.sort_order := 'service_name';
    p.sum_of_service_appropriations := 0;
    p.unappropriated_amount := 0;
    //
    Title.InnerText := configurationmanager.AppSettings['application_name'] + ' - county_dictated_appropriations';
    //
    p.db.Open;
    //
    // Set parent appropriation labels.
    //
    dr_appropriation_attribs := mysqlcommand.Create
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
    dr_appropriation_attribs.Read;
    Label_fiscal_year_designator.Text := dr_appropriation_attribs['designator'].tostring;
    p.region_dictated_appropriation_amount := decimal(dr_appropriation_attribs['amount']);
    Label_parent_appropriation_amount.Text := p.region_dictated_appropriation_amount.ToString('C');
    Label_region_name.Text := dr_appropriation_attribs['name'].tostring;
    Label_application_name.text := configurationmanager.appsettings['application_name'];
    dr_appropriation_attribs.Close;
    //
    // All further rendering is deadline-dependent.
    //
    make_appropriations_deadline := system.datetime
      (
      mysqlcommand.Create
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
      mysqlcommand.Create
        (
        'select service_to_county_submission_deadline from region_dictated_appropriation'
        + ' where id = ' + session['region_dictated_appropriation_id'].tostring,
        p.db.connection
        )
        .ExecuteScalar
      );
    SessionSet('county_dictated_deadline',county_dictated_deadline);
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
    //
    BeginBreadCrumbTrail;
    //
  end;
end;

procedure TWebForm_county_dictated_appropriations.OnInit(e: EventArgs);
begin
  //
  // Required for Designer support
  //
  InitializeComponent;
  inherited OnInit(e);
  //
end;

procedure TWebForm_county_dictated_appropriations.DropDownList_quick_message_targets_SelectedIndexChanged(sender: System.Object;
  e: System.EventArgs);
begin
  Bind_distribution_target;
end;

procedure TWebForm_county_dictated_appropriations.Button_send_Click(sender: System.Object;
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
    '-- From the ' + session[p.biz_user.Kind + '_name'].tostring + ' County EMSOF Coordinator (via ' + configurationmanager.appsettings['application_name']
    + ')' + NEW_LINE
    + NEW_LINE
    + TextBox_quick_message_body.text,
    // be_html
    FALSE,
    // cc
    EMPTY,
    // bcc
    EMPTY,
    // reply_to
    p.biz_accounts.EmailAddressByKindId(p.biz_user.Kind,p.biz_user.IdNum)
    );
  TextBox_quick_message_subject.text := EMPTY;
  TextBox_quick_message_body.text := EMPTY;
  Alert(LOGIC,NORMAL,'messagsnt','Message sent',TRUE);
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
  SessionSet('county_dictated_appropriations.p',p);
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
  SessionSet('parent_appropriation_amount',Safe(Label_parent_appropriation_amount.text,REAL_NUM));
  SessionSet('region_name',Safe(Label_region_name.text,ORG_NAME));
  SessionSet('fiscal_year_designator',Safe(Label_fiscal_year_designator.text,ALPHANUM));
  SessionSet('sum_of_service_appropriations',Safe(Label_sum_of_service_appropriations.text,REAL_NUM));
  SessionSet('unappropriated_amount',p.unappropriated_amount);
  DropCrumbAndTransferTo('create_new_service_appropriation.aspx');
end;

procedure TWebForm_county_dictated_appropriations.DataGrid_service_appropriations_ItemCommand(source: System.Object;
  e: System.Web.UI.WebControls.DataGridCommandEventArgs);
var
  waypoint_stack: stack;
begin
  if e.commandname = 'Select' then begin
    SessionSet('calling_form','county_dictated_appropriations.aspx');
    SessionSet('account_descriptor',session['county_name'].ToString + ' County');
    SessionSet('e_item',e.item);
    session.Remove('waypoint_stack');
    waypoint_stack := system.collections.stack.Create;
    waypoint_stack.Push('county_dictated_appropriations.aspx');
    session.Add('waypoint_stack',waypoint_stack);
    DropCrumbAndTransferTo('full_request_review_approve.aspx');
  end else if e.commandname = 'Edit' then begin
    p.saved_amount := decimal.Parse(Safe(e.item.cells[p.biz_emsof_requests.TcciOfAppropriation].text,REAL_NUM));
  end;
end;

procedure TWebForm_county_dictated_appropriations.LinkButton_county_dictated_deadline_Click(sender: System.Object;
  e: System.EventArgs);
begin
  SessionSet('county_dictated_deadline',LinkButton_county_dictated_deadline.text);
  DropCrumbAndTransferTo('county_dictated_deadline.aspx');
end;

procedure TWebForm_county_dictated_appropriations.DataGrid_service_appropriations_DeleteCommand(source: System.Object;
  e: System.Web.UI.WebControls.DataGridCommandEventArgs);
var
  bc: mysqlcommand;
  id_string: string;
begin
  p.db.Open;
  id_string := Safe(e.Item.Cells[p.biz_emsof_requests.TcciOfId].Text,NUM);
  bc := mysqlcommand.Create
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
    SessionSet('id_of_appropriation_selected_for_deletion',id_string);
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
    DropCrumbAndTransferTo('delete_service_appropriation.aspx');
  end else begin
    //
    // Nothing is linked to this appropriation, so go ahead and delete it.
    //
    mysqlcommand.Create
      (
      p.db_trail.Saved('delete from county_dictated_appropriation where id = ' + id_string),
      p.db.connection
      )
      .ExecuteNonQuery;
    //
    // Send a notification message.
    //
    kix.SmtpMailSend
      (
      configurationmanager.AppSettings['sender_email_address'],
      Safe(e.item.cells[p.biz_emsof_requests.TcciOfPasswordResetEmailAddress].text,EMAIL_ADDRESS),
      'Deletion of ' + configurationmanager.AppSettings['application_name'] + ' allocation for your service',
      'The ' + session['county_name'].ToString + ' County EMSOF Coordinator has deleted an EMSOF allocation from your '
      + 'service for ' + Safe(Label_fiscal_year_designator.text,ALPHANUM) + PERIOD + NEW_LINE
      + NEW_LINE
      + 'For an overview of your EMSOF allocations, visit:' + NEW_LINE
      + NEW_LINE
      + '   http://' + configurationmanager.AppSettings['host_domain_name'] + '/'
      + configurationmanager.AppSettings['application_name'] + NEW_LINE
      + NEW_LINE
      + 'You can contact the ' + session['county_name'].ToString + ' County EMSOF Coordinator at:' + NEW_LINE
      + NEW_LINE
      + '   ' + session['county_user_password_reset_email_address'].tostring + '  (mailto:' + session['county_user_password_reset_email_address'].tostring + ')' + NEW_LINE
      + NEW_LINE
      + '-- ' + configurationmanager.AppSettings['application_name'],
      // be_html
      FALSE,
      // cc
      EMPTY,
      // bcc
      EMPTY,
      // reply_to
      session['county_user_password_reset_email_address'].tostring
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
    e.item.cells[p.biz_emsof_requests.TcciOfLeftoverOrShortage].text := EMPTY;
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
    if e.item.cells[p.biz_emsof_requests.TcciOfPasswordResetEmailAddress].text <> '&nbsp;' then begin
       p.distribution_list_for_services_with_allocations := p.distribution_list_for_services_with_allocations + e.item.cells[p.biz_emsof_requests.TcciOfPasswordResetEmailAddress].text + COMMA_SPACE;
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
        ('update county_dictated_appropriation set amount = ' + amount.tostring + ' where id = ' + appropriation_id_string),
      p.db.connection
      )
      .ExecuteNonQuery;
    //
    kix.SmtpMailSend
      (
      configurationmanager.AppSettings['sender_email_address'],
      Safe(e.item.cells[p.biz_emsof_requests.TcciOfPasswordResetEmailAddress].text,EMAIL_ADDRESS),
      'Modification of ' + configurationmanager.AppSettings['application_name'] + ' allocation for your service',
      'The ' + session['county_name'].ToString + ' County EMSOF Coordinator has modified an EMSOF allocation for your '
      + 'service for ' + Safe(Label_fiscal_year_designator.text,ALPHANUM) + PERIOD + NEW_LINE
      + NEW_LINE
      + 'You can work on this allocation by visiting:' + NEW_LINE
      + NEW_LINE
      + '   http://' + configurationmanager.AppSettings['host_domain_name'] + '/'
      + configurationmanager.AppSettings['application_name'] + NEW_LINE
      + NEW_LINE
      + 'You can contact the ' + session['county_name'].ToString + ' County EMSOF Coordinator at:' + NEW_LINE
      + NEW_LINE
      + '   ' + session['county_user_password_reset_email_address'].tostring + '  (mailto:' + session['county_user_password_reset_email_address'].tostring + ')' + NEW_LINE
      + NEW_LINE
      + '-- ' + configurationmanager.AppSettings['application_name'],
      // be_html
      FALSE,
      // cc
      EMPTY,
      // bcc
      EMPTY,
      // reply_to
      session['county_user_password_reset_email_address'].tostring
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
  //
  p.distribution_list_for_services_with_allocations := EMPTY;
  //
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
  Bind_distribution_target;
  //
  // Clear aggregation vars for next bind, if any.
  //
  p.num_appropriations := 0;
  p.sum_of_service_appropriations := 0;
end;

procedure TWebForm_county_dictated_appropriations.Bind_distribution_target;
begin
  //
  if DropDownList_quick_message_targets.selectedvalue = 'with_allocations' then begin
    Label_distribution_list.text := (p.distribution_list_for_services_with_allocations + SPACE).TrimEnd([',',' ']);
  end else if DropDownList_quick_message_targets.selectedvalue = 'emsof_participants_true' then begin
    Label_distribution_list.text := p.biz_services.EmailTargetForCounty(p.biz_user.IdNum,TRUE,TRUE);
  end else if DropDownList_quick_message_targets.selectedvalue = 'emsof_participants_false' then begin
    Label_distribution_list.text := p.biz_services.EmailTargetForCounty(p.biz_user.IdNum,TRUE,FALSE);
  end else if DropDownList_quick_message_targets.selectedvalue = 'in_county' then begin
    Label_distribution_list.text := p.biz_services.EmailTargetForCounty(p.biz_user.IdNum);
  end;
  //
  TextBox_quick_message_subject.enabled := Label_distribution_list.text <> EMPTY;
  TextBox_quick_message_body.enabled := Label_distribution_list.text <> EMPTY;
  Button_send.enabled := Label_distribution_list.text <> EMPTY;
  //
end;

end.

