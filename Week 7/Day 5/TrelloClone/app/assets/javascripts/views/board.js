TrelloClone.Views.Board = Backbone.View.extend({
  template: JST['board'],
  initialize: function () {
    this.model.fetch()
    this.listenTo(this.model, "sync", this.render.bind(this));
    this.model.lists().fetch();
  },

  render: function() {
    this.$el.html(this.template({board: this.model}));
    this.model.lists().each(function(list) {
      var sub = new TrelloClone.Views.Lists(list);
      this
    })
    return this;
  }
});
