//= require jquery_ujs
//= require_tree ./user

$(document).ready(function() {
  $( "#datepicker, #datepicker2, #datepicker3" ).datepicker({
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
