TrelloClone.Collections.Boards = Backbone.Collection.extend({
  model: TrelloClone.Models.Board,
  url: "/boards/",
  getOrFetch: function (id) {
    var that = this;
    var board = this.get(id);
    var cb = function() {};
    if (!board) {
      cb = function () { that.add(board); }
      board = new that.model({ id: id });
    }
    board.fetch({success: cb});
    return board;
  }
});
