unit Class_biz_services;

interface

uses
  Class_db_services;

type
  TClass_biz_services = class
  private
    db_services: TClass_db_services;
  public
    constructor Create;
    procedure BindDropDownList
      (
      county_user_id: string;
      target: system.object;
      be_filtered: boolean = TRUE
      );
  end;

implementation

constructor TClass_biz_services.Create;
begin
  inherited Create;
  // TODO: Add any constructor code here
  db_services := TClass_db_services.Create;
end;

procedure TClass_biz_services.BindDropDownList
  (
  county_user_id: string;
  target: system.object;
  be_filtered: boolean = TRUE
  );
begin
  db_services.BindDropDownList(county_user_id,target,be_filtered);
end;

end.
