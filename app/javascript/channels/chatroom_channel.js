import consumer from "./consumer"

consumer.subscriptions.create("ChatroomChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
      let currentUserId = $('#chatroom_data').data('current-user');
      let chatroomId = $('#chatroom_data').data('current-chatroom');
      let align = currentUserId === data.id ? 'end' : 'start';
      let klass = currentUserId === data.id ? 'sent' : 'reply';
      if (currentUserId == data.id){
          $('#my_form').val('');
      }
      if(chatroomId == data.chatroom) {
          $('.message_list').append(
              '<div class="d-flex justify-content-' + align + '">' +
                  '<li>' +
                      '<div class="'+ klass +'">' +
                          '<a class="profile_link" href="/profile/'+ data.id + '">' +
                          data.username +
                          '</a>' +
                          '<div class="message">' + data.content +  '</div>' +
                      '</div>' +
                  '</li>' +
              '</div>');
      }
    }
});