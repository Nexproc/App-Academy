JournalApp.Routers.PostsRouter = Backbone.Router.extend({
  routes: {
    "": "index",
    "posts/:id": "show"
  },

  initialize: function (options) {
    this.collection = options.collection;
    this.$el = options.$el;
    this._currentView = new JournalApp.Views.PostsIndex({collection: this.collection})
    this.collection.fetch({ reset: true });
  },

  show: function (id) {
    var post = this.collection.getOrFetch(id);
    var view = new JournalApp.Views.PostShow({model: post});
    this._swapView(view);
  },

  index: function () {
    var view = new JournalApp.Views.PostsIndex({collection: this.collection});
    this._swapView(view);
  },

  _swapView: function (newView) {
    this._currentView && this._currentView.remove();
    this._currentView = newView;
    this.$el.html(newView.$el);
    newView.render();
  }
});
