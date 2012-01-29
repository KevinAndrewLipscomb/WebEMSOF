// Derived from template~protected~nonlanding.aspx.cs~template

using AjaxControlToolkit;
using Class_biz_coned_offering_rosters;
using Class_biz_coned_offerings;
using Class_biz_counties;
using Class_biz_practitioners;
using Class_msg_protected;
using kix;
using System;
using System.Collections;
using System.Configuration;
using System.Drawing;
using System.Web.UI.WebControls;

namespace coned_offering_roster
  {
  public struct p_type
    {
    public bool be_ok_to_edit_roster;
    public bool be_sort_order_ascending;
    public TClass_biz_coned_offering_rosters biz_coned_offering_rosters;
    public TClass_biz_coned_offerings biz_coned_offerings;
    public TClass_biz_counties biz_counties;
    public TClass_biz_practitioners biz_practitioners;
    public string class_id;
    public TClass_msg_protected.coned_offering_roster incoming;
    public k.int_nonnegative num_attendees;
    public k.int_nonnegative num_attendees_with_known_birth_dates;
    public string sort_order;
    public k.decimal_nonnegative total_class_hours;
    }

  public partial class TWebForm_coned_offering_roster: ki_web_ui.page_class
    {
    private class coned_offering_roster_Static
      {
      public const int TCI_DELETE = 0;
      public const int TCI_ID = 1;
      public const int TCI_PRACTITIONER_ID = 2;
      public const int TCI_LAST_NAME = 3;
      public const int TCI_FIRST_NAME = 4;
      public const int TCI_MIDDLE_INITIAL = 5;
      public const int TCI_LEVEL = 6;
      public const int TCI_CERT_NUM = 7;
      public const int TCI_BE_DOB_CONFIRMED = 8;
      public const int TCI_DOB = 9;
      public const int TCI_COUNTY_CODE = 10;
      public const int TCI_COUNTY_NAME = 11;
      public const int TCI_EMAIL_ADDRESS = 12;
      public const int TCI_BE_INSTRUCTOR = 13;
      public const int TCI_INSTRUCTOR_HOURS = 14;
      public const int TCI_EDIT_UPDATE_CANCEL = 15;
      }

    private p_type p;

    private void AddPractitionerToRosterAndInitForNewSearch(ListItem list_item)
      {
      p.biz_coned_offering_rosters.Set(id:k.EMPTY,coned_offering_id:p.class_id,practitioner_id:list_item.Value,instructor_hours:k.EMPTY);
      Bind();
      TextBox_practitioner.Text = k.EMPTY;
      InitForNewSearch();
      }

    private void Bind()
      {
      p.num_attendees.val = 0;
      p.num_attendees_with_known_birth_dates.val = 0;
      DataGrid_control.Columns[coned_offering_roster_Static.TCI_DELETE].Visible = p.be_ok_to_edit_roster;
      p.biz_coned_offering_rosters.BindBaseDataListByClassId(p.sort_order,p.be_sort_order_ascending,DataGrid_control,p.class_id);
      TableRow_none.Visible = (p.num_attendees.val == 0);
      DataGrid_control.Visible = (p.num_attendees.val > 0);
      Focus(TextBox_practitioner,be_using_scriptmanager:true,be_redo:true);
      }

    private void InitForNewSearch()
      {
      Literal_click_to_add.Text = k.NO_BREAK_SPACE;
      ListBox_practitioner.Items.Clear();
      ListBox_practitioner.Items.Add(k.EMPTY);
      ListBox_practitioner.Items.Add("Type at least one letter into the Search box above.");
      ListBox_practitioner.Items.Add(k.EMPTY);
      ListBox_practitioner.Items.Add("Format is:");
      ListBox_practitioner.Items.Add(k.NO_BREAK_SPACE + k.NO_BREAK_SPACE + "Lastname, Firstname MI, Cert#, DOB");
      ListBox_practitioner.Enabled = false;
      Focus(TextBox_practitioner,be_using_scriptmanager:true);
      }

    // / <summary>
    // / Required method for Designer support -- do not modify
    // / the contents of this method with the code editor.
    // / </summary>
    private void InitializeComponent()
      {
      this.PreRender += this.TWebForm_coned_offering_roster_PreRender;
      }

    private void InjectPersistentClientSideScript()
      {
      ToolkitScriptManager.RegisterStartupScript(Page,Page.GetType(),"SearchAsYouTypePostBackDelayTimer","var search_as_you_type_post_back_delay_timer;",true);
      EstablishClientSideFunction(k.client_side_function_enumeral_type.EL);
      EstablishClientSideFunction("SearchAsYouTypePostBack()","__doPostBack('<%= TextBox_practitioner.ClientID %>','');");
      Body_control.Attributes.Add
        (
        "onkeypress",
        k.EMPTY
        + " return (event.keyCode != 13)"  // Prevent default behavior of performing a postback when enter key is pressed since we want to evaluate the situation first in the TextBox_practitioner onkeyup event.
        );
      TextBox_practitioner.Attributes.Add
        (
        "onkeyup",
        k.EMPTY
        + " if (value != El('" + HiddenField_practitioner_saved.ClientID + "').value)"
        +   " {"
        +   " El('" + HiddenField_practitioner_saved.ClientID + "').value = value;"
        +   " search_as_you_type_post_back_delay_timer = setTimeout('SearchAsYouTypePostBack();',1000);" // 1000 millseconds = 1 second delay
        +   " }"
        + " else"
        +   " {"
        +   " if (El('" + ListBox_practitioner.ClientID + "').options.length == 1)"
        +     " {"
        +     " return WebForm_FireDefaultButton(event, 'Button_add');"
        +     " }"
        +   " }"
        );
      TextBox_practitioner.Attributes.Add
        (
        "onkeydown",
        k.EMPTY
        + " if (value != El('" + HiddenField_practitioner_saved.ClientID + "').value) clearTimeout(search_as_you_type_post_back_delay_timer);"
        );
      }

    private void SetCloseAndSubmitAblements(bool ablement)
      {
      Button_close_and_submit.Enabled = ablement;
      CustomValidator_close_class_and_submit_for_credit.Enabled = ablement;
      }

    private void TWebForm_coned_offering_roster_PreRender(object sender, System.EventArgs e)
      {
      SessionSet(InstanceId() + ".p", p);
      }

    //==
    //
    // protected
    //
    //==

    protected void Button_add_Click(object sender, EventArgs e)
      {
      if (ListBox_practitioner.Items.Count == 1)
        {
        AddPractitionerToRosterAndInitForNewSearch(ListBox_practitioner.Items[0]);
        }
      }

    protected void Button_close_and_submit_Click(object sender, EventArgs e)
      {
      if (IsValid)
        {
        p.biz_coned_offerings.CloseAndSubmit(p.incoming.summary,p.num_attendees);
        p.be_ok_to_edit_roster = false;
        Bind();
        SetCloseAndSubmitAblements(false);
        }
      else
        {
        ValidationAlert(be_using_scriptmanager:true);
        }
      }

    protected void CustomValidator_close_class_and_submit_for_credit_ServerValidate(object source, ServerValidateEventArgs args)
      {
      args.IsValid = p.biz_coned_offerings.BeOkToCloseClassAndSubmitForCredit(p.incoming.summary,p.num_attendees,p.num_attendees_with_known_birth_dates);
      }

    protected void CustomValidator_dob_ServerValidate(object source, ServerValidateEventArgs args)
      {
      var dob = DateTime.MinValue;
      args.IsValid = DateTime.TryParse(args.Value,out dob) && (dob > DateTime.Today.AddYears(-130)) && (dob <= DateTime.Today.AddYears(-16));
      }

    protected void CustomValidator_email_address_ServerValidate(object source, ServerValidateEventArgs args)
      {
      var args_value = k.Safe(args.Value.Replace("user@domain.tld",k.EMPTY),k.safe_hint_type.EMAIL_ADDRESS);
      args.IsValid = (args_value.Length == 0) || k.BeValidDomainPartOfEmailAddress(args_value);
      }

    protected void CustomValidator_instructor_hours_ServerValidate(object source, ServerValidateEventArgs args)
      {
      var args_value = k.Safe(args.Value.Replace("#.#",k.EMPTY),k.safe_hint_type.REAL_NUM);
      decimal instructor_hours;
      args.IsValid = (args_value.Length == 0) || (decimal.TryParse(args_value,out instructor_hours) && (instructor_hours > 0) && (instructor_hours <= p.total_class_hours.val));
      }

    protected void DataGrid_control_CancelCommand(object source, DataGridCommandEventArgs e)
      {
      DataGrid_control.EditItemIndex = -1;
      Bind();
      SetCloseAndSubmitAblements(p.be_ok_to_edit_roster);
      }

    protected void DataGrid_control_DeleteCommand(object source, DataGridCommandEventArgs e)
      {
      if (new ArrayList {ListItemType.AlternatingItem,ListItemType.Item,ListItemType.EditItem,ListItemType.SelectedItem}.Contains(e.Item.ItemType))
        {
        p.biz_coned_offering_rosters.Delete(k.Safe(e.Item.Cells[coned_offering_roster_Static.TCI_ID].Text,k.safe_hint_type.NUM));
        DataGrid_control.EditItemIndex = -1;
        Bind();
        SetCloseAndSubmitAblements(p.be_ok_to_edit_roster);
        }
      }

    protected void DataGrid_control_EditCommand(object source, DataGridCommandEventArgs e)
      {
      DataGrid_control.EditItemIndex = e.Item.ItemIndex;
      Bind();
      SetCloseAndSubmitAblements(false);
      }

    protected void DataGrid_control_ItemDataBound(object sender, DataGridItemEventArgs e)
      {
      LinkButton link_button;
      if (new ArrayList {ListItemType.AlternatingItem,ListItemType.Item,ListItemType.EditItem,ListItemType.SelectedItem}.Contains(e.Item.ItemType))
        {
        link_button = ((e.Item.Cells[coned_offering_roster_Static.TCI_DELETE].Controls[0]) as LinkButton);
        link_button.Text = k.ExpandTildePath(link_button.Text);
        link_button.ToolTip = "Delete";
        //
        var edit_update_cancel_controls = e.Item.Cells[coned_offering_roster_Static.TCI_EDIT_UPDATE_CANCEL].Controls;
        if (edit_update_cancel_controls.Count == 1)
          {
          var label_dob = (e.Item.Cells[coned_offering_roster_Static.TCI_DOB].FindControl("Label_dob") as Label);
          if (label_dob.Text == "REQUIRED")
            {
            label_dob.Font.Bold = true;
            label_dob.ForeColor = Color.Red;
            }
          else
            {
            p.num_attendees_with_known_birth_dates.val++;
            }
          //
          var label_email_address = (e.Item.Cells[coned_offering_roster_Static.TCI_EMAIL_ADDRESS].FindControl("Label_email_address") as Label);
          if (label_email_address.Text == "DESIRED")
            {
            label_email_address.ForeColor = Color.DarkOrange;
            }
          //
          if (e.Item.Cells[coned_offering_roster_Static.TCI_BE_INSTRUCTOR].Text == "1")
            {
            var label_instructor_hours = (e.Item.Cells[coned_offering_roster_Static.TCI_INSTRUCTOR_HOURS].FindControl("Label_instructor_hours") as Label);
            label_instructor_hours.Visible = true;
            if (label_instructor_hours.Text == "none")
              {
              label_instructor_hours.ForeColor = Color.LightGray;
              }
            }
          //
          link_button = (edit_update_cancel_controls[0] as LinkButton);
          link_button.Text = k.ExpandTildePath(link_button.Text);
          link_button.ToolTip = "Edit";
          }
        else
          {
          link_button = (edit_update_cancel_controls[0] as LinkButton);
          link_button.Text = k.ExpandTildePath(link_button.Text);
          link_button.ToolTip = "Save edit";
          // Skip comment_edit_update_cancel_controls[1].  It's a literal spacer.
          link_button = (edit_update_cancel_controls[2] as LinkButton);
          link_button.Text = k.ExpandTildePath(link_button.Text);
          link_button.ToolTip = "Cancel edit";
          //
          var text_box_dob = (e.Item.Cells[coned_offering_roster_Static.TCI_DOB].FindControl("TextBox_dob") as TextBox);
          if (text_box_dob.Text == "REQUIRED")
            {
            text_box_dob.Text = k.EMPTY;
            }
          text_box_dob.Enabled = p.be_ok_to_edit_roster && (e.Item.Cells[coned_offering_roster_Static.TCI_BE_DOB_CONFIRMED].Text == "0");
          //
          var drop_down_list_county = e.Item.Cells[coned_offering_roster_Static.TCI_COUNTY_NAME].FindControl("DropDownList_county") as DropDownList;
          p.biz_counties.BindDirectToListControl(drop_down_list_county);
          drop_down_list_county.SelectedValue = e.Item.Cells[coned_offering_roster_Static.TCI_COUNTY_CODE].Text;
          //
          var text_box_email_address = (e.Item.Cells[coned_offering_roster_Static.TCI_EMAIL_ADDRESS].FindControl("TextBox_email_address") as TextBox);
          if (text_box_email_address.Text == "DESIRED")
            {
            text_box_email_address.Text = k.EMPTY;
            }
          //
          if (e.Item.Cells[coned_offering_roster_Static.TCI_BE_INSTRUCTOR].Text == "1")
            {
            var text_box_instructor_hours = (e.Item.Cells[coned_offering_roster_Static.TCI_INSTRUCTOR_HOURS].FindControl("TextBox_instructor_hours") as TextBox);
            text_box_instructor_hours.Visible = true;
            if (text_box_instructor_hours.Text == "none")
              {
              text_box_instructor_hours.Text = k.EMPTY;
              }
            text_box_instructor_hours.Enabled = p.be_ok_to_edit_roster;
            }
          }
        //--
        // DON'T disable viewstate here since thes server needs it to repopulate bound controls when an update is made to an UpdatePanel other than the one that isolates the DataGrid_control.
        //--
        //
        // Remove all cell controls from viewstate except for the one at TCI_ID.
        //
        //foreach (TableCell cell in e.Item.Cells)
        //  {
        //  cell.EnableViewState = false;
        //  }
        //e.Item.Cells[coned_offering_roster_Static.TCI_ID].EnableViewState = true;
        //
        p.num_attendees.val++;
        }
      }

    protected void DataGrid_control_SortCommand(object source, DataGridSortCommandEventArgs e)
      {
      if (e.SortExpression == p.sort_order)
        {
        p.be_sort_order_ascending = !p.be_sort_order_ascending;
        }
      else
        {
        p.sort_order = k.Safe(e.SortExpression, k.safe_hint_type.KI_SORT_EXPRESSION);
        p.be_sort_order_ascending = true;
        }
      DataGrid_control.EditItemIndex = -1;
      Bind();
      SetCloseAndSubmitAblements(p.be_ok_to_edit_roster);
      }

    protected void DataGrid_control_UpdateCommand(object source, DataGridCommandEventArgs e)
      {
      if (IsValid)
        {
        var practitioner_id = k.Safe(e.Item.Cells[coned_offering_roster_Static.TCI_PRACTITIONER_ID].Text,k.safe_hint_type.NUM);
        p.biz_coned_offering_rosters.Set
          (
          k.Safe(e.Item.Cells[coned_offering_roster_Static.TCI_ID].Text,k.safe_hint_type.NUM),
          p.class_id,
          practitioner_id,
          k.Safe((e.Item.Cells[coned_offering_roster_Static.TCI_INSTRUCTOR_HOURS].FindControl("TextBox_instructor_hours") as TextBox).Text.Replace("#.#",k.EMPTY),k.safe_hint_type.REAL_NUM)
          );
        p.biz_practitioners.SetFieldsNotImportedFromState
          (
          practitioner_id,
          DateTime.Parse(k.Safe((e.Item.Cells[coned_offering_roster_Static.TCI_DOB].FindControl("TextBox_dob") as TextBox).Text,k.safe_hint_type.DATE_TIME)),
          k.Safe((e.Item.Cells[coned_offering_roster_Static.TCI_COUNTY_CODE].FindControl("DropDownList_county") as DropDownList).SelectedValue,k.safe_hint_type.NUM),
          k.Safe((e.Item.Cells[coned_offering_roster_Static.TCI_EMAIL_ADDRESS].FindControl("TextBox_email_address") as TextBox).Text.Replace("user@domain.tld",k.EMPTY),k.safe_hint_type.EMAIL_ADDRESS)
          );
        DataGrid_control.EditItemIndex = -1;
        Bind();
        SetCloseAndSubmitAblements(p.be_ok_to_edit_roster);
        }
      else
        {
        ValidationAlert(be_using_scriptmanager:true);
        }
      }

    protected void ListBox_practitioner_SelectedIndexChanged(object sender, EventArgs e)
      {
      AddPractitionerToRosterAndInitForNewSearch(ListBox_practitioner.SelectedItem);
      }

    protected override void OnInit(EventArgs e)
      {
      // Required for Designer support
      InitializeComponent();
      base.OnInit(e);
      var nature_of_visit = NatureOfVisit(InstanceId() + ".p");
      if (nature_of_visit == nature_of_visit_type.VISIT_INITIAL)
        {
        //
        // Initialize p.~ objects here.
        //
        p.biz_coned_offering_rosters = new TClass_biz_coned_offering_rosters();
        p.biz_coned_offerings = new TClass_biz_coned_offerings();
        p.biz_counties = new TClass_biz_counties();
        p.biz_practitioners = new TClass_biz_practitioners();
        //
        p.be_sort_order_ascending = true;
        p.incoming = Message<TClass_msg_protected.coned_offering_roster>(folder_name:"protected",aspx_name:"coned_offering_roster");
        p.num_attendees = new k.int_nonnegative();
        p.num_attendees_with_known_birth_dates = new k.int_nonnegative();
        p.sort_order = "last_name%,first_name,middle_initial,certification_number,birth_date";
        //
        p.be_ok_to_edit_roster = p.biz_coned_offerings.BeOkToEditRoster(p.incoming.summary);
        p.class_id = p.biz_coned_offerings.ClassIdOf(p.incoming.summary);
        p.total_class_hours = p.biz_coned_offerings.TotalClassHoursOf(p.incoming.summary);
        }
      else if (nature_of_visit == nature_of_visit_type.VISIT_POSTBACK_STANDARD)
        {
        p = (p_type)(Session[InstanceId() + ".p"]);
        }
//
//ToolkitScriptManager.GetCurrent(Page).EnablePartialRendering = false;
//
      }

    protected void Page_Load(object sender, System.EventArgs e)
      {
      if (!IsPostBack)
        {
        Title = Server.HtmlEncode(ConfigurationManager.AppSettings["application_name"]) + " - coned_offering_roster";
        var max_spec_length = p.biz_practitioners.MaxSpecLength(Session["region_code"].ToString(),k.EMPTY);
        TextBox_practitioner.Width = new Unit(max_spec_length.val*0.535,UnitType.Em);
        ListBox_practitioner.Width = new Unit(max_spec_length.val*0.650,UnitType.Em);
        InitForNewSearch();
        Literal_course_title.Text = p.biz_coned_offerings.CourseTitleOf(p.incoming.summary);
        var raw_class_number = p.biz_coned_offerings.ClassNumberOf(p.incoming.summary);
        Literal_class_number.Text = raw_class_number.Substring(0,2) + k.SPACE + raw_class_number.Substring(2,6) + k.SPACE + raw_class_number.Substring(8,6);
        Literal_location.Text = p.biz_coned_offerings.LocationOf(p.incoming.summary);
        Literal_start.Text = p.biz_coned_offerings.StartOf(p.incoming.summary);
        Literal_end.Text = p.biz_coned_offerings.EndOf(p.incoming.summary);
        Literal_total_class_hours.Text = p.total_class_hours.val.ToString();
        Literal_be_approved.Text = k.YesNoOf(p.biz_coned_offerings.BeApprovedOf(p.incoming.summary));
        Bind();
        SetCloseAndSubmitAblements(p.be_ok_to_edit_roster);
        RequireConfirmation
          (
          Button_close_and_submit,
          "Closing this class will prevent you from adding or removing practitioners from the roster, and from editing any birth dates or instructor hours." + k.NEW_LINE
          + k.NEW_LINE
          + "To proceed, click OK:"
          );
        }
      InjectPersistentClientSideScript();
      }

    protected void TextBox_practitioner_TextChanged(object sender, EventArgs e)
      {
      DataGrid_control.EditItemIndex = -1;
      Bind();
      SetCloseAndSubmitAblements(p.be_ok_to_edit_roster);
      UpdatePanel_attendees.Update();
      //
      var practitioner = k.Safe(TextBox_practitioner.Text,k.safe_hint_type.PUNCTUATED);
      p.biz_practitioners.BindDirectToListControlForRoster(ListBox_practitioner,Session["region_code"].ToString(),practitioner);
      if (practitioner.Length > 0)
        {
        if (ListBox_practitioner.Items.Count > 0)
          {
          Literal_click_to_add.Text = "Click a practitioner below to add to roster:";
          ListBox_practitioner.Enabled = true;
          }
        else
          {
          Literal_click_to_add.Text = k.NO_BREAK_SPACE;
          ListBox_practitioner.Items.Add(k.EMPTY);
          ListBox_practitioner.Items.Add("No match. Try backspacing.");
          ListBox_practitioner.Items.Add(k.EMPTY);
          ListBox_practitioner.Enabled = false;
          }
        }
      else
        {
        InitForNewSearch();
        }
      Focus(TextBox_practitioner,be_using_scriptmanager:true,be_redo:true);
      }

    } // end TWebForm_coned_offering_roster

  }