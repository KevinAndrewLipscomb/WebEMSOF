unit appcommon;

interface

uses
  system.configuration,
  system.web.UI.WebControls;

const ID = '$Id$';

procedure PopulatePlaceHolders
  (
  var precontent: System.Web.Ui.WebControls.PlaceHolder;
  var postcontent: System.Web.Ui.WebControls.PlaceHolder
  );

implementation

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
  +       '<img src="https://' + ConfigurationSettings.AppSettings['ssl_base_path'] + '/'
  +         ConfigurationSettings.AppSettings['application_name']
  +         '/protected/image/logo_left.gif" align="center" valign="middle" width="113" height="99" />'
  +     '</td>'
  +     '<td align="left" valign="top" width=1>'
  +       '<img src="https://' + ConfigurationSettings.AppSettings['ssl_base_path'] + '/'
  +         ConfigurationSettings.AppSettings['application_name']
  +         '/protected/image/logo_right.gif" align="left" valign="top" width="135" height="100" />'
  +     '</td>'
  +     '<td nowrap valign=top>'
  +       '<p>'
  +         '<small>'
  +           '221-2500 Penn Avenue '
  +           '<a href="http://www.emsi.org/location/index.shtml">'
  +             '<b><span style="font-variant: small-caps">(map)</span></b>'
  +           '</a>'
  +           '<br>'
  +           'Pittsburgh, PA 15221-2166<br>'
  +           'tel:+1-412-242-7322<br>'
  +           'tel:+1-866-827-EMSI (3674)<br>'
  +           'fax:+1-412-242-7434<br>'
  +           '<a href="mailto:info@emsi.org">info@emsi.org</a>'
  +         '</small>'
  +       '</p>'
  +     '</td>'
  +   '</tr>'
  + '</table>'
  + '<h1>' + ConfigurationSettings.AppSettings['application_name'] + ' system</h1>'
  + '<table cellspacing="0" cellpadding="10" width="100%" border="0">'
  + '	 <tr>'
  + '		 <td valign="top" width="15%">'
  + '		   <table bordercolor="#dcdcdc" cellspacing="0" cellpadding="0" border="1">'
  + '			   <tr>'
  + '			     <td>'
  + '				     <table cellspacing="0" cellpadding="5" border="0">'
  + '					     <tr>'
  + '					       <td bgcolor="#f5f5f5"><small><strong>EMSOF documents</strong></small></td>'
  + '					     </tr>'
  + '					     <tr>'
  + '					       <td>'
  + '                  <small><small>These links open in a new window.</small></small>'
  + '                  <table cellspacing="0" cellpadding="5" border="0">'
  + '	                   <tr>'
  + '                      <td valign="top"><li></li></td>'
  + '		                   <td><small><a href="/frompaper2web/WebEMSOF/resource/funding-priorities-epel-fy0607.pdf" target="_blank">Funding Priorities and Eligible Provider Equipment List</a></small></td>'
  + '	                   </tr>'
  + '	                   <tr>'
  + '                      <td valign="top"><li></li></td>'
  + '		                   <td><small><a href="/frompaper2web/WebEMSOF/resource/emsi-emsof-allocations-memo-fy0607.pdf" target="_blank">Regional announcement</a></small></td>'
  + '	                   </tr>'
  + '	                   <tr>'
  + '                      <td valign="top"><li></li></td>'
  + '		                   <td><small><a href="/frompaper2web/WebEMSOF/resource/terms-and-conditions.pdf" target="_blank">Terms and Conditions</a></small></td>'
  + '	                   </tr>'
  + '                  </table>'
  + '                </td>'
  + '					     </tr>'
  + '				     </table>'
  + '          </td>'
  + '			   </tr>'
  + '		   </table>'
  + '      <p></p>'
  + '		   <table bordercolor="#dcdcdc" cellspacing="0" cellpadding="0" border="1">'
  + '			   <tr>'
  + '			     <td>'
  + '				     <table cellspacing="0" cellpadding="5" border="0">'
  + '					     <tr><td bgcolor="#f5f5f5"><small><strong>Process improvement</strong></small></td></tr>'
  + '					     <tr><td><small><small>You can help us make WebEMSOF better!</small></small></td></tr>'
  + '              <tr>'
  + '                <td>'
  + '                  <small><small>Copy any fatal errors and paste them into an email '
  + '                    <a href="mailto:feedback@frompaper2web.com?subject=WebEMSOF%20bug%20report">here</a>.</small></small>'
  + '                </td>'
  + '              </tr>'
  + '              <tr><td><small><small>Send suggestions <a href="mailto:feedback@frompaper2web.com?subject=WebEMSOF%20suggestion">here</a>.</small></small></td></tr>'
  + '              <tr><td><small><small><strong>Thanks!</strong></small></small></td></tr>'
  + '				     </table>'
  + '          </td>'
  + '			   </tr>'
  + '		   </table>'
  + '    </td>'
  + '		 <td valign="top">';
  precontent.Controls.Add(literal);
  validation_summary_control := System.Web.Ui.WebControls.ValidationSummary.Create;
  precontent.Controls.Add(validation_summary_control);
end;

PROCEDURE PopulatePostcontent(var postcontent: System.Web.Ui.WebControls.PlaceHolder);
var
  literal: System.Web.Ui.WebControls.Literal;
begin
  literal := System.Web.Ui.WebControls.Literal.Create;
  literal.Text := ''
  + '    </td>'
  + '	 </tr>'
  + '</table>'
  + '<!-- Copyright Kalips''o Infogistics LLC -->';
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

end.
