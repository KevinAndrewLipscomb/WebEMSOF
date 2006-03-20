
unit registration;

interface

uses
  System.Collections, System.ComponentModel,
  System.Data, System.Drawing, System.Web, System.Web.SessionState,
  System.Web.UI, System.Web.UI.WebControls, System.Web.UI.HtmlControls, AppCommon,
  System.Data.Common, Borland.Data.Provider, System.Globalization, 
  Borland.Data.Common;

type
  TWebForm_registration = class(System.Web.UI.Page)
  {$REGION 'Designer Managed Code'}
  strict private
    procedure InitializeComponent;
    procedure Button_register_Click(sender: System.Object; e: System.EventArgs);
  {$ENDREGION}
  strict private
    procedure Page_Load(sender: System.Object; e: System.EventArgs);
  strict protected
    PlaceHolder_precontent: System.Web.UI.WebControls.PlaceHolder;
    PlaceHolder_postcontent: System.Web.UI.WebControls.PlaceHolder;
    BdpDataAdapter1: Borland.Data.Provider.BdpDataAdapter;
    bdpSelectCommand1: Borland.Data.Provider.BdpCommand;
    bdpConnection1: Borland.Data.Provider.BdpConnection;
    TextBox_nominal_password: System.Web.UI.WebControls.TextBox;
    RequiredFieldValidator_nominal_password: System.Web.UI.WebControls.RequiredFieldValidator;
    TextBox_confirmation_password: System.Web.UI.WebControls.TextBox;
    RequiredFieldValidator_confirmation_password: System.Web.UI.WebControls.RequiredFieldValidator;
    Button_main_submit: System.Web.UI.WebControls.Button;
    TextBox_nominal_email_address: System.Web.UI.WebControls.TextBox;
    RequiredFieldValidator_nominal_email_address: System.Web.UI.WebControls.RequiredFieldValidator;
    TextBox_confirmation_email_address: System.Web.UI.WebControls.TextBox;
    RequiredFieldValidator_confirmation_email_address: System.Web.UI.WebControls.RequiredFieldValidator;
    CompareValidator_email_addresses: System.Web.UI.WebControls.CompareValidator;
    CompareValidator_passwords: System.Web.UI.WebControls.CompareValidator;
    dataSet_response_agency_names: System.Data.DataSet;
    DataTable1: System.Data.DataTable;
    DataColumn1: System.Data.DataColumn;
    bdpUpdateCommand1: Borland.Data.Provider.BdpCommand;
    RegularExpressionValidator_email_address_rfc_legal: System.Web.UI.WebControls.RegularExpressionValidator;
    RegularExpressionValidator_password_sql_safe: System.Web.UI.WebControls.RegularExpressionValidator;
    Label_service_name: System.Web.UI.WebControls.Label;
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
procedure TWebForm_registration.InitializeComponent;
type
  TArrayOfSystem_Data_Common_DataTableMapping = array of System.Data.Common.DataTableMapping;
  TArrayOfSystem_Data_Common_DataColumnMapping = array of System.Data.Common.DataColumnMapping;
  TArrayOfSystem_Data_DataTable = array of System.Data.DataTable;
  TArrayOfSystem_Data_DataColumn = array of System.Data.DataColumn;
begin
  Self.BdpDataAdapter1 := Borland.Data.Provider.BdpDataAdapter.Create;
  Self.dataSet_response_agency_names := System.Data.DataSet.Create;
  Self.DataTable1 := System.Data.DataTable.Create;
  Self.DataColumn1 := System.Data.DataColumn.Create;
  Self.bdpSelectCommand1 := Borland.Data.Provider.BdpCommand.Create;
  Self.bdpConnection1 := Borland.Data.Provider.BdpConnection.Create;
  Self.bdpUpdateCommand1 := Borland.Data.Provider.BdpCommand.Create;
  (System.ComponentModel.ISupportInitialize(Self.BdpDataAdapter1)).BeginInit;
  (System.ComponentModel.ISupportInitialize(Self.dataSet_response_agency_names)).BeginInit;
  (System.ComponentModel.ISupportInitialize(Self.DataTable1)).BeginInit;
  Include(Self.Button_main_submit.Click, Self.Button_register_Click);
  // 
  // BdpDataAdapter1
  // 
  Self.BdpDataAdapter1.Active := True;
  Self.BdpDataAdapter1.DataSet := Self.dataSet_response_agency_names;
  Self.BdpDataAdapter1.DataTable := Self.DataTable1;
  Self.BdpDataAdapter1.SelectCommand := Self.bdpSelectCommand1;
  Self.BdpDataAdapter1.StartRecord := 0;
  Self.BdpDataAdapter1.TableMappings.AddRange(TArrayOfSystem_Data_Common_DataTableMapping.Create(System.Data.Common.DataTableMapping.Create('T' +
          'able', 'response_agency', TArrayOfSystem_Data_Common_DataColumnMapping.Create(System.Data.Common.DataColumnMapping.Create('n' +
                'ame', 'name')))));
  Self.BdpDataAdapter1.UpdateCommand := Self.bdpUpdateCommand1;
  // 
  // dataSet_response_agency_names
  // 
  Self.dataSet_response_agency_names.DataSetName := 'NewDataSet';
  Self.dataSet_response_agency_names.Locale := System.Globalization.CultureInfo.Create('e' +
    'n-US');
  Self.dataSet_response_agency_names.Tables.AddRange(TArrayOfSystem_Data_DataTable.Create(Self.DataTable1));
  // 
  // DataTable1
  // 
  Self.DataTable1.Columns.AddRange(TArrayOfSystem_Data_DataColumn.Create(Self.DataColumn1));
  Self.DataTable1.TableName := 'response_agency';
  // 
  // DataColumn1
  // 
  Self.DataColumn1.AllowDBNull := False;
  Self.DataColumn1.ColumnName := 'name';
  Self.DataColumn1.MaxLength := 132;
  // 
  // bdpSelectCommand1
  // 
  Self.bdpSelectCommand1.CommandOptions := nil;
  Self.bdpSelectCommand1.CommandText := 'SELECT name FROM kalipso.response_a' +
  'gency';
  Self.bdpSelectCommand1.CommandType := System.Data.CommandType.Text;
  Self.bdpSelectCommand1.Connection := Self.bdpConnection1;
  Self.bdpSelectCommand1.ParameterCount := (SmallInt(0));
  Self.bdpSelectCommand1.SchemaName := nil;
  Self.bdpSelectCommand1.Transaction := nil;
  Self.bdpSelectCommand1.UpdatedRowSource := System.Data.UpdateRowSource.None;
  // 
  // bdpConnection1
  // 
  Self.bdpConnection1.ConnectionOptions := 'transaction isolation=ReadCommit' +
  'ted';
  Self.bdpConnection1.ConnectionString := 'assembly=CoreLab.Bdp.MySql, Versi' +
  'on=2.70.1.2500, Culture=neutral, PublicKeyToken=09af7300eec23701;vendorcl' +
  'ient=libmysql.dll;grow on demand=True;database=kalipso;username=kalipso;m' +
  'ax pool size=100;password=egalmess;provider=MySQL (Core Lab);hostname=db4' +
  'free.org';
  // 
  // bdpUpdateCommand1
  // 
  Self.bdpUpdateCommand1.CommandOptions := nil;
  Self.bdpUpdateCommand1.CommandText := nil;
  Self.bdpUpdateCommand1.CommandType := System.Data.CommandType.Text;
  Self.bdpUpdateCommand1.Connection := Self.bdpConnection1;
  Self.bdpUpdateCommand1.ParameterCount := (SmallInt(0));
  Self.bdpUpdateCommand1.SchemaName := nil;
  Self.bdpUpdateCommand1.Transaction := nil;
  Self.bdpUpdateCommand1.UpdatedRowSource := System.Data.UpdateRowSource.None;
  Include(Self.Load, Self.Page_Load);
  (System.ComponentModel.ISupportInitialize(Self.BdpDataAdapter1)).EndInit;
  (System.ComponentModel.ISupportInitialize(Self.dataSet_response_agency_names)).EndInit;
  (System.ComponentModel.ISupportInitialize(Self.DataTable1)).EndInit;
end;
{$ENDREGION}

procedure TWebForm_registration.Page_Load(sender: System.Object; e: System.EventArgs);
begin
  AppCommon.PopulatePlaceHolders(PlaceHolder_precontent,PlaceHolder_postcontent);
  if not IsPostback then
    begin
    Label_service_name.Text := session.Item['userid'].ToString;
    end;
end;

procedure TWebForm_registration.OnInit(e: EventArgs);
begin
  //
  // Required for Designer support
  //
  InitializeComponent;
  inherited OnInit(e);
end;

procedure TWebForm_registration.Button_register_Click(sender: System.Object;
  e: System.EventArgs);
begin
bdpUpdateCommand1.CommandText := 'UPDATE kalipso.response_agency'
+  ' SET webemsof_primary_email_address = "' + TextBox_nominal_email_address.Text + '"'
+  '   , encoded_password = sha("' + TextBox_nominal_password.Text + '")'
+  ' WHERE name = "' + session.Item['userid'].ToString + '"';
bdpUpdateCommand1.Connection.Open;
bdpUpdateCommand1.ExecuteNonQuery;
server.Transfer('welcome.aspx');
end;

end.

