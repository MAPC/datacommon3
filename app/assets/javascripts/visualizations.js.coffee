# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(document).ready ->

  $(document).bind "ajaxSuccess", ".form", (event, xhr, settings) ->
    $thing_form = $(event.data)
    $error_container = $("#error_explanation", $thing_form)
    $error_container.hide()

    $success_container = $("#success_explanation", $thing_form)
    $success_container_ul = $("ul", $success_container)
    $success_container.show()

    $vis   = xhr.responseJSON

    $('.btn.btn-success').remove()
    $thing_form.append("<a href='" + $vis.id + "'>View your visualization.</a>")

    $("<li>").html($vis.title + " saved. You will be redirected to it in a few seconds. If that doesn't happen, <a href='" + $vis.id + "'>view it here.</a>").appendTo $success_container

    redirect = -> window.location = '/visualizations/' + $vis.id
    setTimeout redirect, 5000


  $(document).bind "ajaxError", ".form", (event, jqxhr, settings, exception) ->
    $thing_form = $(event.data)
    $error_container = $("#error_explanation", $thing_form)
    $error_container_ul = $("ul", $error_container)
    $error_container.show()
    if $("li", $error_container_ul).length
      $("li", $error_container_ul).clear()
    $.each jqxhr.responseJSON, (index, message) ->
      $error_container.append("<li>" + message)

  $('.form').on 'ajax:before', (xhr, settings) ->
    $session_state_field = $('#visualization_sessionstate')
    $session_state = JSON.stringify(DC.weave.getSessionState([]))
    $session_state_field.val($session_state)