unit Class_bc_emsof_request_master;

interface

uses
  Class_dalc_emsof_request_master;

type
  TClass_bc_emsof_request_master = class
  private
    { Private Declarations }
  public
    constructor Create;
    function NumBcInStatus(status: Class_dalc_emsof_request_master.status_type): cardinal;
  end;

implementation

constructor TClass_bc_emsof_request_master.Create;
begin
  inherited Create;
  // TODO: Add any constructor code here
end;

function TClass_bc_emsof_request_master.NumBcInStatus(status: Class_dalc_emsof_request_master.status_type): cardinal;
begin
  NumBcInStatus := TClass_dalc_emsof_request_master.Create.NumRecsInStatus(status);
end;

end.
