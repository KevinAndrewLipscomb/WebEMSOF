unit Class_db_match_level;

interface

uses
  Class_db,
  Class_db_trail;

type
  TClass_db_match_level = class(TClass_db)
  private
    db_trail: TClass_db_trail;
  public
    constructor Create;
    function Bind
      (
      partial_name: string;
      target: system.object
      )
      : boolean;
    procedure Delete(name: string);
    function Get
      (
      name: string;
      out factor: decimal
      )
      : boolean;
    procedure &Set
      (
      name: string;
      factor: decimal
      );
  end;

implementation

uses
  mysql.data.mysqlclient,
  system.web.ui.webcontrols;

constructor TClass_db_match_level.Create;
begin
  inherited Create;
  // TODO: Add any constructor code here
  db_trail := TClass_db_trail.Create;
end;

function TClass_db_match_level.Bind
  (
  partial_name: string;
  target: system.object
  )
  : boolean;
var
  dr: mysqldatareader;
begin
  self.Open;
  ListControl(target).items.Clear;
  //
  dr := mysqlcommand.Create
    (
    'SELECT name FROM match_level WHERE name like "' + partial_name + '%" order by name',
    connection
    )
    .ExecuteReader;
  while dr.Read do begin
    ListControl(target).Items.Add
      (listitem.Create(dr['name'].tostring,dr['name'].tostring));
  end;
  dr.Close;
  self.Close;
  Bind := ListControl(target).items.count > 0;
end;

procedure TClass_db_match_level.Delete(name: string);
begin
  self.Open;
  mysqlcommand.Create(db_trail.Saved('delete from match_level where name = ' + name),connection).ExecuteNonquery;
  self.Close;
end;

function TClass_db_match_level.Get
  (
      name: string;
      out factor: decimal
  )
  : boolean;
var
  dr: mysqldatareader;
begin
  Get := FALSE;
  self.Open;
  dr := mysqlcommand.Create('select * from match_level where name = "' + name + '"',connection).ExecuteReader;
  if dr.Read then begin
    //
    name := dr['name'].tostring;
    factor := decimal.Parse(dr['factor'].tostring);
    //
    Get := TRUE;
    //
  end;
  dr.Close;
  self.Close;
end;

procedure TClass_db_match_level.&Set
  (
      name: string;
      factor: decimal
  );
begin
  self.Open;
  mysqlcommand.Create
    (
    db_trail.Saved
      (
      'replace match_level'
      + ' set name = "' + name + '"'
      + ' , factor = ' + factor.tostring
      ),
    connection
    )
    .ExecuteNonquery;
  self.Close;
end;

end.
