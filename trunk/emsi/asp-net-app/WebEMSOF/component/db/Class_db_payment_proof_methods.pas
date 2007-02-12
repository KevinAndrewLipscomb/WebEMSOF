unit Class_db_payment_proof_methods;

interface

uses
  Class_db;

type
  TClass_db_payment_proof_methods = class(TClass_db)
  private
    { Private Declarations }
  public
    constructor Create;
    procedure BindDropDownList(target: system.object);
  end;

implementation

uses
  borland.data.provider,
  system.web.ui.webcontrols;

constructor TClass_db_payment_proof_methods.Create;
begin
  inherited Create;
  // TODO: Add any constructor code here
end;

procedure TClass_db_payment_proof_methods.BindDropDownList(target: system.object);
var
  bdr: bdpdatareader;
begin
  self.Open;
  DropDownList(target).Items.Clear;
  DropDownList(target).Items.Add(listitem.Create('-- Select --',''));
  //
  bdr := Borland.Data.Provider.BdpCommand.Create
    ('SELECT code,description FROM payment_proof_method_code_description_map ORDER BY description',connection).ExecuteReader;
  while bdr.Read do begin
    DropDownList(target).Items.Add(listitem.Create(bdr['description'].tostring,bdr['code'].tostring));
  end;
  bdr.Close;
  self.Close;
end;

end.
