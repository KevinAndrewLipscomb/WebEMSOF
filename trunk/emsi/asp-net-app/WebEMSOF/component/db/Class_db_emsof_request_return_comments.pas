unit Class_db_emsof_request_return_comments;

interface

uses
  Class_db;

type
  TClass_db_emsof_request_return_comments = class(TClass_db)
  strict private
  published
    //
    constructor Create;
    //
    function Bind
      (
      target: system.object;
      master_id: string
      )
      : boolean;
    procedure Log
      (
      master_id: string;
      demoter: string;
      content: string
      );
    //
  end;

implementation

uses
  mysql.data.mysqlclient,
  system.web.ui.webcontrols;

constructor TClass_db_emsof_request_return_comments.Create;
begin
  inherited Create;
  // TODO: Add any constructor code here
end;

function TClass_db_emsof_request_return_comments.Bind
  (
  target: system.object;
  master_id: string
  )
  : boolean;
var
  dr: mysqldatareader;
begin
  Bind := FALSE;
  self.Open;
  dr := mysqlcommand.Create
    (
    'select timestamp'
    + ' , demoter'
    + ' , content'
    + ' from emsof_request_return_comment'
    + ' where emsof_request_master_id = "' + master_id + '"'
    + ' order by timestamp',
    connection
    )
    .ExecuteReader;
  if dr.HasRows then begin
    GridView(target).datasource := dr;
    GridView(target).DataBind;
    Bind := TRUE;
  end;
  self.Close;
end;

procedure TClass_db_emsof_request_return_comments.Log
  (
  master_id: string;
  demoter: string;
  content: string
  );
begin
  self.Open;
  mysqlcommand.Create
    (
    'insert emsof_request_return_comment'
    + ' set emsof_request_master_id = "' + master_id + '"'
    +   ' , demoter = "' + demoter + '"'
    +   ' , content = "' + content + '"',
    connection
    )
    .ExecuteNonquery;
  self.Close;
end;

end.
