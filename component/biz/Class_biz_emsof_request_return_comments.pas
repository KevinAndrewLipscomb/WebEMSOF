unit Class_biz_emsof_request_return_comments;

interface

uses
  Class_db_emsof_request_return_comments;

type
  TClass_biz_emsof_request_return_comments = class
  strict private
    db_emsof_request_return_comments: TClass_db_emsof_request_return_comments;
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

constructor TClass_biz_emsof_request_return_comments.Create;
begin
  inherited Create;
  db_emsof_request_return_comments := TClass_db_emsof_request_return_comments.Create;
end;

function TClass_biz_emsof_request_return_comments.Bind
  (
  target: system.object;
  master_id: string
  )
  : boolean;
begin
  Bind := db_emsof_request_return_comments.Bind(target,master_id);
end;

procedure TClass_biz_emsof_request_return_comments.Log
  (
  master_id: string;
  demoter: string;
  content: string
  );
begin
  db_emsof_request_return_comments.Log(master_id,demoter,content);
end;

end.
