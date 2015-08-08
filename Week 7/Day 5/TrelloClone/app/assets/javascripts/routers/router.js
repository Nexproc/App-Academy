TrelloClone.Routers.Router = Backbone.Router.extend({
  routes: {
    "" : "index",
    "boards/new" : "newBoard",
    "boards/:id" : "showBoard",
    "boards/:id/lists/new" : "newList",
    "boards/:id/lists/:id" : "showList",
    "boards/:id/lists/:id/item/new" : "newItem",
    "boards/:id/lists/:id/item/:id" : "showItem"
  },

  initialize: function (options) {
    this.collection = options.collection;
    this.$el = options.$el;
  },

  index: function () {
    var col = this.collection;
    this._switchView(new TrelloClone.Views.BoardsIndex({collection: col}));
  },
  newboard: function () {},
  showBoard: function (id) {
    var model = this.collection.getOrFetch(id);
    this._switchView(new TrelloClone.Views.Board({model: model}));
  },
  newList: function () {},
  showList: function () {},
  newItem: function () {},
  showItem: function () {},
  _switchView: function (view) {
    this._currentView && this._currentView.remove();
    this._currentView = view;
    this.$el.html(view.render().$el);
  }
});
