
unit request_overview;

interface

uses
  System.Collections, System.ComponentModel,
  System.Data, System.Drawing, System.Web, System.Web.SessionState,
  System.Web.UI, System.Web.UI.WebControls, System.Web.UI.HtmlControls, AppCommon, system.configuration, borland.data.provider;

type
  TWebForm_request_overview = class(System.Web.UI.Page)
  {$REGION 'Designer Managed Code'}
  strict private
    procedure InitializeComponent;
  {$ENDREGION}
  strict private
    procedure Page_Load(sender: System.Object; e: System.EventArgs);
  strict protected
    Title: System.Web.UI.HtmlControls.HtmlGenericControl;
    PlaceHolder_precontent: System.Web.UI.WebControls.PlaceHolder;
    PlaceHolder_postcontent: System.Web.UI.WebControls.PlaceHolder;
    Label_service_name: System.Web.UI.WebControls.Label;
    Label_num_items_in_shopping_cart: System.Web.UI.WebControls.Label;
    Table_shopping_cart: System.Web.UI.WebControls.Table;
    LinkButton_add_item: System.Web.UI.WebControls.LinkButton;
    Label_fiscal_year_designator: System.Web.UI.WebControls.Label;
    Label_sponsor_county: System.Web.UI.WebControls.Label;
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
procedure TWebForm_request_overview.InitializeComponent;
begin
  Include(Self.Load, Self.Page_Load);
end;
{$ENDREGION}

const ID = '$Id$';

procedure TWebForm_request_overview.Page_Load(sender: System.Object; e: System.EventArgs);
var
  BdpCommand_get_line_items: borland.data.provider.BdpCommand;
begin
  AppCommon.PopulatePlaceHolders(PlaceHolder_precontent,PlaceHolder_postcontent);
  if not IsPostback then begin
    Title.InnerText := ConfigurationSettings.AppSettings['application_name'] + ' - request_overview';
    appcommon.bdpconnection.Open;
    //
    // Set Label_service_name
    //
    Label_service_name.text := session.Item['service_name'].ToString;
    //
    // Set Label_fiscal_year_designator
    //
    Label_fiscal_year_designator.text := session.item['fiscal_year_designator'].tostring;
    //
    // Set Label_sponsor_county
    //
    Label_sponsor_county.text := session.item['sponsor_county'].tostring;
    //
    // Get request line items
    //
//    BdpCommand_get_line_items := borland.data.provider.BdpCommand.Create
//      (
//      'select ',
//      AppCommon.BdpConnection
//      );
    //
    // Set Label_num_items_in_shopping_cart
    //
    //
    // Fill Table_shopping_cart
    //
  end;
end;

procedure TWebForm_request_overview.OnInit(e: EventArgs);
begin
  //
  // Required for Designer support
  //
  InitializeComponent;
  inherited OnInit(e);
end;

end.

