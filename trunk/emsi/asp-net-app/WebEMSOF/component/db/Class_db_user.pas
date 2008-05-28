unit Class_db_user;

interface

uses
  kix,
  mysql.data.mysqlclient,
  Class_db,
  system.collections;

const
  ID = '$Id$';

type
  TClass_db_user = class(Class_db.TClass_db)
  private
    { Private Declarations }
  public
    constructor Create;
    function RolesOf
      (
      target_user_table: string;
      id: string
      )
      : kix.string_array;
  end;

implementation

constructor TClass_db_user.Create;
begin
  inherited Create;
  // TODO: Add any constructor code here
end;

function TClass_db_user.RolesOf
  (
  target_user_table: string;
  id: string
  )
  : kix.string_array;
var
  dr: mysqldatareader;
  roles_of: kix.string_array;
  roles_of_len: cardinal;
begin
  self.Open;
  dr := mysqlcommand.Create
    (
    'select ' + target_user_table + 'group.name as group_name'
    + ' from ' + target_user_table + 'role'
    +   ' join ' + target_user_table + 'group on (' + target_user_table + 'group.id=' + target_user_table + 'role.group_id)'
    +   ' join ' + target_user_table + 'user on (' + target_user_table + 'user.id=' + target_user_table + 'role.user_id)'
    + ' where ' + target_user_table + 'user.id = ' + id,
    connection
    )
    .ExecuteReader;
  roles_of_len := 0;
  while dr.Read do begin
    roles_of_len := roles_of_len + 1;
    SetLength(roles_of,roles_of_len);
    roles_of[roles_of_len - 1] := dr['group_name'].tostring;
  end;
  dr.Close;
  self.Close;
  RolesOf := roles_of;
end;

end.
