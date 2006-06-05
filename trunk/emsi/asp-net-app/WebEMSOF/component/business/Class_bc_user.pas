unit Class_bc_user;

interface

uses
  appcommon,
  Class_dalc_user;

const
  ID = '$Id$';

type
  TClass_bc_user = class
  private
    { Private Declarations }
  public
    constructor Create;
    function RolesOf(id: string): appcommon.string_array;
  end;

implementation

const
  ID_THAT_HAS_ROLES_TOKEN = 'regional-staffer-';

constructor TClass_bc_user.Create;
begin
  inherited Create;
  // TODO: Add any constructor code here
end;

function TClass_bc_user.RolesOf(id: string): appcommon.string_array;
begin
  if id.StartsWith(ID_THAT_HAS_ROLES_TOKEN) then begin
    RolesOf := Class_dalc_user.TClass_dalc_user.Create.RolesOf
      (
      'regional_staffer_',
      id.Replace(ID_THAT_HAS_ROLES_TOKEN,system.string.EMPTY)
      );
  end;
end;

end.
