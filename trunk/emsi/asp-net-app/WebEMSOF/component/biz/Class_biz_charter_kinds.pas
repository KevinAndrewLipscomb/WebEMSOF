unit Class_biz_charter_kinds;

interface

uses
  Class_db_charter_kinds,
  kix;

type
  TClass_biz_charter_kinds = class
  private
    db_charter_kinds: TClass_db_charter_kinds;
  public
    constructor Create;
    function Bind
      (
      partial_code: string;
      target: system.object
      )
      : boolean;
    procedure BindDirectToListControl
      (
      target: system.object;
      unselected_literal: string = '-- charter_kind --';
      selected_value: string = EMPTY
      );
    function Delete(code: string): boolean;
    function Get
      (
      code: string;
      out description: string
      )
      : boolean;
    procedure &Set
      (
      code: string;
      description: string
      );
  end;

implementation

constructor TClass_biz_charter_kinds.Create;
begin
  inherited Create;
  // TODO: Add any constructor code here
  db_charter_kinds := TClass_db_charter_kinds.Create;
end;

function TClass_biz_charter_kinds.Bind
  (
  partial_code: string;
  target: system.object
  )
  : boolean;
begin
  Bind := db_charter_kinds.Bind(partial_code,target);
end;

procedure TClass_biz_charter_kinds.BindDirectToListControl
  (
  target: system.object;
  unselected_literal: string = '-- charter_kind --';
  selected_value: string = EMPTY
  );
begin
  db_charter_kinds.BindDirectToListControl(target,unselected_literal,selected_value);
end;

function TClass_biz_charter_kinds.Delete(code: string): boolean;
begin
  Delete := db_charter_kinds.Delete(code);
end;

function TClass_biz_charter_kinds.Get
  (
      code: string;
      out description: string
  )
  : boolean;
begin
  //
  Get := db_charter_kinds.Get
    (
    code,
    description
    );
  //
end;

procedure TClass_biz_charter_kinds.&Set
  (
      code: string;
      description: string
  );
begin
  //
  db_charter_kinds.&Set
    (
    code,
    description
    );
  //
end;

end.
