unit Class_biz_accounts;

interface

uses
  appcommon,
  borland.vcl.sysutils,
  Class_biz_user,
  Class_db_accounts,
  system.configuration,
  system.web.mail;

type
  TClass_biz_accounts = class
  private
    { Private Declarations }
  public
    constructor Create;
    procedure MakeDemotionNotification
      (
      role: string;
      reviewer_descriptor: string;
      new_status_description: string;
      service_id: string;
      service_name: string;
      fy_designator: string;
      be_ok_to_rework: boolean;
      reason: string;
      county_code: string;
      emsof_ante: string
      );
    procedure MakePromotionNotification
      (
      next_reviewer_role: string;
      reviewer_descriptor: string;
      new_status_description: string;
      service_id: string;
      service_name: string;
      fy_designator: string
      );
  end;

implementation

function EmailAddressByKindId
  (
  user_kind: string;
  user_id: string
  )
  : string;
begin
  EmailAddressByKindId := TClass_db_accounts.Create.EmailAddressByKindId(user_kind,user_id);
end;

function EmailTargetByRole(role: string): string;
begin
  EmailTargetByRole := TClass_db_accounts.Create.EmailTargetByRole(role);
end;

function SelfEmailAddress: string;
var
  biz_user: TClass_biz_user;
begin
  biz_user := TClass_biz_user.Create;
  SelfEmailAddress := EmailAddressByKindId(biz_user.Kind,biz_user.IdNum);
end;

constructor TClass_biz_accounts.Create;
begin
  inherited Create;
  // TODO: Add any constructor code here
  smtpmail.SmtpServer := ConfigurationSettings.AppSettings['smtp_server'];
end;

procedure TClass_biz_accounts.MakeDemotionNotification
  (
  role: string;
  reviewer_descriptor: string;
  new_status_description: string;
  service_id: string;
  service_name: string;
  fy_designator: string;
  be_ok_to_rework: boolean;
  reason: string;
  county_code: string;
  emsof_ante: string
  );
var
  BreakChars: array[1..3] of char;
  other_stakeholder_email_address: string;
  service_email_address: string;
begin
  //
  // Get service's email address of record.
  //
  service_email_address := EmailAddressByKindId('service',service_id);
  //
  BreakChars[1] := appcommon.SPACE;
  BreakChars[2] := appcommon.TAB;
  BreakChars[3] := '-';
  //
  if be_ok_to_rework then begin
    //
    //   Send notification to service.
    //
    smtpmail.Send
      (
      SelfEmailAddress,
      service_email_address,
      'Return of EMSOF request for rework',
      reviewer_descriptor + ' did NOT approve ' + service_name + '''s ' + fy_designator + ' EMSOF request.  Instead, the request '
      + 'has been returned to you for rework.' + NEW_LINE
      + NEW_LINE
      + reviewer_descriptor + ' gave this reason for this action:' + NEW_LINE
      + NEW_LINE
      + '   '
      + WrapText
        (
        reason,
        (NEW_LINE + '   '),
        BreakChars,
        int16.Parse(configurationsettings.AppSettings['email_blockquote_maxcol'])
        )
      + NEW_LINE
      + NEW_LINE
      + 'You can rework this EMSOF request by visiting:' + NEW_LINE
      + NEW_LINE
      + '   https://' + ConfigurationSettings.AppSettings['ssl_base_path'] + '/'
      + ConfigurationSettings.AppSettings['application_name'] + '/protected/service_overview.aspx' + NEW_LINE
      + NEW_LINE
      + 'Replies to this message will be addressed to ' + reviewer_descriptor
      + NEW_LINE
      + NEW_LINE
      + '-- ' + ConfigurationSettings.AppSettings['application_name']
      );
  end else begin
    //
    //   Get other stakeholder's email address.
    //
    if TClass_biz_user.Create.Kind = 'county' then begin
      other_stakeholder_email_address := EmailTargetByRole('emsof-coordinator');
    end else if TClass_biz_user.Create.Kind = 'regional_staffer' then begin
      other_stakeholder_email_address := EmailAddressByKindId('county',county_code);
    end;
    //
    //   Send notifications to service and region.
    //
    smtpmail.Send
      (
      SelfEmailAddress,
      service_email_address,
      'REJECTION of EMSOF request',
      reviewer_descriptor + ' has REJECTED ' + service_name + '''s ' + fy_designator + ' EMSOF request.  ' + NEW_LINE
      + NEW_LINE
      + reviewer_descriptor + ' gave this reason for this action:' + NEW_LINE
      + NEW_LINE
      + '   '
      + WrapText
        (
        reason,
        (NEW_LINE + '   '),
        BreakChars,
        int16.Parse(configurationsettings.AppSettings['email_blockquote_maxcol'])
        )
      + NEW_LINE
      + NEW_LINE
      + 'You can review your EMSOF requests by visiting:' + NEW_LINE
      + NEW_LINE
      + '   https://' + ConfigurationSettings.AppSettings['ssl_base_path'] + '/'
      + ConfigurationSettings.AppSettings['application_name'] + '/protected/service_overview.aspx' + NEW_LINE
      + NEW_LINE
      + 'Replies to this message will be addressed to ' + reviewer_descriptor + NEW_LINE
      + NEW_LINE
      + '-- ' + ConfigurationSettings.AppSettings['application_name']
      );
    smtpmail.Send
      (
      SelfEmailAddress,
      other_stakeholder_email_address,
      'REJECTION of EMSOF request',
      reviewer_descriptor + ' has REJECTED ' + service_name + '''s '+ fy_designator + ' EMSOF request.  ' + NEW_LINE
      + NEW_LINE
      + reviewer_descriptor + ' gave this reason for this action:' + NEW_LINE
      + NEW_LINE
      + '   '
      + WrapText
        (
        reason,
        (NEW_LINE + '   '),
        BreakChars,
        int16.Parse(configurationsettings.AppSettings['email_blockquote_maxcol'])
        )
      + NEW_LINE
      + NEW_LINE
      + 'This action effectively returns ' + emsof_ante + ' of EMSOF funds to the regional council.' + NEW_LINE
      + NEW_LINE
      + 'You can review this EMSOF request by visiting:' + NEW_LINE
      + NEW_LINE
      + '   https://' + ConfigurationSettings.AppSettings['ssl_base_path'] + '/'
      + ConfigurationSettings.AppSettings['application_name'] + '/protected/regional_staffer_overview.aspx'
      + NEW_LINE
      + NEW_LINE
      + 'Replies to this message will be addressed to ' + reviewer_descriptor + NEW_LINE
      + NEW_LINE
      + '-- ' + ConfigurationSettings.AppSettings['application_name']
      );
  end;
end;

procedure TClass_biz_accounts.MakePromotionNotification
  (
  next_reviewer_role: string;
  reviewer_descriptor: string;
  new_status_description: string;
  service_id: string;
  service_name: string;
  fy_designator: string
  );
var
  messageText: string;
  next_reviewer_email_target: string;
begin
  //
  //   Get the next approver's email address.
  //
  if next_reviewer_role <> system.string.EMPTY then begin
    next_reviewer_email_target := EmailTargetByRole(next_reviewer_role);
  end else begin
    next_reviewer_email_target := system.string.EMPTY
  end;
  //
  messageText := reviewer_descriptor + ' has promoted ' + service_name + '''s '+ fy_designator + ' EMSOF request.' + NEW_LINE
    + NEW_LINE
    + 'The status of this EMSOF request is now "' + new_status_description + '".  ';
  if next_reviewer_email_target <> system.string.EMPTY then begin
    messageText := messageText + 'The next reviewer''s email address is <' + next_reviewer_email_target + '>.';
  end;
  messageText := messageText
  + NEW_LINE
  + NEW_LINE
  + 'NOTE that this message is *not* a "Notice To Proceed", so you must *not* purchase any of the items in your EMSOF request '
  + 'yet.' + NEW_LINE
  + NEW_LINE
  + 'You can review your EMSOF requests by visiting:' + NEW_LINE
  + NEW_LINE
  + '   https://' + ConfigurationSettings.AppSettings['ssl_base_path'] + '/'
  + ConfigurationSettings.AppSettings['application_name'] + '/protected/service_overview.aspx' + NEW_LINE
  + NEW_LINE
  + 'Replies to this message will be addressed to ' + reviewer_descriptor + NEW_LINE
  + NEW_LINE
  + '-- ' + ConfigurationSettings.AppSettings['application_name'];
  //
  //   Send notification to service.
  //
  smtpmail.Send(SelfEmailAddress,EmailAddressByKindId('service',service_id),'Promotion of EMSOF request',messageText);
  //
  //   Send notification to region.
  //
  if next_reviewer_email_target <> system.string.EMPTY then begin
    smtpmail.Send
      (
      SelfEmailAddress,
      next_reviewer_email_target,
      'Promotion of EMSOF request',
      reviewer_descriptor + ' has promoted ' + service_name + '''s ' + fy_designator + ' EMSOF request.' + NEW_LINE
      + NEW_LINE
      + 'Your action is now required.  The status of this EMSOF request is "' + new_status_description + '".' + NEW_LINE
      + NEW_LINE
      + 'You can review this EMSOF request by visiting:' + NEW_LINE
      + NEW_LINE
      + '   https://' + ConfigurationSettings.AppSettings['ssl_base_path'] + '/'
      + ConfigurationSettings.AppSettings['application_name'] + '/protected/regional_staffer_overview.aspx' + NEW_LINE
      + NEW_LINE
      + 'Replies to this message will be addressed to ' + reviewer_descriptor
      + NEW_LINE
      + NEW_LINE
      + '-- ' + ConfigurationSettings.AppSettings['application_name']
      );
  end;
end;

end.
