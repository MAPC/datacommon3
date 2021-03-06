// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require jquery.validate
//= require chosen.jquery.min
//= require swfobject
//= require retina
//= require_tree .


$(document).on('ready', function () {

  $('.chosen-select').chosen({
    width:  '250px',
    allow_single_deselect:    false,
    disable_search_threshold: 10,
    no_results_text:         'No results matched'
  });

  $('.carousel').carousel({
    interval: 20000
  });

});