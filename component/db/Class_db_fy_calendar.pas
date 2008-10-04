unit Class_db_fy_calendar;

interface

uses
  Class_db;

type
  TClass_db_fy_calendar = class(TClass_db)
  strict private
    { Private Declarations }
  public
    constructor Create;
  published
    function MilestoneDate(milestone_code: string): datetime;
  end;

implementation

uses
  mysql.data.mysqlclient;

constructor TClass_db_fy_calendar.Create;
begin
  inherited Create;
  // TODO: Add any constructor code here
end;

function TClass_db_fy_calendar.MilestoneDate(milestone_code: string): datetime;
var
  milestone_date_obj: system.object;
begin
  //
  MilestoneDate := datetime.MaxValue;
  //
  self.Open;
  milestone_date_obj := mysqlcommand.Create
    (
    'select value'
    + ' from fy_calendar'
    + ' where fiscal_year_id = (select max(id) from fiscal_year)'
      + ' and milestone_code = "' + milestone_code + '"',
    connection
    )
    .ExecuteScalar;
  self.Close;
  //
  if assigned(milestone_date_obj) then begin
    MilestoneDate := datetime(milestone_date_obj);
  end;
  //
end;

end.
