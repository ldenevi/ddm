/**
 * GSP - Task manager
 * 
 * Functionalities
 * 
 * - Open task from link in modal dialog
 * - Mark completed: remove from active list and place in completed list
 * - Re-open: remove from completed list and place in active list
 * - Add comment: Resize windows and boxes, append new comment to bottom or top of comment list (user preference)
 * - Remove comment: remove comment from DB and from comment list
 * - Remove excessive scrollbars
 * - Update status popup: Green, yellow red
 * - Load next/previous task
 * 
 * 
 * 
 * 
 */




(function(gsp, window, undefined) {
  // Get DOM elements  
  var $active_tasks_list    = null;
  var $completed_tasks_list = null;
  var $dialog = $("<div id='task_dialog'></div>");
    
  // events
  var evt_marked_completed  = "task.completed";
  var evt_marked_reopened   = "task.reopened";
  var evt_show_comment_form = "task.show-comment-form";
  var evt_hide_comment_form = "task.hide-comment-form";
  /*
  var evt_comment_added     = "task.comment-added";
  var evt_comment_removed   = "task.comment-removed";
  var evt_next_task         = "task.next";
  var evt_previous_task     = "task.previous";
  var evt_status_change     = "task.status-change";
  */
  
  var config = {
    fx : {
      fade_rate   : 500,
      scroll_rate : 200,
    },
    styles : {
      task_completed : "panel-task-completed"
    }
  };
    
  // Task actions
  function show_task(event, url) {
    $dialog.load(url, function(responseText, textStatus, XMLHttpRequest) {
                        TaskWorksheet($(event.target).data("row"));
                      });
    
    // Visuals clean up
    $dialog.dialog(
      {
        open:  function() { $("html body").addClass("no-scrollbar"); },
        close: function() { $("html body").removeClass("no-scrollbar"); }
      }
    );
    $dialog.dialog('open');
    $dialog.trigger('focus');
  }
  
  function mark_completed(event) {
    var row = $(event.target).data("row");
    $.post('/tasks/mark_completed/' + row.id, function(data) {
      move_to_completed_list(row);
    }).fail(function () {  alert("Mark complete failed"); });
    return event;
  }
  
  function reopen(event) {
    var row = $(event.target).data("row");
    $.post('/tasks/reopen/' + row.id, function(data) {
      move_to_active_list(row);
    }).fail(function () {  alert("Reopen failed"); });
    return event;
  }
  
  // UI effects
  function move_to_completed_list(row) {
    var $row = $(row.row);
    var last_tr = $("tr:last-child", $completed_tasks_list);
    
    $row.addClass(config.styles.task_completed);
    $row.hide(config.fx.fade_rate, function () { last_tr.after($row); });
    $row.show(config.fx.fade_rate, function () { /*$('html, body').animate({scrollTop: $row.offset().top}, config.fx.scroll_rate); */ });
    
  }
  
  function move_to_active_list(row) {
    var $row = $(row.row);
    var last_tr = $("tr:last-child", $active_tasks_list);
    
    $row.removeClass(config.styles.task_completed);
    $row.hide(config.fx.fade_rate, function () { last_tr.after($row); });
    $row.show(config.fx.fade_rate, function () { /*$('html, body').animate({scrollTop: $row.offset().top}, config.fx.scroll_rate); */ });
  }
  
  /*********************************************
   * Task Manager objects
   *
   * Custom data classes for handling events,
   * visual behaviors and storing temporary data
   *
   */
   
  /*
   * Row(jQueryTableRow)
   */
  function Row($table_row) {
    var row_object = {
      id       : $table_row.data("task-id"),
      row      : $table_row,
      checkbox : $("input[type=checkbox]", $table_row),
      anchor   : $("a", $table_row),
      
      changeStatus : function () {
        if (this.checked) {
          $(this).trigger(evt_marked_completed);
        }
        else {
          $(this).trigger(evt_marked_reopened);
        }
      },
      
      onMouseEnter : function () {
        active_row = $(this).data("row");
      },
      
      onMouseOut : function () {
      },
      
      showTask : function(event) {
        show_task(event, active_row.anchor.attr("href"));
        return false;
      }
    }
    
    // Events
    row_object.checkbox.bind(evt_marked_completed, mark_completed);
    row_object.checkbox.bind(evt_marked_reopened,  reopen);
    row_object.checkbox.on("click", row_object.changeStatus);
    row_object.checkbox.data("row", row_object);
    
    row_object.row.on("mouseenter", row_object.onMouseEnter);
    //row_object.row.on("click", row_object.showTask);
    row_object.row.data("row", row_object);
    
    row_object.anchor.data("row", row_object);
    row_object.anchor.click(row_object.showTask);
    
    return row_object;
  }
  
  /*
   * TaskWorksheet(Row)
   */
  function TaskWorksheet(source_row) {
    var task_worksheet_object = {
      revealCommentForm  : function() {
                              $('#comment_fake_input').removeClass('show-comment-entry-box');
                              $('#comment_fake_input').addClass('hide-comment-entry-box');
                              $('#comment_input').removeClass('hide-comment-entry-box');
                              $('#comment_input').addClass('show-comment-entry-box');
                              $dialog.animate({scrollTop: $('#comment_entry').offset().top - $("#task_dialog").offset().top}, config.fx.scroll_rate);
                              $dialog.addClass("no-scrollbar");
                           },
      concealCommentForm : function() {
                              $('#comment_fake_input').addClass('show-comment-entry-box');
                              $('#comment_fake_input').removeClass('hide-comment-entry-box');
                              $('#comment_input').addClass('hide-comment-entry-box');
                              $('#comment_input').removeClass('show-comment-entry-box');
                              $dialog.removeClass("no-scrollbar");
                           },
      changeStatus       : function() {
                              source_row.checkbox.trigger("click");
                              source_row.checkbox.trigger("focus");
                              $dialog.dialog("close");
                              $dialog.text("Loading...");
                              return false;
                           }
    };
  
    var status_button = $(".task-close p a, .task-reopen p a", $dialog);
    status_button.on("click", task_worksheet_object.changeStatus);
                        
    $('#comment_fake_input').bind(evt_show_comment_form, task_worksheet_object.revealCommentForm);
    $('#comment_entry iframe').bind(evt_hide_comment_form, task_worksheet_object.concealCommentForm);
                        
    $('#comment_fake_input').on('click', function () { $(this).trigger(evt_show_comment_form);  });
    $("#comment_entry iframe").on("blur", function () { $(this).trigger(evt_hide_comment_form); });
    
  }
  
  
  var TaskManager = function() {
    // Get DOM elements  
    // $active_tasks_list    = $("#active_tasks_list");
    // $completed_tasks_list = $("#completed_tasks_list");
    $task_list = $("#task_list");
    
    // Create dialog box
    $("#content:last-child").after($dialog);
    $dialog.dialog({
      autoOpen:false,
      height: 600,
      width: '90%',
      modal: true
    });
    
    // $("tr", $active_tasks_list).each(function(i, e) { Row($(e)); });
    // $("tr", $completed_tasks_list).each(function(i, e) { Row($(e)); });
    $("tr", $task_list).each(function(i, e) { Row($(e)); });
    

  };
  
  gsp.TaskManager = TaskManager;
  
}(GSP, window));


$(document).ready(function() { 
  GSP.TaskManager();
});
