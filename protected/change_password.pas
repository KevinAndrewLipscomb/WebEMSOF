
unit change_password;

interface

uses
  System.Collections, System.ComponentModel,
  System.Data, System.Drawing, System.Web, System.Web.SessionState,
  system.web.ui, ki_web_ui, System.Web.UI.WebControls, System.Web.UI.HtmlControls, ki, borland.data.provider, system.configuration,
  system.web.security,
  Class_db,
  Class_db_trail;

const ID = '$Id$';

type
  p_type =
    RECORD
    db: TClass_db;
    db_trail: TClass_db_trail;
    END;
  TWebForm_change_password = class(ki_web_ui.page_class)
  {$REGION 'Designer Managed Code'}
  strict private
    procedure InitializeComponent;
    procedure Button_submit_Click(sender: System.Object; e: System.EventArgs);
    procedure LinkButton_overview_Click(sender: System.Object; e: System.EventArgs);
    procedure LinkButton_logout_Click(sender: System.Object; e: System.EventArgs);
    procedure TWebForm_change_password_PreRender(sender: System.Object;
      e: System.EventArgs);
  {$ENDREGION}
  strict private
    p: p_type;
    procedure Page_Load(sender: System.Object; e: System.EventArgs);
  strict protected
    Title: System.Web.UI.HtmlControls.HtmlGenericControl;
    PlaceHolder_precontent: System.Web.UI.WebControls.PlaceHolder;
    PlaceHolder_postcontent: System.Web.UI.WebControls.PlaceHolder;
    Label_account_descriptor: System.Web.UI.WebControls.Label;
    Button_submit: System.Web.UI.WebControls.Button;
    TextBox_nominal_password: System.Web.UI.WebControls.TextBox;
    TextBox_confirmation_password: System.Web.UI.WebControls.TextBox;
    RequiredFieldValidator_nominal_password: System.Web.UI.WebControls.RequiredFieldValidator;
    RequiredFieldValidator_confirmation_password: System.Web.UI.WebControls.RequiredFieldValidator;
    CompareValidator1: System.Web.UI.WebControls.CompareValidator;
    RegularExpressionValidator_password: System.Web.UI.WebControls.RegularExpressionValidator;
    LinkButton_back_to_overview: System.Web.UI.WebControls.LinkButton;
    LinkButton_logout: System.Web.UI.WebControls.LinkButton;
    procedure OnInit(e: EventArgs); override;
  private
    { Private Declarations }
  public
    { Public Declarations }
  end;

implementation

uses
  appcommon;

{$REGION 'Designer Managed Code'}
/// <summary>
/// Required method for Designer support -- do not modify
/// the contents of this method with the code editor.
/// </summary>
procedure TWebForm_change_password.InitializeComponent;
begin
  Include(Self.LinkButton_logout.Click, Self.LinkButton_logout_Click);
  Include(Self.LinkButton_back_to_overview.Click, Self.LinkButton_overview_Click);
  Include(Self.Button_submit.Click, Self.Button_submit_Click);
  Include(Self.Load, Self.Page_Load);
  Include(Self.PreRender, Self.TWebForm_change_password_PreRender);
end;
{$ENDREGION}

procedure TWebForm_change_password.Page_Load(sender: System.Object; e: System.EventArgs);
begin
  appcommon.PopulatePlaceHolders(PlaceHolder_precontent,PlaceHolder_postcontent);
  if IsPostback and (session['p'].GetType.namespace = p.GetType.namespace) then begin
    p := p_type(session['p']);
  end else begin
    if request.servervariables['URL'] = request.currentexecutionfilepath then begin
      session.Clear;
      server.Transfer('~/login.aspx');
    end;
    Title.InnerText := ConfigurationSettings.AppSettings['application_name'] + ' - change_password';
    //
    p.db := TClass_db.Create;
    p.db_trail := TClass_db_trail.Create;
    //
    Label_account_descriptor.Text := session[session['target_user_table'].ToString + '_name'].ToString;
    if session['target_user_table'].tostring = 'county' then begin
      Label_account_descriptor.Text := Label_account_descriptor.Text + ' County';
    end;
    LinkButton_back_to_overview.text := session['target_user_table'].tostring + ' overview';
  end;
end;

procedure TWebForm_change_password.OnInit(e: EventArgs);
begin
  //
  // Required for Designer support
  //
  InitializeComponent;
  inherited OnInit(e);
end;

procedure TWebForm_change_password.TWebForm_change_password_PreRender(sender: System.Object;
  e: System.EventArgs);
begin
  session.Remove('p');
  session.Add('p',p);
end;

procedure TWebForm_change_password.LinkButton_logout_Click(sender: System.Object;
  e: System.EventArgs);
begin
  formsauthentication.SignOut;
  session.Clear;
  server.Transfer('../Default.aspx');
end;

procedure TWebForm_change_password.LinkButton_overview_Click(sender: System.Object;
  e: System.EventArgs);
begin
  server.Transfer(session['target_user_table'].tostring + '_overview.aspx');
end;

procedure TWebForm_change_password.Button_submit_Click(sender: System.Object;
  e: System.EventArgs);
begin
  //
  // Commit the data to the database.
  //
  p.db.Open;
  borland.data.provider.bdpcommand.Create
    (
    p.db_trail.Saved
      (
      'UPDATE ' + session['target_user_table'].ToString + '_user'
      + ' SET encoded_password = "' + ki.Digest(Safe(TextBox_nominal_password.Text.trim,ALPHANUM)) + '",'
      +   ' be_stale_password = FALSE'
      + ' WHERE id = "' + session[session['target_user_table'].ToString + '_user_id'].ToString + '"'
      ),
    p.db.connection
    ).ExecuteNonQuery;
  p.db.Close;
  server.Transfer(session['target_user_table'].ToString + '_overview.aspx');
end;

end.

