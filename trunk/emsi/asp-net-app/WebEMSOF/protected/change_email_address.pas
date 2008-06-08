unit change_email_address;

interface

uses
  System.Collections, System.ComponentModel,
  System.Data, System.Drawing, System.Web, System.Web.SessionState,
  system.web.ui, ki_web_ui, System.Web.UI.WebControls, System.Web.UI.HtmlControls, kix, mysql.data.mysqlclient, system.configuration,
  system.net, system.web.security,
  Class_db,
  Class_db_trail;

const ID = '$Id$';

type
  p_type =
    RECORD
    db: TClass_db;
    db_trail: TClass_db_trail;
    END;
  TWebForm_change_email_address = class(ki_web_ui.page_class)
  {$REGION 'Designer Managed Code'}
  strict private
    procedure InitializeComponent;
    procedure Button_submit_Click(sender: System.Object; e: System.EventArgs);
    procedure CustomValidator_nominal_email_address_ServerValidate(source: System.Object; args: System.Web.UI.WebControls.ServerValidateEventArgs);
    procedure TWebForm_change_email_address_PreRender(sender: System.Object;
      e: System.EventArgs);
  {$ENDREGION}
  strict private
    p: p_type;
    procedure Page_Load(sender: System.Object; e: System.EventArgs);
  strict protected
    Title: System.Web.UI.HtmlControls.HtmlGenericControl;
    PlaceHolder_precontent: System.Web.UI.WebControls.PlaceHolder;
    PlaceHolder_postcontent: System.Web.UI.WebControls.PlaceHolder;
    Button_submit: System.Web.UI.WebControls.Button;
    TextBox_nominal_email_address: System.Web.UI.WebControls.TextBox;
    TextBox_confirmation_email_address: System.Web.UI.WebControls.TextBox;
    RequiredFieldValidator_nominal_email_address: System.Web.UI.WebControls.RequiredFieldValidator;
    RequiredFieldValidator_confirmation_email_address: System.Web.UI.WebControls.RequiredFieldValidator;
    RegularExpressionValidator_nominal_email_address: System.Web.UI.WebControls.RegularExpressionValidator;
    CustomValidator_nominal_email_address: System.Web.UI.WebControls.CustomValidator;
    CompareValidator1: System.Web.UI.WebControls.CompareValidator;
  protected
    procedure OnInit(e: EventArgs); override;
  private
    { Private Declarations }
  public
  end;

implementation

{$REGION 'Designer Managed Code'}
/// <summary>
/// Required method for Designer support -- do not modify
/// the contents of this method with the code editor.
/// </summary>
procedure TWebForm_change_email_address.InitializeComponent;
begin
  Include(Self.CustomValidator_nominal_email_address.ServerValidate, Self.CustomValidator_nominal_email_address_ServerValidate);
  Include(Self.Button_submit.Click, Self.Button_submit_Click);
  Include(Self.PreRender, Self.TWebForm_change_email_address_PreRender);
  Include(Self.Load, Self.Page_Load);
end;
{$ENDREGION}

procedure TWebForm_change_email_address.Page_Load(sender: System.Object; e: System.EventArgs);
var
  email_address: string;
begin
  if IsPostback and (session['p'].GetType.namespace = p.GetType.namespace) then begin
    p := p_type(session['p']);
  end else begin
    if request.servervariables['URL'] = request.currentexecutionfilepath then begin
      session.Clear;
      server.Transfer('~/login.aspx');
    end;
    Title.InnerText := configurationmanager.AppSettings['application_name'] + ' - change_email_address';
    //
    p.db_trail := TClass_db_trail.Create;
    p.db := TClass_db.Create;
    p.db.Open;
    //
    // Preload email address fields
    //
    email_address := mysqlcommand.Create
      (
      'SELECT password_reset_email_address '
      + 'FROM ' + session['target_user_table'].ToString + '_user '
      + 'WHERE id = "' + session[session['target_user_table'].ToString + '_user_id'].ToString + '"',
      p.db.connection
      )
      .ExecuteScalar.tostring;
    TextBox_nominal_email_address.Text := email_address;
    TextBox_confirmation_email_address.Text := email_address;
    //
    p.db.Close;
    end;
end;

procedure TWebForm_change_email_address.OnInit(e: EventArgs);
begin
  //
  // Required for Designer support
  //
  InitializeComponent;
  inherited OnInit(e);
end;

procedure TWebForm_change_email_address.TWebForm_change_email_address_PreRender(sender: System.Object;
  e: System.EventArgs);
begin
  SessionSet('p',p);
end;

procedure TWebForm_change_email_address.CustomValidator_nominal_email_address_ServerValidate(source: System.Object;
  args: System.Web.UI.WebControls.ServerValidateEventArgs);
begin
  args.isvalid := TRUE;
  try
    dns.GetHostEntry(args.value.Substring(args.value.LastIndexOf('@') + 1));
  except
    args.isvalid := FALSE;
  end;
end;

procedure TWebForm_change_email_address.Button_submit_Click(sender: System.Object;
  e: System.EventArgs);
begin
  if page.isvalid then begin
    p.db.Open;
    //
    // Commit the data to the database.
    //
    mysqlcommand.Create
      (
      p.db_trail.Saved
        (
        'UPDATE ' + session['target_user_table'].ToString + '_user'
        + ' SET password_reset_email_address = "' + Safe(TextBox_nominal_email_address.Text.Trim,EMAIL_ADDRESS) + '"'
        + ' WHERE id = "' + session[session['target_user_table'].ToString + '_user_id'].ToString + '"'
        ),
      p.db.connection
      )
      .ExecuteNonQuery;
    p.db.Close;
    server.Transfer(session['target_user_table'].ToString + '_overview.aspx');
  end else begin
    ValidationAlert;
  end;
end;

end.

