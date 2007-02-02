unit Class_db_milestones;

interface

uses
  Class_biz_fiscal_years,
  Class_db,
  Class_db_trail,
  system.collections;

type
  TClass_db_milestones = class(TClass_db)
  private
    biz_fiscal_years: TClass_biz_fiscal_years;
    db_trail: TClass_db_trail;
  public
    constructor Create;
    procedure Check
      (
      code: cardinal;
      var be_processed: boolean;
      var value: datetime
      );
    procedure MarkProcessed(code: cardinal);
  end;

implementation

uses
  borland.data.provider;

constructor TClass_db_milestones.Create;
begin
  inherited Create;
  // TODO: Add any constructor code here
  biz_fiscal_years := TClass_biz_fiscal_years.Create;
  db_trail := TClass_db_trail.Create;
end;

procedure TClass_db_milestones.Check
  (
  code: cardinal;
  var be_processed: boolean;
  var value: datetime
  );
var
  bdr: bdpdatareader;
begin
  self.Open;
  bdr := borland.data.provider.bdpcommand.Create
    (
    'select be_processed,value'
    + ' from fy_calendar'
    + ' where fiscal_year_id = ' + biz_fiscal_years.IdOfCurrent
    +   ' and milestone_code = ' + code.tostring,
    connection
    )
    .ExecuteReader;
  bdr.Read;
  be_processed := (bdr['be_processed'].tostring = '1');
  value := datetime.Parse(bdr['value'].tostring);
  bdr.Close;
  self.Close;
end;

procedure TClass_db_milestones.MarkProcessed(code: cardinal);
var
  cmdText: string;
begin
  cmdText := 'update fy_calendar'
    + ' set be_processed = TRUE'
    + ' where fiscal_year_id = ' + biz_fiscal_years.IdOfCurrent
    +   ' and milestone_code = ' + code.tostring;
  self.Open;
  borland.data.provider.bdpcommand.Create(db_trail.Saved(cmdText),connection).ExecuteNonQuery;
  self.Close;
end;

end.
