unit Class_biz_counties;

interface

uses
  Class_db_counties,
  kix;

type
  TClass_biz_counties = class
  strict private
    db_counties: TClass_db_counties;
  public
    constructor Create;
  published
    procedure BindDirectToListControl
      (
      target: system.object;
      unselected_literal: string = '-- County --';
      selected_value: string = EMPTY
      );
    function NameOf(code: string): string;
  end;

implementation

constructor TClass_biz_counties.Create;
begin
  inherited Create;
  // TODO: Add any constructor code here
  db_counties := TClass_db_counties.Create;
end;

procedure TClass_biz_counties.BindDirectToListControl
  (
  target: system.object;
  unselected_literal: string = '-- County --';
  selected_value: string = EMPTY
  );
begin
  db_counties.BindDirectToListControl(target,unselected_literal,selected_value);
end;

function TClass_biz_counties.NameOf(code: string): string;
begin
  NameOf := db_counties.NameOf(code);
end;

end.
