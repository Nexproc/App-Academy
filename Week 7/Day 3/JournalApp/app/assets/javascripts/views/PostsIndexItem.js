 JournalApp.Views.PostsIndexItem = Backbone.View.extend({
   template: JST['postsIndexItem'],
   tagName: 'li',
   className: 'posts-index-item',
   events: {
     "click .delete-post": "deletePostItem"
   },

   render: function () {
    var content = this.template({ post: this.model });
    this.$el.html(content);
    return this;
  },

  deletePostItem: function () {
    this.model.collection.remove(this.model);
    this.model.destroy();
  }
 });
