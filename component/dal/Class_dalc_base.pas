unit Class_dalc_base;

interface

uses
  borland.data.provider,
  system.configuration,
  system.data;

type
  TClass_dalc_base = class
  private
    { Private Declarations }
  protected
    connection: borland.data.provider.bdpconnection;
  public
    constructor Create;
    procedure Close;
    procedure Open;
  end;

implementation

constructor TClass_dalc_base.Create;
begin
  inherited Create;
  // TODO: Add any constructor code here
  connection := borland.data.provider.bdpconnection.Create;
  connection.ConnectionOptions := 'transaction isolation=ReadCommitted';
  connection.ConnectionString := ConfigurationSettings.AppSettings['bdp_connection_string'];
end;

procedure TClass_dalc_base.Close;
begin
  connection.Close;
end;

procedure TClass_dalc_base.Open;
begin
  if connection.State <> connectionstate.OPEN then begin
    connection.Open;
  end;
end;

end.
