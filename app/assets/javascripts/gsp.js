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
