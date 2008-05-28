unit Class_db_services;

interface

uses
  mysql.data.mysqlclient,
  Class_db,
  Class_db_trail,
  system.web.ui.webcontrols;

type
  TClass_db_services = class(TClass_db)
  private
    db_trail: TClass_db_trail;
  public
    constructor Create;
    function AffiliateNumOfId(id: string): string;
    procedure BindDropDownList
      (
      county_user_id: string;
      target: system.object;
      be_unfiltered: boolean = FALSE
      );
    procedure GetProfile
      (
      affiliate_num: string;
      out name: string;
      out be_qrs: boolean;
      out be_bls_amb: boolean;
      out be_als_amb: boolean;
      out be_als_squad: boolean;
      out be_air_amb: boolean;
      out be_rescue: boolean;
      out address_line_1: string;
      out address_line_2: string;
      out city: string;
      out zip_code: string;
      out federal_tax_id_num: string;
      out contact_person_name: string;
      out contact_person_phone_num: string;
      out be_valid_profile: boolean
      );
    function NameOf(service_id: string): string;
    procedure SetProfile
      (
      affiliate_num: string;
      name: string;
      be_qrs: string;
      be_bls_amb: string;
      be_als_amb: string;
      be_als_squad: string;
      be_air_amb: string;
      be_rescue: string;
      address_line_1: string;
      address_line_2: string;
      city: string;
      zip_code: string;
      federal_tax_id_num: string;
      contact_person_name: string;
      contact_person_phone_num: string
      );
  end;

implementation

uses
  kix;

constructor TClass_db_services.Create;
begin
  inherited Create;
  // TODO: Add any constructor code here
  db_trail := TClass_db_trail.Create;
end;

function TClass_db_services.AffiliateNumOfId(id: string): string;
begin
  self.Open;
  AffiliateNumOfId := mysqlcommand.Create
    (
    'SELECT affiliate_num FROM service WHERE id = ' + id,
    connection
    )
    .ExecuteScalar.tostring;
  self.Close;
end;

procedure TClass_db_services.BindDropDownList
  (
  county_user_id: string;
  target: system.object;
  be_unfiltered: boolean = FALSE
  );
var
  dr: mysqldatareader;
  cmdText: string;
begin
  self.Open;
  DropDownList(target).Items.Clear;
  DropDownList(target).Items.Add(listitem.Create('-- Select --','0'));
  //
  cmdText := 'SELECT id,name FROM service_user JOIN service using (id) WHERE be_active = TRUE ';
  if not be_unfiltered then begin
    cmdText := cmdText + 'and county_code = ' + county_user_id + SPACE;
  end;
  cmdText := cmdText + 'ORDER BY name';
  //
  dr := mysqlcommand.Create(cmdText,connection).ExecuteReader;
  while dr.Read do begin
    DropDownList(target).Items.Add(listitem.Create(dr['name'].tostring,dr['id'].ToString));
  end;
  dr.Close;
  self.Close;
end;

procedure TClass_db_services.GetProfile
  (
  affiliate_num: string;
  out name: string;
  out be_qrs: boolean;
  out be_bls_amb: boolean;
  out be_als_amb: boolean;
  out be_als_squad: boolean;
  out be_air_amb: boolean;
  out be_rescue: boolean;
  out address_line_1: string;
  out address_line_2: string;
  out city: string;
  out zip_code: string;
  out federal_tax_id_num: string;
  out contact_person_name: string;
  out contact_person_phone_num: string;
  out be_valid_profile: boolean
  );
var
  dr: mysqldatareader;
begin
  self.Open;
  dr := mysqlcommand.Create
    (
    'SELECT name,'
    + 'be_qrs,'
    + 'be_bls_amb,'
    + 'be_als_amb,'
    + 'be_als_squad,'
    + 'be_air_amb,'
    + 'be_rescue,'
    + 'address_line_1,'
    + 'address_line_2,'
    + 'city,'
    + 'zip_code,'
    + 'federal_tax_id_num,'
    + 'contact_person_name,'
    + 'contact_person_phone_num, '
    + 'be_valid_profile '
    + 'FROM service '
    + 'WHERE affiliate_num = "' + affiliate_num + '"',
    connection
    )
    .ExecuteReader;
  dr.Read;
  name := dr['name'].tostring;
  be_qrs := (dr['be_qrs'].tostring = '1');
  be_bls_amb := (dr['be_bls_amb'].tostring = '1');
  be_als_amb := (dr['be_als_amb'].tostring = '1');
  be_als_squad := (dr['be_als_squad'].tostring = '1');
  be_air_amb := (dr['be_air_amb'].tostring = '1');
  be_rescue := (dr['be_rescue'].tostring = '1');
  address_line_1 := dr['address_line_1'].tostring;
  address_line_2 := dr['address_line_2'].tostring;
  city := dr['city'].tostring;
  zip_code := dr['zip_code'].tostring;
  federal_tax_id_num := dr['federal_tax_id_num'].tostring;
  contact_person_name := dr['contact_person_name'].tostring;
  contact_person_phone_num := dr['contact_person_phone_num'].tostring;
  be_valid_profile := (dr['be_valid_profile'].tostring = '1');
  dr.Close;
  self.Close;
end;

function TClass_db_services.NameOf(service_id: string): string;
begin
  self.Open;
  NameOf := mysqlcommand.Create('select name from service where id = ' + service_id,connection).ExecuteScalar.tostring;
  self.Close;
end;

procedure TClass_db_services.SetProfile
  (
  affiliate_num: string;
  name: string;
  be_qrs: string;
  be_bls_amb: string;
  be_als_amb: string;
  be_als_squad: string;
  be_air_amb: string;
  be_rescue: string;
  address_line_1: string;
  address_line_2: string;
  city: string;
  zip_code: string;
  federal_tax_id_num: string;
  contact_person_name: string;
  contact_person_phone_num: string
  );
begin
  self.Open;
  mysqlcommand.Create
    (
    db_trail.Saved
      (
      'UPDATE service '
      + 'SET name = "' + name + '",'
      +   'be_qrs = ' + be_qrs + COMMA
      +   'be_bls_amb = ' + be_bls_amb + COMMA
      +   'be_als_amb = ' + be_als_amb + COMMA
      +   'be_als_squad = ' + be_als_squad + COMMA
      +   'be_air_amb = ' + be_air_amb + COMMA
      +   'be_rescue = ' + be_rescue + COMMA
      +   'address_line_1 = "' + address_line_1 + '",'
      +   'address_line_2 = "' + address_line_2 + '",'
      +   'city = "' + city + '",'
      +   'zip_code = "' + zip_code + '",'
      +   'federal_tax_id_num = "' + federal_tax_id_num + '",'
      +   'contact_person_name = "' + contact_person_name + '",'
      +   'contact_person_phone_num = "' + contact_person_phone_num + '",'
      +   'be_valid_profile = TRUE '
      + 'WHERE affiliate_num = "' + affiliate_num + '"'
      ),
    connection
    )
    .ExecuteNonQuery;
  self.Close;
end;

end.
