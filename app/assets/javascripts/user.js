//= require jquery
//= require jquery_ujs
//= require_tree ./user
//= require jquery.nicescroll
//= require bootstrap-sprockets

$(document).ready(function() {
  $( "#datepicker" ).datepicker({
      buttonText: "",
      changeMonth: true,
      changeYear: true});
  document.getElementById('get_file').onclick = function() {
    document.getElementById('my_file').click();
  };
});
