unit Class_db_charter_kinds;

interface

uses
  Class_db,
  Class_db_trail,
  kix;

type
  TClass_db_charter_kinds = class(TClass_db)
  private
    db_trail: TClass_db_trail;
  public
    constructor Create;
    function Bind
      (
      partial_spec: string;
      target: system.object
      )
      : boolean;
    procedure BindDirectToListControl
      (
      target: system.object;
      unselected_literal: string = '-- charter_kind --';
      selected_value: string = EMPTY
      );
    function Delete(id: string): boolean;
    function Get
      (
      id: string;
      out description: string
      )
      : boolean;
    procedure &Set
      (
      id: string;
      description: string
      );
  end;

implementation

uses
  mysql.data.mysqlclient,
  system.web.ui.webcontrols;

constructor TClass_db_charter_kinds.Create;
begin
  inherited Create;
  // TODO: Add any constructor code here
  db_trail := TClass_db_trail.Create;
end;

function TClass_db_charter_kinds.Bind
  (
  partial_spec: string;
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
    'SELECT id'
    + ' , description'
    + ' FROM charter_kind'
    + ' WHERE description like "%' + partial_spec + '%"'
    + ' order by id',
    connection
    )
    .ExecuteReader;
  while dr.Read do begin
    ListControl(target).Items.Add
      (listitem.Create(dr['description'].tostring,dr['id'].tostring));
  end;
  dr.Close;
  self.Close;
  Bind := ListControl(target).items.count > 0;
end;

procedure TClass_db_charter_kinds.BindDirectToListControl
  (
  target: system.object;
  unselected_literal: string = '-- charter_kind --';
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
  dr := mysqlcommand.Create('SELECT id,description FROM charter_kind where description <> "(none specified)" order by id',connection).ExecuteReader;
  while dr.Read do begin
    ListControl(target).items.Add(listitem.Create(dr['description'].tostring,dr['id'].tostring));
  end;
  dr.Close;
  self.Close;
  //
  if selected_value <> EMPTY then begin
    ListControl(target).selectedvalue := selected_value;
  end;
  //
end;

function TClass_db_charter_kinds.Delete(id: string): boolean;
begin
  //
  Delete := TRUE;
  //
  self.Open;
  try
    mysqlcommand.Create(db_trail.Saved('delete from charter_kind where id = ' + id),connection).ExecuteNonquery;
  except on e: exception do
    if e.message.StartsWith('Cannot delete or update a parent row: a foreign key constraint fails',TRUE,nil) then begin
      Delete := FALSE;
    end else begin
      raise e;
    end;
  end;
  self.Close;
end;

function TClass_db_charter_kinds.Get
  (
  id: string;
  out description: string
  )
  : boolean;
var
  dr: mysqldatareader;
begin
  Get := FALSE;
  self.Open;
  dr := mysqlcommand.Create('select description from charter_kind where id = "' + id + '"',connection).ExecuteReader;
  if dr.Read then begin
    //
    description := dr['description'].tostring;
    //
    Get := TRUE;
    //
  end;
  dr.Close;
  self.Close;
end;

procedure TClass_db_charter_kinds.&Set
  (
  id: string;
  description: string
  );
var
  childless_field_assignments_clause: string;
begin
  //
  childless_field_assignments_clause := 'description = "' + description + '"';
  //
  self.Open;
  mysqlcommand.Create
    (
    db_trail.Saved
      (
      'insert charter_kind'
      + ' set id = NULLIF("' + id + '","")'
      + ' , ' + childless_field_assignments_clause
      + ' on duplicate key update '
      + childless_field_assignments_clause
      ),
    connection
    )
    .ExecuteNonquery;
  self.Close;
  //
end;

end.
