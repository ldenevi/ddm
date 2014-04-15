$("#email").keyup(function(event) {
  var field = event.target;
  if (validateEmail(event.target.value))
    $(field).removeClass("invalid-email");
  else
    $(field).addClass("invalid-email");
});

function validateEmail(address) {
  var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
  return re.test(address);
}
