
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
    VERSION : '0.1.5',
    template_types : ["GspTemplate", "OrganizationTemplate", "Review"],
    styles : {
      editable : 'standard-editable',
      add_or_remove_task_button : 'standard-add-remove-task-button',
      hide_inline_element : 'hide-inline-element',
      editable_highlight : 'inline-editable-highlight',
      changed_highlight  : 'inline-editable-changed-highlight'
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
  
  ajax.update_attributes = function (action, data, callBack) { $.ajax({type: 'PUT', url: action, data: data, success: callBack}); };
  ajax.add_task          = function (template_type, template_id, task_sequence, params) { };
  ajax.remove_task       = function (template_type, template_id, task_sequence) { };
  
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
    var hide_style  = config.styles.hide_inline_element;
    var element     = $(this);
    var elementPair = $(element.data("elementPair"));
    element.addClass(hide_style);
    elementPair.removeClass(hide_style);
    elementPair.trigger('focus');
  };
  
  function persist_change(event, form, is_task) {
    ajax.update_attributes(form.action, $(form).serialize(), function() { console.log("Success."); });
    return true;
  };
  
  /*
   * Form types
   * 
   * 1) <SELECT> options
   * 2) <INPUT TYPE="HIDDEN"> field (uses CKEditor)
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
  
  function create_text_form_for(JQueryElement) {
    var last_element = JQueryElement.last();
    var form = document.createElement("FORM");
    
    var action_urls = urls[JQueryElement.data('templateType')];
    var is_task     = (JQueryElement.data("task-sequence") != undefined);
    
    form.action = (is_task) ? action_urls.put_task.merge_params([JQueryElement.data('templateId'), JQueryElement.data('task-sequence')]) : action_urls.put_attributes.merge_param(JQueryElement.data('templateId'));
    form.method = 'PUT';
    
    var textfield = document.createElement("INPUT");
        textfield.type = "hidden";
        textfield.name = JQueryElement.data('fieldName');
        textfield.value = JQueryElement.html();
    
    JQueryElement.on('blur', function (event) { 
      me = $(this);
      if (me.data("content-changed")) {
        textfield.value = me.html();
        persist_change(event, form);
      }
    });
    
    form.appendChild(textfield);
    last_element.after(form);
  };
  
  var select = function (JQueryElement) {
    if (!validate_required_attributes(JQueryElement))
      return false;
    create_select_form_for(JQueryElement);
  };
  
  var textfield = function (JQueryElement) {
    if (!validate_required_attributes(JQueryElement))
      return false;
    create_text_form_for(JQueryElement);
  };
  
  inline.select    = select;
  inline.textfield = textfield;
  
  // Attach to modules
  TemplateManager.toString = function () { return "GSP Template Manager v" + this.config.VERSION };
  TemplateManager.config = config;
  TemplateManager.ajax   = ajax;
  TemplateManager.inline = inline;
  gsp.TemplateManager    = TemplateManager;
  
  
  $(document).ready(function () {
    var styles = config.styles;
    $("*[data-inline-edit]").addClass(styles.editable_highlight);
    // On a key press, mark as changed and quit tracking key presses
    $("*[data-inline-edit]").on('keydown', function (event) { 
      var me = $(this);
      me.data("content-changed", "true");
      me.removeClass(styles.editable_highlight);
      me.addClass(styles.changed_highlight);
    });
    $("*[data-inline-edit=select]").each(function () { inline.select($(this));  });
    $("*[data-inline-edit=textfield]").each(function () { inline.textfield($(this));   });
    
  });
   
}(GSP, window));


