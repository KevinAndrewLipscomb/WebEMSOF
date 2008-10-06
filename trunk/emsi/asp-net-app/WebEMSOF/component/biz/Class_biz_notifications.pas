unit Class_biz_notifications;

interface

type
  //
  // Class type
  //
  TClass_biz_notifications = class
  strict private
    application_name: string;
  public
    constructor Create;
  published
    procedure IssueCorruptionNotification
      (
      user_kind: string;
      detection_phase: string
      );
  end;

implementation

uses
  kix,
  system.configuration,
  system.io,
  system.web;

var
  BreakChars: array[1..3] of char;

constructor TClass_biz_notifications.Create;
begin
  inherited Create;
  application_name := configurationmanager.appsettings['application_name'];
end;

procedure TClass_biz_notifications.IssueCorruptionNotification
  (
  user_kind: string;
  detection_phase: string
  );
var
  template_reader: streamreader;
  //
  FUNCTION Merge(s: string): string;
  BEGIN
    Merge := s
      .Replace('<application_name/>',application_name)
      .Replace('<detection_phase/>',detection_phase)
      .Replace('<user_kind/>',user_kind);
  END;
  //
begin
  template_reader := &file.OpenText(httpcontext.current.server.MapPath('template/notification/corruption_notification.txt'));
  kix.SmtpMailSend
    (
    //from
    configurationmanager.appsettings['sender_email_address'],
    //to
    configurationmanager.appsettings['sender_email_address'],
    //subject
    Merge(template_reader.ReadLine),
    //body
    Merge(template_reader.ReadToEnd)
    );
  template_reader.Close;
end;

begin
  BreakChars[1] := SPACE;
  BreakChars[2] := TAB;
  BreakChars[3] := HYPHEN;
end.
