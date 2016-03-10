$(document).ready(function () {
  $('select.select-user-type').on('change', function() {
    formHidden();
      var userType =this.value;
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
      formHidden();
  };
}

function formHidden() {
  $('.startup, .investor, .entrepreneur').hide();
}
