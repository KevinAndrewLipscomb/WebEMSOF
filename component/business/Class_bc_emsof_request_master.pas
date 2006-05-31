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
    function TallyByStatus: Class_dalc_emsof_request_master.tally_by_status_type;
  end;

implementation

constructor TClass_bc_emsof_request_master.Create;
begin
  inherited Create;
  // TODO: Add any constructor code here
end;

function TClass_bc_emsof_request_master.TallyByStatus: Class_dalc_emsof_request_master.tally_by_status_type;
begin
  TallyByStatus := TClass_dalc_emsof_request_master.Create.TallyByStatus;
end;

end.
