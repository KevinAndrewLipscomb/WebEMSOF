
unit choose_county_appropriation;

interface

uses
  System.Collections, System.ComponentModel,
  System.Data, System.Drawing, System.Web, System.Web.SessionState,
  System.Web.UI, System.Web.UI.WebControls, System.Web.UI.HtmlControls, AppCommon, system.configuration, borland.data.provider;

type
  TWebForm_county_appropriation = class(System.Web.UI.Page)
  {$REGION 'Designer Managed Code'}
  strict private
    procedure InitializeComponent;
    procedure Button_continue_Click(sender: System.Object; e: System.EventArgs);
  {$ENDREGION}
  strict private
    procedure Page_Load(sender: System.Object; e: System.EventArgs);
  strict protected
    Title: System.Web.UI.HtmlControls.HtmlGenericControl;
    PlaceHolder_precontent: System.Web.UI.WebControls.PlaceHolder;
    PlaceHolder_postcontent: System.Web.UI.WebControls.PlaceHolder;
    Label_county_name: System.Web.UI.WebControls.Label;
    RadioButtonList_appropriation: System.Web.UI.WebControls.RadioButtonList;
    Button_continue: System.Web.UI.WebControls.Button;
    RequiredFieldValidator_appropriation: System.Web.UI.WebControls.RequiredFieldValidator;
    Label_literal_county: System.Web.UI.WebControls.Label;
    procedure OnInit(e: EventArgs); override;
  private
    { Private Declarations }
  public
    { Public Declarations }
  end;

implementation

{$REGION 'Designer Managed Code'}
/// <summary>
/// Required method for Designer support -- do not modify
/// the contents of this method with the code editor.
/// </summary>
procedure TWebForm_county_appropriation.InitializeComponent;
begin
  Include(Self.Button_continue.Click, Self.Button_continue_Click);
  Include(Self.Load, Self.Page_Load);
end;
{$ENDREGION}

const ID = '$Id$';

procedure TWebForm_county_appropriation.Page_Load(sender: System.Object; e: System.EventArgs);
var
  bdr: borland.data.provider.BdpDataReader;
begin
  AppCommon.PopulatePlaceHolders(PlaceHolder_precontent,PlaceHolder_postcontent);
  if not IsPostback then begin
    Title.InnerText := ConfigurationSettings.AppSettings['application_name'] + ' - choose_county_appropriation';
    AppCommon.BdpConnection.Open;
    //
    Label_county_name.Text := session.Item['county_name'].ToString;
    //
    // Load RadioButtonList_appropriation
    //
    bdr := Borland.Data.Provider.BdpCommand.Create
      (
      'SELECT region_dictated_appropriation.id,'
      + 'concat("$",format(region_dictated_appropriation.amount,2)," from ",name," for ",designator) '
      +   'as appropriation_description '
      + 'FROM region_dictated_appropriation '
      +   'JOIN state_dictated_appropriation on (state_dictated_appropriation.id=state_dictated_appropriation_id) '
      +   'JOIN region_code_name_map on (region_code_name_map.code=region_code) '
      +   'JOIN fiscal_year on (fiscal_year.id = fiscal_year_id) '
      + 'WHERE county_code = ' + session.Item['county_user_id'].ToString,
      AppCommon.BdpConnection
      )
      .ExecuteReader;
    while bdr.Read do begin
      RadioButtonList_appropriation.Items.Add(listitem.Create(bdr['appropriation_description'].tostring,bdr['id'].ToString));
    end;
    AppCommon.BdpConnection.Close;
  end;
end;

procedure TWebForm_county_appropriation.OnInit(e: EventArgs);
begin
  //
  // Required for Designer support
  //
  InitializeComponent;
  inherited OnInit(e);
end;

procedure TWebForm_county_appropriation.Button_continue_Click(sender: System.Object;
  e: System.EventArgs);
begin
  session.Remove('region_dictated_appropriation_id');
  session.Add('region_dictated_appropriation_id',Safe(RadioButtonList_appropriation.SelectedValue,NUM));
  server.Transfer('county_dictated_appropriations.aspx');
end;

end.

