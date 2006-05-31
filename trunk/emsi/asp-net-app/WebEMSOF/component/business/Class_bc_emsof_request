unit Class_bc_emsof_request_master;

interface

uses
  Class_dalc_emsof_request;

type
  TClass_bc_emsof_request_master = class
  private
  public
    constructor Create;
    function TallyOfStatus(status: Class_dalc_emsof_request.status_type): string;
  end;

implementation

var
  be_valid_tally_by_status: boolean;
  tally_by_status: tally_by_status_type;

procedure DoTallyByStatus;
begin
  if not be_valid_tally_by_status then begin
    tally_by_status := TClass_dalc_emsof_request.Create.TallyByStatus;
    be_valid_tally_by_status := TRUE;
  end;
end;

constructor TClass_bc_emsof_request_master.Create;
begin
  inherited Create;
  // TODO: Add any constructor code here
  be_valid_tally_by_status := FALSE;
end;

function TClass_bc_emsof_request_master.TallyOfStatus(status: Class_dalc_emsof_request.status_type): string;
begin
  if not be_valid_tally_by_status then begin
    DoTallyByStatus;
  end;
  TallyOfStatus := tally_by_status[status].tostring;
end;

end.
