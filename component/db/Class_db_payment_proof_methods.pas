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
    procedure BindListControl(target: system.object);
  end;

implementation

uses
  mysql.data.mysqlclient,
  system.web.ui.webcontrols;

constructor TClass_db_payment_proof_methods.Create;
begin
  inherited Create;
  // TODO: Add any constructor code here
end;

procedure TClass_db_payment_proof_methods.BindListControl(target: system.object);
var
  dr: mysqldatareader;
begin
  self.Open;
  ListControl(target).Items.Clear;
  ListControl(target).Items.Add(listitem.Create('-- Select --',''));
  //
  dr := mysqlcommand.Create
    ('SELECT code,description FROM payment_proof_method_code_description_map ORDER BY description',connection).ExecuteReader;
  while dr.Read do begin
    ListControl(target).Items.Add(listitem.Create(dr['description'].tostring,dr['code'].tostring));
  end;
  dr.Close;
  self.Close;
end;

end.
