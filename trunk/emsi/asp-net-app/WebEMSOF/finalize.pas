
unit finalize;

interface

uses
  System.Collections, System.ComponentModel,
  System.Data, System.Drawing, System.Web, System.Web.SessionState,
  System.Web.UI, System.Web.UI.WebControls, System.Web.UI.HtmlControls, AppCommon, system.configuration, borland.data.provider;

type
  TWebForm_finalize = class(System.Web.UI.Page)
  {$REGION 'Designer Managed Code'}
  strict private
    procedure InitializeComponent;
    procedure Button_finalize_Click(sender: System.Object; e: System.EventArgs);
  {$ENDREGION}
  strict private
    procedure Page_Load(sender: System.Object; e: System.EventArgs);
  strict protected
    Title: System.Web.UI.HtmlControls.HtmlGenericControl;
    PlaceHolder_precontent: System.Web.UI.WebControls.PlaceHolder;
    PlaceHolder_postcontent: System.Web.UI.WebControls.PlaceHolder;
    Label_service_name: System.Web.UI.WebControls.Label;
    Table_sorry: System.Web.UI.HtmlControls.HtmlTable;
    Table_summary: System.Web.UI.HtmlControls.HtmlTable;
    CheckBox_understand_read_only_1: System.Web.UI.WebControls.CheckBox;
    ListItem_remainder_goes_to_region: system.web.ui.htmlcontrols.htmlgenericcontrol;
    Label_grand_total_cost: System.Web.UI.WebControls.Label;
    CheckBox_understand_grand_total_up_front: System.Web.UI.WebControls.CheckBox;
    CheckBox_understand_max_reimbursement: System.Web.UI.WebControls.CheckBox;
    Label_max_reimbursement_1: System.Web.UI.WebControls.Label;
    CheckBox_understand_anticipated_vs_actual: System.Web.UI.WebControls.CheckBox;
    Label_unreimbursed_amount: System.Web.UI.WebControls.Label;
    CheckBox_understand_unreimbursed_amount: System.Web.UI.WebControls.CheckBox;
    CheckBox_understand_deadlines: System.Web.UI.WebControls.CheckBox;
    CheckBox_agree_to_terms_and_conditions: System.Web.UI.WebControls.CheckBox;
    HyperLink_terms_and_conditions: System.Web.UI.WebControls.HyperLink;
    Button_finalize: System.Web.UI.WebControls.Button;
    CheckBox_understand_read_only_2: System.Web.UI.WebControls.CheckBox;
    CheckBox_understand_wait_for_approval_to_order: System.Web.UI.WebControls.CheckBox;
    Label_deadline_purchase_completion: System.Web.UI.WebControls.Label;
    Label_deadline_invoice_submission: System.Web.UI.WebControls.Label;
    Label_deadline_canceled_check_submission: System.Web.UI.WebControls.Label;
    Label_unused_amount: System.Web.UI.WebControls.Label;
    CheckBox_understand_remainder_goes_to_region: System.Web.UI.WebControls.CheckBox;
    HyperLink_request_overview_0: System.Web.UI.WebControls.HyperLink;
    HyperLink_request_overview_2: System.Web.UI.WebControls.HyperLink;
    HyperLink_request_overview_3: System.Web.UI.WebControls.HyperLink;
    HyperLink_request_overview_4: System.Web.UI.WebControls.HyperLink;
    HyperLink_request_overview_5: System.Web.UI.WebControls.HyperLink;
    HyperLink_request_overview_6: System.Web.UI.WebControls.HyperLink;
    HyperLink_request_overview_7: System.Web.UI.WebControls.HyperLink;
    HyperLink_request_overview_8: System.Web.UI.WebControls.HyperLink;
    HyperLink_request_overview_9: System.Web.UI.WebControls.HyperLink;
    HyperLink_request_overview_10: System.Web.UI.WebControls.HyperLink;
    HyperLink_request_overview_1: System.Web.UI.WebControls.HyperLink;
    Label_max_reimbursement_2: System.Web.UI.WebControls.Label;
    HyperLink_request_overview_bottom: System.Web.UI.WebControls.HyperLink;
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
procedure TWebForm_finalize.InitializeComponent;
begin
  Include(Self.Button_finalize.Click, Self.Button_finalize_Click);
  Include(Self.Load, Self.Page_Load);
end;
{$ENDREGION}

const ID = '$Id$';

procedure TWebForm_finalize.Page_Load(sender: System.Object; e: System.EventArgs);
var
  bdr: borland.data.provider.bdpdatareader;
  grand_total_cost: decimal;
  max_reimbursement: decimal;
begin
  AppCommon.PopulatePlaceHolders(PlaceHolder_precontent,PlaceHolder_postcontent);
  if not IsPostback then begin
    Title.InnerText := server.HtmlEncode(ConfigurationSettings.AppSettings['application_name']) + ' - finalize';
    //
    Label_service_name.text := session.item['service_name'].tostring;
    //
    if decimal(session.item['unused_amount']) >= 0 then begin
      //
      Table_sorry.visible := FALSE;
      //
      if decimal(session.item['unused_amount']) = 0 then begin
        ListItem_remainder_goes_to_region.visible := FALSE;
      end else begin
        Label_unused_amount.text := decimal(session.item['unused_amount']).tostring('C');
      end;
      //
      appcommon.bdpconnection.Open;
      //
      // Set Label_grand_total_cost.
      //
      grand_total_cost := decimal
        (
        borland.data.provider.bdpcommand.Create
          (
          'select sum(unit_cost*quantity) from emsof_request_detail'
          + ' where master_id = ' + session.item['emsof_request_master_id'].tostring,
          appcommon.bdpconnection
          )
          .ExecuteScalar
        );
      Label_grand_total_cost.text := grand_total_cost.tostring('C');
      //
      // Set Label_max_reimbursement.
      //
      max_reimbursement := decimal(session.item['sum_of_emsof_antes']);
      Label_max_reimbursement_1.text := max_reimbursement.tostring('C');
      Label_max_reimbursement_2.text := Label_max_reimbursement_1.text;
      //
      // Set Label_unreimbursed_amount.
      //
      Label_unreimbursed_amount.text := (grand_total_cost - max_reimbursement).tostring('C');
      //
      // Set Label_deadline_*
      //
      bdr := borland.data.provider.bdpcommand.Create
        (
        'select value as emsof_service_purchase_completion_deadline'
        + ' from fy_calendar'
        +   ' join milestone_code_name_map on (milestone_code_name_map.code=fy_calendar.milestone_code)'
        + ' where name = "emsof-service-purchase-completion-deadline"',
        appcommon.bdpconnection
        )
        .ExecuteReader;
      bdr.Read;
      Label_deadline_purchase_completion.text :=
        datetime.Parse(bdr['emsof_service_purchase_completion_deadline'].tostring).tostring('HH:mm:ss dddd, MMMM dd, yyyy');
      bdr.Close;
      bdr := borland.data.provider.bdpcommand.Create
        (
        'select value as emsof_service_invoice_submission_deadline'
        + ' from fy_calendar'
        +   ' join milestone_code_name_map on (milestone_code_name_map.code=fy_calendar.milestone_code)'
        + ' where name = "emsof-service-invoice-submission-deadline"',
        appcommon.bdpconnection
        )
        .ExecuteReader;
      bdr.Read;
      Label_deadline_invoice_submission.text :=
        datetime.Parse(bdr['emsof_service_invoice_submission_deadline'].tostring).tostring('HH:mm:ss dddd, MMMM dd, yyyy');
      bdr.Close;
      bdr := borland.data.provider.bdpcommand.Create
        (
        'select value as emsof_service_canceled_check_submission_deadline'
        + ' from fy_calendar'
        +   ' join milestone_code_name_map on (milestone_code_name_map.code=fy_calendar.milestone_code)'
        + ' where name = "emsof-service-canceled-check-submission-deadline"',
        appcommon.bdpconnection
        )
        .ExecuteReader;
      bdr.Read;
      Label_deadline_canceled_check_submission.text :=
        datetime.Parse(bdr['emsof_service_canceled_check_submission_deadline'].tostring).tostring('HH:mm:ss dddd, MMMM dd, yyyy');
      bdr.Close;
      //
      appcommon.bdpconnection.Close;
      //
    end else begin
      Table_summary.visible := FALSE;
    end;
  end;
end;

procedure TWebForm_finalize.OnInit(e: EventArgs);
begin
  //
  // Required for Designer support
  //
  InitializeComponent;
  inherited OnInit(e);
end;

procedure TWebForm_finalize.Button_finalize_Click(sender: System.Object; e: System.EventArgs);
begin
  if CheckBox_understand_read_only_1.checked
    and ((decimal(session.item['unused_amount']) = 0) or CheckBox_understand_remainder_goes_to_region.checked)
    and CheckBox_understand_grand_total_up_front.checked
    and CheckBox_understand_max_reimbursement.checked
    and CheckBox_understand_anticipated_vs_actual.checked
    and CheckBox_understand_unreimbursed_amount.checked
    and CheckBox_understand_deadlines.checked
    and CheckBox_agree_to_terms_and_conditions.checked
    and CheckBox_understand_read_only_2.checked
    and CheckBox_understand_wait_for_approval_to_order.checked
  then begin
    //
    server.Transfer('request_overview.aspx');
    //
  end;
end;

end.

