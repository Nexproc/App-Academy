TrelloClone.Collections.Lists = Backbone.Collection.extend({
  initialize: function (options) {
    debugger
    this.board = options.board;
  },
  model: TrelloClone.Models.List,
  url: function () {
    return this.board.url() + '/lists';
  }
});
