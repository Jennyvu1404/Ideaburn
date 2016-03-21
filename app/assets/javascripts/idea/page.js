function postCommentIdea(idea_id){
  var message = $('#message').val();
  if(message == '')
    return false;
  $.ajax({
    url: '/user/ideas/comment',
    type: 'POST',
    data: {idea_id: idea_id, message: message},
    beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
    success: function(html) {
      $(".comment-details #comments").prepend(html);
      $('#message').val('');
    },
    error: function(e) {
    }
  });
}
function replyCommentIdea(comment_id){
  var message = $('#message_' + comment_id).val();
  if(message == '')
    return false;
  $.ajax({
    url: '/user/ideas/reply',
    type: 'POST',
    data: {comment_id: comment_id, message: message},
    beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
    success: function(html) {
      $('#reply_' + comment_id).append(html);
      $('#message_' + comment_id).val('');
    },
    error: function(e) {
    }
  });
}
function likeIdea(idea_id, status){
  $.ajax({
    url: '/user/ideas/like',
    type: 'POST',
    data: {idea_id: idea_id, status: status},
    beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
    success: function(html) {
      $('.like-idea').html(html);
    },
    error: function(e) {
    }
  });
}
