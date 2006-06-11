unit Class_dalc_user;

interface

uses
  appcommon,
  borland.data.provider,
  Class_dalc_base,
  system.collections;

const
  ID = '$Id$';

type
  TClass_dalc_user = class(Class_dalc_base.TClass_dalc_base)
  private
    { Private Declarations }
  public
    constructor Create;
    function RolesOf
      (
      target_user_table: string;
      id: string
      )
      : appcommon.string_array;
  end;

implementation

constructor TClass_dalc_user.Create;
begin
  inherited Create;
  // TODO: Add any constructor code here
end;

function TClass_dalc_user.RolesOf
  (
  target_user_table: string;
  id: string
  )
  : appcommon.string_array;
var
  bdr: borland.data.provider.bdpdatareader;
  roles_of: appcommon.string_array;
  roles_of_len: cardinal;
begin
  connection.Open;
  bdr := borland.data.provider.bdpcommand.Create
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
  while bdr.Read do begin
    roles_of_len := roles_of_len + 1;
    SetLength(roles_of,roles_of_len);
    roles_of[roles_of_len - 1] := bdr['group_name'].tostring;
  end;
  connection.Close;
  RolesOf := roles_of;
end;

end.
