/**
 * GSP - Review manager
 */
(function(gsp, window, undefined) {
  var DOM_validated = false;
  
  var classes = {
    task : '.review-task',
    task_attributes : '.review-task-attributes',
    date : '.review-date',
    review_attributes : '.review-attributes',
    comment_button : '.review-task-comment-button',
    comment_form   : '.review-task-comment-form'
  };

  /*
   * Review object
   */
  function load_dom_elements() {
    // Required elements
    var DOM = {
      review_page : $("#review_page"),
      review_attributes : $("#review_attributes"),
      review_tasks : $("#review_tasks"),
      review_form : $("#review_page form")
    };
    
    // Validate their existence in the DOM
    for (prop in DOM) {
      if (DOM[prop].length == 0) {
        throw "Required DOM element '"+prop+"' not detected in HTML";
      }
    }
    
    return DOM;
  };
  
  var Review = function (form) {
    this.DOM = load_dom_elements();
    this.classes = classes;
    
    // Tasks
    this.tasks = [];
    var jq_tasks = $(classes.task);
    for (var i=0; i < jq_tasks.length; i++) {  this.tasks.push(new Task(jq_tasks[i]));  }
    
    var TaskPaginator = function(review) {
      self = this;
      this.tasks = review.tasks;
      this.active_task_index = 0;
      this.total_tasks_count = review.tasks.length;
      this.previous_button = $("#review_tasks .review-task-page-previous");
      this.next_button     = $("#review_tasks .review-task-page-next");
      this.page_reference  = $("#task_page_numbers");
      
      this.next = function () {
        if (self.active_task_index == (self.total_tasks_count - 1))
          return;
        else {
          self.tasks[self.active_task_index].JQueryElement.slideUp(500);
          self.active_task_index++;
          self.tasks[self.active_task_index].JQueryElement.slideDown(500);
          self.update_task_page_number();
        }
      };
      
      this.previous = function () {
        if (self.active_task_index == 0) {
          return;
        }
        else {
          self.tasks[self.active_task_index].JQueryElement.slideUp(500);
          self.active_task_index--;
          self.tasks[self.active_task_index].JQueryElement.slideDown(500);
          self.update_task_page_number();
        }
      };
      
      this.update_task_page_number = function () {
        this.page_reference.empty();
        this.page_reference.append("&nbsp;" + (this.active_task_index + 1) + " / " + this.total_tasks_count + "&nbsp;");
      };
      
      this.previous_button.on('click', this.previous);
      this.next_button.on('click', this.next);
      this.update_task_page_number();
      var first_task = this.tasks[0].JQueryElement;
      first_task.removeClass('review-task-inactive');
      first_task.addClass('review-task-active');
    };
    
    this.task_paginator = new TaskPaginator(this);
    
    // Add JQuery UI DatePicker to all date fields
    $(".date-range").each(function(index, element) {
                            $("td > .start-date", element).datepicker({dateFormat:"MM d, yy", numberOfMonths:3, onClose:function(selectedDate) {
                                                                                                                        $(".end-date", element).datepicker( "option", "minDate", selectedDate);
                                                                                                                      }});
                            $("td > .end-date", element).datepicker({dateFormat:"MM d, yy", numberOfMonths:3, onClose:function(selectedDate) {
                                                                                                                        $(".start-date", element).datepicker( "option", "maxDate", selectedDate);
                                                                                                                      }});
                          });
    
  };
  
  /*
   * Task object
   */
  var Task = function (DOMElement) {
    this.JQueryElement = $(DOMElement);
    this.DOM = DOMElement;
    this.dom_id = this.DOM.id;
    this.hidden_fields = $("#" + this.dom_id + " input[type=hidden]");
    this.attributes = {};
    
    for (var i=0; i < this.hidden_fields.length; i++) {
      var field = this.hidden_fields[i];
      var id_split = field.id.split('_');
      var name = id_split[id_split.length - 1];
      this.attributes[name] = field.value;
    }
  };
  
  gsp.Review = Review;
  
}(GSP, window));

$(document).ready(function() { 
  new GSP.Review($('#review_prepare'));
});
