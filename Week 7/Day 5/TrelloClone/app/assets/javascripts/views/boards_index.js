TrelloClone.Views.BoardsIndex = Backbone.CompositeView.extend({
  template: JST['boards_index'],

  initialize: function () {
    var section = this.$el.html(this.template());
    this.listenTo(this.collection, "sync", this.render.bind(this));
    this.listenTo(this.collection, 'add', this.addBoardIdxItemView.bind(this));
    this.collection.each(this.addBoardIdxItemView.bind(this));
    this.collection.fetch();
  },

  addBoardIdxItemView: function (board) {
    var boardView = new TrelloClone.Views.BoardsIndexItem({ model: board });
    this.addSubview('ul', boardView);
  },

  render: function () {
    this.$el.html(this.template());
    this.attachSubviews();
    return this;
  }
});
