unit Class_biz_fy_calendar;

interface

uses
  Class_db_fy_calendar,
  Class_biz_milestones;

type
  TClass_biz_fy_calendar = class
  strict private
    db_fy_calendar: TClass_db_fy_calendar;
  public
    constructor Create;
  published
    function MilestoneDate(milestone: milestone_type): datetime;
  end;

implementation

constructor TClass_biz_fy_calendar.Create;
begin
  inherited Create;
  db_fy_calendar := TClass_db_fy_calendar.Create;
end;

function TClass_biz_fy_calendar.MilestoneDate(milestone: milestone_type): datetime;
begin
  MilestoneDate := db_fy_calendar.MilestoneDate(uint32(ord(milestone)).tostring);
end;

end.
