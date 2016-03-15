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

  //USER PROFILE
  var current = $('.list-info > li:first-child');
  var current_profile = 1;
  var numProfile = $('.list-info > li').size();
  $('.list-info > li').click(function(){
    current.removeClass('active');
    $('.profile-info > .info-content:nth-of-type(' + current_profile + ')').css('display','none');
    current_profile = $(this).index() + 1;
    current = $(this);
    current.addClass('active');
    $('.profile-info > .info-content:nth-of-type(' + current_profile + ')').css('display','block');
  });
});
