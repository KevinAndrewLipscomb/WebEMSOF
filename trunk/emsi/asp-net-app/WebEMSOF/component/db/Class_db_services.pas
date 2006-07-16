unit Class_db_services;

interface

uses
  borland.data.provider,
  Class_db,
  system.web.ui.webcontrols;

type
  TClass_db_services = class(TClass_db)
  private
    { Private Declarations }
  public
    constructor Create;
    procedure BindDropDownList
      (
      county_user_id: string;
      target: system.object;
      be_filtered: boolean = TRUE
      );
  end;

implementation

constructor TClass_db_services.Create;
begin
  inherited Create;
  // TODO: Add any constructor code here
end;

procedure TClass_db_services.BindDropDownList
  (
  county_user_id: string;
  target: system.object;
  be_filtered: boolean = TRUE
  );
var
  bdr: borland.data.provider.bdpdatareader;
  cmdText: string;
begin
  connection.Open;
  DropDownList(target).Items.Clear;
  DropDownList(target).Items.Add(listitem.Create('-- Select --','0'));
  //
  cmdText := 'SELECT id,name FROM service_user JOIN service using (id) WHERE be_active = TRUE ';
  if be_filtered then begin
    cmdText := cmdText + 'and county_code = ' + county_user_id + ' ';
  end;
  cmdText := cmdText + 'ORDER BY name';
  //
  bdr := Borland.Data.Provider.BdpCommand.Create(cmdText,connection).ExecuteReader;
  while bdr.Read do begin
    DropDownList(target).Items.Add(listitem.Create(bdr['name'].tostring,bdr['id'].ToString));
  end;
  connection.Close;
end;

end.
