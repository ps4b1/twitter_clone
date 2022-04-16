import consumer from "./consumer"

consumer.subscriptions.create("ChatroomChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    if ($('.message_list')){
      $('.message_list').append('<div class="d-flex justify-content-end"><li><div class="sent">'+data.username+'<div class="message">'+data.content+'</div></div></li></div>');
    }
  }
});