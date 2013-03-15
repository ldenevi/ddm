/*
 * Old JavaScript.... this will be gone soon.
 *
 *
 */

/* Task comments */
function append_posted_comment(comment_id) {
  $.get("/review/task/comment/"+comment_id+"/show", function(data) {
      $('#comment-insertion-marker').after(data);
  });
};


var OrganizationTree = null;

function logout() {
  if(confirm("Are you sure you want to log out of the application?"))
    document.location = "/users/sign_out";
};


function load_organization(id) {
  tree_array = $.getJSON('/organization/hierarchy', function(data) { build_ecotree(data); });
}

function build_ecotree(data) {
  var orgTree = new ECOTree("orgTree", "organization_tree");
  for (var i = 0; i < data.length; i++) {
    // .add(id, pid, description, width, height, color, bgcolor, target, meta)
    orgTree.add(data[i]["id"], data[i]["parent_id"], data[i]["name"], 175, null, null, null, "javascript:select_organization("+data[i]["id"]+")", null);
  }
  
  // config
  orgTree.config.defaultNodeWidth = 450;
  orgTree.config.expandedImage = '';
  orgTree.config.collapsedImage = '';
  orgTree.config.transImage = '';
  
  orgTree.UpdateTree();
  OrganizationTree = orgTree;
}

function select_organization(id) {
  OrganizationTree.selectNode(id, true);
}

/* Panel Tasks */
var Task = {};
Task.toggle_completed = function(task_id, caller) {
  if(caller.checked)
    Task.mark_completed(task_id);
  else
    Task.unmark_completed(task_id);
};

Task.mark_completed = function(task_id) {
  var row = $("#active-task-row-" + task_id)
  // Mark row as completed
  row.addClass('panel-task-completed');
  // Send completion POST request
  //   if fails, unmark row, popup modal dialog error, return
  $.post('/tasks/mark_completed/' + task_id, function(data) {
    // Fade away row
    row.fadeOut(600);
    // Add row to completed tasks panel (if panel exists in DOM)
    $("#completed-tasks").load('tasks/recently_completed_tasks');
  });

};

Task.unmark_completed = function(task_id) {
  // Unmark row as completed
  $("#active-task-row-" + task_id).removeClass('panel-task-completed');
  // Send reopen POST request
  //   if fails, mark row, popup modal dialog error, return
  // Fade away row
  // Add row to completed tasks panel (if panel exists in DOM)

};

/*===================
  End old code
  ===================*/




/**
 * GSP JavaScript module
 *
 */
 
if(!GSP) { var GSP = {}; }
 
(function(gsp, window, undefined) {
  // GSP library requires JQuery
  if ((typeof $ == undefined) || (!$.get || !$.post || !$.ajax)) {
    throw "GSP - TemplateManager error: JQuery not found!";
    return false;
  }
  
  // GSP.config
  gsp.config = {
    constants : {
      VERSION : '0.0.1',
      AUTHOR  : 'Leonardo de Nevi <leonardo.denevi@greenstatuspro.com>'
    }
  };
  
  String.prototype.merge_params = function(args) {
    var new_string = this;
    for (var i = 0; i < args.length; i++) {
      var j = i + 1;
      new_string = new_string.replace("$" + j, args[i]);
    }
    return new_string;
  };
  
  String.prototype.merge_param = function(arg) {
    return this.replace("$1", arg);
  };
  
  String.prototype.strip_surrounding_whitespace = function() {
    return this.replace(/^\s+|\s+$/g, '');
  };
  
}(GSP, window));
 

/**
 * GSP - Template Manager
 */
(function(gsp, window, undefined) {
  if (typeof CKEditor == undefined) {
    throw "GSP - TemplateManager error: CKEditor not found!";
    return false;
  }

  var TemplateManager = {};
  /*
   * TemplateManager configurations
   */
  var config = {
    template_types : ["GspTemplate", "OrganizationTemplate", "Review"],
    styles : {
      editable : 'standard-editable',
      add_or_remove_task_button : 'standard-add-remove-task-button',
      hide_inline_element : 'hide-inline-element'
    }
  };

  
  /*
   * URLs for POST, GET, PUT, DELETE elements of GSP, Organization or Review templates.
   * These URLs match ./config/routes.rb URLs
   */
  var organization_template_urls = {
    // Template attributes
    put_attributes : "/organization_templates/$1/update_attributes",
  
    // Tasks
    post_task   : "/organization_templates/$1/create_task",
    delete_task : "/organization_templates/$1/destroy_task/$2",
    put_task    : "/organization_templates/$1/update_task/$2",
    get_task    : "/organization_templates/$1/task/$2"
  };
  
  var gsp_template_urls = {
    // Template attributes
    put_attributes : "/gsp_templates/$1/update_attributes",
  
    // Tasks
    post_task   : "/gsp_templates/$1/create_task",
    delete_task : "/gsp_templates/$1/destroy_task/$2",
    put_task    : "/gsp_templates/$1/update_task/$2",
    get_task    : "/gsp_templates/$1/task/$2"
  };
  
  var review_template_urls = {
    // Template attributes
    put_attributes : "/reviews/$1/update_attributes",
  
    // Tasks
    post_task   : "/reviews/$1/create_task",
    delete_task : "/reviews/$1/destroy_task/$2",
    put_task    : "/reviews/$1/update_task/$2",
    get_task    : "/reviews/$1/task/$2"
  };
  
  var urls = {
    'GspTemplate' : gsp_template_urls,
    'OrganizationTemplate' : organization_template_urls,
    'Review' : review_template_urls,
    get_field_options : '/templates/field_options/$1'
  };
  
  /*
   * AJAX server calls. RESTful operations for manipulating a GSP, Organization or Review template.
   * 
   */
  var ajax = {};
  
  var update_attributes = function (template_type, template_id, task_sequence, params) { };
  var add_task          = function (template_type, template_id, params) { };
  var remove_task       = function (template_type, template_id) { };
  var update_task       = function (template_type, template_id) { };
  
  
  /*
   * Invisible <FORM>s for dynamically manipulating template data.
   * 
   * Create form objects on elements which use data- attributes
   */
  var inline = {};
  
// Private methods
  function validate_required_attributes (JQueryElement) {
    var required_attributes = ['data-template-type', 'data-field-name', 'data-template-id'];
    
    for (var i = 0; i < required_attributes.length; i++) {
      required_attributes[i];
      if (JQueryElement.attr(required_attributes[i]) == undefined) {
        throw "Missing attribute '" + required_attributes[i] + "' in:\n" + JQueryElement.html();
        return false;
      }
    }
    return true;
  };
  
  /*
   * Onclick will hide the read-only HTML element with its assigned form.
   * When form is unfocused without change, read-only form reappears.
   * When form is changed, AJAX PUT request is sent; on success read-only form reappears
   */
  function swap_reader_writer_elements(event) {
    var hide_style = config.styles.hide_inline_element;
  
    var element = $(this);
    var elementPair = $(element.data("elementPair"));
    element.addClass(hide_style);
    elementPair.removeClass(hide_style);
    elementPair.trigger('focus');
    console.log("swap_reader_writer_elements");
  };
  
  /*
   * Form types
   * 
   * 1) <SELECT> options
   * 2) <INPUT TYPE="TEXT"> field (uses CKEditor)
   * 
   */
  function create_select_form_for(JQueryElement) {
    var last_element = JQueryElement.last();
    var form = document.createElement("FORM");
    
    form.action = urls[JQueryElement.data('templateType')].put_attributes.merge_param(JQueryElement.data('templateId'));
    form.method = 'PUT';
    
    var select  = document.createElement("SELECT");
    select.name = JQueryElement.data('fieldName');
    $(select).addClass(config.styles.hide_inline_element);
    
    // Element pairing and Visibility events
    JQueryElement.on('click', swap_reader_writer_elements);
    JQueryElement.data('elementPair', select);
    $(select).data('elementPair', JQueryElement);
    $(select).on('blur', swap_reader_writer_elements);
    
    // Fetch options from server
    $.getJSON(urls.get_field_options.merge_param(JQueryElement.data('fieldName')), function (data) {
      for (var i = 0; i < data.length; i++) {
        var option   = document.createElement("OPTION");
        option.text  = data[i][0];
        option.value = data[i][1];

        if (JQueryElement.html().strip_surrounding_whitespace() == data[i][0].strip_surrounding_whitespace()) {
          option.selected = true;
        }
        select.appendChild(option);
      }
    });
    
    form.appendChild(select);
    last_element.after(form);
  };
  
  var select = function (JQueryElement) {
    if (!validate_required_attributes(JQueryElement))
      return false;
    create_select_form_for(JQueryElement);
  };
  
  var text   = function (JQueryElement) {
    if (!validate_required_attributes(JQueryElement))
      return false;
    create_text_form_for(JQueryElement);
  };
  
  inline.select = select;
  inline.text   = text;
  
  
  
  // Attach to modules
  TemplateManager.config = config;
  TemplateManager.ajax   = ajax;
  TemplateManager.inline = inline;
  gsp.TemplateManager    = TemplateManager;
  
  
  $(document).ready(function () {
    $("*[data-inline-edit]").addClass("inline-editable-highlight");
    $("*[data-inline-edit=select]").each(function () {
      inline.select($(this));
    });
  });
  
  
   
}(GSP, window));


