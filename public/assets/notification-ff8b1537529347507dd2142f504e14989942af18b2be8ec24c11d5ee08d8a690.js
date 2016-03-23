var $notifications = $('ul.drp-notification');

var pusher = new Pusher('5cc1643b6d3132075121', {
  encrypted: true
});

var channel = pusher.subscribe('notification_channel');

channel.bind('commented', function(data) {
  if(uid == data.author){
    notifications();
  }
});

channel.bind('liked', function(data) {
  if(uid == data.author){
    notifications();
  }
});

channel.bind('rated', function(data) {
  if(uid == data.author){
    notifications();
  }
});

function notifications() {
  $notifications.find('li.no-notification').remove();
  $('.notifications-icon span.badge11').css({"display": "block"});
}

var countClick = 0;

$('.notifications-icon').on('click', function(){
  if (countClick < 1){
    $.get( "/api/notifications/seen" );
    countClick++;
  }
  var url =  "/api/notifications/all";
  $notifications.load(url);
  $notifications.toggle();
  $('.notifications-icon span.badge11').css({"display": "none"});
});

$(document).ready(function() {
  var url =  "/api/notifications/all";
  $notifications.load(url);
  $('.profile_details_drop, .prof-img, .msg-icon').on('click', function(){
    $notifications.css({"display":"none"});
  });

  $('#page-wrapper').click(function(){
    $('ul.drp-notification').css({"display": "none"});
  });
});
