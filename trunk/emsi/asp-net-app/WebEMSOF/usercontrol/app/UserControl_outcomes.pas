unit UserControl_outcomes;

interface

uses
  Class_biz_emsof_requests,
  ki_web_ui,
  System.Data,
  System.Drawing,
  System.Web,
  System.Web.UI,
  System.Web.UI.WebControls,
  System.Web.UI.HtmlControls;

type
  TWebUserControl_outcomes = class(ki_web_ui.usercontrol_class)
  {$REGION 'Designer Managed Code'}
  strict private
    procedure InitializeComponent;
    procedure TWebUserControl_outcomes_PreRender(sender: System.Object;
      e: System.EventArgs);
    procedure LinkButton_completed_Click(sender: System.Object; e: System.EventArgs);
    procedure LinkButton_withdrawn_Click(sender: System.Object; e: System.EventArgs);
    procedure LinkButton_rejected_Click(sender: System.Object; e: System.EventArgs);
    procedure LinkButton_missed_deadlines_Click(sender: System.Object; e: System.EventArgs);
  {$ENDREGION}
  strict private
    type
      p_type =
        RECORD
        be_loaded: boolean;
        biz_emsof_requests: TClass_biz_emsof_requests;
        END;
  strict private
    p: p_type;
    procedure InjectPersistentClientSideScript;
    procedure Page_Load(sender: System.Object; e: System.EventArgs);
  strict protected
    LinkButton_rejected: System.Web.UI.WebControls.LinkButton;
    LinkButton_withdrawn: System.Web.UI.WebControls.LinkButton;
    LinkButton_missed_deadlines: System.Web.UI.WebControls.LinkButton;
    LinkButton_completed: System.Web.UI.WebControls.LinkButton;
  protected
    procedure OnInit(e: System.EventArgs); override;
  published
    function Fresh: TWebUserControl_outcomes;
  end;

implementation

uses
  kix,
  System.Collections,
  system.configuration;

procedure TWebUserControl_outcomes.InjectPersistentClientSideScript;
begin
{$REGION 'Persistent client-side script'}
//  EstablishClientSideFunction(EL);
//  EstablishClientSideFunction(KGS_TO_LBS);
//  EstablishClientSideFunction(LBS_TO_KGS);
//  EstablishClientSideFunction
//    (
//    'RecalculateDependentValues()',
//    EMPTY
//    + 'El("' + TextBox_gain_or_loss_in_lbs.clientid + '").value ='
//    +  ' El("' + TextBox_gross_landed_weight_in_pounds.clientid + '").value - El("' + TextBox_gross_invoiced_weight_in_lbs.clientid + '").value;'
//    + NEW_LINE
//    + 'El("' + TextBox_gain_or_loss_in_kgs.clientid + '").value ='
//    +  ' El("' + TextBox_gross_landed_weight_in_kgs.clientid + '").value - El("' + TextBox_gross_invoiced_weight_in_kgs.clientid + '").value;'
//    + NEW_LINE
//    + 'El("' + TextBox_gain_or_loss_per_bale_in_lbs.clientid + '").value ='
//    +  ' El("' + TextBox_gain_or_loss_in_lbs.clientid + '").value/El("' + TextBox_bales.clientid + '").value;'
//    + NEW_LINE
//    + 'El("' + TextBox_gain_or_loss_per_bale_in_kgs.clientid + '").value ='
//    +  ' El("' + TextBox_gain_or_loss_in_kgs.clientid + '").value/El("' + TextBox_bales.clientid + '").value;'
//    + NEW_LINE
//    + 'El("' + TextBox_actual_gain_or_loss_in_lbs.clientid + '").value ='
//    +  ' El("' + TextBox_gain_or_loss_in_lbs.clientid + '").value - El("' + TextBox_franchise_in_lbs.clientid + '").value;'
//    + NEW_LINE
//    + 'El("' + TextBox_actual_gain_or_loss_in_kgs.clientid + '").value ='
//    +  ' El("' + TextBox_gain_or_loss_in_kgs.clientid + '").value - El("' + TextBox_franchise_in_kgs.clientid + '").value;'
//    + NEW_LINE
//    + 'El("' + TextBox_actual_gain_or_loss_per_bale_in_lbs.clientid + '").value ='
//    +  ' El("' + TextBox_actual_gain_or_loss_in_lbs.clientid + '").value/El("' + TextBox_bales.clientid + '").value;'
//    + NEW_LINE
//    + 'El("' + TextBox_actual_gain_or_loss_per_bale_in_kgs.clientid + '").value ='
//    +  ' El("' + TextBox_actual_gain_or_loss_in_kgs.clientid + '").value/El("' + TextBox_bales.clientid + '").value;'
//    + NEW_LINE
//    + 'El("' + TextBox_percent_gain_or_loss.clientid + '").value ='
//    +  ' Math.round(El("' + TextBox_actual_gain_or_loss_in_lbs.clientid + '").value/El("' + TextBox_net_invoiced_in_lbs.clientid + '").value*100*100)/100;'
//    + NEW_LINE
//    + 'El("' + TextBox_monetary_gain_or_loss.clientid + '").value ='
//    +  ' El("' + TextBox_actual_gain_or_loss_in_lbs.clientid + '").value*El("' + TextBox_unit_price_in_cents_per_pound.clientid + '").value;'
//    );
//  //
//  TextBox_bales.attributes.Add('onkeyup','RecalculateDependentValues();');
//  TextBox_gross_landed_weight_in_pounds.attributes.Add
//    (
//    'onkeyup',
//    'El("' + TextBox_gross_landed_weight_in_kgs.clientid + '").value = LbsToKgs(El("' + TextBox_gross_landed_weight_in_pounds.clientid + '").value);'
//    + ' RecalculateDependentValues();'
//    );
//  TextBox_gross_landed_weight_in_kgs.attributes.Add
//    (
//    'onkeyup',
//    'El("' + TextBox_gross_landed_weight_in_pounds.clientid + '").value = KgsToLbs(El("' + TextBox_gross_landed_weight_in_kgs.clientid + '").value);'
//    + ' RecalculateDependentValues();'
//    );
//  TextBox_landed_or_ciq_tare.attributes.Add
//    (
//    'onkeyup',
//    'El("' + TextBox_landed_or_ciq_tare_in_kgs.clientid + '").value = LbsToKgs(El("' + TextBox_landed_or_ciq_tare.clientid + '").value);'
//    + ' RecalculateDependentValues();'
//    );
//  TextBox_landed_or_ciq_tare_in_kgs.attributes.Add
//    (
//    'onkeyup',
//    'El("' + TextBox_landed_or_ciq_tare.clientid + '").value = KgsToLbs(El("' + TextBox_landed_or_ciq_tare_in_kgs.clientid + '").value);'
//    + ' RecalculateDependentValues();'
//    );
//  TextBox_net_landed_in_pounds.attributes.Add
//    (
//    'onkeyup',
//    'El("' + TextBox_net_landed_in_kgs.clientid + '").value = LbsToKgs(El("' + TextBox_net_landed_in_pounds.clientid + '").value);'
//    + ' RecalculateDependentValues();'
//    );
//  TextBox_net_landed_in_kgs.attributes.Add
//    (
//    'onkeyup',
//    'El("' + TextBox_net_landed_in_pounds.clientid + '").value = KgsToLbs(El("' + TextBox_net_landed_in_kgs.clientid + '").value);'
//    + ' RecalculateDependentValues();'
//    );
{$ENDREGION}
end;

procedure TWebUserControl_outcomes.Page_Load(sender: System.Object; e: System.EventArgs);
begin
  //
  if not p.be_loaded then begin
    //
    LinkButton_completed.text := p.biz_emsof_requests.TallyOfStatus(REIMBURSEMENT_ISSUED) + LinkButton_completed.text;
    LinkButton_missed_deadlines.text := p.biz_emsof_requests.TallyOfStatus(FAILED_DEADLINE) + LinkButton_missed_deadlines.text;
    LinkButton_withdrawn.text := p.biz_emsof_requests.TallyOfStatus(WITHDRAWN) + LinkButton_withdrawn.text;
    LinkButton_rejected.text := p.biz_emsof_requests.TallyOfStatus(REJECTED) + LinkButton_rejected.text;
    //
    scriptmanager.GetCurrent(page).RegisterPostBackControl(LinkButton_completed);
    scriptmanager.GetCurrent(page).RegisterPostBackControl(LinkButton_missed_deadlines);
    scriptmanager.GetCurrent(page).RegisterPostBackControl(LinkButton_withdrawn);
    scriptmanager.GetCurrent(page).RegisterPostBackControl(LinkButton_rejected);
    //
    p.be_loaded := TRUE;
    //
  end;
  //
  InjectPersistentClientSideScript;
  //
end;

procedure TWebUserControl_outcomes.OnInit(e: System.EventArgs);
begin
  //
  // Required for Designer support
  //
  InitializeComponent;
  inherited OnInit(e);
  //
  if session['UserControl_outcomes.p'] <> nil then begin
    p := p_type(session['UserControl_outcomes.p']);
    p.be_loaded := IsPostBack and (string(session['UserControl_member_binder_PlaceHolder_content']) = 'UserControl_outcomes');
  end else begin
    //
    p.be_loaded := FALSE;
    //
    p.biz_emsof_requests := TClass_biz_emsof_requests.Create;
    //
  end;
  //
end;

{$REGION 'Designer Managed Code'}
/// <summary>
/// Required method for Designer support -- do not modify
/// the contents of this method with the code editor.
/// </summary>
procedure TWebUserControl_outcomes.InitializeComponent;
begin
  Include(Self.PreRender, Self.TWebUserControl_outcomes_PreRender);
  Include(Self.Load, Self.Page_Load);
  Include(Self.LinkButton_completed.Click, Self.LinkButton_completed_Click);
  Include(Self.LinkButton_missed_deadlines.Click, Self.LinkButton_missed_deadlines_Click);
  Include(Self.LinkButton_withdrawn.Click, Self.LinkButton_withdrawn_Click);
  Include(Self.LinkButton_rejected.Click, Self.LinkButton_rejected_Click);
end;
{$ENDREGION}

procedure TWebUserControl_outcomes.TWebUserControl_outcomes_PreRender(sender: System.Object;
  e: System.EventArgs);
begin
  SessionSet('UserControl_outcomes.p',p);
end;

function TWebUserControl_outcomes.Fresh: TWebUserControl_outcomes;
begin
  session.Remove('UserControl_outcomes.p');
  Fresh := self;
end;

procedure TWebUserControl_outcomes.LinkButton_rejected_Click(sender: System.Object;
  e: System.EventArgs);
begin
  SessionSet('status_of_interest',REJECTED);
  DropCrumbAndTransferTo('emsof_request_status_filter.aspx');
end;

procedure TWebUserControl_outcomes.LinkButton_withdrawn_Click(sender: System.Object;
  e: System.EventArgs);
begin
  SessionSet('status_of_interest',WITHDRAWN);
  DropCrumbAndTransferTo('emsof_request_status_filter.aspx');
end;

procedure TWebUserControl_outcomes.LinkButton_completed_Click(sender: System.Object;
  e: System.EventArgs);
begin
  SessionSet('status_of_interest',REIMBURSEMENT_ISSUED);
  DropCrumbAndTransferTo('emsof_request_status_filter.aspx');
end;

procedure TWebUserControl_outcomes.LinkButton_missed_deadlines_Click(sender: System.Object;
  e: System.EventArgs);
begin
  SessionSet('status_of_interest',FAILED_DEADLINE);
  DropCrumbAndTransferTo('emsof_request_status_filter.aspx');
end;

end.
