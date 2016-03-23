$(document).ready(function () {
  /*$('[data-user_type_select]').on('change', function() {
    hideFormUserType();
      var userType = this.value;
      _renderFormUserType(userType);
  });*/

  //Aminate
  $('.c-theme-nav > li').click(function(){
    // $('.c-layout-page').css({'animation-name':'animate_home', 'animation-duration':'5s'});
    // $('.c-pull-left').css({'animation-name':'animate_home', 'animation-duration':'5s'});
    // $('.entrepreneur-section').css({'animation-name':'animate_home', 'animation-duration':'5s'});
    // var index = $(this).index() + 1;
    // for(var i = 0; i <= $('.c-theme-nav > li').size(); i++){
    //   if(i != index){
    //     $('.c-theme-nav > li:nth-child(' + i + ')').css({'animation-name':'animate_home', 'animation-duration':'5s'});
    //   }
    // }
    $('.entrepreneur-section').animate({'opacity':'1','top':'0px'}, 2000);
    $('.c-layout-page').animate({'opacity':'0'}, 2000);
    $('.c-layout-header').animate({'opacity':'0'}, 2000);
  });
  $('.btn-close').click(function(){
    $('.entrepreneur-section').animate({'opacity':'0','top':'-150%'}, 2000);
    $('.c-layout-page').animate({'opacity':'1'}, 2000);
    $('.c-layout-header').animate({'opacity':'1'}, 2000);
  });

  $('body').keydown(function(e){
    if(e.keyCode == 27) {
      $('.entrepreneur-section').animate({'opacity':'0','top':'-150%'}, 2000);
      $('.c-layout-page').animate({'opacity':'1'}, 2000);
      $('.c-layout-header').animate({'opacity':'1'}, 2000);
    }
  });


  $('[data-country_select]').change(function () {
    var input_state = $('[data-state_select]');
    var first_city = ""
    $.getJSON('/api/states/' + $(this).val(), function (data){
      if($.isEmptyObject(data)){
        $('[data-state_select]').hide();
        $('[data-city_select]').hide();
        return false;
      }
      $('[data-state_select]').show();
      $('[data-city_select]').show();
      first_city = data[0];
      input_state.empty();
      $('[data-city_select]').empty();
      $('[data-city_select]').append('<option value="">- Slect A City -</option>');
      $.each(data, function (i) {
        var opt = '<option value='+ i +'>' + data[i] + '</option>';
        input_state.append(opt);
        first_city = i
      });
      appendCitiesByState(first_city);
    });
  });

  $('[data-state_select]').change(function () {
    appendCitiesByState($(this).val());
  });

  function appendCitiesByState(state){
    var input_city = $('[data-city_select]');
    $.getJSON('/api/cities/' + $('[data-country_select]').val() + '/' + state, function (data) {
      input_city.empty();
      $.each(data, function (i) {
        var opt = '<option value='+ i +'>' + data[i] + '</option>';
        input_city.append(opt);
      });
    });
  }

});

function _renderFormUserType(userType) {
  switch(userType) {
    case 'entrepreneur':
      $('.entrepreneur').show();
      break;
    case 'startup':
      $('.startup').show();
      break;
    case 'investor':
      $('.investor').show();
      break;
    default:
      hideFormUserType();
  };
}

function hideFormUserType() {
  $('.startup, .investor, .entrepreneur').hide();
}
