unit Class_db_accounts;

interface

uses
  borland.data.provider,
  Class_db;

type
  TClass_db_accounts = class(TClass_db)
  private
    { Private Declarations }
  public
    constructor Create;
    function EmailAddressByKindId
      (
      user_kind: string;
      user_id: string
      )
      : string;
    function EmailTargetByRole(role: string): string;
  end;

implementation

constructor TClass_db_accounts.Create;
begin
  inherited Create;
  // TODO: Add any constructor code here
end;

function TClass_db_accounts.EmailAddressByKindId
  (
  user_kind: string;
  user_id: string
  )
  : string;
begin
  connection.Open;
  EmailAddressByKindId := borland.data.provider.bdpcommand.Create
    (
    'select password_reset_email_address from ' + user_kind + '_user where id = ' + user_id,
    connection
    )
    .ExecuteScalar.tostring;
  connection.Close;
end;

function TClass_db_accounts.EmailTargetByRole
  (
  role: string
  )
  : string;
var
  bdr: borland.data.provider.bdpdatareader;
  email_target: string;
begin
  email_target := system.string.EMPTY;
  connection.Open;
  bdr := borland.data.provider.bdpcommand.Create
    (
    'select password_reset_email_address'
    + ' from regional_staffer_user'
    +   ' join regional_staffer_role on (regional_staffer_role.user_id=regional_staffer_user.id)'
    +   ' join regional_staffer_group on (regional_staffer_group.id=regional_staffer_role.group_id)'
    + ' where regional_staffer_group.name = "' + role + '"',
    connection
    )
    .ExecuteReader;
  while bdr.Read do begin
    email_target := email_target + bdr['password_reset_email_address'].tostring + ',';
  end;
  connection.Close;
  EmailTargetByRole := email_target.Substring(0,email_target.Length - 1);
end;

end.
