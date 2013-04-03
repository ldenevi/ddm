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
      VERSION : '0.1.1',
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
 

