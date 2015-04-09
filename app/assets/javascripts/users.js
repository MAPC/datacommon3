$(document).on('ready', function () {
  
  $("#new_user").validate({
    rules: {
      "user[username]":   {
        required:  true,
        minlength: 5,
        maxlength: 30,
        remote:   "/users/check_username"
      },
      "user[first_name]": {
        required:  true,
        maxlength: 30
      },
      "user[last_name]":  {
        required:  true,
        maxlength: 30
      },
      "user[email]":      {
        required:  true,
        minlength: 5,
        maxlength: 75,
        email:     true,
        remote:   "/users/check_email"
      },
      "user[password]":   {
        required:  true,
        minlength: 5,
        maxlength: 128
      },
      "user[password_confirmation]": {
        required:  true,
        minlength: 5,
        maxlength: 128,
        equalTo:  "#user_password"
      }
    },

    messages: {
      "user[username]":   {
        required: "Please enter a username.",
        minlength: "This must be between 5 and 30 characters long.",
        maxlength: "This must be between 5 and 30 characters long.",
        remote: "Sorry, this username is taken."
      },
      "user[first_name]": {
        required: "Please enter your firstname.",
        maxlength: "This cannot be longer than 30 characters."
      },
      "user[last_name]":  {
        required: "Please enter your last name.",
        maxlength: "This cannot be longer than 30 characters."
      },
      "user[email]":      {
        required: "Please enter your email.",
        minlength: "This must be between 5 and 75 characters long.",
        maxlength: "This must be between 5 and 75 characters long.",
        email: "Please enter a valid email address.",
        remote: "We know this email address. Do you have an account?"
      },
      "user[password]":   {
        required: "Please enter a password.",
        minlength: "This must be between 5 and 128 characters long.",
        maxlength: "This must be between 5 and 128 characters long."
      },
      "user[password_confirmation]": {
        required: "Please enter your password again here.",
        minlength: "This must be between 5 and 128 characters long.",
        maxlength: "This must be between 5 and 128 characters long.",
        equalTo: "Your passwords don't match."
      }
    }
  });


  $("#user_username").focus(function() {
    var first = $("#user_first_name").val(),
        last  = $("#user_last_name").val();
    if (first && last && !this.value) {
      this.value = ( first[0] + last ).toLowerCase();
    }
  })

});