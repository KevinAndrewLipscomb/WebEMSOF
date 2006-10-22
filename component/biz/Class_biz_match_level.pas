unit Class_biz_match_level;

interface

const
  ID = '$Id';

type
  nominal_type = (STANDARD,RURAL,DISTRESSED);

type
  TClass_biz_match_level = class
  private
    { Private Declarations }
  public
    constructor Create;
    function EnumOfId(id: cardinal): nominal_type;
  end;

implementation

constructor TClass_biz_match_level.Create;
begin
  inherited Create;
  // TODO: Add any constructor code here
end;

function TClass_biz_match_level.EnumOfId(id: cardinal): nominal_type;
begin
  EnumOfId := nominal_type(id - 1);
end;

end.
