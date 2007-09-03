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
  borland.data.provider,
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
  bdr: bdpdatareader;
begin
  self.Open;
  DropDownList(target).items.Clear;
  //
  bdr := bdpcommand.Create
    (
    'SELECT name FROM match_level WHERE name like "' + partial_name + '%" order by name',
    connection
    )
    .ExecuteReader;
  while bdr.Read do begin
    DropDownList(target).Items.Add
      (listitem.Create(bdr['name'].tostring,bdr['name'].tostring));
  end;
  bdr.Close;
  self.Close;
  Bind := DropDownList(target).items.count > 0;
end;

procedure TClass_db_match_level.Delete(name: string);
begin
  self.Open;
  bdpcommand.Create(db_trail.Saved('delete from match_level where name = ' + name),connection).ExecuteNonquery;
  self.Close;
end;

function TClass_db_match_level.Get
  (
      name: string;
      out factor: decimal
  )
  : boolean;
var
  bdr: bdpdatareader;
begin
  Get := FALSE;
  self.Open;
  bdr := bdpcommand.Create('select * from match_level where name = "' + name + '"',connection).ExecuteReader;
  if bdr.Read then begin
    //
    name := bdr['name'].tostring;
    factor := decimal.Parse(bdr['factor'].tostring);
    //
    Get := TRUE;
    //
  end;
  bdr.Close;
  self.Close;
end;

procedure TClass_db_match_level.&Set
  (
      name: string;
      factor: decimal
  );
begin
  self.Open;
  bdpcommand.Create
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
