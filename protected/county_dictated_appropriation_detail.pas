
unit county_dictated_appropriation_detail;

interface

uses
  System.Collections, System.ComponentModel,
  System.Data, System.Drawing, System.Web, System.Web.SessionState,
  System.Web.UI, System.Web.UI.WebControls, System.Web.UI.HtmlControls, AppCommon, system.configuration, system.web.security,
  borland.data.provider;

type
  TWebForm_county_dictated_appropriation_detail = class(System.Web.UI.Page)
  {$REGION 'Designer Managed Code'}
  strict private
    procedure InitializeComponent;
    procedure LinkButton_logout_Click(sender: System.Object; e: System.EventArgs);
    procedure DataGrid_items_ItemDataBound(sender: System.Object; e: System.Web.UI.WebControls.DataGridItemEventArgs);
  {$ENDREGION}
  strict private
    procedure Page_Load(sender: System.Object; e: System.EventArgs);
  strict protected
    Title: System.Web.UI.HtmlControls.HtmlGenericControl;
    PlaceHolder_precontent: System.Web.UI.WebControls.PlaceHolder;
    PlaceHolder_postcontent: System.Web.UI.WebControls.PlaceHolder;
    LinkButton_logout: System.Web.UI.WebControls.LinkButton;
    HyperLink_change_password: System.Web.UI.WebControls.HyperLink;
    HyperLink_change_email_address: System.Web.UI.WebControls.HyperLink;
    Label_account_descriptor: System.Web.UI.WebControls.Label;
    HyperLink_back: System.Web.UI.WebControls.HyperLink;
    Label_parent_appropriation_amount: System.Web.UI.WebControls.Label;
    Label_sponsor_county: System.Web.UI.WebControls.Label;
    Label_fiscal_year_designator: System.Web.UI.WebControls.Label;
    Label_sum_of_emsof_antes: System.Web.UI.WebControls.Label;
    Label_unused_amount: System.Web.UI.WebControls.Label;
    DataGrid_items: System.Web.UI.WebControls.DataGrid;
    Label_service_name: System.Web.UI.WebControls.Label;
    Label_affiliate_num: System.Web.UI.WebControls.Label;
    TableRow_sum_of_emsof_antes: System.Web.UI.HtmlControls.HtmlTableRow;
    TableRow_unrequested_amount: System.Web.UI.HtmlControls.HtmlTableRow;
    Label_num_items: System.Web.UI.WebControls.Label;
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
procedure TWebForm_county_dictated_appropriation_detail.InitializeComponent;
begin
  Include(Self.LinkButton_logout.Click, Self.LinkButton_logout_Click);
  Include(Self.DataGrid_items.ItemDataBound, Self.DataGrid_items_ItemDataBound);
  Include(Self.Load, Self.Page_Load);
end;
{$ENDREGION}

const ID = '$Id$';

var
  num_items: cardinal;
  parent_appropriation_amount: decimal;
  total_emsof_ante: decimal;

procedure TWebForm_county_dictated_appropriation_detail.Page_Load(sender: System.Object; e: System.EventArgs);
begin
  AppCommon.PopulatePlaceHolders(PlaceHolder_precontent,PlaceHolder_postcontent);
  if not IsPostback then begin
    //
    Title.InnerText := server.HtmlEncode(ConfigurationSettings.AppSettings['application_name']) + ' - county_dictated_appropriation_detail';
    Label_account_descriptor.text := session.item['county_name'].tostring + ' County';
    //
    // Initialize implementation-wide vars.
    //
    num_items := 0;
    total_emsof_ante := 0;
    //
    Label_fiscal_year_designator.text := session.item['fiscal_year_designator'].tostring;
    Label_service_name.text := session.item['service_name'].tostring;
    Label_affiliate_num.text := session.item['affiliate_num'].tostring;
    parent_appropriation_amount := decimal.Parse(session.item['appropriation_amount'].tostring);
    Label_parent_appropriation_amount.text := parent_appropriation_amount.tostring('C');
    Label_sponsor_county.text := session.item['county_name'].tostring;
    //
    appcommon.DbOpen;
    //
    DataGrid_items.DataSource := borland.data.provider.bdpcommand.Create
      (
      'select priority,'
      + ' make_model,'
      + ' if(be_refurbished,"(refurbished)","") as be_refurbished,'
      + ' description as category,'
      + ' place_kept,'
      + ' quantity,'
      + ' unit_cost,'
      + ' (quantity*unit_cost) as subtotal,'
      + ' allowable_cost,'
      + ' emsof_ante,'
      + ' (emsof_ante/(quantity*unit_cost)) as effective_match_level'
      + ' from emsof_request_detail'
      +   ' join eligible_provider_equipment_list'
      +     ' on (eligible_provider_equipment_list.code=emsof_request_detail.equipment_code)'
      +   ' join emsof_request_master on (emsof_request_master.id=emsof_request_detail.master_id)'
      + ' where county_dictated_appropriation_id = ' + session.item['county_dictated_appropriation_id'].tostring
      +   ' and emsof_request_detail.status_code <> 6'
      + ' order by priority',
      appcommon.db
      )
      .ExecuteReader;
    DataGrid_items.DataBind;
    //
    Label_sum_of_emsof_antes.text := total_emsof_ante.tostring('C');
    Label_unused_amount.text := (parent_appropriation_amount - total_emsof_ante).tostring('C');
    Label_num_items.text := num_items.tostring;
    //
    appcommon.DbClose;
    //
  end;
end;

procedure TWebForm_county_dictated_appropriation_detail.OnInit(e: EventArgs);
begin
  //
  // Required for Designer support
  //
  InitializeComponent;
  inherited OnInit(e);
end;

procedure TWebForm_county_dictated_appropriation_detail.DataGrid_items_ItemDataBound(sender: System.Object;
  e: System.Web.UI.WebControls.DataGridItemEventArgs);
begin
  if (e.item.itemtype = listitemtype.alternatingitem)
    or (e.item.itemtype = listitemtype.edititem)
    or (e.item.itemtype = listitemtype.item)
    or (e.item.itemtype = listitemtype.selecteditem)
  then begin
    //
    // We are dealing with a data row, not a header or footer row.
    //
    num_items := num_items + 1;
    total_emsof_ante := total_emsof_ante + decimal.Parse(databinder.Eval(e.item.dataitem,'emsof_ante').tostring);
  end;
end;

procedure TWebForm_county_dictated_appropriation_detail.LinkButton_logout_Click(sender: System.Object;
  e: System.EventArgs);
begin
  formsauthentication.SignOut;
  session.Clear;
  server.Transfer('../Default.aspx');
end;

end.

