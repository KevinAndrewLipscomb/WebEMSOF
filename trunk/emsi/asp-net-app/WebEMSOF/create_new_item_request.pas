
unit create_new_item_request;

interface

uses
  System.Collections, System.ComponentModel,
  System.Data, System.Drawing, System.Web, System.Web.SessionState,
  System.Web.UI, System.Web.UI.WebControls, System.Web.UI.HtmlControls, AppCommon, system.configuration, borland.data.provider,
  system.web.mail;

type
  TWebForm_create_new_item_request = class(System.Web.UI.Page)
  {$REGION 'Designer Managed Code'}
  strict private
    procedure InitializeComponent;
    procedure Button_cancel_Click(sender: System.Object; e: System.EventArgs);
    procedure DropDownList_equipment_category_SelectedIndexChanged(sender: System.Object;
      e: System.EventArgs);
    procedure Button_submit_and_repeat_Click(sender: System.Object; e: System.EventArgs);
    procedure Button_submit_and_stop_Click(sender: System.Object; e: System.EventArgs);
  {$ENDREGION}
  strict private
    procedure Page_Load(sender: System.Object; e: System.EventArgs);
    procedure AddItem
      (
      amount_string: string;
      service_id_string: string
      );
  strict protected
    Title: System.Web.UI.HtmlControls.HtmlGenericControl;
    PlaceHolder_precontent: System.Web.UI.WebControls.PlaceHolder;
    PlaceHolder_postcontent: System.Web.UI.WebControls.PlaceHolder;
    DropDownList_equipment_category: System.Web.UI.WebControls.DropDownList;
    Button_cancel: System.Web.UI.WebControls.Button;
    Label_life_expectancy: System.Web.UI.WebControls.Label;
    TextBox_make_model: System.Web.UI.WebControls.TextBox;
    RequiredFieldValidator_make_model: System.Web.UI.WebControls.RequiredFieldValidator;
    TextBox_place_kept: System.Web.UI.WebControls.TextBox;
    RequiredFieldValidator_place_kept: System.Web.UI.WebControls.RequiredFieldValidator;
    RequiredFieldValidator_condition: System.Web.UI.WebControls.RequiredFieldValidator;
    RadioButtonList_condition: System.Web.UI.WebControls.RadioButtonList;
    RegularExpressionValidator_make_model: System.Web.UI.WebControls.RegularExpressionValidator;
    RegularExpressionValidator_place_kept: System.Web.UI.WebControls.RegularExpressionValidator;
    RequiredFieldValidator_unit_cost: System.Web.UI.WebControls.RequiredFieldValidator;
    RegularExpressionValidator_unit_cost: System.Web.UI.WebControls.RegularExpressionValidator;
    TextBox_quantity: System.Web.UI.WebControls.TextBox;
    RequiredFieldValidator_quantity: System.Web.UI.WebControls.RequiredFieldValidator;
    RegularExpressionValidator_quantity: System.Web.UI.WebControls.RegularExpressionValidator;
    Label_total_cost: System.Web.UI.WebControls.Label;
    Label_match_level: System.Web.UI.WebControls.Label;
    Label_min_service_ante: System.Web.UI.WebControls.Label;
    TextBox_additional_service_ante: System.Web.UI.WebControls.TextBox;
    RegularExpressionValidator_additinoal_service_ante: System.Web.UI.WebControls.RegularExpressionValidator;
    Label_sponsor_county: System.Web.UI.WebControls.Label;
    Label_emsof_ante: System.Web.UI.WebControls.Label;
    Label_allowable_cost: System.Web.UI.WebControls.Label;
    RequiredFieldValidator_equipment_category: System.Web.UI.WebControls.RequiredFieldValidator;
    RangeValidator_equipment_category: System.Web.UI.WebControls.RangeValidator;
    Button_submit_and_repeat: System.Web.UI.WebControls.Button;
    Button_submit_and_stop: System.Web.UI.WebControls.Button;
    TextBox_unit_cost: System.Web.UI.WebControls.TextBox;
    procedure OnInit(e: EventArgs); override;
  private
  public
    { Public Declarations }
  end;

implementation

{$REGION 'Designer Managed Code'}
/// <summary>
/// Required method for Designer support -- do not modify
/// the contents of this method with the code editor.
/// </summary>
procedure TWebForm_create_new_item_request.InitializeComponent;
begin
  Include(Self.DropDownList_equipment_category.SelectedIndexChanged, Self.DropDownList_equipment_category_SelectedIndexChanged);
  Include(Self.Button_submit_and_repeat.Click, Self.Button_submit_and_repeat_Click);
  Include(Self.Button_submit_and_stop.Click, Self.Button_submit_and_stop_Click);
  Include(Self.Button_cancel.Click, Self.Button_cancel_Click);
  Include(Self.Load, Self.Page_Load);
end;
{$ENDREGION}

const ID = '$Id$';

procedure TWebForm_create_new_item_request.Page_Load(sender: System.Object; e: System.EventArgs);
var
  bdr_factors: borland.data.provider.BdpDataReader;
  bdr_services: borland.data.provider.BdpDataReader;
  cmdText: string;
begin
  AppCommon.PopulatePlaceHolders(PlaceHolder_precontent,PlaceHolder_postcontent);
  if not IsPostback then begin
    Title.InnerText := server.HtmlEncode(ConfigurationSettings.AppSettings['application_name']) + ' - create_new_item_request';
    //
    appcommon.bdpconnection.Open;
    //
    // Determine this service's eligibility factors.
    //
    bdr_factors := borland.data.provider.bdpcommand.Create
      (
      'select (be_als_amb or be_air_amb) as be_als_amb,'
      + ' (be_als_amb or be_als_squad) as be_als_squad,'
      + ' (be_bls_amb or be_als_amb) as be_bls_amb,'
      + ' (be_qrs or be_bls_amb or be_als_amb or be_als_squad) as be_qrs'
      + ' FROM service'
      + ' WHERE id = ' + session.item['service_user_id'].tostring,
      appcommon.bdpconnection
      )
      .ExecuteReader;
    bdr_factors.Read;
    cmdText := 'SELECT code,description FROM eligible_provider_equipment_list WHERE FALSE '; // Default to empty set
    if bdr_factors['be_als_amb'].tostring = '1' then begin
      cmdText := cmdText + 'or be_eligible_als_amb = 1 ';
    end;
    if bdr_factors['be_als_squad'].tostring = '1' then begin
      cmdText := cmdText + 'or be_eligible_als_squad = 1 ';
    end;
    if bdr_factors['be_bls_amb'].tostring = '1' then begin
      cmdText := cmdText + 'or be_eligible_bls_amb = 1 ';
    end;
    if bdr_factors['be_qrs'].tostring = '1' then begin
      cmdText := cmdText + 'or be_eligible_qrs = 1 ';
    end;
    cmdText := cmdText + 'ORDER BY description';
    bdr_factors.Close;
    //
    // Build DropDownList using the appropriate query.
    //
    DropDownList_equipment_category.Items.Add(listitem.Create('-- Select --','0'));
    //
    bdr_services := Borland.Data.Provider.BdpCommand.Create(cmdText,AppCommon.BdpConnection).ExecuteReader;
    while bdr_services.Read do begin
      DropDownList_equipment_category.Items.Add(listitem.Create(bdr_services['description'].tostring,bdr_services['code'].ToString));
    end;
    appcommon.bdpconnection.Close;
  end;
end;

procedure TWebForm_create_new_item_request.OnInit(e: EventArgs);
begin
  //
  // Required for Designer support
  //
  InitializeComponent;
  inherited OnInit(e);
end;

procedure TWebForm_create_new_item_request.Button_submit_and_stop_Click(sender: System.Object;
  e: System.EventArgs);
begin
//  AddItem(Safe(TextBox_new_amount.Text.Trim,REAL_NUM),Safe(DropDownList_services.SelectedValue,NUM));
  server.Transfer('request_overview.aspx');
end;

procedure TWebForm_create_new_item_request.Button_submit_and_repeat_Click(sender: System.Object;
  e: System.EventArgs);
begin
//  AddItem(Safe(TextBox_new_amount.Text.Trim,REAL_NUM),Safe(DropDownList_services.SelectedValue,NUM));
//  TextBox_new_amount.Text := system.string.EMPTY;
  DropDownList_equipment_category.SelectedIndex := -1;
end;

procedure TWebForm_create_new_item_request.DropDownList_equipment_category_SelectedIndexChanged(sender: System.Object;
  e: System.EventArgs);
begin

end;

procedure TWebForm_create_new_item_request.Button_cancel_Click(sender: System.Object;
  e: System.EventArgs);
begin
  server.Transfer('request_overview.aspx');
end;

procedure TWebForm_create_new_item_request.AddItem
  (
  amount_string: string;
  service_id_string: string
  );
var
  amount: decimal;
  bc_get_cc_email_address: borland.data.provider.bdpcommand;
  bc_get_fy_designator: borland.data.provider.bdpcommand;
  bc_get_service_email_address: borland.data.provider.bdpcommand;
  max_county_dictated_appropriation_id_string: string;
begin
  if amount_string <> system.string.EMPTY then begin
    amount := decimal.Parse(amount_string);
    if amount > 0 then begin
      appcommon.bdpconnection.Open;
      //
      // Record the new appropriation.
      //
      borland.data.provider.bdpcommand.Create
        (
        'insert into county_dictated_appropriation'
        + ' set region_dictated_appropriation_id = ' + session.Item['region_dictated_appropriation_id'].tostring + ','
        +   ' service_id = ' + service_id_string + ','
        +   ' amount = ' + amount.tostring,
        appcommon.bdpconnection
        )
        .ExecuteNonQuery;
      //
      // Initialize a new emsof_request_master record, since at this time there must be a one-to-one relationship between a county-
      // dictated appropriation and an EMSOF request.
      //
      //   Get max(county_dictated_appropriation.id), which must be the id of the county_dictated_appropriation record that we just
      //   inserted.
      //
      max_county_dictated_appropriation_id_string := borland.data.provider.bdpcommand.Create
        (
        'select max(id) from county_dictated_appropriation',
        appcommon.bdpconnection
        )
        .ExecuteScalar.tostring;
      //
      //    Insert and link back to the above max id.
      //
      borland.data.provider.bdpcommand.Create
        (
        'insert into emsof_request_master set county_dictated_appropriation_id = ' + max_county_dictated_appropriation_id_string,
        appcommon.bdpconnection
        )
        .ExecuteNonQuery;
      //
      // Send notice of the appropriation to the service's email address of record.
      //
      //   Set up the command to get service's email address of record.
      bc_get_service_email_address := borland.data.provider.bdpcommand.Create
        (
        'select password_reset_email_address from service_user '
        + 'where id ="' + service_id_string + '"',
        AppCommon.BdpConnection
        );
      //   Set up the command to get the appropriate fiscal year designator.
      bc_get_fy_designator := borland.data.provider.bdpcommand.Create
        (
        'select designator'
        + ' from fiscal_year'
        +   ' join state_dictated_appropriation on (state_dictated_appropriation.fiscal_year_id=fiscal_year.id)'
        +   ' join region_dictated_appropriation'
        +     ' on (region_dictated_appropriation.state_dictated_appropriation_id=state_dictated_appropriation.id)'
        + ' where region_dictated_appropriation.id = ' + session.Item['region_dictated_appropriation_id'].tostring,
        appcommon.bdpconnection
        );
      //   Set up the command to get the County Coorindator's email address.
      bc_get_cc_email_address := borland.data.provider.bdpcommand.Create
        (
        'select password_reset_email_address from county_user where id ="' + session.item['county_user_id'].tostring + '"',
        AppCommon.BdpConnection
        );
      //   Send the email message.
      smtpmail.SmtpServer := ConfigurationSettings.AppSettings['smtp_server'];
      smtpmail.Send
        (
        bc_get_cc_email_address.ExecuteScalar.tostring,
        bc_get_service_email_address.ExecuteScalar.tostring,
        'New ' + ConfigurationSettings.AppSettings['application_name'] + ' appropriation for your service',
        'The ' + session.Item['county_name'].ToString + ' County EMSOF Coordinator has made a new EMSOF appropriation of '
        + amount.tostring('C') + ' to your service for ' + bc_get_fy_designator.ExecuteScalar.tostring + '.' + NEW_LINE
        + NEW_LINE
        + 'You can work on this appropriation by visiting:' + NEW_LINE
        + NEW_LINE
        + '   http://' + ConfigurationSettings.AppSettings['host_domain_name'] + '/'
        + server.UrlEncode(ConfigurationSettings.AppSettings['application_name']) + '/main.aspx' + NEW_LINE
        + NEW_LINE
        + 'Replies to this message will be addressed to the ' + session.Item['county_name'].ToString + ' County EMSOF Coordinator.'
        + NEW_LINE
        + NEW_LINE
        + '-- ' + ConfigurationSettings.AppSettings['application_name']
        );
      //
      appcommon.bdpconnection.Close;
    end;
  end;
end;

end.

