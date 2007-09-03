unit Class_biz_match_level;

interface

uses
  Class_db_match_level;

const
  ID = '$Id';

type
  nominal_type = (STANDARD,RURAL,DISTRESSED);

type
  TClass_biz_match_level = class
  private
    db_match_level: TClass_db_match_level;
  public
    constructor Create;
    function Bind
      (
      partial_username: string;
      target: system.object
      )
      : boolean;
    procedure Delete(username: string);
    function EnumOfId(id: cardinal): nominal_type;
    function Get
      (
      name: string;
      out factor: decimal
      )
      : boolean;
    procedure &Set
      (
      name: string;
      factor: decimal
      );
  end;

implementation

constructor TClass_biz_match_level.Create;
begin
  inherited Create;
  // TODO: Add any constructor code here
  db_match_level := TClass_db_match_level.Create;
end;

function TClass_biz_match_level.Bind
  (
  partial_username: string;
  target: system.object
  )
  : boolean;
begin
  Bind := db_match_level.Bind(partial_username,target);
end;

procedure TClass_biz_match_level.Delete(username: string);
begin
  db_match_level.Delete(username);
end;

function TClass_biz_match_level.EnumOfId(id: cardinal): nominal_type;
begin
  EnumOfId := nominal_type(id - 1);
end;

function TClass_biz_match_level.Get
  (
      name: string;
      out factor: decimal
  )
  : boolean;
begin
  //
  Get := db_match_level.Get
    (
    name,
    factor
    );
  //
end;

procedure TClass_biz_match_level.&Set
  (
      name: string;
      factor: decimal
  );
begin
  //
  db_match_level.&Set
    (
    name,
    factor
    );
  //
end;

end.
