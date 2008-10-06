unit Class_db_counties;

interface

uses
  kix,
  mysql.data.mysqlclient,
  Class_db,
  system.web.ui.webcontrols;

type
  TClass_db_counties = class(TClass_db)
  strict private
    { Private Declarations }
  public
    constructor Create;
  published
    procedure BindDirectToListControl
      (
      target: system.object;
      unselected_literal: string = '-- County --';
      selected_value: string = EMPTY
      );
    function NameOf(code: string): string;
  end;

implementation

constructor TClass_db_counties.Create;
begin
  inherited Create;
  // TODO: Add any constructor code here
end;

procedure TClass_db_counties.BindDirectToListControl
  (
  target: system.object;
  unselected_literal: string = '-- County --';
  selected_value: string = EMPTY
  );
var
  dr: mysqldatareader;
begin
  //
  ListControl(target).items.Clear;
  if unselected_literal <> EMPTY then begin
    ListControl(target).items.Add(listitem.Create(unselected_literal,EMPTY));
  end;
  //
  self.Open;
  dr := mysqlcommand.Create('SELECT code,name FROM county_code_name_map order by name',connection).ExecuteReader;
  while dr.Read do begin
    ListControl(target).items.Add(listitem.Create(dr['name'].tostring,dr['code'].tostring));
  end;
  dr.Close;
  self.Close;
  //
  if selected_value <> EMPTY then begin
    ListControl(target).selectedvalue := selected_value;
  end;
  //
end;

function TClass_db_counties.NameOf(code: string): string;
begin
  self.Open;
  NameOf := mysqlcommand.Create('select name from county_code_name_map where code = ' + code,connection).ExecuteScalar.tostring;
  self.Close;
end;

end.
