/*
 * Green Status Pro JavaScript Library v0.2.0
 * http://greenstatuspro.com/
 *
 * Copyright (c) 2013, Green Status Investment Club
 *
 * Date: 2013-04-04
 */
 

(function($, window, undefined ) {
"use strict";

  window.$GSP = {};

})(jQuery, window);


/**
 * Template Editor
 *
 * Create or edit template using a WYSIWYG interface.
 * If the template id returned from the server is null,
 * we'll assume the user is creating a new template.
 *
 * For editing, the data will be instantly saved on field blurs.
 * But for editing, since it's impossible to save attributes
 * on a template without an id, we'll create a save button.
 *
 */
(function($GSP, window, undefined) {

  var config = {
    VERSION : '0.2.0',
    styles : {
      editable : 'standard-editable',
      add_or_remove_task_button : 'standard-add-remove-task-button',
      hide_inline_element : 'hide-inline-element',
      editable_highlight : 'inline-editable-highlight',
      changed_highlight  : 'inline-editable-changed-highlight'
    }
  };

  /*
   * URLs for POST, GET, PUT, DELETE elements of the GSP or Organization template.
   * These URLs match ./config/routes.rb URLs
   */
  var organization_urls = {
    put_attributes : "/organization_templates/$1/update_attributes",
  
    // Tasks
    post_task   : "/organization_templates/$1/create_task",
    delete_task : "/organization_templates/$1/destroy_task/$2",
    put_task    : "/organization_templates/$1/update_task/$2",
    get_task    : "/organization_templates/$1/task/$2"
  };
  
  var gsp_urls = {
    // Template attributes
    put_attributes : "/gsp_templates/$1/update_attributes",
  
    // Tasks
    post_task   : "/gsp_templates/$1/create_task",
    delete_task : "/gsp_templates/$1/destroy_task/$2",
    put_task    : "/gsp_templates/$1/update_task/$2",
    get_task    : "/gsp_templates/$1/task/$2"
  };
  
  var urls = {
    'GspTemplate' : gsp_urls,
    'OrganizationTemplate' : organization_urls,
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
  
  
  

}($GSP, window));
