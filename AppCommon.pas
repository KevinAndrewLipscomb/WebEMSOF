unit AppCommon;

interface

  uses
    borland.data.provider,
    system.Web.UI.WebControls,
    vault;

  const
    HOST_DOMAIN_NAME = 'localhost';
    SENDER_EMAIL_ADDRESS = '"WebEMSOF" <kevin.lipscomb@kvrs.org>';

  var
    BdpConnection: borland.data.provider.bdpconnection;

  procedure PopulatePlaceHolders
    (
    var precontent: System.Web.Ui.WebControls.PlaceHolder;
    var postcontent: System.Web.Ui.WebControls.PlaceHolder
    );

implementation

  procedure PopulatePrecontent(var precontent: System.Web.Ui.WebControls.PlaceHolder);
  var
    literal: System.Web.Ui.WebControls.Literal;
    validation_summary_control: System.Web.Ui.WebControls.ValidationSummary;
  begin
    literal := System.Web.Ui.WebControls.Literal.Create;
    literal.Text := ''
      + '<table cellpadding=5>'
      +   '<tr>'
      +     '<td valign=top width=1>'
      +       'logo-1' //<img src="http://www.emsi.org/images/logo_left.gif" align="center" valign="middle" width="113" height="99" />'
      +     '</td>'
      +     '<td align="left" valign="top" width=1>'
      +       'logo-2' //<img src="http://www.emsi.org/images/logo_right.gif" align="left" valign="top" width="135" height="100" />'
      +     '</td>'
      +     '<td nowrap valign=top>'
      +       '<p>'
		  +         '<small>'
			+           'address' //221-2500 Penn Avenue '
      //+           '<a href="http://www.emsi.org/location/index.shtml">'
      +             '<b><span style="font-variant: small-caps">(map)</span></b>'
      //+           '</a>'
      +           '<br>'
      +           'city-state-zip<br>' //Pittsburgh, PA 15221-2166<br>'
      +           'tel-1<br>' //tel:+1-412-242-7322<br>'
      +           'tel-2<br>' //tel:+1-866-827-EMSI (3674)<br>'
      +           'fax<br>' //fax:+1-412-242-7434<br>'
      +           'email' //<a href="mailto:info@emsi.org">info@emsi.org</a>'
      +         '</small>'
      +       '</p>'
      +     '</td>'
      +   '</tr>'
      + '</table>'
      + '<h1>TUTORIAL EXERCISE 1 system</h1>'; //WebEMSOF system</h1>';
    precontent.Controls.Add(literal);
    validation_summary_control := System.Web.Ui.WebControls.ValidationSummary.Create;
    precontent.Controls.Add(validation_summary_control);
  end;

  procedure PopulatePostcontent(var postcontent: System.Web.Ui.WebControls.PlaceHolder);
  var
    literal: System.Web.Ui.WebControls.Literal;
  begin
    literal := System.Web.Ui.WebControls.Literal.Create;
    literal.Text := '<!-- Copyright Kalips''o Infogistics LLC -->';
    postcontent.Controls.Add(literal);
  end;

  procedure PopulatePlaceHolders
    (
    var precontent: System.Web.Ui.WebControls.PlaceHolder;
    var postcontent: System.Web.Ui.WebControls.PlaceHolder
    );
  begin
  PopulatePrecontent(precontent);
  PopulatePostcontent(postcontent);
  end;

begin
BdpConnection := borland.data.provider.bdpconnection.Create;
BdpConnection.ConnectionOptions := 'transaction isolation=ReadCommitted';
BdpConnection.ConnectionString := 'assembly=CoreLab.Bdp.MySql, Versi' +
  'on=2.70.1.2500, Culture=neutral, PublicKeyToken=09af7300eec23701;vendorcl' +
  'ient=libmysql.dll;grow on demand=True;database=kalipso;username=kalipso;m' +
  'ax pool size=100;password=' + vault.PASSWORD + ';provider=MySQL (Core Lab);min pool siz' +
  'e=0;hostname=db4free.org';
end.
