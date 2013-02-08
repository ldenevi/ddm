var OrganizationTree = null;


function logout() {
  if(confirm("Are you sure you want to log out of the application?"))
    document.location = "/";
};


function load_organization(id) {
  tree_array = $.getJSON('/orghier/' + parseInt(id), function(data) { build_ecotree(data); });
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
