# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# TODO: Rapid-fire successful updates simply append errors

$(document).ready ->

  # Prepare elements before AJAX call
  $flash = $("#flash")
  $alert = $('<div>' ).addClass('alert alert-danger')
  $success = $('<div>' ).addClass('alert alert-success')
  $err_intro = $('<li>Almost there! Please fix the errors and try again.</li>')
  $submit = $('.btn.btn-success')

  # Add glyphicon 'x' link to the pending alert.
  $glyph_string = '<a class="removable left"><span class="glyphicon glyphicon-remove"></a>'
  $alert.append( $glyph_string )
  $success.append( $glyph_string )

  # Define function to hide flash
  hide_flash = -> $('a', $flash).trigger('click')

  # Before the form submits the AJAX request, get the Weave
  # sessionstate, then append it to the hidden sessionstate field.
  $('.form').on 'ajax:before', (xhr, settings) ->
    $submit.addClass('disabled');
    $submit.attr('value', 'Saving...')
    $weave_state = JSON.stringify( DC.weave.getSessionState([]) )
    $('#visualization_sessionstate').val( $weave_state )


  # Handle success
  $(document).bind "ajaxSuccess", ".form", (event, xhr, settings) ->
    $flash.empty()
    $vis = xhr.responseJSON
    $p   = $('<p>').appendTo($success)
    $p.append("Saved visualization. You can keep editing, or <a href='/visualizations/" + $vis.id + "'>view it here.</a>")
    $flash.append($success)
    $('h1').text('Edit "' + $vis.title + '"')

    $submit.removeClass('disabled')
    $submit.attr('value', 'Update')

    setTimeout hide_flash, 15000
    

  # Handle error messages on submit
  $(document).bind "ajaxError", ".form", (event, xhr, settings, exception) ->
    $flash.empty()                    # Clear out the flash
    $ul = $('<ul>').appendTo($alert)  # Add a list
    $ul.append($err_intro)            # Introduce the errors

    # Add each error message to the list.
    $.each xhr.responseJSON, (index, message) ->
      $ul.append("<li>" + message + "</li>")
    $flash.append($alert)  # Add the flash to the DOM

    $submit.removeClass('disabled')
    $submit.attr('value', 'Create')