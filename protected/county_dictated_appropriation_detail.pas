
unit county_dictated_appropriation_detail;

interface

uses
  System.Collections, System.ComponentModel,
  System.Data, System.Drawing, System.Web, System.Web.SessionState,
  System.Web.UI, System.Web.UI.WebControls, System.Web.UI.HtmlControls, AppCommon, system.configuration, system.web.security,
  borland.data.provider, system.web.mail, borland.vcl.sysutils;

type
  TWebForm_county_dictated_appropriation_detail = class(System.Web.UI.Page)
  {$REGION 'Designer Managed Code'}
  strict private
    procedure InitializeComponent;
    procedure LinkButton_logout_Click(sender: System.Object; e: System.EventArgs);
    procedure DataGrid_items_ItemDataBound(sender: System.Object; e: System.Web.UI.WebControls.DataGridItemEventArgs);
    procedure Button_approve_Click(sender: System.Object; e: System.EventArgs);
    procedure Button_disapprove_Click(sender: System.Object; e: System.EventArgs);
  {$ENDREGION}
  strict private
    procedure Page_Load(sender: System.Object; e: System.EventArgs);
  strict protected
    Title: System.Web.UI.HtmlControls.HtmlGenericControl;
    PlaceHolder_precontent: System.Web.UI.WebControls.PlaceHolder;
    PlaceHolder_postcontent: System.Web.UI.WebControls.PlaceHolder;
    LinkButton_logout: System.Web.UI.WebControls.LinkButton;
    HyperLink_change_password: System.Web.UI.WebControls.HyperLink;
    HyperLink_change_email_address: System.Web.UI.WebControls.HyperLink;
    Label_account_descriptor: System.Web.UI.WebControls.Label;
    HyperLink_back: System.Web.UI.WebControls.HyperLink;
    Label_parent_appropriation_amount: System.Web.UI.WebControls.Label;
    Label_sponsor_county: System.Web.UI.WebControls.Label;
    Label_fiscal_year_designator: System.Web.UI.WebControls.Label;
    Label_sum_of_emsof_antes: System.Web.UI.WebControls.Label;
    Label_unused_amount: System.Web.UI.WebControls.Label;
    DataGrid_items: System.Web.UI.WebControls.DataGrid;
    Label_service_name: System.Web.UI.WebControls.Label;
    Label_affiliate_num: System.Web.UI.WebControls.Label;
    TableRow_sum_of_emsof_antes: System.Web.UI.HtmlControls.HtmlTableRow;
    TableRow_unrequested_amount: System.Web.UI.HtmlControls.HtmlTableRow;
    Label_num_items: System.Web.UI.WebControls.Label;
    HyperLink_back_2: System.Web.UI.WebControls.HyperLink;
    CheckBox_approve: System.Web.UI.WebControls.CheckBox;
    Button_approve: System.Web.UI.WebControls.Button;
    Button_disapprove: System.Web.UI.WebControls.Button;
    Table_disposition: System.Web.UI.HtmlControls.HtmlTable;
    TableRow_return: System.Web.UI.HtmlControls.HtmlTableRow;
    TableRow_reject: System.Web.UI.HtmlControls.HtmlTableRow;
    Table_action_required: System.Web.UI.HtmlControls.HtmlTable;
    TextArea_disapproval_reason: System.Web.UI.HtmlControls.HtmlTextArea;
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
procedure TWebForm_county_dictated_appropriation_detail.InitializeComponent;
begin
  Include(Self.LinkButton_logout.Click, Self.LinkButton_logout_Click);
  Include(Self.DataGrid_items.ItemDataBound, Self.DataGrid_items_ItemDataBound);
  Include(Self.Button_approve.Click, Self.Button_approve_Click);
  Include(Self.Button_disapprove.Click, Self.Button_disapprove_Click);
  Include(Self.Load, Self.Page_Load);
end;
{$ENDREGION}

const ID = '$Id$';

var
  be_before_improvement_deadline: boolean;
  num_items: cardinal;
  parent_appropriation_amount: decimal;
  total_emsof_ante: decimal;

procedure TWebForm_county_dictated_appropriation_detail.Page_Load(sender: System.Object; e: System.EventArgs);
begin
  AppCommon.PopulatePlaceHolders(PlaceHolder_precontent,PlaceHolder_postcontent);
  if not IsPostback then begin
    //
    Title.InnerText := server.HtmlEncode(ConfigurationSettings.AppSettings['application_name']) + ' - county_dictated_appropriation_detail';
    Label_account_descriptor.text := session.item['county_name'].tostring + ' County';
    //
    // Initialize implementation-wide vars.
    //
    num_items := 0;
    total_emsof_ante := 0;
    //
    Label_fiscal_year_designator.text := session.item['fiscal_year_designator'].tostring;
    Label_service_name.text := session.item['service_name'].tostring;
    Label_affiliate_num.text := session.item['affiliate_num'].tostring;
    parent_appropriation_amount := decimal.Parse(session.item['appropriation_amount'].tostring);
    Label_parent_appropriation_amount.text := parent_appropriation_amount.tostring('C');
    Label_sponsor_county.text := session.item['county_name'].tostring;
    //
    appcommon.DbOpen;
    //
    DataGrid_items.DataSource := borland.data.provider.bdpcommand.Create
      (
      'select priority,'
      + ' make_model,'
      + ' if(be_refurbished,"(refurbished)","") as be_refurbished,'
      + ' description as category,'
      + ' place_kept,'
      + ' quantity,'
      + ' unit_cost,'
      + ' (quantity*unit_cost) as subtotal,'
      + ' allowable_cost,'
      + ' emsof_ante,'
      + ' (emsof_ante/(quantity*unit_cost)) as effective_match_level'
      + ' from emsof_request_detail'
      +   ' join eligible_provider_equipment_list'
      +     ' on (eligible_provider_equipment_list.code=emsof_request_detail.equipment_code)'
      +   ' join emsof_request_master on (emsof_request_master.id=emsof_request_detail.master_id)'
      + ' where county_dictated_appropriation_id = ' + session.item['county_dictated_appropriation_id'].tostring
      +   ' and emsof_request_detail.status_code <> 6'
      + ' order by priority',
      appcommon.db
      )
      .ExecuteReader;
    DataGrid_items.DataBind;
    //
    Label_sum_of_emsof_antes.text := total_emsof_ante.tostring('C');
    Label_unused_amount.text := (parent_appropriation_amount - total_emsof_ante).tostring('C');
    Label_num_items.text := num_items.tostring;
    //
    if session.item['emsof_request_master_status_code'].tostring = '3' then begin
      be_before_improvement_deadline := datetime.Now <= datetime(session.item['county_dictated_deadline']);
      if be_before_improvement_deadline then begin
        TableRow_reject.visible := FALSE;
        Button_disapprove.text := 'Return';
      end else begin
        TableRow_return.visible := FALSE;
        Button_disapprove.text := 'REJECT';
      end;
    end else begin
      Table_action_required.visible := FALSE;
      Table_disposition.visible := FALSE;
    end;
    //
    appcommon.DbClose;
    //
  end;
end;

procedure TWebForm_county_dictated_appropriation_detail.OnInit(e: EventArgs);
begin
  //
  // Required for Designer support
  //
  InitializeComponent;
  inherited OnInit(e);
end;

procedure TWebForm_county_dictated_appropriation_detail.Button_disapprove_Click(sender: System.Object;
  e: System.EventArgs);
var
  BreakChars: array[1..3] of char;
  cc_email_address: string;
  region_email_address: string;
  service_email_address: string;
begin
  if TextArea_disapproval_reason.Value <> system.string.EMPTY then begin
    appcommon.DbOpen;
    //
    //   Get the County Coorindator's email address.
    //
    cc_email_address := borland.data.provider.bdpcommand.Create
      (
      'select password_reset_email_address'
      + ' from county_dictated_appropriation'
      +   ' join region_dictated_appropriation'
      +     ' on (region_dictated_appropriation.id=county_dictated_appropriation.region_dictated_appropriation_id)'
      +   ' join county_user on (county_user.id=region_dictated_appropriation.county_code)'
      + ' where county_dictated_appropriation.id = ' + session.item['county_dictated_appropriation_id'].tostring,
      appcommon.db
      )
      .ExecuteScalar.tostring;
    //
    //   Get service's email address of record.
    //
    service_email_address := borland.data.provider.bdpcommand.Create
      (
      'select password_reset_email_address from service_user join service using (id)'
      + ' where affiliate_num ="' + session.item['affiliate_num'].tostring + '"',
      appcommon.db
      )
      .ExecuteScalar.tostring;
    //
    BreakChars[1] := appcommon.SPACE;
    BreakChars[2] := appcommon.TAB;
    BreakChars[3] := '-';
    //
    if be_before_improvement_deadline then begin
      borland.data.provider.bdpcommand.Create
        (
        'update emsof_request_master'
        + ' join county_dictated_appropriation'
        +   ' on (county_dictated_appropriation.id=emsof_request_master.county_dictated_appropriation_id)'
        + ' set emsof_request_master.status_code = 2'
        + ' where county_dictated_appropriation.id = ' + session.item['county_dictated_appropriation_id'].tostring,
        appcommon.db
        )
        .ExecuteNonQuery;
      //
      //   Send notification to service.
      //
      smtpmail.Send
        (
        cc_email_address,
        service_email_address,
        'Return of EMSOF request for improvement',
        'The ' + session.Item['county_name'].ToString + ' County EMSOF Coordinator did NOT approve '
        + session.item['service_name'].tostring + '''s ' + session.item['fiscal_year_designator'].tostring + ' EMSOF request.  '
        + 'Instead, the request has been returned to you for improvement.' + NEW_LINE
        + NEW_LINE
        + 'The ' + session.Item['county_name'].ToString + ' County EMSOF Coordinator gave this reason for this action:' + NEW_LINE
        + NEW_LINE
        + '   '
        + WrapText
          (
          TextArea_disapproval_reason.value,
          (NEW_LINE + '   '),
          BreakChars,
          int16.Parse(configurationsettings.AppSettings['email_blockquote_maxcol'])
          )
        + NEW_LINE
        + NEW_LINE
        + 'You can work on this EMSOF request by visiting:' + NEW_LINE
        + NEW_LINE
        + '   http://' + ConfigurationSettings.AppSettings['ssl_base_path'] + '/'
        + server.UrlEncode(ConfigurationSettings.AppSettings['application_name']) + '/protected/service_overview.aspx' + NEW_LINE
        + NEW_LINE
        + 'Replies to this message will be addressed to the ' + session.Item['county_name'].ToString + ' County EMSOF Coordinator.'
        + NEW_LINE
        + NEW_LINE
        + '-- ' + ConfigurationSettings.AppSettings['application_name']
        );
    end else begin
      borland.data.provider.bdpcommand.Create
        (
        'update emsof_request_master'
        + ' join county_dictated_appropriation'
        +   ' on (county_dictated_appropriation.id=emsof_request_master.county_dictated_appropriation_id)'
        + ' set emsof_request_master.status_code = 11'
        + ' where county_dictated_appropriation.id = ' + session.item['county_dictated_appropriation_id'].tostring,
        appcommon.db
        )
        .ExecuteNonQuery;
      //
      //   Get the Regional Council EMSOF Coordinator's email address.
      //
      region_email_address := borland.data.provider.bdpcommand.Create
        (
        'select password_reset_email_address'
        + ' from regional_staffer_user'
        +   ' join regional_staffer_role on (regional_staffer_role.regional_staffer_id=regional_staffer_user.id)'
        + ' where regional_staffer_role.title = "primary-emsof-coordinator"',
        appcommon.db
        )
        .ExecuteScalar.tostring;
      //
      //   Send notifications to service and region.
      //
      smtpmail.SmtpServer := ConfigurationSettings.AppSettings['smtp_server'];
      //
      smtpmail.Send
        (
        cc_email_address,
        service_email_address,
        'REJECTION of EMSOF request',
        'The ' + session.Item['county_name'].ToString + ' County EMSOF Coordinator has REJECTED '
        + session.item['service_name'].tostring + '''s ' + session.item['fiscal_year_designator'].tostring + ' EMSOF request.  '
        + NEW_LINE
        + NEW_LINE
        + 'The ' + session.Item['county_name'].ToString + ' County EMSOF Coordinator gave this reason for this action:' + NEW_LINE
        + NEW_LINE
        + '   '
        + WrapText
          (
          TextArea_disapproval_reason.value,
          (NEW_LINE + '   '),
          BreakChars,
          int16.Parse(configurationsettings.AppSettings['email_blockquote_maxcol'])
          )
        + NEW_LINE
        + NEW_LINE
        + 'You can review your EMSOF requests by visiting:' + NEW_LINE
        + NEW_LINE
        + '   http://' + ConfigurationSettings.AppSettings['ssl_base_path'] + '/'
        + server.UrlEncode(ConfigurationSettings.AppSettings['application_name']) + '/protected/service_overview.aspx' + NEW_LINE
        + NEW_LINE
        + 'Replies to this message will be addressed to the ' + session.Item['county_name'].ToString + ' County EMSOF Coordinator.'
        + NEW_LINE
        + NEW_LINE
        + '-- ' + ConfigurationSettings.AppSettings['application_name']
        );
      smtpmail.Send
        (
        cc_email_address,
        region_email_address,
        'REJECTION of EMSOF request',
        'The ' + session.Item['county_name'].ToString + ' County EMSOF Coordinator has REJECTED '
        + session.item['service_name'].tostring + '''s ' + session.item['fiscal_year_designator'].tostring + ' EMSOF request.  '
        + NEW_LINE
        + NEW_LINE
        + 'The ' + session.Item['county_name'].ToString + ' County EMSOF Coordinator gave this reason for this action:' + NEW_LINE
        + NEW_LINE
        + '   '
        + WrapText
          (
          TextArea_disapproval_reason.value,
          (NEW_LINE + '   '),
          BreakChars,
          int16.Parse(configurationsettings.AppSettings['email_blockquote_maxcol'])
          )
        + NEW_LINE
        + NEW_LINE
        + 'This action effectively returns ' + Label_sum_of_emsof_antes.text + ' of EMSOF funds to the regional council.' + NEW_LINE
        + NEW_LINE
        + 'You can review this EMSOF requests by visiting:' + NEW_LINE
        + NEW_LINE
        + '   http://' + ConfigurationSettings.AppSettings['ssl_base_path'] + '/'
        + server.UrlEncode(ConfigurationSettings.AppSettings['application_name']) + '/protected/regional_staffer_overview.aspx'
        + NEW_LINE
        + NEW_LINE
        + 'Replies to this message will be addressed to the ' + session.Item['county_name'].ToString + ' County EMSOF Coordinator.'
        + NEW_LINE
        + NEW_LINE
        + '-- ' + ConfigurationSettings.AppSettings['application_name']
        );
    end;
    appcommon.DbClose;
    server.Transfer('county_dictated_appropriations.aspx');
  end;
end;

procedure TWebForm_county_dictated_appropriation_detail.Button_approve_Click(sender: System.Object;
  e: System.EventArgs);
var
  cc_email_address: string;
  new_status_description: string;
  region_email_address: string;
  service_email_address: string;
begin
  if CheckBox_approve.checked then begin
    appcommon.DbOpen;
    borland.data.provider.bdpcommand.Create
      (
      'START TRANSACTION;'
      + ' update emsof_request_master'
      + ' join county_dictated_appropriation'
      +     ' on (county_dictated_appropriation.id=emsof_request_master.county_dictated_appropriation_id)'
      + ' set emsof_request_master.status_code = 4,'
      +   ' county_approval_timestamp = now()'
      + ' where county_dictated_appropriation.id = ' + session.item['county_dictated_appropriation_id'].tostring
      + ';'
      + ' update emsof_request_detail'
      + ' join emsof_request_master on (emsof_request_master.id=emsof_request_detail.master_id)'
      + ' join county_dictated_appropriation on (county_dictated_appropriation.id=emsof_request_detail.master_id)'
      + ' set emsof_request_detail.status_code = 2'
      + ' where county_dictated_appropriation.id = ' + session.item['county_dictated_appropriation_id'].tostring
      + ';'
      + 'COMMIT',
      appcommon.db
      )
      .ExecuteNonQuery;
    //
    // Send notification messages.
    //
    smtpmail.SmtpServer := ConfigurationSettings.AppSettings['smtp_server'];
    //
    //   Get the County Coorindator's email address.
    //
    cc_email_address := borland.data.provider.bdpcommand.Create
      (
      'select password_reset_email_address'
      + ' from county_dictated_appropriation'
      +   ' join region_dictated_appropriation'
      +     ' on (region_dictated_appropriation.id=county_dictated_appropriation.region_dictated_appropriation_id)'
      +   ' join county_user on (county_user.id=region_dictated_appropriation.county_code)'
      + ' where county_dictated_appropriation.id = ' + session.item['county_dictated_appropriation_id'].tostring,
      appcommon.db
      )
      .ExecuteScalar.tostring;
    //
    //   Get the Regional Council EMSOF Coordinator's email address.
    //
    region_email_address := borland.data.provider.bdpcommand.Create
      (
      'select password_reset_email_address'
      + ' from regional_staffer_user'
      +   ' join regional_staffer_role on (regional_staffer_role.regional_staffer_id=regional_staffer_user.id)'
      + ' where regional_staffer_role.title = "primary-emsof-coordinator"',
      appcommon.db
      )
      .ExecuteScalar.tostring;
    //
    //   Get new status description.
    //
    new_status_description := borland.data.provider.bdpcommand.Create
      ('select description from request_status_code_description_map where code = 4',appcommon.db).ExecuteScalar.tostring;
    //
    //   Get service's email address of record.
    //
    service_email_address := borland.data.provider.bdpcommand.Create
      (
      'select password_reset_email_address from service_user join service using (id)'
      + ' where affiliate_num ="' + session.item['affiliate_num'].tostring + '"',
      appcommon.db
      )
      .ExecuteScalar.tostring;
    //
    //   Send notification to service.
    //
    smtpmail.Send
      (
      cc_email_address,
      service_email_address,
      'Approval of EMSOF request',
      'The ' + session.Item['county_name'].ToString + ' County EMSOF Coordinator has approved '
      + session.item['service_name'].tostring + '''s ' + session.item['fiscal_year_designator'].tostring + ' EMSOF request.'
      + NEW_LINE
      + NEW_LINE
      + 'The status of this EMSOF request is now "' + new_status_description + '".  The Regional Council EMSOF Coordinator''s '
      + 'email address is ' + region_email_address + '.' + NEW_LINE
      + NEW_LINE
      + 'You can review your EMSOF requests by visiting:' + NEW_LINE
      + NEW_LINE
      + '   http://' + ConfigurationSettings.AppSettings['ssl_base_path'] + '/'
      + server.UrlEncode(ConfigurationSettings.AppSettings['application_name']) + '/protected/service_overview.aspx' + NEW_LINE
      + NEW_LINE
      + 'Replies to this message will be addressed to the ' + session.Item['county_name'].ToString + ' County EMSOF Coordinator.'
      + NEW_LINE
      + NEW_LINE
      + '-- ' + ConfigurationSettings.AppSettings['application_name']
      );
    //
    //   Send notification to region.
    //
    smtpmail.Send
      (
      cc_email_address,
      region_email_address,
      'County approval of EMSOF request',
      'The ' + session.Item['county_name'].ToString + ' County EMSOF Coordinator has approved '
      + session.item['service_name'].tostring + '''s ' + session.item['fiscal_year_designator'].tostring + ' EMSOF request.'
      + NEW_LINE
      + NEW_LINE
      + 'Your action is now required.  The status of this EMSOF request is "' + new_status_description + '".' + NEW_LINE
      + NEW_LINE
      + 'You can review this EMSOF request by visiting:' + NEW_LINE
      + NEW_LINE
      + '   http://' + ConfigurationSettings.AppSettings['ssl_base_path'] + '/'
      + server.UrlEncode(ConfigurationSettings.AppSettings['application_name']) + '/protected/regional_staffer_overview.aspx'
      + NEW_LINE
      + NEW_LINE
      + 'Replies to this message will be addressed to the ' + session.Item['county_name'].ToString + ' County EMSOF Coordinator.'
      + NEW_LINE
      + NEW_LINE
      + '-- ' + ConfigurationSettings.AppSettings['application_name']
      );
    //
    appcommon.DbClose;
    server.Transfer('county_dictated_appropriations.aspx');
  end;
end;

procedure TWebForm_county_dictated_appropriation_detail.DataGrid_items_ItemDataBound(sender: System.Object;
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
    num_items := num_items + 1;
    total_emsof_ante := total_emsof_ante + decimal.Parse(databinder.Eval(e.item.dataitem,'emsof_ante').tostring);
  end;
end;

procedure TWebForm_county_dictated_appropriation_detail.LinkButton_logout_Click(sender: System.Object;
  e: System.EventArgs);
begin
  formsauthentication.SignOut;
  session.Clear;
  server.Transfer('../Default.aspx');
end;

end.

