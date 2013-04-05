/*
 * Green Status Pro JavaScript Library v0.2.0
 * http://greenstatuspro.com/
 *
 * Copyright 2013, Green Status Investment Club
 * http://jquery.org/license
 *
 * Date: 2013-04-04
 *
 * = User Interface Elements =
 *
 * + Balloon popup
 * + Instant list filter
 * + Slide paginator
 * + Tag input
 * + Concealed form input
 * + Attachment pillbox (inline attachment removal or editing)
 * + Inline Element-to-Field editor
 *
 */
 

(function($GSP, $, window, undefined) {
"use strict";
var ui = {};
$GSP.ui = ui;
})($GSP, jQuery, window);



/*
 * Balloon popup
 *
 */
(function($GSPUI, $, window, undefined) {
"use strict";

// TODO: I'm not sure if this should be in the JavaScript or in a separate HTML document
var _balloon_html_structure = '\
<div class="balloon">\
 <div class="balloon-header">\
  <div class="balloon-title">\
  </div>\
  <div class="balloon-close">\
  close\
  </div>\
 </div>\
 <div class="balloon-body">\
 </div>\
</div>\
';

function Balloon(DOMElement, evoke_method, index) {
  var $element   = $(DOMElement);
  var balloon_id = "balloon-" + index;
  
  // Create balloon div
  var initial_css = {
    position : 'absolute',
    top  : $element.offset().top + ($element.height() / 2),
    left : $element.offset().left + $element.width() + 10
  };
  
  var balloon_code = $(_balloon_html_structure);
  $(balloon_code).css(initial_css);
  $(balloon_code).attr("id", balloon_id);
  $("body").append(balloon_code);
  
  // load base/gsp.ui.balloon.css stylesheet
  $("head").append($("<link href=\"/assets/gspjs/base/gsp.ui.balloon.css\" media=\"all\" rel=\"stylesheet\" type=\"text/css\" />"));
  
  // Attach event handlers to balloon div
  var balloon = {
        selector : "#" + balloon_id,
        $        : $("#" + balloon_id),
        url      : $element.attr("href"),
        cache    : null,
        
        click : function(event) {
          show(event);
          return false;
        },
        
        close : function(event) {
          $("#"+balloon_id).fadeOut(500);
        },
        
        show : function(event) {
          show(event);
        },
        
        position : function(window) {
          var balloon = $("#"+balloon_id);
          var top = balloon.offset().top - (balloon.height() / 2);
          if (top < 0) { top = 0; }
          balloon.css("top", top);
          
          var window = $(window);          
          var width = balloon.width();
          if (width + balloon.offset().left > window.width()) {
            balloon.css("left", window.width() - width);
          }
        },
        
        setTitle : function() {
          var text  = $("title", $("#" + balloon_id)).text();
          var title = $(".balloon-title", $("#" + balloon_id));
          title.text(text);
        }
      };
      
  function show(event) {
    $(".balloon[gsp-ui-balloon-active=true]").fadeOut(0, function() {
      $(this).attr("gsp-ui-balloon-active", "false");
    });
    if (!balloon.cache) {
      $(".balloon-body", balloon.$).load(balloon.url, function(responseText, textStatus, XMLHttpRequest) { 
                                                        balloon.cache = responseText;
                                                        balloon.position(window);
                                                        balloon.setTitle();
                                                      });
    }
    
    balloon.$.fadeIn(500);
    balloon.$.attr("gsp-ui-balloon-active", "true");
  }

  switch(evoke_method)
  {
    case 'click':
      $element.bind('click', balloon.click);
      $(".balloon-close", balloon.$).bind('click', balloon.close);
      break;
      
    // TODO: FIX ME! I SPAZ OUT WHEN I POPUP
    case 'hover':
      $element.bind('click', function () { return false; });
      $element.bind('mouseover', balloon.show);
      $(balloon.$).bind('mouseout', balloon.close);
      break;
  }
  
  
  $(document).bind('keyup', function(event){
    if(event.keyCode == 27){
      balloon.close();
    }
  });
  
}

// Attach balloons to DOMs
$('document').ready(function () {

  // onClick balloons
  $("a[data-gsp-ui-balloon]").each(function (index, element) {
    $(element).data('gsp-ui-balloon');
    Balloon(element, $(element).data('gsp-ui-balloon'), index);
  });
  
});

})($GSP.ui, jQuery, window);
