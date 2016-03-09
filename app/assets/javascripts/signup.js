$(document).ready(function () {
  $('select.select-user-type').on('change', function() {
    formHidden();
      var userType = parseInt(this.value);
      _renderForm(userType);
  });

  $('select.select-country').change(function () {
    var input_state = $('.select-state');
    $.getJSON('/api/states/' + $(this).val(), function (data) {
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
    $.getJSON('/api/cities/' + $('select.select-country').val() + '/' + $(this).val(), function (data) {
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
      formHidden();
  };
}

function formHidden() {
  $('.startup, .investor, .entrepreneur').hide();
}
