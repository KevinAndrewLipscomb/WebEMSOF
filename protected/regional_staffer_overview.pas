
unit regional_staffer_overview;

interface

uses
  System.Collections, System.ComponentModel,
  System.Data, System.Drawing, System.Web, System.Web.SessionState,
  System.Web.UI, System.Web.UI.WebControls, System.Web.UI.HtmlControls, AppCommon, system.configuration, system.web.security,
  Class_bc_emsof_request,
  system.text;

const ID = '$Id$';

type
  TWebForm_regional_staffer_overview = class(System.Web.UI.Page)
  {$REGION 'Designer Managed Code'}
  strict private
    procedure InitializeComponent;
    procedure LinkButton_logout_Click(sender: System.Object; e: System.EventArgs);
    procedure LinkButton_regional_compliance_Click(sender: System.Object; e: System.EventArgs);
    procedure LinkButton_num_requests_needing_development_Click(sender: System.Object; 
      e: System.EventArgs);
    procedure LinkButton_num_requests_needing_finalization_Click(sender: System.Object; 
      e: System.EventArgs);
    procedure LinkButton_num_requests_needing_county_approval_Click(sender: System.Object; 
      e: System.EventArgs);
    procedure LinkButton_exec_dir_approval_Click(sender: System.Object; e: System.EventArgs);
    procedure LinkButton_transmittal_Click(sender: System.Object; e: System.EventArgs);
    procedure LinkButton_state_approval_Click(sender: System.Object; e: System.EventArgs);
    procedure LinkButton_invoice_collection_Click(sender: System.Object; e: System.EventArgs);
    procedure LinkButton_canceled_check_collection_Click(sender: System.Object; 
      e: System.EventArgs);
    procedure LinkButton_reimbursement_Click(sender: System.Object; e: System.EventArgs);
    procedure LinkButton_completed_Click(sender: System.Object; e: System.EventArgs);
    procedure LinkButton_withdrawn_Click(sender: System.Object; e: System.EventArgs);
    procedure LinkButton_rejected_Click(sender: System.Object; e: System.EventArgs);
    procedure LinkButton_deployed_Click(sender: System.Object; e: System.EventArgs);
    procedure LinkButton_archived_Click(sender: System.Object; e: System.EventArgs);
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
    LinkButton_num_requests_needing_development: System.Web.UI.WebControls.LinkButton;
    LinkButton_num_requests_needing_finalization: System.Web.UI.WebControls.LinkButton;
    LinkButton_num_requests_needing_county_approval: System.Web.UI.WebControls.LinkButton;
    LinkButton_regional_compliance: System.Web.UI.WebControls.LinkButton;
    LinkButton_exec_dir_approval: System.Web.UI.WebControls.LinkButton;
    LinkButton_transmittal: System.Web.UI.WebControls.LinkButton;
    LinkButton_state_approval: System.Web.UI.WebControls.LinkButton;
    LinkButton_invoice_collection: System.Web.UI.WebControls.LinkButton;
    LinkButton_canceled_check_collection: System.Web.UI.WebControls.LinkButton;
    LinkButton_reimbursement: System.Web.UI.WebControls.LinkButton;
    //
    LinkButton_completed: System.Web.UI.WebControls.LinkButton;
    LinkButton_withdrawn: System.Web.UI.WebControls.LinkButton;
    LinkButton_rejected: System.Web.UI.WebControls.LinkButton;
    //
    HyperLink_maintain_service_accounts: System.Web.UI.WebControls.HyperLink;
    HyperLink_maintain_county_accounts: System.Web.UI.WebControls.HyperLink;
    HyperLink_maintain_regional_staffer_accounts: System.Web.UI.WebControls.HyperLink;
    //
    HyperLink_maintain_epels: System.Web.UI.WebControls.HyperLink;
    HyperLink_maintain_region_dictated_appropriations: System.Web.UI.WebControls.HyperLink;
    //
    LinkButton_deployed: System.Web.UI.WebControls.LinkButton;
    LinkButton_archived: System.Web.UI.WebControls.LinkButton;
    Label_parent_appropriation: System.Web.UI.WebControls.Label;
    Label_sum_of_appropriations: System.Web.UI.WebControls.Label;
    Label_unrequested: System.Web.UI.WebControls.Label;
    Label_remaining: System.Web.UI.WebControls.Label;
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
  Include(Self.LinkButton_num_requests_needing_development.Click, Self.LinkButton_num_requests_needing_development_Click);
  Include(Self.LinkButton_num_requests_needing_finalization.Click, Self.LinkButton_num_requests_needing_finalization_Click);
  Include(Self.LinkButton_num_requests_needing_county_approval.Click, Self.LinkButton_num_requests_needing_county_approval_Click);
  Include(Self.LinkButton_regional_compliance.Click, Self.LinkButton_regional_compliance_Click);
  Include(Self.LinkButton_exec_dir_approval.Click, Self.LinkButton_exec_dir_approval_Click);
  Include(Self.LinkButton_transmittal.Click, Self.LinkButton_transmittal_Click);
  Include(Self.LinkButton_state_approval.Click, Self.LinkButton_state_approval_Click);
  Include(Self.LinkButton_invoice_collection.Click, Self.LinkButton_invoice_collection_Click);
  Include(Self.LinkButton_canceled_check_collection.Click, Self.LinkButton_canceled_check_collection_Click);
  Include(Self.LinkButton_reimbursement.Click, Self.LinkButton_reimbursement_Click);
  Include(Self.LinkButton_completed.Click, Self.LinkButton_completed_Click);
  Include(Self.LinkButton_withdrawn.Click, Self.LinkButton_withdrawn_Click);
  Include(Self.LinkButton_rejected.Click, Self.LinkButton_rejected_Click);
  Include(Self.LinkButton_deployed.Click, Self.LinkButton_deployed_Click);
  Include(Self.LinkButton_archived.Click, Self.LinkButton_archived_Click);
  Include(Self.Load, Self.Page_Load);
end;
{$ENDREGION}

procedure TWebForm_regional_staffer_overview.Page_Load
  (
  sender: System.Object;
  e: System.EventArgs
  );
begin
  AppCommon.PopulatePlaceHolders(PlaceHolder_precontent,PlaceHolder_postcontent);
  if not IsPostback then begin
    //
    Title.InnerText := server.HtmlEncode(ConfigurationSettings.AppSettings['application_name']) + ' - regional_staffer_overview';
    Label_account_descriptor.text := session['regional_staffer_name'].tostring;
    //
    LinkButton_num_requests_needing_development.text :=
      TClass_bc_emsof_request.Create.TallyOfStatus(INITIALIZED) + LinkButton_num_requests_needing_development.text;
    LinkButton_num_requests_needing_finalization.text :=
      TClass_bc_emsof_request.Create.TallyOfStatus(NEEDS_SERVICE_FINALIZATION) + LinkButton_num_requests_needing_finalization.text;
    LinkButton_num_requests_needing_county_approval.text :=
      TClass_bc_emsof_request.Create.TallyOfStatus(NEEDS_COUNTY_APPROVAL) + LinkButton_num_requests_needing_county_approval.text;
    LinkButton_regional_compliance.text :=
      TClass_bc_emsof_request.Create.TallyOfStatus(NEEDS_REGIONAL_COMPLIANCE_CHECK) + LinkButton_regional_compliance.text;
    LinkButton_exec_dir_approval.text :=
      TClass_bc_emsof_request.Create.TallyOfStatus(NEEDS_REGIONAL_EXEC_DIR_APPROVAL) + LinkButton_exec_dir_approval.text;
    LinkButton_transmittal.text :=
      TClass_bc_emsof_request.Create.TallyOfStatus(NEEDS_SENT_TO_PA_DOH_EMSO) + LinkButton_transmittal.text;
    LinkButton_state_approval.text :=
      TClass_bc_emsof_request.Create.TallyOfStatus(NEEDS_PA_DOH_EMSO_APPROVAL) + LinkButton_state_approval.text;
    LinkButton_invoice_collection.text :=
      TClass_bc_emsof_request.Create.TallyOfStatus(NEEDS_INVOICE_COLLECTION) + LinkButton_invoice_collection.text;
    LinkButton_canceled_check_collection.text :=
      TClass_bc_emsof_request.Create.TallyOfStatus(NEEDS_CANCELED_CHECK_COLLECTION) + LinkButton_canceled_check_collection.text;
    LinkButton_reimbursement.text :=
      TClass_bc_emsof_request.Create.TallyOfStatus(NEEDS_REIMBURSEMENT_ISSUANCE) + LinkButton_reimbursement.text;
    //
    LinkButton_completed.text := TClass_bc_emsof_request.Create.TallyOfStatus(REIMBURSEMENT_ISSUED) + LinkButton_completed.text;
    LinkButton_withdrawn.text := TClass_bc_emsof_request.Create.TallyOfStatus(WITHDRAWN) + LinkButton_withdrawn.text;
    LinkButton_rejected.text := TClass_bc_emsof_request.Create.TallyOfStatus(REJECTED) + LinkButton_rejected.text;
    //
    LinkButton_deployed.text := TClass_bc_emsof_request.Create.TallyOfStatus(DEPLOYED) + LinkButton_deployed.text;
    LinkButton_archived.text := TClass_bc_emsof_request.Create.TallyOfStatus(ARCHIVED) + LinkButton_archived.text;
    //
    session.Remove('calling_form');
    session.Add('calling_form','regional_staffer_overview.aspx');
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

procedure TWebForm_regional_staffer_overview.LinkButton_archived_Click(sender: System.Object;
  e: System.EventArgs);
begin
  session.Remove('status_of_interest');
  session.Add('status_of_interest',ARCHIVED);
  server.Transfer('emsof_request_status_filter.aspx');
end;

procedure TWebForm_regional_staffer_overview.LinkButton_deployed_Click(sender: System.Object;
  e: System.EventArgs);
begin
  session.Remove('status_of_interest');
  session.Add('status_of_interest',DEPLOYED);
  server.Transfer('emsof_request_status_filter.aspx');
end;

procedure TWebForm_regional_staffer_overview.LinkButton_rejected_Click(sender: System.Object;
  e: System.EventArgs);
begin
  session.Remove('status_of_interest');
  session.Add('status_of_interest',REJECTED);
  server.Transfer('emsof_request_status_filter.aspx');
end;

procedure TWebForm_regional_staffer_overview.LinkButton_withdrawn_Click(sender: System.Object;
  e: System.EventArgs);
begin
  session.Remove('status_of_interest');
  session.Add('status_of_interest',WITHDRAWN);
  server.Transfer('emsof_request_status_filter.aspx');
end;

procedure TWebForm_regional_staffer_overview.LinkButton_completed_Click(sender: System.Object;
  e: System.EventArgs);
begin
  session.Remove('status_of_interest');
  session.Add('status_of_interest',REIMBURSEMENT_ISSUED);
  server.Transfer('emsof_request_status_filter.aspx');
end;

procedure TWebForm_regional_staffer_overview.LinkButton_reimbursement_Click(sender: System.Object;
  e: System.EventArgs);
begin
  session.Remove('status_of_interest');
  session.Add('status_of_interest',NEEDS_REIMBURSEMENT_ISSUANCE);
  server.Transfer('emsof_request_status_filter.aspx');
end;

procedure TWebForm_regional_staffer_overview.LinkButton_canceled_check_collection_Click(sender: System.Object;
  e: System.EventArgs);
begin
  session.Remove('status_of_interest');
  session.Add('status_of_interest',NEEDS_CANCELED_CHECK_COLLECTION);
  server.Transfer('emsof_request_status_filter.aspx');
end;

procedure TWebForm_regional_staffer_overview.LinkButton_invoice_collection_Click(sender: System.Object;
  e: System.EventArgs);
begin
  session.Remove('status_of_interest');
  session.Add('status_of_interest',NEEDS_INVOICE_COLLECTION);
  server.Transfer('emsof_request_status_filter.aspx');
end;

procedure TWebForm_regional_staffer_overview.LinkButton_state_approval_Click(sender: System.Object;
  e: System.EventArgs);
begin
  session.Remove('status_of_interest');
  session.Add('status_of_interest',NEEDS_PA_DOH_EMSO_APPROVAL);
  server.Transfer('emsof_request_status_filter.aspx');
end;

procedure TWebForm_regional_staffer_overview.LinkButton_transmittal_Click(sender: System.Object;
  e: System.EventArgs);
begin
  session.Remove('status_of_interest');
  session.Add('status_of_interest',NEEDS_SENT_TO_PA_DOH_EMSO);
  server.Transfer('emsof_request_status_filter.aspx');
end;

procedure TWebForm_regional_staffer_overview.LinkButton_exec_dir_approval_Click(sender: System.Object;
  e: System.EventArgs);
begin
  session.Remove('status_of_interest');
  session.Add('status_of_interest',NEEDS_REGIONAL_EXEC_DIR_APPROVAL);
  server.Transfer('emsof_request_status_filter.aspx');
end;

procedure TWebForm_regional_staffer_overview.LinkButton_num_requests_needing_county_approval_Click(sender: System.Object;
  e: System.EventArgs);
begin
  session.Remove('status_of_interest');
  session.Add('status_of_interest',NEEDS_COUNTY_APPROVAL);
  server.Transfer('emsof_request_status_filter.aspx');
end;

procedure TWebForm_regional_staffer_overview.LinkButton_num_requests_needing_finalization_Click(sender: System.Object;
  e: System.EventArgs);
begin
  session.Remove('status_of_interest');
  session.Add('status_of_interest',NEEDS_SERVICE_FINALIZATION);
  server.Transfer('emsof_request_status_filter.aspx');
end;

procedure TWebForm_regional_staffer_overview.LinkButton_num_requests_needing_development_Click(sender: System.Object;
  e: System.EventArgs);
begin
  session.Remove('status_of_interest');
  session.Add('status_of_interest',INITIALIZED);
  server.Transfer('emsof_request_status_filter.aspx');
end;

procedure TWebForm_regional_staffer_overview.LinkButton_regional_compliance_Click(sender: System.Object;
  e: System.EventArgs);
begin
  session.Remove('status_of_interest');
  session.Add('status_of_interest',NEEDS_REGIONAL_COMPLIANCE_CHECK);
  server.Transfer('emsof_request_status_filter.aspx');
end;

procedure TWebForm_regional_staffer_overview.LinkButton_logout_Click(sender: System.Object;
  e: System.EventArgs);
begin
  formsauthentication.SignOut;
  session.Clear;
  server.Transfer('../Default.aspx');
end;

end.

