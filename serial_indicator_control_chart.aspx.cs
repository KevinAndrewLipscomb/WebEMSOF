using Class_db_equipment;
using Class_biz_equipment;
using com.quinncurtis.chart2dnet;
using com.quinncurtis.spcchartnet;
using kix;
using System;
using System.Collections;
using System.ComponentModel;
using System.Drawing;
using System.Drawing.Text;
using System.Drawing.Imaging;
using System.Threading;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace serial_indicator_control_chart
{
    public partial class TWebForm1: System.Web.UI.Page
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
            serial_indicator_rec_type datum;
            uint i;
            ((this.Application["spcchartnet_avail"]) as AutoResetEvent).WaitOne();
            // One data point per time period
            // time periods wide
            // time distance between data points
            int width_in_years = 10;
            var chart = new SPCTimeVariableControlChart(SPCControlChartData.INDIVIDUAL_RANGE_CHART, 1, width_in_years, AVERAGE_NUM_MINUTES_PER_YEAR);
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
            var history = new TClass_biz_equipment().SerialIndicatorData(k.Safe(this.Request["indicator"], k.safe_hint_type.ECMASCRIPT_WORD), k.Safe(this.Server.UrlDecode(this.Request["description"]), k.safe_hint_type.PUNCTUATED));
            uint history_count = (uint)(history.Count);
            if (history_count > 0)
            {
                for (i = 0; i <= (history_count - 1); i ++ )
                {
                    datum = ((serial_indicator_rec_type)(history.Dequeue()));
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
            chart.HScrollBar1.LargeChange = width_in_years;
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
            image.SaveImage(this.Response.OutputStream);
            ((this.Application["spcchartnet_avail"]) as AutoResetEvent).Set();

        }

        protected override void OnInit(EventArgs e)
        {
            // Required for Designer support
            InitializeComponent();
            base.OnInit(e);

        }

    } // end TWebForm1

}
