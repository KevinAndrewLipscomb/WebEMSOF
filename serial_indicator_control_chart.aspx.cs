using Class_biz_equipment;
using Class_db_equipment;
using com.quinncurtis.chart2dnet;
using com.quinncurtis.spcchartnet;
using kix;
using System;
using System.Configuration;
using System.Drawing;
using System.Drawing.Imaging;
using System.Drawing.Text;
using System.Threading;

namespace serial_indicator_control_chart
{
    public partial class TWebForm1: ki_web_ui.page_class
    {
        // / <summary>
        // / Required method for Designer support -- do not modify
        // / the contents of this method with the code editor.
        // / </summary>
        private void InitializeComponent()
        {
        }

        protected void Page_Load(object sender, System.EventArgs e)
        {
            const int AVERAGE_NUM_MINUTES_PER_YEAR = 525948;
            // takes into account all scheduled leap days
            TClass_db_equipment.serial_indicator_rec_type datum;
            uint i;
            ((Application["spcchartnet_avail"]) as AutoResetEvent).WaitOne();
            // One data point per time period
            // time periods wide
            // time distance between data points
            var width_in_years = new k.int_positive(27);
            if (!string.IsNullOrEmpty(ConfigurationManager.AppSettings["serial_indicator_control_chart_width_in_years"]))
              {
              width_in_years.val = int.Parse(ConfigurationManager.AppSettings["serial_indicator_control_chart_width_in_years"]);
              }
            if (!string.IsNullOrEmpty(Request["width_in_years"]))
              {
              width_in_years.val = int.Parse(k.Safe(Request["width_in_years"],k.safe_hint_type.NUM));
              }
            using var chart = new SPCTimeVariableControlChart(SPCControlChartData.INDIVIDUAL_RANGE_CHART, 1, width_in_years.val, AVERAGE_NUM_MINUTES_PER_YEAR);
            chart.Bounds = new Rectangle(0, 0, 781, 417);
            SPCControlChartData.DefaultSampleValueString = k.EMPTY;
            chart.ChartAlarmEmphasisMode = SPCChartBase.ALARM_HIGHLIGHT_SYMBOL;
            chart.ChartData.DefectiveDecimalPrecision = 0;
            chart.EnableAlarmStatusValues = false;
            chart.EnableCalculatedValues = false;
            chart.EnableNotes = false;
            chart.EnableScrollBar = true;
            chart.EnableTimeValues = false;
            chart.EnableTotalSamplesValues = false;
            chart.HeaderStringsLevel = SPCControlChartData.HEADER_STRINGS_LEVEL0;
            chart.PrimaryChart.ControlLineMode = SPCChartObjects.CONTROL_LINE_VARIABLE;
            chart.PrimaryChart.DisplayChart = true;
            chart.TextRenderingHint = TextRenderingHint.ClearTypeGridFit;
            var history = new TClass_biz_equipment().SerialIndicatorData(k.Safe(Request["indicator"], k.safe_hint_type.ECMASCRIPT_WORD), k.Safe(Server.UrlDecode(Request["description"]), k.safe_hint_type.PUNCTUATED));
            uint history_count = (uint)(history.Count);
            if (history_count > 0)
            {
                for (i = 0; i <= (history_count - 1); i ++ )
                {
                    datum = ((TClass_db_equipment.serial_indicator_rec_type)(history.Dequeue()));
                    if (i == 0)
                      {
                      chart.ChartData.SetControlLimitValues(new double[] {datum.value,datum.value,datum.value});
                      }
                    chart.ChartData.AddNewSampleRecord(new ChartCalendar((int)(datum.year), 5, 31), new DoubleArray(new double[] {datum.value}));
                    if (i > 0)
                      {
                      chart.AutoCalculatePrimaryControlLimits();
                      }
                }
            }
            chart.AutoScalePrimaryChartYRange();
            chart.ChartData.SetSampleRowHeaderString(0, k.EMPTY);
            chart.HScrollBar1.Maximum = (int)(history_count);
            chart.HScrollBar1.LargeChange = width_in_years.val;
            int potential_scrollbar_value = chart.HScrollBar1.Maximum - chart.HScrollBar1.LargeChange;
            if (potential_scrollbar_value < chart.HScrollBar1.Minimum)
              {
              chart.HScrollBar1.Value = chart.HScrollBar1.Minimum;
              }
            else if (potential_scrollbar_value > chart.HScrollBar1.Maximum)
              {
              chart.HScrollBar1.Value = chart.HScrollBar1.Maximum;
              }
            else
              {
              chart.HScrollBar1.Value = potential_scrollbar_value;
              }
            chart.RebuildChartUsingCurrentData();
            var image = new BufferedImage(chart, ImageFormat.Jpeg);
            image.JpegImageQuality = 100;
            image.SaveImage(Response.OutputStream);
            ((Application["spcchartnet_avail"]) as AutoResetEvent).Set();

        }

        protected override void OnInit(EventArgs e)
        {
            // Required for Designer support
            InitializeComponent();
            base.OnInit(e);

        }

    } // end TWebForm1

}
