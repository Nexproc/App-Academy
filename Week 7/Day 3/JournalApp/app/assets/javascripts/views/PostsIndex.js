JournalApp.Views.PostsIndex = Backbone.View.extend({
  template: JST['postsIndex'],

  events: {
    "click .posts-index-item a": ""
  },

  initialize: function () {
    this.listenTo(this.collection, "sync remove reset", this.render)
  },

  render: function () {
    this.$el.html(this.template());
    var $content = this.$('ul')
    this.collection.each(function (post) {
      var view = new JournalApp.Views.PostsIndexItem({model: post});
      $content.append(view.render().$el)
    });

    return this;
  }


});
