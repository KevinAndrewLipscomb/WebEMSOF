UNIT AppCommon;

INTERFACE

uses
  borland.data.provider,
  system.configuration,
  system.text.regularexpressions,
  system.Web.UI.WebControls;

const
  APOSTROPHE = '''';
  DOUBLE_APOSTROPHE = '''''';
  DOUBLE_QUOTE = '""';
  NEW_LINE = #10;
  NULL_STRING = '';
  QUOTE = '"';

type
  safe_hint_type =
    (
    NONE,
    ALPHANUM,
    ECMASCRIPT_WORD,
    EMAIL_ADDRESS,
    HOSTNAME,
    HUMAN_NAME,
    HYPHENATED_NUM,
    NUM,
    PHONE_NUM,
    POSTAL_CITY,
    POSTAL_STREET_ADDRESS,
    REAL_NUM
    );

var
  BdpConnection: borland.data.provider.bdpconnection;

function Safe
  (
  source_string: string;
  hint: safe_hint_type = NONE
  )
  : string;

procedure PopulatePlaceHolders
  (
  var precontent: System.Web.Ui.WebControls.PlaceHolder;
  var postcontent: System.Web.Ui.WebControls.PlaceHolder
  );

IMPLEMENTATION

const ID = '$Id';

FUNCTION Safe
  (
  source_string: string;
  hint: safe_hint_type = NONE
  )
  : string;
var
  allow: string;
  scratch_string: string;
begin
  allow := NULL_STRING;
  case hint of
    //
    // Be extremely protective here:
    // -  Escape ("\") the following eleven characters: [\^$.|?*+()
    // -  For scalars, do not allow punctuation.
    // -  When in doubt, don't allow it.
    //
    // This routine is not intended to assure that data is submitted in proper
    // format.  It is intended to protect against SQL insertion attacks.
    //
    ALPHANUM:
      allow := '0-9a-zA-Z';
    ECMASCRIPT_WORD:
      allow := '0-9a-zA-Z_';
    EMAIL_ADDRESS:
      allow := '0-9a-zA-Z_\.@-';
    HOSTNAME:
      allow := '0-9a-zA-z_-\.';
    HUMAN_NAME:
      allow := 'a-zA-z-\. ' + APOSTROPHE;
    HYPHENATED_NUM:
      allow := '0-9-';
    NUM:
      allow := '0-9';
    PHONE_NUM:
      allow := '0-9-\+\(\) ';
    POSTAL_CITY:
      allow := 'a-zA-Z-\. ' + APOSTROPHE;
    POSTAL_STREET_ADDRESS:
      allow := '0-9a-zA-Z#-,\(\)\. ' + APOSTROPHE;
    REAL_NUM:
      allow := '0-9\.';
  end;
  //
  if allow = NULL_STRING then
    scratch_string := NULL_STRING
  else
    begin
    scratch_string := regex.Replace(source_string,'[^' + allow + ']',NULL_STRING);
    regex.Replace(scratch_string,APOSTROPHE,DOUBLE_APOSTROPHE);
    regex.Replace(scratch_string,QUOTE,DOUBLE_QUOTE);
    end;
  //
  Safe := scratch_string;
end;

  PROCEDURE PopulatePrecontent(var precontent: System.Web.Ui.WebControls.PlaceHolder);
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
    + '<h1>' + ConfigurationSettings.AppSettings['application_name'] + ' system</h1>';
  precontent.Controls.Add(literal);
  validation_summary_control := System.Web.Ui.WebControls.ValidationSummary.Create;
  precontent.Controls.Add(validation_summary_control);
end;

PROCEDURE PopulatePostcontent(var postcontent: System.Web.Ui.WebControls.PlaceHolder);
var
  literal: System.Web.Ui.WebControls.Literal;
begin
  literal := System.Web.Ui.WebControls.Literal.Create;
  literal.Text := '<!-- Copyright Kalips''o Infogistics LLC -->';
  postcontent.Controls.Add(literal);
end;

PROCEDURE PopulatePlaceHolders
  (
  var precontent: System.Web.Ui.WebControls.PlaceHolder;
  var postcontent: System.Web.Ui.WebControls.PlaceHolder
  );
begin
PopulatePrecontent(precontent);
PopulatePostcontent(postcontent);
end;

BEGIN
BdpConnection := borland.data.provider.bdpconnection.Create;
BdpConnection.ConnectionOptions := 'transaction isolation=ReadCommitted';
BdpConnection.ConnectionString := ConfigurationSettings.AppSettings['bdp_connection_string'];
END.
