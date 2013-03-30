/**
 * GSP - Calendar
 * using wdCalendar (http://www.web-delicious.com/jquery-plugins-demo/wdCalendar/sample.php)
 */
 
 
(function(gsp, window, undefined) {
  var view = "month";
  
  var DATA_FEED_URL = "/calendar/datafeed";
  var op = {
    view: view,
    theme: 3,
    showday: new Date(),
    autoload: true,
    // Command Handlers
    EditCmdhandler:   Edit,
    DeleteCmdhandler: Delete,
    ViewCmdhandler:   View,
    onWeekOrMonthToDay: wtd,
    onBeforeRequestData: cal_beforerequest,
    onAfterRequestData:  cal_afterrequest,
    onRequestDataError:  cal_onerror,
    // Data urls
    url:            DATA_FEED_URL + "/list",
    quickAddUrl:    DATA_FEED_URL + "/add",
    quickUpdateUrl: DATA_FEED_URL + "/update",
    quickDeleteUrl: DATA_FEED_URL + "/remove"
  };
  
  var $dv = $("#calhead");
  var _MH = document.documentElement.clientHeight;
  var dvH = $dv.height() + 2;
  op.height = _MH - dvH - 200;
  op.eventItems = [];
  
  var p = $("#gridcontainer").bcalendar(op).BcalGetOp();
  if (p && p.datestrshow) {
    $("#txtdatetimeshow").text(p.datestrshow);
  }
  $("#caltoolbar").noSelect();
  
  $("#hdtxtshow").datepicker({
    picker: "#txtdatetimeshow",
    showtarget: $("#txtdatetimeshow"),
    onReturn: function(r) {
      var p = $("#gridcontainer").gotoDate(r).BcalGetOp();
      if (p && p.datestrshow) {
        $("#txtdatetimeshow").text(p.datestrshow);
      }
    }
  });
  
  function cal_beforerequest(type) {
    var t = "Loading data...";
    switch(type)
    {
      case 1:
        t = "Loading data...";
        break;
      case 2:
      case 3:
      case 4:
        t = "The request is being processed...";
        break;
    }
    $("#errorpannel").hide();
    $("#loadingpannel").html(t).show();
  }
  
  function cal_afterrequest(type) {
    switch(type)
    {
      case 1:
        $("#loadingpannel").hide();
        break;
      case 2:
      case 3:
      case 4:
        $("#loadingpannel").html("Success!");
        window.setTimeout(function() { $("#loadingpannel").hide();  }, 2000);
        break;
    }
  }
  
  function cal_onerror(type, data) {
    $("#errorpannel").show();
  }
  
  /*
   *  Command handlers
   */
  function Edit(data) {
    var eurl = "/calendar/edit?id={0}&start={2}&end={3}&isallday={4}&title={1}";
    if (data) {
      var url = StrFormat(eurl, data);
      OpenModelWindow(url, {
        width:   600,
        height:  400,
        caption: "Manage the Calendar",
        onclose: function () { $("#gridcontainer").reload(); }
      });
    }
  }
  
  function View(data) {
    var str = "";
    $.each(data, function(i, item) { 
                    str += "[" + i + "]: " + item + "\n";
                  });
    alert(str);
  }
  
  function Delete(data, callback) {
    $.alerts.okButton = "Ok";
    $.alerts.cancelButton = "Cancel";
    hiConfirm("Are you sure you want to delete this event?", "Confirm", function(r) { r && callback(0); });
  };
  
  function wtd(p) {
    if (p && p.datestrshow) {
      $("#txtdatetimeshow").text(p.datestrshow);
    }
    $("#caltoolbar div.fcurrent").each(function() {
      $(this).removeClass("fcurrent");
    });
    $("#showdaybtn").addClass("fcurrent");
  }
  
  
  /*
   *  Add behavior to components
   */
  // Switch to day view
  $("#showdaybtn").click(function(e) {
    $("#caltoolbar div.fcurrent").each(function() {
      $(this).removeClass("fcurrent");
    });
    $(this).addClass("fcurrent");
    var p = $("#gridcontainer").swtichView("day").BcalGetOp();
    if (p && p.datestrshow) {
      $("#txtdatetimeshow").text(p.datestrshow);
    }
  });
  
  // Switch to week view
  $("#showweekbtn").click(function(e) {
    $("#caltoolbar div.fcurrent").each(function() {
      $(this).removeClass("fcurrent");
    });
    $(this).addClass("fcurrent");
    var p = $("#gridcontainer").swtichView("week").BcalGetOp();
    if (p && p.datestrshow) {
      $("#txtdatetimeshow").text(p.datestrshow);
    }
  });
  
  // Switch to month view
  $("#showmonthbtn").click(function(e) {
    $("#caltoolbar div.fcurrent").each(function() {
      $(this).removeClass("fcurrent");
    });
    $(this).addClass("fcurrent");
    var p = $("#gridcontainer").swtichView("month").BcalGetOp();
    if (p && p.datestrshow) {
      $("#txtdatetimeshow").text(p.datestrshow);
    }
  });
  
  // Add new event
  $("#faddbtn").click(function(e) {
    var url = "/edit";
    OpenModelWindow(url, {
      width:   500,
      height:  400,
      caption: "Create New Calendar"});
  });
  
  // Go to day
  $("#showtodaybtn").click(function(e) {
    var p = $("#gridcontainer").gotoDate().BcalGetOp();
    if (p && p.datestrshow) {
      $("#txtdatetimeshow").text(p.datestrshow);
    }
  });
  
  // Previous date range
  $("#sfprevbtn").click(function (e) {
    var p = $("#gridcontainer").previousRange().BcalGetOp();
    if (p && p.datestrshow) {
      $("#txtdatetimeshow").text(p.datestrshow);
    }
  });
  
  // Next date range
  $("#sfnextbtn").click(function (e) {
    var p = $("#gridcontainer").nextRange().BcalGetOp();
    if (p && p.datestrshow) {
      $("#txtdatetimeshow").text(p.datestrshow);
    }
  });
  
}(GSP, window));

