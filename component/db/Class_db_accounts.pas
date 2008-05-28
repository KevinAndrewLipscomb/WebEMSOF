unit Class_db_accounts;

interface

uses
  mysql.data.mysqlclient,
  Class_db,
  Class_db_trail;

type
  TClass_db_accounts = class(TClass_db)
  private
    db_trail: TClass_db_trail;
  public
    constructor Create;
    procedure BindCounties(target: system.object);
    procedure BindRegionalStaffers(target: system.object);
    procedure BindServices(target: system.object);
    function EmailAddressByKindId
      (
      user_kind: string;
      user_id: string
      )
      : string;
    function EmailTargetByRole(role: string): string;
    function Exists
      (
      user_kind: string;
      user_id: string;
      encoded_password: string
      )
      : boolean;
    procedure SetTemporaryPassword
      (
      user_kind: string;
      user_id: string;
      encoded_password: string
      );
  end;

implementation

uses
  kix,
  system.web.ui.webcontrols;

constructor TClass_db_accounts.Create;
begin
  inherited Create;
  // TODO: Add any constructor code here
  db_trail := TClass_db_trail.Create;
end;

procedure TClass_db_accounts.BindCounties(target: system.object);
var
  dr: mysqldatareader;
begin
  self.Open;
  DropDownList(target).items.Clear;
  DropDownList(target).items.Add(listitem.Create('-- Select --','0'));
  dr := mysqlcommand.Create
    (
    'SELECT id,name '
    + 'FROM county_user JOIN county_code_name_map on (county_code_name_map.code = county_user.id) '
    + 'WHERE be_active = TRUE '
    + 'ORDER BY name',
    connection
    )
    .ExecuteReader;
  while dr.Read do begin
    DropDownList(target).Items.Add(listitem.Create(dr['name'].tostring,'county_' + dr['id'].ToString));
  end;
  dr.Close;
  self.Close;
end;

procedure TClass_db_accounts.BindRegionalStaffers(target: system.object);
var
  dr: mysqldatareader;
begin
  self.Open;
  DropDownList(target).items.Clear;
  DropDownList(target).items.Add(listitem.Create('-- Select --','0'));
  dr := mysqlcommand.Create
    (
    'SELECT id,last_name,first_name '
    + 'FROM regional_staffer_user JOIN regional_staffer using (id) '
    + 'WHERE be_active = TRUE '
    + 'ORDER BY last_name,first_name',
    connection
    )
    .ExecuteReader;
  while dr.Read do begin
    DropDownList(target).Items.Add
      (listitem.Create(dr['last_name'].tostring + COMMA_SPACE + dr['first_name'].tostring,'regional_staffer_' + dr['id'].ToString));
  end;
  dr.Close;
  self.Close;
end;

procedure TClass_db_accounts.BindServices(target: system.object);
var
  dr: mysqldatareader;
begin
  self.Open;
  DropDownList(target).items.Clear;
  DropDownList(target).items.Add(listitem.Create('-- Select --','0'));
  dr := mysqlcommand.Create
    (
    'SELECT id,name FROM service_user JOIN service using (id) WHERE be_active = TRUE ORDER BY name',
    connection
    )
    .ExecuteReader;
  while dr.Read do begin
    DropDownList(target).Items.Add(listitem.Create(dr['name'].tostring,'service_' + dr['id'].ToString));
  end;
  dr.Close;
  self.Close;
end;

function TClass_db_accounts.EmailAddressByKindId
  (
  user_kind: string;
  user_id: string
  )
  : string;
begin
  self.Open;
  EmailAddressByKindId := mysqlcommand.Create
    (
    'select password_reset_email_address from ' + user_kind + '_user where id = ' + user_id,
    connection
    )
    .ExecuteScalar.tostring;
  self.Close;
end;

function TClass_db_accounts.EmailTargetByRole
  (
  role: string
  )
  : string;
var
  dr: mysqldatareader;
  email_target: string;
begin
  email_target := EMPTY;
  self.Open;
  dr := mysqlcommand.Create
    (
    'select password_reset_email_address'
    + ' from regional_staffer_user'
    +   ' join regional_staffer_role on (regional_staffer_role.user_id=regional_staffer_user.id)'
    +   ' join regional_staffer_group on (regional_staffer_group.id=regional_staffer_role.group_id)'
    + ' where regional_staffer_group.name = "' + role + '"',
    connection
    )
    .ExecuteReader;
  while dr.Read do begin
    email_target := email_target + dr['password_reset_email_address'].tostring + COMMA;
  end;
  dr.Close;
  self.Close;
  EmailTargetByRole := email_target.Substring(0,email_target.Length - 1);
end;

function TClass_db_accounts.Exists
  (
  user_kind: string;
  user_id: string;
  encoded_password: string
  )
  : boolean;
begin
  self.Open;
  Exists := nil <> mysqlcommand.Create
    (
    'SELECT 1 FROM ' + user_kind + '_user'
    +  ' where id = ' + user_id
    +     ' and encoded_password = "' + encoded_password + '"',
    connection
    )
    .ExecuteScalar;
  self.Close;
end;

procedure TClass_db_accounts.SetTemporaryPassword
  (
  user_kind: string;
  user_id: string;
  encoded_password: string
  );
begin
  self.Open;
  mysqlcommand.Create
    (
    db_trail.Saved
      (
      'update ' + user_kind + '_user'
      + ' set encoded_password = "' + encoded_password + '",'
      +   ' be_stale_password = TRUE '
      + ' where id = ' + user_id
      ),
    connection
    )
    .ExecuteNonQuery;
  self.Close;
end;

end.
