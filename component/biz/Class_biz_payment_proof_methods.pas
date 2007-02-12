unit Class_biz_payment_proof_methods;

interface

uses
  Class_db_payment_proof_methods;

type
  TClass_biz_payment_proof_methods = class
  private
    db_payment_proof_methods: TClass_db_payment_proof_methods;
  public
    constructor Create;
    procedure BindDropDownList(target: system.object);
  end;

implementation

constructor TClass_biz_payment_proof_methods.Create;
begin
  inherited Create;
  // TODO: Add any constructor code here
  db_payment_proof_methods := TClass_db_payment_proof_methods.Create;
end;

procedure TClass_biz_payment_proof_methods.BindDropDownList(target: system.object);
begin
  db_payment_proof_methods.BindDropDownList(target);
end;

end.
