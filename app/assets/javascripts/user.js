//= require jquery
//= require cocoon
//= require jquery_ujs
//= require_tree ./user

$(document).ready(function() {
  $( "#datepicker, #datepicker2, #datepicker3" ).datepicker({
      yearRange: '2006:2020',
      buttonText: "",
      changeMonth: true,
      changeYear: true,
      dateFormat: 'yy-mm-dd'});
  $( "#dob-datepicker" ).datepicker({
      yearRange: '1930:2000',
      buttonText: "",
      changeMonth: true,
      changeYear: true,
      dateFormat: 'yy-mm-dd' });
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
    if(!$(this).hasClass('disabled')){
      current.removeClass('active');
      $('.profile-info > .info-content:nth-of-type(' + current_profile + ')').css('display','none');
      current_profile = $(this).index() + 1;
      current = $(this);
      current.addClass('active');
      $('.profile-info > .info-content:nth-of-type(' + current_profile + ')').css('display','block');
    }
  });

  var maxTab = "#tab" + ($('ul.tabsec > li').size() - 1);
  var lastTab = "#tab" + ($('ul.tabsec > li').size());

  $('ul.tabsec > li').on('click', function(){
    var tab = $(this).find('a').attr('href');
    if (tab === lastTab) {
      $('.btn-submit').removeClass('hide');
      $('.btn-next').addClass('hide');
      }else{
        $('.btn-submit').addClass('hide');
        $('.btn-next').removeClass('hide');
      }
  });

  $('select.country').on('change', function(){
      select_wrapper = $('#order_state_code_wrapper');
      $('select', select_wrapper).attr('disabled', true);
      country_code = $(this).val();
      url = "/api/subregion_options?parent_region=" + country_code;
      select_wrapper.load(url);
      setTimeout(function(){
        changeSelectRegion();
        changeTextRegion();
      }, 600);
    });
  $('select#user_investor_attributes_investor_type').on('change', function(){
    var type = parseInt((this).value);
    if(type === 1 || type == 2){
      $('ul.tabsec > li:nth-child(3)').find('a').text('Contact');
      $('ul.tabsec > li:nth-child(2)').hide();
      $('.tab-content').find('.type2').show();
      $('.tab-content').find('.type3').hide();
    }else{
      $('ul.tabsec > li:nth-child(3)').find('a').text('Office Headquarters');
      $('ul.tabsec > li:nth-child(2)').show();
      $('.tab-content').find('.type2').hide();
      $('.tab-content').find('.type3').show();
    }
  });

  changeSelectRegion();
  changeTextRegion();

  function changeSelectRegion(){
    $('select[name="user[region]"]').change(function () {
      try {
      var select = '<select name="user[city]" id="user_city"></select>';
      $(select).insertAfter( $('input[name="user[city]"]'));
      $('input[name="user[city]"]').remove();
      }catch(err){}
      var input_state = $('select[name="user[city]"]');
      $.getJSON('/api/cities/' + $('select[name="user[country]"]').val() + '/' + $(this).val(), function (data) {
        if(data.length > 0) {
          input_state.empty();
          $.each(data, function (key, val) {
            var opt = '<option value='+ val +'>' + val + '</option>';
            input_state.append(opt);
          });
          }else {
            var html = '<input id="user_city" required="required" type="text" name="user[city]" placeholder="e.g New York" required>';
            $(html).insertAfter(input_state);
            input_state.remove();
          }
      });
    });
  }

  function changeTextRegion(){
    try{
      $('input[name="user[region]"]').text(function(){
        var html = '<input id="user_city" required="required" type="text" name="user[city]" placeholder="e.g New York" required>';
        var input_state = $('select[name="user[city]"]');
        $(html).insertAfter(input_state);
        input_state.remove();
      });
    }catch(err){}
  }

  $('.profile_details_drop').click(function(){
    if(!$(this).hasClass('open')){
      $(this).addClass('open');
      $(this).find('a.dropdown-toggle').attr('aria-expanded', 'true');
    }else{
      $(this).removeClass('open');
      $(this).find('a.dropdown-toggle').attr('aria-expanded', 'false');
    }
  });
});
