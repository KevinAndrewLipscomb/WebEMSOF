unit Class_db;

interface

uses
  borland.data.provider,
  system.configuration,
  system.data;

const
  ID = '$Id$';

type
  TClass_db = class
  private
    { Private Declarations }
  protected
  public
    connection: borland.data.provider.bdpconnection;
      //
      // The connection member should be protected rather than public once all db operations in WebEMSOF are performed via
      // descendants of this class.
      //
    constructor Create;
    procedure Close;
    procedure Open;
  end;

implementation

constructor TClass_db.Create;
begin
  inherited Create;
  // TODO: Add any constructor code here
  connection := borland.data.provider.bdpconnection.Create;
  connection.ConnectionOptions := 'transaction isolation=ReadCommitted';
  connection.ConnectionString := ConfigurationSettings.AppSettings['bdp_connection_string'];
end;

procedure TClass_db.Close;
begin
  connection.Close;
end;

procedure TClass_db.Open;
begin
  if connection.State <> connectionstate.OPEN then begin
    connection.Open;
  end;
end;

end.
