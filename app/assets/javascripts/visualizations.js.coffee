# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(document).ready ->

  $(document).bind "ajaxSuccess", ".form", (event, xhr, settings) ->
    $thing_form = $(event.data)
    $error_container = $("#error_explanation", $thing_form)
    $error_container_ul = $("ul", $error_container)
    $("<p>").html(xhr.responseJSON.title + " saved.").appendTo $thing_form
    if $("li", $error_container_ul).length
      $("li", $error_container_ul).remove()
      $error_container.hide()

  $(document).bind "ajaxError", ".form", (event, jqxhr, settings, exception) ->
    $thing_form = $(event.data)
    $error_container = $("#error_explanation", $thing_form)
    $error_container_ul = $("ul", $error_container)
    $error_container.show()
    $.each jqxhr.responseJSON, (index, message) ->
      console.log(index, message)
      $error_container.append("<li>" + message)