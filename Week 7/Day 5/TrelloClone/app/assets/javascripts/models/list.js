TrelloClone.Models.List = Backbone.Model.extend({
  initialize: function (options) {
    debugger
    this.board = options.board;
  },
  urlRoot: function () {
    return this.board.url() + '/lists';
  }
});
