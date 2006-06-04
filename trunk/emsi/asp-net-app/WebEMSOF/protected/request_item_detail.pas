
unit request_item_detail;

interface

uses
  System.Collections, System.ComponentModel,
  System.Data, System.Drawing, System.Web, System.Web.SessionState,
  System.Web.UI, System.Web.UI.WebControls, System.Web.UI.HtmlControls, AppCommon, system.configuration, borland.data.provider,
  system.web.mail, system.web.security;

const ID = '$Id$';

type
  TWebForm_request_item_detail = class(System.Web.UI.Page)
  {$REGION 'Designer Managed Code'}
  strict private
    procedure InitializeComponent;
    procedure Button_cancel_Click(sender: System.Object; e: System.EventArgs);
    procedure DropDownList_equipment_category_SelectedIndexChanged(sender: System.Object;
      e: System.EventArgs);
    procedure Button_submit_and_repeat_Click(sender: System.Object; e: System.EventArgs);
    procedure Button_submit_and_stop_Click(sender: System.Object; e: System.EventArgs);
    procedure LinkButton_recalculate_1_Click(sender: System.Object; e: System.EventArgs);
    procedure LinkButton_recalculate_2_Click(sender: System.Object; e: System.EventArgs);
    procedure LinkButton_recalculate_3_Click(sender: System.Object; e: System.EventArgs);
    procedure Button_delete_Click(sender: System.Object; e: System.EventArgs);
    procedure Button_update_Click(sender: System.Object; e: System.EventArgs);
    procedure Button_withdraw_Click(sender: System.Object; e: System.EventArgs);
    procedure LinkButton_logout_Click(sender: System.Object; e: System.EventArgs);
  {$ENDREGION}
  strict private
    additional_service_ante: decimal;
    allowable_cost: decimal;
    bdri_equipment_category_allowable_cost: cardinal;
    bdri_equipment_category_funding_level: cardinal;
    cmdText_get_equipment_category_monetary_details: string;
    funding_level: decimal;
    match_level: decimal;
    saved_emsof_ante: decimal;
    procedure AddItem;
    procedure Page_Load(sender: System.Object; e: System.EventArgs);
    procedure Recalculate;
    procedure ShowDependentData;
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
    Label_emsof_ante: System.Web.UI.WebControls.Label;
    Label_allowable_cost: System.Web.UI.WebControls.Label;
    RequiredFieldValidator_equipment_category: System.Web.UI.WebControls.RequiredFieldValidator;
    RangeValidator_equipment_category: System.Web.UI.WebControls.RangeValidator;
    Button_submit_and_repeat: System.Web.UI.WebControls.Button;
    Button_submit_and_stop: System.Web.UI.WebControls.Button;
    TextBox_unit_cost: System.Web.UI.WebControls.TextBox;
    RegularExpressionValidator_additional_service_ante: System.Web.UI.WebControls.RegularExpressionValidator;
    LinkButton_recalculate_1: System.Web.UI.WebControls.LinkButton;
    LinkButton_recalculate_2: System.Web.UI.WebControls.LinkButton;
    LinkButton_recalculate_3: System.Web.UI.WebControls.LinkButton;
    CheckBox_delete: System.Web.UI.WebControls.CheckBox;
    Button_delete: System.Web.UI.WebControls.Button;
    TableRow_delete: System.Web.UI.HtmlControls.HtmlTableRow;
    Button_update: System.Web.UI.WebControls.Button;
    HyperLink_request_overview_1: System.Web.UI.WebControls.HyperLink;
    HyperLink_request_overview_2: System.Web.UI.WebControls.HyperLink;
    Button_withdraw: System.Web.UI.WebControls.LinkButton;
    TableRow_post_finalization_actions: System.Web.UI.HtmlControls.HtmlTableRow;
    LinkButton_logout: System.Web.UI.WebControls.LinkButton;
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
procedure TWebForm_request_item_detail.InitializeComponent;
begin
  Include(Self.LinkButton_logout.Click, Self.LinkButton_logout_Click);
  Include(Self.DropDownList_equipment_category.SelectedIndexChanged, Self.DropDownList_equipment_category_SelectedIndexChanged);
  Include(Self.LinkButton_recalculate_1.Click, Self.LinkButton_recalculate_1_Click);
  Include(Self.LinkButton_recalculate_2.Click, Self.LinkButton_recalculate_2_Click);
  Include(Self.LinkButton_recalculate_3.Click, Self.LinkButton_recalculate_3_Click);
  Include(Self.Button_submit_and_repeat.Click, Self.Button_submit_and_repeat_Click);
  Include(Self.Button_submit_and_stop.Click, Self.Button_submit_and_stop_Click);
  Include(Self.Button_update.Click, Self.Button_update_Click);
  Include(Self.Button_cancel.Click, Self.Button_cancel_Click);
  Include(Self.Button_delete.Click, Self.Button_delete_Click);
  Include(Self.Button_withdraw.Click, Self.Button_withdraw_Click);
  Include(Self.Load, Self.Page_Load);
end;
{$ENDREGION}

procedure TWebForm_request_item_detail.Page_Load(sender: System.Object; e: System.EventArgs);
var
  bdr_factors: borland.data.provider.BdpDataReader;
  bdr_services: borland.data.provider.BdpDataReader;
  bdr_user_details: borland.data.provider.BdpDataReader;
  be_before_deadline: boolean;
  be_finalized: boolean;
  be_locked: boolean;
  be_new: boolean;
  cmdText: string;
begin
  AppCommon.PopulatePlaceHolders(PlaceHolder_precontent,PlaceHolder_postcontent);
  if not IsPostback then begin
    Title.InnerText := server.HtmlEncode(ConfigurationSettings.AppSettings['application_name']) + ' - request_item_detail';
    //
    appcommon.DbOpen;
    //
    // Set Label_match_level.
    //
    match_level := decimal.Parse
      (
      borland.data.provider.bdpcommand.Create
        (
        'select factor'
        + ' from match_level join county_dictated_appropriation on (county_dictated_appropriation.match_level_id=match_level.id)'
        + ' where county_dictated_appropriation.id = ' + session['county_dictated_appropriation_id'].tostring,
        appcommon.db
        )
        .ExecuteScalar.tostring
      );
    //
    // Build cmdText_get_equipment_category_monetary_details
    //
    cmdText_get_equipment_category_monetary_details := 'select life_expectancy_years,'
    + ' allowable_cost,';
    if match_level = 0.60 then begin
      cmdText_get_equipment_category_monetary_details := cmdText_get_equipment_category_monetary_details
      + 'funding_level_rural as funding_level';
    end else if match_level = 1.00 then begin
      cmdText_get_equipment_category_monetary_details := cmdText_get_equipment_category_monetary_details
      + 'allowable_cost as funding_level';
    end else begin
      cmdText_get_equipment_category_monetary_details := cmdText_get_equipment_category_monetary_details
      + 'funding_level_nonrural as funding_level';
    end;
    cmdText_get_equipment_category_monetary_details := cmdText_get_equipment_category_monetary_details
    + ' from eligible_provider_equipment_list'
    + ' where code = ';
    //    Mind these indices if the query changes.
    bdri_equipment_category_allowable_cost := 1;
    bdri_equipment_category_funding_level := 2;
    //
    be_before_deadline := session['be_before_service_to_county_submission_deadline'].tostring = 'True'; // Case matters.
    be_finalized := session['be_finalized'].tostring = 'True'; // Case matters.
    be_locked := (not be_before_deadline) or be_finalized;
    be_new := session['emsof_request_item_priority'].tostring = system.string.EMPTY;
    //
    // Manage whether or not the instruction ("-- Select --") appears at the top of DropDownList_equipment_category.
    //
    if be_new then begin
      DropDownList_equipment_category.Items.Add(listitem.Create('-- Select (then wait for form to refresh) --','0'));
    end;
    //
    // Manage the loading of nominal elements into DropDownList_equipment_category.
    //
    if be_new or (not be_locked) then begin
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
        + ' WHERE id = ' + session['service_user_id'].tostring,
        appcommon.db
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
      bdr_services := Borland.Data.Provider.BdpCommand.Create(cmdText,appcommon.db).ExecuteReader;
      while bdr_services.Read do begin
        DropDownList_equipment_category.Items.Add(listitem.Create(bdr_services['description'].tostring,bdr_services['code'].ToString));
      end;
    end else begin
      DropDownList_equipment_category.Items.Add
        (
        listitem.Create
          (
          session['emsof_request_item_equipment_category'].tostring,
          session['emsof_request_item_code'].tostring
          )
        );
      //
    end;
    //
    // Manage the initially selected value in DropDownList_equipment_category and the availability of the submit/update/delete
    // options.
    //
    if not (be_new or be_locked) then begin
      DropDownList_equipment_category.selectedvalue := session['emsof_request_item_code'].tostring;
      Button_submit_and_repeat.visible := FALSE;
      Button_submit_and_stop.visible := FALSE;
      Button_update.visible := TRUE;
    end else begin
      TableRow_delete.visible := FALSE;
    end;
    //
    // Manage the filling of the other data elements.
    //
    if be_new then begin
      Label_match_level.text := match_level.tostring('P0');
    end else begin
      //
      appcommon.DbClose;
      ShowDependentData;
      appcommon.DbOpen;
      //
      bdr_user_details := borland.data.provider.bdpcommand.Create
        (
        'select make_model,place_kept,be_refurbished,unit_cost,quantity,additional_service_ante,emsof_ante'
        + ' from emsof_request_detail'
        + ' where master_id = ' + session['emsof_request_master_id'].tostring
        +   ' and priority = ' + session['emsof_request_item_priority'].tostring,
        appcommon.db
        )
        .ExecuteReader;
      bdr_user_details.Read;
      TextBox_make_model.text := bdr_user_details['make_model'].tostring;
      TextBox_place_kept.text := bdr_user_details['place_kept'].tostring;
      if bdr_user_details['be_refurbished'].tostring = '0' then begin
         RadioButtonList_condition.selectedindex := 0;
      end else begin
         RadioButtonList_condition.selectedindex := 1;
      end;
      TextBox_unit_cost.text := decimal.Parse(bdr_user_details['unit_cost'].tostring).tostring('N2');
      TextBox_quantity.text := bdr_user_details['quantity'].tostring;
      TextBox_additional_service_ante.text := decimal.Parse(bdr_user_details['additional_service_ante'].tostring).tostring('N2');
      saved_emsof_ante := decimal.Parse(bdr_user_details['emsof_ante'].tostring);
      Label_emsof_ante.text := saved_emsof_ante.tostring('N2');
      //
      Recalculate;
      //
    end;
    //
    // Manage the availability of the remaining item-detail-related controls.
    //
    if be_locked then begin
      //
      DropDownList_equipment_category.enabled := FALSE;
      RequiredFieldValidator_equipment_category.enabled := FALSE;
      RangeValidator_equipment_category.enabled := FALSE;
      TextBox_make_model.enabled := FALSE;
      RequiredFieldValidator_make_model.enabled := FALSE;
      RegularExpressionValidator_make_model.enabled := FALSE;
      TextBox_place_kept.enabled := FALSE;
      RequiredFieldValidator_place_kept.enabled := FALSE;
      RegularExpressionValidator_place_kept.enabled := FALSE;
      RadioButtonList_condition.enabled := FALSE;
      RequiredFieldValidator_condition.enabled := FALSE;
      TextBox_unit_cost.enabled := FALSE;
      RequiredFieldValidator_unit_cost.enabled := FALSE;
      RegularExpressionValidator_unit_cost.enabled := FALSE;
      TextBox_quantity.enabled := FALSE;
      RequiredFieldValidator_quantity.enabled := FALSE;
      RegularExpressionValidator_quantity.enabled := FALSE;
      TextBox_additional_service_ante.enabled := FALSE;
      RegularExpressionValidator_additional_service_ante.enabled := FALSE;
      LinkButton_recalculate_1.visible := FALSE;
      LinkButton_recalculate_2.visible := FALSE;
      LinkButton_recalculate_3.visible := FALSE;
      Button_submit_and_repeat.visible := FALSE;
      Button_submit_and_stop.visible := FALSE;
      Button_update.visible := FALSE;
      Button_cancel.visible := FALSE;
      TableRow_post_finalization_actions.visible := TRUE;
      //
    end else begin
      TableRow_post_finalization_actions.visible := FALSE;
    end;
    //
    appcommon.DbClose;
    //
  end;
end;

procedure TWebForm_request_item_detail.OnInit(e: EventArgs);
begin
  //
  // Required for Designer support
  //
  InitializeComponent;
  inherited OnInit(e);
end;

procedure TWebForm_request_item_detail.LinkButton_logout_Click(sender: System.Object;
  e: System.EventArgs);
begin
  formsauthentication.SignOut;
  session.Clear;
  server.Transfer('../Default.aspx');
end;

procedure TWebForm_request_item_detail.Button_withdraw_Click(sender: System.Object;
  e: System.EventArgs);
begin
  session.Remove('emsof_request_item_make_model');
  session.Add('emsof_request_item_make_model',Safe(TextBox_make_model.text,MAKE_MODEL));
  session.Remove('emsof_request_item_emsof_ante');
  session.Add('emsof_request_item_emsof_ante',Safe(Label_emsof_ante.text,REAL_NUM));
  server.Transfer('withdraw_request_item.aspx');
end;

procedure TWebForm_request_item_detail.Button_update_Click(sender: System.Object;
  e: System.EventArgs);
begin
  //
  Recalculate;  // Forces setting of additional_service_ante
  //
  appcommon.DbOpen;
  //
  // Update the detail record.
  // Update the master record.
  //
  borland.data.provider.bdpcommand.Create
    (
    'START TRANSACTION'
    + ';'
    + 'update emsof_request_detail'
    + ' set equipment_code = ' + Safe(DropDownList_equipment_category.selectedvalue,NUM) + ','
    +   ' make_model = "' + Safe(TextBox_make_model.text,MAKE_MODEL) + '",'
    +   ' place_kept = "' + Safe(TextBox_place_kept.text,NARRATIVE) + '",'
    +   ' be_refurbished = ' + Safe(RadioButtonList_condition.selectedvalue,NUM) + ','
    +   ' quantity = ' + Safe(TextBox_quantity.text,NUM) + ','
    +   ' unit_cost = ' + Safe(TextBox_unit_cost.text,REAL_NUM) + ','
    +   ' additional_service_ante = ' + additional_service_ante.tostring + ','
    +   ' emsof_ante = ' + Safe(Label_emsof_ante.text,REAL_NUM)
    + ' where master_id = ' + session['emsof_request_master_id'].tostring
    +   ' and priority = ' + session['emsof_request_item_priority'].tostring
    + ';'
    + 'update emsof_request_master'
    + ' set value = value - ' + saved_emsof_ante.tostring + ' + ' + Safe(Label_emsof_ante.text,REAL_NUM)
    + ' where id = ' + session['emsof_request_master_id'].tostring
    + ';'
    + 'COMMIT;',
    appcommon.db
    )
    .ExecuteNonQuery;
  //
  appcommon.DbClose;
  server.Transfer('request_overview.aspx');
end;

procedure TWebForm_request_item_detail.Button_delete_Click(sender: System.Object;
  e: System.EventArgs);
begin
  if CheckBox_delete.checked then begin
    appcommon.DbOpen;
    //
    // Delete the detail record.
    // Eliminate the resulting gap in the priority sequence.
    // Update the master record.
    //
    borland.data.provider.bdpcommand.Create
      (
      'START TRANSACTION'
      + ';'
      + 'delete from emsof_request_detail'
      + ' where master_id = ' + session['emsof_request_master_id'].tostring
      +   ' and priority = ' + session['emsof_request_item_priority'].tostring
      + ';'
      + 'update emsof_request_detail set priority = priority - 1'
      + ' where master_id = ' + session['emsof_request_master_id'].tostring
      +   ' and priority > ' + session['emsof_request_item_priority'].tostring
      + ';'
      + 'update emsof_request_master'
      + ' set value = value - ' + saved_emsof_ante.tostring + ','
      +   ' num_items = num_items - 1'
      + ' where id = ' + session['emsof_request_master_id'].tostring
      + ';'
      + 'COMMIT;',
      appcommon.db
      )
      .ExecuteNonQuery;
    appcommon.DbClose;
    server.Transfer('request_overview.aspx');
  end;
end;

procedure TWebForm_request_item_detail.LinkButton_recalculate_3_Click(sender: System.Object;
  e: System.EventArgs);
begin
  Recalculate;
end;

procedure TWebForm_request_item_detail.LinkButton_recalculate_2_Click(sender: System.Object;
  e: System.EventArgs);
begin
  Recalculate;
end;

procedure TWebForm_request_item_detail.LinkButton_recalculate_1_Click(sender: System.Object;
  e: System.EventArgs);
begin
  Recalculate;
end;

procedure TWebForm_request_item_detail.Button_submit_and_stop_Click(sender: System.Object;
  e: System.EventArgs);
begin
  AddItem;
  server.Transfer('request_overview.aspx');
end;

procedure TWebForm_request_item_detail.Button_submit_and_repeat_Click(sender: System.Object;
  e: System.EventArgs);
begin
  AddItem;
  DropDownList_equipment_category.SelectedIndex := -1;
  Label_life_expectancy.text := '';
  TextBox_make_model.text := '';
  TextBox_place_kept.text := '';
  RadioButtonList_condition.selectedindex := -1;
  Label_allowable_cost.text := '';
  TextBox_unit_cost.text := '';
  TextBox_quantity.text := '';
  Label_total_cost.text := '';
  Label_match_level.text := match_level.tostring('P0');
  Label_min_service_ante.text := '';
  TextBox_additional_service_ante.text := '';
  Label_emsof_ante.text := '';
end;

procedure TWebForm_request_item_detail.DropDownList_equipment_category_SelectedIndexChanged(sender: System.Object;
  e: System.EventArgs);
begin
  ShowDependentData;
end;

procedure TWebForm_request_item_detail.Button_cancel_Click(sender: System.Object;
  e: System.EventArgs);
begin
  server.Transfer('request_overview.aspx');
end;

procedure TWebForm_request_item_detail.Recalculate;
var
  effective_emsof_ante: decimal;
  max_emsof_ante: decimal;
  quantity: decimal;
  total_cost: decimal;
  unit_cost: decimal;
begin
  if (TextBox_unit_cost.text <> system.string.EMPTY) and (TextBox_quantity.text <> system.string.EMPTY) then begin
    //
    unit_cost := decimal.Parse(TextBox_unit_cost.text);
    quantity := decimal.Parse(TextBox_quantity.text);
    if TextBox_additional_service_ante.text <> system.string.EMPTY then begin
      additional_service_ante := decimal.Parse(TextBox_additional_service_ante.text);
    end else begin
      additional_service_ante := 0;
    end;
    //
    total_cost := unit_cost*quantity;
    Label_total_cost.text := total_cost.tostring('N2');
    //
    if ((match_level = 1.00) and (allowable_cost = decimal.maxvalue))
        //
        // This is the zebra case where a distressed service wants an item with no specified allowable cost (initially an ambulance
        // or squad/response vehicle).  Basically, they can have whatever they want, up to the limit of the remainder of their
        // appropriation.  Consideration of their appropriation is not within the scope of this form, so we can indicate that the
        // request can be fully funded.
        //
      or ((unit_cost <= allowable_cost) and (funding_level = allowable_cost))
        //
        // This is the case where items in an "equipment category" are always fully funded (up to the limit of a service's
        // appropriation, which is not within the scope of this form).  This initially describes only Data Collection Software.
        //
    then begin
      //
      max_emsof_ante := total_cost;
      //
    end else begin
      //
      if unit_cost > allowable_cost then begin
        max_emsof_ante := math.Max(allowable_cost*match_level,funding_level)*quantity;
      end else begin
        max_emsof_ante := total_cost*match_level;
      end;
      //
    end;
    //
    // A service may elect not to use the max_emsof_ante.  An example would be when they know that doing so, in the context of all
    // their other request items, would draw more EMSOF funds than they were appropriated.  So account for if they want to ante up
    // more of the cost themselves.
    //
    effective_emsof_ante := max_emsof_ante - additional_service_ante;
    //
    Label_match_level.text := (effective_emsof_ante/total_cost).tostring('P0');
    Label_emsof_ante.text := effective_emsof_ante.tostring('N2');
    Label_min_service_ante.text := (total_cost - max_emsof_ante).tostring('N2');
  end;
end;

procedure TWebForm_request_item_detail.AddItem;
var
  priority_string: string;
begin
  //
  Recalculate;  // Forces setting of additional_service_ante
  //
  appcommon.DbOpen;
  //
  //
  // Get the number of items entered against this request previously, and initialize this item to have a priority just lower than
  // all previous items.
  //
  priority_string := borland.data.provider.bdpcommand.Create
    (
    'select (num_items + 1) from emsof_request_master where id = ' + session['emsof_request_master_id'].tostring,
    appcommon.db
    )
    .ExecuteScalar.tostring;
  //
  // Record the new request item.
  // Update the master record.
  //
  borland.data.provider.bdpcommand.Create
    (
    'START TRANSACTION'
    + ';'
    + 'insert into emsof_request_detail'
    + ' set master_id = ' + session['emsof_request_master_id'].tostring + ','
    +   ' equipment_code = ' + Safe(DropDownList_equipment_category.selectedvalue,NUM) + ','
    +   ' make_model = "' + Safe(TextBox_make_model.text,MAKE_MODEL) + '",'
    +   ' place_kept = "' + Safe(TextBox_place_kept.text,NARRATIVE) + '",'
    +   ' be_refurbished = ' + Safe(RadioButtonList_condition.selectedvalue,NUM) + ','
    +   ' quantity = ' + Safe(TextBox_quantity.text,NUM) + ','
    +   ' unit_cost = ' + Safe(TextBox_unit_cost.text,REAL_NUM) + ','
    +   ' additional_service_ante = ' + additional_service_ante.tostring + ','
    +   ' emsof_ante = ' + Safe(Label_emsof_ante.text,REAL_NUM) + ','
    +   ' priority = ' + priority_string
    + ';'
    + 'update emsof_request_master'
    + ' set status_code = 2,'
    +   ' value = value + ' + Safe(Label_emsof_ante.text,REAL_NUM) + ','
    +   ' num_items = num_items + 1'
    + ' where id = ' + session['emsof_request_master_id'].tostring
    + ';'
    + 'COMMIT;',
    appcommon.db
    )
    .ExecuteNonQuery;
  //
  appcommon.DbClose;
end;

procedure TWebForm_request_item_detail.ShowDependentData;
var
  bdr_state_details: borland.data.provider.bdpdatareader;
  life_expectancy_string: string;
begin
  appcommon.DbOpen;
  bdr_state_details := borland.data.provider.bdpcommand.Create
    (
    cmdText_get_equipment_category_monetary_details + Safe(DropDownList_equipment_category.SelectedValue,NUM),
    appcommon.db
    )
    .ExecuteReader;
  if bdr_state_details.Read then begin
    //
    life_expectancy_string := bdr_state_details['life_expectancy_years'].tostring;
    //
    if life_expectancy_string <> system.string.EMPTY then begin
      Label_life_expectancy.text := 'PA DOH EMSO expects this equipment to last ' + life_expectancy_string + ' years.';
      Label_life_expectancy.font.bold := TRUE;
    end else begin
      Label_life_expectancy.text := 'PA DOH EMSO has not specified a life expectancy for this category of equipment.';
      Label_life_expectancy.font.bold := FALSE;
    end;
    //
    if not bdr_state_details.IsDbNull(bdri_equipment_category_allowable_cost) then begin
      Label_allowable_cost.text := decimal.Parse(bdr_state_details['allowable_cost'].tostring).tostring('N2');
      allowable_cost := decimal.Parse(Label_allowable_cost.text);
    end else begin
      Label_allowable_cost.text := '(none specified)';
      allowable_cost := decimal.maxvalue;
    end;
    //
    if not bdr_state_details.IsDbNull(bdri_equipment_category_funding_level) then begin
      funding_level := decimal.Parse(bdr_state_details['funding_level'].tostring);
    end else begin
      funding_level := decimal.maxvalue;
    end;
    //
    if funding_level = allowable_cost then begin
      Label_match_level.text := '100%';
    end else begin
      Label_match_level.text := match_level.tostring('P0');
    end;
    //
  end;
  appcommon.DbClose;
  //
  Recalculate;
end;

end.

