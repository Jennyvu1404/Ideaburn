$(document).ready(function () {
  App.init();
  var slider = $('.c-layout-revo-slider .tp-banner');
  var cont = $('.c-layout-revo-slider .tp-banner-container');
  var api = slider.show().revolution(
    {
      delay: 15000,
      startwidth: 1170,
      startheight: 620,
      navigationType: "hide",
      navigationArrows: "solo",
      touchenabled: "on",
      onHoverStop: "on",
      keyboardNavigation: "off",
      navigationStyle: "circle",
      navigationHAlign: "center",
      navigationVAlign: "bottom",
      spinner: "spinner2",
      fullScreen: "on",
      fullScreenAlignForce: "on",
      fullScreenOffsetContainer: '',
      shadow: 0,
      fullWidth: "off",
      forceFullWidth: "off",
      hideTimerBar: "on",
      hideThumbsOnMobile: "on",
      hideNavDelayOnMobile: 1500,
      hideBulletsOnMobile: "on",
      hideArrowsOnMobile: "on",
      hideThumbsUnderResolution: 0
    });
  api.bind("revolution.slide.onchange", function (e, data) {
      $('.c-layout-header').removeClass('hide');
      setTimeout(function () {
        $('.c-singup-form').fadeIn();
      }, 1500);
  });
  $('#sliders').tinycarousel();

  /* Customize Javascript */
  $('select.select-user-type').on('change', function() {
    formDisplay();
      var userType = parseInt(this.value);
      _renderForm(userType);
  });
  $('select.select-country').change(function () {
    var input_state = $('.select-state');
    $.getJSON('/states/' + $(this).val(), function (data) {
      input_state.empty();
      $('.select-city').empty();
      $('.select-city').append('<option value="">- Slect A City -</option>');
      $.each(data, function (i) {
        var opt = '<option value='+ i +'>' + data[i] + '</option>';
        input_state.append(opt);
      });
    });
  });

  $('select.select-state').change(function () {
    var input_state2 = $('.select-city');
    $.getJSON('/cities/' + $('select.select-country').val() + '/' + $(this).val(), function (data) {
      input_state2.empty();
      $.each(data, function (i) {
        var opt = '<option value='+ i +'>' + data[i] + '</option>';
        input_state2.append(opt);
      });
    });
  });

});

function _renderForm(userType) {
  switch(userType) {
    case 2:
      $('.entrepreneur').show();
      break;
    case 3:
      $('.startup').show();
      break;
    case 4:
      $('.investor').show();
      break;
    default:
      formDisplay();
      break;
  };
}

function formDisplay() {
  $('.startup, .investor, .entrepreneur').hide();
}
