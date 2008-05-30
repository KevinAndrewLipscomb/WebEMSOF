unit Class_db_fiscal_years;

interface

uses
  mysql.data.mysqlclient,
  Class_db;

type
  TClass_db_fiscal_years = class(TClass_db)
  private
    { Private Declarations }
  public
    constructor Create;
    procedure BindListControl(target: system.object);
    function DesignatorOfCurrent: string;
    function IdOfCurrent: string;
    function IdOfDesignator(designator: string): string;
  end;

implementation

uses
  system.web.ui.webcontrols;

constructor TClass_db_fiscal_years.Create;
begin
  inherited Create;
  // TODO: Add any constructor code here
end;

procedure TClass_db_fiscal_years.BindListControl(target: system.object);
var
  dr: mysqldatareader;
begin
  self.Open;
  ListControl(target).items.Clear;
  dr := mysqlcommand.Create('select id,designator from fiscal_year order by id desc',connection).ExecuteReader;
  while dr.Read do begin
    ListControl(target).Items.Add(listitem.Create(dr['designator'].tostring,dr['id'].ToString));
  end;
  dr.Close;
  self.Close;
end;

function TClass_db_fiscal_years.DesignatorOfCurrent: string;
begin
  self.Open;
  DesignatorOfCurrent := mysqlcommand.Create('select designator from fiscal_year order by id desc limit 1',connection).ExecuteScalar.tostring;
  self.Close;
end;

function TClass_db_fiscal_years.IdOfCurrent: string;
begin
  self.Open;
  IdOfCurrent := mysqlcommand.Create('select max(id) from fiscal_year',connection).ExecuteScalar.tostring;
  self.Close;
end;

function TClass_db_fiscal_years.IdOfDesignator(designator: string): string;
begin
  self.Open;
  IdOfDesignator := mysqlcommand.Create
    ('select id from fiscal_year where designator = "' + designator + '"',connection).ExecuteScalar.tostring;
  self.Close;
end;

end.
