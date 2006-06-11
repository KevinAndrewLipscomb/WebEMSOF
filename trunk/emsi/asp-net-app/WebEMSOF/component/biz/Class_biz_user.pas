unit Class_biz_user;

interface

uses
  appcommon,
  Class_db_user,
  system.web;

const
  ID = '$Id$';

type
  TClass_biz_user = class
  private
    { Private Declarations }
  public
    constructor Create;
    function Kind: string;
    function IdNum: string;
    function Roles: appcommon.string_array;
  end;

implementation

const
  KIND_THAT_HAS_ROLES = 'regional_staffer';

constructor TClass_biz_user.Create;
begin
  inherited Create;
  // TODO: Add any constructor code here
end;

function TClass_biz_user.Kind: string;
var
  name: string;
begin
  name := httpcontext.current.user.identity.name;
  Kind := name.Substring(0,name.LastIndexOf('_'));
end;

function TClass_biz_user.IdNum: string;
var
  name: string;
begin
  name := httpcontext.current.user.identity.name;
  IdNum := name.Substring(name.LastIndexOf('_') + 1);
end;

function TClass_biz_user.Roles: appcommon.string_array;
var
  name: string;
begin
  name := httpcontext.current.user.identity.name;
  if Kind = KIND_THAT_HAS_ROLES then begin
    Roles := Class_db_user.TClass_db_user.Create.RolesOf('regional_staffer_',IdNum);
  end;
end;

end.
