unit Class_biz_accounts;

interface

uses
  appcommon,
  borland.vcl.sysutils,
  Class_bc_user,
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
      role: string;
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
  bc_user: TClass_bc_user;
begin
  bc_user := TClass_bc_user.Create;
  SelfEmailAddress := EmailAddressByKindId(bc_user.Kind,bc_user.IdNum);
end;

constructor TClass_biz_accounts.Create;
begin
  inherited Create;
  // TODO: Add any constructor code here
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
    if TClass_bc_user.Create.Kind = 'county' then begin
      other_stakeholder_email_address := EmailTargetByRole('emsof-coordinator');
    end else if TClass_bc_user.Create.Kind = 'regional_staffer' then begin
      other_stakeholder_email_address := EmailAddressByKindId('county',county_code);
    end;
    //
    //   Send notifications to service and region.
    //
    smtpmail.SmtpServer := ConfigurationSettings.AppSettings['smtp_server'];
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
  role: string;
  reviewer_descriptor: string;
  new_status_description: string;
  service_id: string;
  service_name: string;
  fy_designator: string
  );
var
  next_approver_email_target: string;
begin
  //
  smtpmail.SmtpServer := ConfigurationSettings.AppSettings['smtp_server'];
  //
  //   Get the next approver's email address.
  //
  if role = 'county' then begin
    next_approver_email_target := EmailTargetByRole('regional-planner');
  end else if role = 'regional_planner' then begin
    next_approver_email_target := EmailTargetByRole('director');
  end else if role = 'regional_director' then begin
    next_approver_email_target := EmailTargetByRole('regional-coordinator');
  end;
  //
  //   Send notification to service.
  //
  smtpmail.Send
    (
    SelfEmailAddress,
    EmailAddressByKindId('service',service_id),
    'Approval of EMSOF request',
    reviewer_descriptor + ' has approved ' + service_name + '''s '+ fy_designator + ' EMSOF request.' + NEW_LINE
    + NEW_LINE
    + 'The status of this EMSOF request is now "' + new_status_description + '".  The next approver''s email address is <'
    + next_approver_email_target + '>.' + NEW_LINE
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
  //
  //   Send notification to region.
  //
  smtpmail.Send
    (
    SelfEmailAddress,
    next_approver_email_target,
    'Promotion of EMSOF request',
    reviewer_descriptor + ' has approved ' + service_name + '''s ' + fy_designator + ' EMSOF request.' + NEW_LINE
    + NEW_LINE
    + 'Your action is now required.  The status of this EMSOF request is "' + new_status_description + '".' + NEW_LINE
    + NEW_LINE
    + 'You can review this EMSOF request by visiting:' + NEW_LINE
    + NEW_LINE
    + '   https://' + ConfigurationSettings.AppSettings['ssl_base_path'] + '/'
    + ConfigurationSettings.AppSettings['application_name'] + '/protected/'
    + TClass_bc_user.Create.Kind + '_overview.aspx'
    + NEW_LINE
    + NEW_LINE
    + 'Replies to this message will be addressed to ' + reviewer_descriptor
    + NEW_LINE
    + NEW_LINE
    + '-- ' + ConfigurationSettings.AppSettings['application_name']
    );
end;

end.
