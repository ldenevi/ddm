var email_text_field = $("#email");
var sign_up_form     = $("#sign_up_form");

email_text_field.keyup(function(event) {
  var field = event.target;
  if (validateEmail(event.target.value))
    $(field).removeClass("invalid-email");
  else
    $(field).addClass("invalid-email");
});

function validateEmail(address) {
  if (address.length == 0)
    return false;
  var re = /^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
  return re.test(address);
}

sign_up_form.submit(function(event) {
  var addr     = email_text_field.val();
  var is_valid = validateEmail(addr);

  if (!is_valid) {
    alert("Invalid email");
    return false;
  }
  else {
    return true;
  }
})
