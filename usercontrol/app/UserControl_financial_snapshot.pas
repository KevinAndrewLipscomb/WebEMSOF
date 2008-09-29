unit UserControl_financial_snapshot;

interface

uses
  Class_biz_appropriations,
  Class_biz_emsof_requests,
  Class_biz_fiscal_years,
  Class_biz_regional_staffers,
  ki_web_ui,
  System.Data,
  System.Drawing,
  System.Web,
  System.Web.UI,
  System.Web.UI.WebControls,
  System.Web.UI.HtmlControls;

type
  TWebUserControl_financial_snapshot = class(ki_web_ui.usercontrol_class)
  {$REGION 'Designer Managed Code'}
  strict private
    procedure InitializeComponent;
    procedure TWebUserControl_financial_snapshot_PreRender(sender: System.Object;
      e: System.EventArgs);
  {$ENDREGION}
  strict private
    type
      p_type =
        RECORD
        be_loaded: boolean;
        biz_appropriations: TClass_biz_appropriations;
        biz_emsof_requests: TClass_biz_emsof_requests;
        biz_fiscal_years: TClass_biz_fiscal_years;
        biz_regional_staffers: TClass_biz_regional_staffers;
        END;
  strict private
    p: p_type;
    procedure InjectPersistentClientSideScript;
    procedure Page_Load(sender: System.Object; e: System.EventArgs);
  strict protected
    Label_remaining: System.Web.UI.WebControls.Label;
    Label_actually_spent: System.Web.UI.WebControls.Label;
    Label_requested_by_services: System.Web.UI.WebControls.Label;
    Label_appropriated_to_services: System.Web.UI.WebControls.Label;
    Label_sum_of_appropriations: System.Web.UI.WebControls.Label;
    Label_parent_appropriation: System.Web.UI.WebControls.Label;
  protected
    procedure OnInit(e: System.EventArgs); override;
  published
    function Fresh: TWebUserControl_financial_snapshot;
  end;

implementation

uses
  kix,
  System.Collections,
  system.configuration;

procedure TWebUserControl_financial_snapshot.InjectPersistentClientSideScript;
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

procedure TWebUserControl_financial_snapshot.Page_Load(sender: System.Object; e: System.EventArgs);
var
  amount_actually_spent: decimal;
  parent_appropriation: decimal;
  sum_of_appropriations: decimal;
begin
  //
  if not p.be_loaded then begin
    //
    parent_appropriation := p.biz_appropriations.SumOfAppropriationsFromOnlyParent;
    Label_parent_appropriation.text := parent_appropriation.tostring('C');
    sum_of_appropriations := p.biz_appropriations.SumOfSelfDictatedAppropriations;
    Label_sum_of_appropriations.text := sum_of_appropriations.tostring('C');
    Label_appropriated_to_services.text := p.biz_appropriations.SumOfAppropriationsToServicesInRegion
      (
      p.biz_regional_staffers.RegionCodeOf(session['regional_staffer_user_id'].tostring),
      p.biz_fiscal_years.IdOfCurrent
      )
      .tostring('C');
    Label_requested_by_services.text := p.biz_emsof_requests.SumOfRequestValues.tostring('C');
    amount_actually_spent := p.biz_emsof_requests.SumOfActualValues;
    Label_actually_spent.text := amount_actually_spent.tostring('C');
    Label_remaining.text := (parent_appropriation - amount_actually_spent).tostring('C');
    //
    p.be_loaded := TRUE;
    //
  end;
  //
  InjectPersistentClientSideScript;
  //
end;

procedure TWebUserControl_financial_snapshot.OnInit(e: System.EventArgs);
begin
  //
  // Required for Designer support
  //
  InitializeComponent;
  inherited OnInit(e);
  //
  if session['UserControl_financial_snapshot.p'] <> nil then begin
    p := p_type(session['UserControl_financial_snapshot.p']);
    p.be_loaded := IsPostBack and (string(session['UserControl_member_binder_PlaceHolder_content']) = 'UserControl_financial_snapshot');
  end else begin
    //
    p.be_loaded := FALSE;
    //
    p.biz_appropriations := TClass_biz_appropriations.Create;
    p.biz_emsof_requests := TClass_biz_emsof_requests.Create;
    p.biz_fiscal_years := TClass_biz_fiscal_years.Create;
    p.biz_regional_staffers := TClass_biz_regional_staffers.Create;
    //
  end;
  //
end;

{$REGION 'Designer Managed Code'}
/// <summary>
/// Required method for Designer support -- do not modify
/// the contents of this method with the code editor.
/// </summary>
procedure TWebUserControl_financial_snapshot.InitializeComponent;
begin
  Include(Self.PreRender, Self.TWebUserControl_financial_snapshot_PreRender);
  Include(Self.Load, Self.Page_Load);
end;
{$ENDREGION}

procedure TWebUserControl_financial_snapshot.TWebUserControl_financial_snapshot_PreRender(sender: System.Object;
  e: System.EventArgs);
begin
  SessionSet('UserControl_financial_snapshot.p',p);
end;

function TWebUserControl_financial_snapshot.Fresh: TWebUserControl_financial_snapshot;
begin
  session.Remove('UserControl_financial_snapshot.p');
  Fresh := self;
end;

end.
