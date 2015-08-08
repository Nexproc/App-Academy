window.JournalApp = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    var col = new JournalApp.Collections.Posts()
    new JournalApp.Routers.PostsRouter({ $el: $('div.content'), collection: col });
    Backbone.history.start();
  }
};

$(document).ready(function(){
  JournalApp.initialize();
});
