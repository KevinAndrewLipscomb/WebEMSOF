
unit regional_staffer_overview;

interface

uses
  System.Collections, System.ComponentModel,
  System.Data, System.Drawing, System.Web, System.Web.SessionState,
  System.Web.UI, System.Web.UI.WebControls, System.Web.UI.HtmlControls, AppCommon, system.configuration, system.web.security,
  Class_bc_emsof_request_master,
  Class_dalc_emsof_request_master,
  system.text;

const ID = '$Id$';

type
  TWebForm_regional_staffer_overview = class(System.Web.UI.Page)
  {$REGION 'Designer Managed Code'}
  strict private
    procedure InitializeComponent;
    procedure LinkButton_logout_Click(sender: System.Object; e: System.EventArgs);
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
    //
    HyperLink_maintain_service_accounts: System.Web.UI.WebControls.HyperLink;
    HyperLink_maintain_county_accounts: System.Web.UI.WebControls.HyperLink;
    HyperLink_maintain_regional_staffer_accounts: System.Web.UI.WebControls.HyperLink;
    //
    HyperLink_num_requests_needing_development: System.Web.UI.WebControls.HyperLink;
    HyperLink_num_requests_needing_finalization: System.Web.UI.WebControls.HyperLink;
    HyperLink_num_requests_needing_county_approval: System.Web.UI.WebControls.HyperLink;
    HyperLink_regional_compliance: System.Web.UI.WebControls.HyperLink;
    HyperLink_exec_dir_approval: System.Web.UI.WebControls.HyperLink;
    HyperLink_transmittal: System.Web.UI.WebControls.HyperLink;
    HyperLink_state_approval: System.Web.UI.WebControls.HyperLink;
    HyperLink_invoice_collection: System.Web.UI.WebControls.HyperLink;
    HyperLink_canceled_check_collection: System.Web.UI.WebControls.HyperLink;
    HyperLink_reimbursement: System.Web.UI.WebControls.HyperLink;
    //
    HyperLink_completed: System.Web.UI.WebControls.HyperLink;
    HyperLink_withdrawn: System.Web.UI.WebControls.HyperLink;
    HyperLink_rejected: System.Web.UI.WebControls.HyperLink;
    //
    HyperLink_deployed: System.Web.UI.WebControls.HyperLink;
    HyperLink_archived: System.Web.UI.WebControls.HyperLink;
    HyperLink_maintain_epels: System.Web.UI.WebControls.HyperLink;
    HyperLink_maintain_region_dictated_appropriations: System.Web.UI.WebControls.HyperLink;
    //
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
procedure TWebForm_regional_staffer_overview.InitializeComponent;
begin
  Include(Self.LinkButton_logout.Click, Self.LinkButton_logout_Click);
  Include(Self.Load, Self.Page_Load);
end;
{$ENDREGION}

procedure TWebForm_regional_staffer_overview.Page_Load(sender: System.Object; e: System.EventArgs);
begin
  AppCommon.PopulatePlaceHolders(PlaceHolder_precontent,PlaceHolder_postcontent);
  if not IsPostback then begin
    //
    Title.InnerText := server.HtmlEncode(ConfigurationSettings.AppSettings['application_name']) + ' - regional_staffer_overview';
    Label_account_descriptor.text := session.item['regional_staffer_name'].tostring;
    //
    HyperLink_num_requests_needing_development.text :=
      TClass_bc_emsof_request_master.Create.NumBcInStatus(Class_dalc_emsof_request_master.INITIALIZED).tostring
      + HyperLink_num_requests_needing_development.text;
    HyperLink_num_requests_needing_finalization.text :=
      TClass_bc_emsof_request_master.Create.NumBcInStatus(Class_dalc_emsof_request_master.NEEDS_SERVICE_FINALIZATION).tostring
      + HyperLink_num_requests_needing_finalization.text;
    HyperLink_num_requests_needing_county_approval.text :=
      TClass_bc_emsof_request_master.Create.NumBcInStatus(Class_dalc_emsof_request_master.NEEDS_COUNTY_APPROVAL).tostring
      + HyperLink_num_requests_needing_county_approval.text;
    HyperLink_regional_compliance.text :=
      TClass_bc_emsof_request_master.Create.NumBcInStatus(Class_dalc_emsof_request_master.NEEDS_REGIONAL_COMPLIANCE_CHECK).tostring
      + HyperLink_regional_compliance.text;
    HyperLink_exec_dir_approval.text :=
      TClass_bc_emsof_request_master.Create.NumBcInStatus(Class_dalc_emsof_request_master.NEEDS_REGIONAL_EXEC_DIR_APPROVAL).tostring
      + HyperLink_exec_dir_approval.text;
    HyperLink_transmittal.text :=
      TClass_bc_emsof_request_master.Create.NumBcInStatus(Class_dalc_emsof_request_master.NEEDS_SENT_TO_PA_DOH_EMSO).tostring
      + HyperLink_transmittal.text;
    HyperLink_state_approval.text :=
      TClass_bc_emsof_request_master.Create.NumBcInStatus(Class_dalc_emsof_request_master.NEEDS_PA_DOH_EMSO_APPROVAL).tostring
      + HyperLink_state_approval.text;
    HyperLink_invoice_collection.text :=
      TClass_bc_emsof_request_master.Create.NumBcInStatus(Class_dalc_emsof_request_master.NEEDS_INVOICE_COLLECTION).tostring
      + HyperLink_invoice_collection.text;
    HyperLink_canceled_check_collection.text :=
      TClass_bc_emsof_request_master.Create.NumBcInStatus(Class_dalc_emsof_request_master.NEEDS_CANCELED_CHECK_COLLECTION).tostring
      + HyperLink_canceled_check_collection.text;
    HyperLink_reimbursement.text :=
      TClass_bc_emsof_request_master.Create.NumBcInStatus(Class_dalc_emsof_request_master.NEEDS_REIMBURSEMENT_ISSUANCE).tostring
      + HyperLink_reimbursement.text;
    //
    HyperLink_completed.text :=
      TClass_bc_emsof_request_master.Create.NumBcInStatus(Class_dalc_emsof_request_master.REIMBURSEMENT_ISSUED).tostring
      + HyperLink_completed.text;
    HyperLink_withdrawn.text :=
      TClass_bc_emsof_request_master.Create.NumBcInStatus(Class_dalc_emsof_request_master.WITHDRAWN).tostring
      + HyperLink_withdrawn.text;
    HyperLink_rejected.text :=
      TClass_bc_emsof_request_master.Create.NumBcInStatus(Class_dalc_emsof_request_master.REJECTED).tostring
      + HyperLink_rejected.text;
    //
    HyperLink_deployed.text :=
      TClass_bc_emsof_request_master.Create.NumBcInStatus(Class_dalc_emsof_request_master.DEPLOYED).tostring
      + HyperLink_deployed.text;
    HyperLink_archived.text :=
      TClass_bc_emsof_request_master.Create.NumBcInStatus(Class_dalc_emsof_request_master.ARCHIVED).tostring
      + HyperLink_archived.text;
    //
  end;
end;

procedure TWebForm_regional_staffer_overview.OnInit(e: EventArgs);
begin
  //
  // Required for Designer support
  //
  InitializeComponent;
  inherited OnInit(e);
end;

procedure TWebForm_regional_staffer_overview.LinkButton_logout_Click(sender: System.Object;
  e: System.EventArgs);
begin
  formsauthentication.SignOut;
  session.Clear;
  server.Transfer('../Default.aspx');
end;

end.

