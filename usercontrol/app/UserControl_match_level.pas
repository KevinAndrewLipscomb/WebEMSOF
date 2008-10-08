unit UserControl_match_level;

interface

uses
  Class_biz_match_level,
  ki_web_ui,
  System.Data,
  System.Drawing,
  System.Web,
  System.Web.UI,
  System.Web.UI.WebControls,
  System.Web.UI.HtmlControls,
  UserControl_drop_down_date;

type
  TWebUserControl_match_level = class(ki_web_ui.usercontrol_class)
  {$REGION 'Designer Managed Code'}
  strict private
    procedure InitializeComponent;
    procedure TWebUserControl_match_level_PreRender(sender: System.Object;
      e: System.EventArgs);
    procedure Button_lookup_Click(sender: System.Object; e: System.EventArgs);
    procedure LinkButton_reset_Click(sender: System.Object; e: System.EventArgs);
    procedure LinkButton_new_record_Click(sender: System.Object; e: System.EventArgs);
    procedure Button_delete_Click(sender: System.Object; e: System.EventArgs);
    procedure DropDownList_name_SelectedIndexChanged(sender: System.Object; 
      e: System.EventArgs);
    procedure Button_submit_Click(sender: System.Object; e: System.EventArgs);
  {$ENDREGION}
  strict private
    type
      p_type =
        RECORD
        be_loaded: boolean;
        be_ok_to_config_match_levels: boolean;
        biz_match_level: TClass_biz_match_level;
        END;
  strict private
    p: p_type;
    procedure Clear;
    procedure Page_Load(sender: System.Object; e: System.EventArgs);
    function PresentRecord(name: string): boolean;
  strict protected
    Label_application_name: System.Web.UI.WebControls.Label;
    Button_submit: System.Web.UI.WebControls.Button;
    Button_delete: System.Web.UI.WebControls.Button;
    Button_lookup: System.Web.UI.WebControls.Button;
    LinkButton_new_record: System.Web.UI.WebControls.LinkButton;
    Label_lookup_arrow: &label;
    Label_lookup_hint: &label;
    LinkButton_reset: System.Web.UI.WebControls.LinkButton;
    TextBox_name: TextBox;
    DropDownList_name: DropDownList;
    TextBox_factor: TextBox;
  protected
    procedure OnInit(e: System.EventArgs); override;
  published
    function Fresh: TWebUserControl_match_level;
  end;

implementation

uses
  kix,
  System.Collections,
  system.configuration;

procedure TWebUserControl_match_level.Clear;
begin
  //
  TextBox_name.text := EMPTY;
  DropDownList_name.visible := FALSE;
  TextBox_factor.text := EMPTY;
  //
  Button_submit.enabled := FALSE;
  Button_delete.enabled := FALSE;
  //
end;

procedure TWebUserControl_match_level.Page_Load(sender: System.Object; e: System.EventArgs);
begin
  //
  if not p.be_loaded then begin
    //
    LinkButton_new_record.visible := p.be_ok_to_config_match_levels;
    //
    RequireConfirmation(Button_delete,'Are you sure you want to delete this record?');
    //
    Focus(TextBox_name,TRUE);
    //
    p.be_loaded := TRUE;
    //
  end;
  //
end;

function TWebUserControl_match_level.PresentRecord(name: string): boolean;
var
  factor: decimal;
begin
  PresentRecord := FALSE;
  if p.biz_match_level.Get
    (
    name,
    factor
    )
  then begin
    //
    TextBox_name.text := name;
    TextBox_factor.text := factor.tostring;
    //
    TextBox_name.enabled := FALSE;
    Button_lookup.enabled := FALSE;
    Label_lookup_arrow.enabled := FALSE;
    Label_lookup_hint.enabled := FALSE;
    LinkButton_reset.enabled := TRUE;
    TextBox_factor.enabled := p.be_ok_to_config_match_levels;
    Button_submit.enabled := p.be_ok_to_config_match_levels;
    Button_delete.enabled := p.be_ok_to_config_match_levels;
    //
    PresentRecord := TRUE;
    //
  end;
end;

procedure TWebUserControl_match_level.OnInit(e: System.EventArgs);
begin
  //
  // Required for Designer support
  //
  InitializeComponent;
  inherited OnInit(e);
  //
  if IsPostback
    and (session['UserControl_match_level.p'] <> nil)
    and (session['UserControl_match_level.p'].GetType.namespace = p.GetType.namespace)
  then begin
    p := p_type(session['UserControl_match_level.p']);
  end else begin
    //
    p.be_loaded := FALSE;
    //
    p.biz_match_level := TClass_biz_match_level.Create;
    //
    p.be_ok_to_config_match_levels := httpcontext.current.User.IsInRole('director')
      or httpcontext.current.User.IsInRole('emsof-coordinator');
    //
  end;
  //
end;

{$REGION 'Designer Managed Code'}
/// <summary>
/// Required method for Designer support -- do not modify
/// the contents of this method with the code editor.
/// </summary>
procedure TWebUserControl_match_level.InitializeComponent;
begin
  Include(Self.Button_lookup.Click, Self.Button_lookup_Click);
  Include(Self.LinkButton_reset.Click, Self.LinkButton_reset_Click);
  Include(Self.LinkButton_new_record.Click, Self.LinkButton_new_record_Click);
  Include(Self.DropDownList_name.SelectedIndexChanged, Self.DropDownList_name_SelectedIndexChanged);
  Include(Self.Button_submit.Click, Self.Button_submit_Click);
  Include(Self.Button_delete.Click, Self.Button_delete_Click);
  Include(Self.Load, Self.Page_Load);
  Include(Self.PreRender, Self.TWebUserControl_match_level_PreRender);
end;
{$ENDREGION}

procedure TWebUserControl_match_level.TWebUserControl_match_level_PreRender(sender: System.Object;
  e: System.EventArgs);
begin
  SessionSet('UserControl_match_level.p',p);
end;

function TWebUserControl_match_level.Fresh: TWebUserControl_match_level;
begin
  session.Remove('UserControl_match_level.p');
  Fresh := self;
end;

procedure TWebUserControl_match_level.Button_submit_Click(sender: System.Object;
  e: System.EventArgs);
var
  factor: decimal;
begin
  if page.IsValid then begin
    //
    factor := 0;
    if TextBox_factor.text <> EMPTY then begin
      factor := decimal.Parse(Safe(TextBox_factor.text,REAL_NUM_INCLUDING_NEGATIVE));
    end;
    //
    p.biz_match_level.&Set
      (
      Safe(TextBox_name.text,PUNCTUATED),
      factor
      );
    Alert(USER,SUCCESS,'recsaved','Record saved.',TRUE);
  end else begin
    ValidationAlert;
  end;
end;

procedure TWebUserControl_match_level.DropDownList_name_SelectedIndexChanged(sender: System.Object;
  e: System.EventArgs);
begin
  PresentRecord(DropDownList_name.selectedvalue);
end;

procedure TWebUserControl_match_level.Button_delete_Click(sender: System.Object;
  e: System.EventArgs);
begin
  p.biz_match_level.Delete(Safe(TextBox_name.text,ALPHANUM));
  Clear;
end;

procedure TWebUserControl_match_level.LinkButton_new_record_Click(sender: System.Object;
  e: System.EventArgs);
begin
  Clear;
  TextBox_name.text := '*';
  TextBox_name.enabled := False;
  Button_lookup.enabled := FALSE;
  Label_lookup_arrow.enabled := FALSE;
  Label_lookup_hint.enabled := FALSE;
  LinkButton_reset.enabled := TRUE;
  LinkButton_new_record.enabled := FALSE;
  TextBox_factor.enabled := p.be_ok_to_config_match_levels;
  Button_submit.enabled := p.be_ok_to_config_match_levels;
  Button_delete.enabled := FALSE;
  Focus(TextBox_name,TRUE);
end;

procedure TWebUserControl_match_level.LinkButton_reset_Click(sender: System.Object;
  e: System.EventArgs);
begin
  Clear;
  TextBox_name.enabled := TRUE;
  Button_lookup.enabled := TRUE;
  Label_lookup_arrow.enabled := TRUE;
  Label_lookup_hint.enabled := TRUE;
  LinkButton_reset.enabled := FALSE;
  LinkButton_new_record.enabled := p.be_ok_to_config_match_levels;
  TextBox_factor.enabled := FALSE;
  Focus(TextBox_name,TRUE);
end;

procedure TWebUserControl_match_level.Button_lookup_Click(sender: System.Object;
  e: System.EventArgs);
var
  num_matches: cardinal;
  saved_name: string;
begin
  saved_name := TextBox_name.text;
  Clear;
  if not PresentRecord(saved_name) then begin
    TextBox_name.text := saved_name;
    p.biz_match_level.Bind(saved_name,DropDownList_name);
    num_matches := DropDownList_name.items.count;
    if num_matches > 0 then begin
      DropDownList_name.visible := TRUE;
      if num_matches = 1 then begin
        PresentRecord(DropDownList_name.selectedvalue);
      end else begin
        DropDownList_name.items.Insert(0,listitem.Create('-- Select --',EMPTY));
      end;
    end;
  end;
end;

end.
