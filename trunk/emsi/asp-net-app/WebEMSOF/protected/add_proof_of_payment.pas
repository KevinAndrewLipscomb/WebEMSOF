unit add_proof_of_payment;

interface

uses
  System.Collections, System.ComponentModel,
  System.Data, System.Drawing, System.Web, System.Web.SessionState,
  System.Web.UI, System.Web.UI.WebControls, System.Web.UI.HtmlControls, system.configuration, system.web.security,
  Class_biz_emsof_requests,
  Class_biz_payment_proof_methods,
  ki_web_ui;

const ID = '$Id$';

type
  p_type =
    RECORD
    amount: decimal;
    biz_emsof_requests: TClass_biz_emsof_requests;
    biz_payment_proof_methods: TClass_biz_payment_proof_methods;
    END;
  TWebForm_add_proof_of_payment = class(ki_web_ui.page_class)
  {$REGION 'Designer Managed Code'}
  strict private
    procedure InitializeComponent;
    procedure TWebForm_add_proof_of_payment_PreRender(sender: System.Object;
      e: System.EventArgs);
    procedure Button_cancel_Click(sender: System.Object; e: System.EventArgs);
    procedure Button_submit_Click(sender: System.Object; e: System.EventArgs);
    procedure CustomValidator_amount_ServerValidate(source: System.Object; args: System.Web.UI.WebControls.ServerValidateEventArgs);
  {$ENDREGION}
  //
  // Expected session objects:
  //
  //   waypoint_stack: system.collections.stack;
  //
  //
  strict private
    p: p_type;
    procedure Page_Load(sender: System.Object; e: System.EventArgs);
  strict protected
    Title: System.Web.UI.HtmlControls.HtmlGenericControl;
    PlaceHolder_precontent: System.Web.UI.WebControls.PlaceHolder;
    PlaceHolder_postcontent: System.Web.UI.WebControls.PlaceHolder;
    Label_account_descriptor: System.Web.UI.WebControls.Label;
    LinkButton_back: System.Web.UI.WebControls.LinkButton;
    Button_submit: System.Web.UI.WebControls.Button;
    Button_cancel: System.Web.UI.WebControls.Button;
    RequiredFieldValidator_method: System.Web.UI.WebControls.RequiredFieldValidator;
    TextBox_amount: System.Web.UI.WebControls.TextBox;
    TextBox_note: System.Web.UI.WebControls.TextBox;
    RequiredFieldValidator_amount: System.Web.UI.WebControls.RequiredFieldValidator;
    RegularExpressionValidator_amount: System.Web.UI.WebControls.RegularExpressionValidator;
    Label_service_name: System.Web.UI.WebControls.Label;
    Calendar_date_of_payment: System.Web.UI.WebControls.Calendar;
    DropDownList_methods: System.Web.UI.WebControls.DropDownList;
    CustomValidator_amount: System.Web.UI.WebControls.CustomValidator;
  protected
    procedure OnInit(e: EventArgs); override;
  private
    { Private Declarations }
  public
    { Public Declarations }
  end;

implementation

uses
  kix;

{$REGION 'Designer Managed Code'}
/// <summary>
/// Required method for Designer support -- do not modify
/// the contents of this method with the code editor.
/// </summary>
procedure TWebForm_add_proof_of_payment.InitializeComponent;
begin
  Include(Self.CustomValidator_amount.ServerValidate, Self.CustomValidator_amount_ServerValidate);
  Include(Self.Button_submit.Click, Self.Button_submit_Click);
  Include(Self.Button_cancel.Click, Self.Button_cancel_Click);
  Include(Self.Load, Self.Page_Load);
  Include(Self.PreRender, Self.TWebForm_add_proof_of_payment_PreRender);
end;
{$ENDREGION}

procedure TWebForm_add_proof_of_payment.Page_Load(sender: System.Object; e: System.EventArgs);
begin
  if IsPostback and (session['p'].GetType.namespace = p.GetType.namespace) then begin
    p := p_type(session['p']);
  end else begin
    if request.servervariables['URL'] = request.currentexecutionfilepath then begin
      //
      // The request for this page could not have been the result of a server.Transfer call, and the session state is therefore unknown.  This is rarely allowed.
      //
      session.Clear;
      server.Transfer('~/login.aspx');
    end else begin
      //
      Title.InnerText := server.HtmlEncode(configurationmanager.AppSettings['application_name']) + ' - add_proof_of_payment';
      Label_account_descriptor.text := session.item['account_descriptor'].tostring;
      //
      p.biz_emsof_requests := TClass_biz_emsof_requests.Create;
      p.biz_payment_proof_methods := TClass_biz_payment_proof_methods.Create;
      //
      Label_service_name.text := p.biz_emsof_requests.ServiceNameOf(session['e_item']);
      Calendar_date_of_payment.selecteddate := datetime.today;
      p.biz_payment_proof_methods.BindListControl(DropDownList_methods);
      //
    end;
  end;
end;

procedure TWebForm_add_proof_of_payment.OnInit(e: EventArgs);
begin
  //
  // Required for Designer support
  //
  InitializeComponent;
  inherited OnInit(e);
end;

procedure TWebForm_add_proof_of_payment.CustomValidator_amount_ServerValidate(source: System.Object;
  args: System.Web.UI.WebControls.ServerValidateEventArgs);
var
  amount_string: string;
begin
  amount_string := Safe(args.value,REAL_NUM);
  if amount_string = EMPTY then begin
    args.isvalid := FALSE;
  end else begin
    p.amount := decimal.Parse(amount_string);
    args.isvalid := (p.amount > 0);
  end;
end;

procedure TWebForm_add_proof_of_payment.Button_submit_Click(sender: System.Object;
  e: System.EventArgs);
var
  timestamp: datetime;
begin
  if p.biz_emsof_requests.BeValidStateApprovalTimestampOf(p.biz_emsof_requests.IdOf(session['e_item']),timestamp)
    and (Calendar_date_of_payment.selecteddate >= timestamp.Date)
    and (Calendar_date_of_payment.selecteddate < datetime.Now)
  then begin
    p.biz_emsof_requests.AddProofOfPayment
      (
      p.biz_emsof_requests.IdOf(session['e_item']),
      Calendar_date_of_payment.selecteddate,
      Safe(DropDownList_methods.selectedvalue,NUM),
      p.amount,
      Safe(TextBox_note.text,PUNCTUATED)
      );
  end;
  BackTrack;
end;

procedure TWebForm_add_proof_of_payment.Button_cancel_Click(sender: System.Object;
  e: System.EventArgs);
begin
  BackTrack;
end;

procedure TWebForm_add_proof_of_payment.TWebForm_add_proof_of_payment_PreRender(sender: System.Object;
  e: System.EventArgs);
begin
  SessionSet('p',p);
end;

end.

