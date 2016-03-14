//= require jquery
//= require jquery_ujs
//= require_tree ./user
//= require jquery.nicescroll
//= require bootstrap-sprockets

$(document).ready(function() {
  $( "#datepicker" ).datepicker({
      yearRange: '2006:2020',
      buttonText: "",
      changeMonth: true,
      changeYear: true});
  try {
    document.getElementById('get_file').onclick = function() {
      document.getElementById('my_file').click();
    };
  } catch(err){console.clear();}
});
