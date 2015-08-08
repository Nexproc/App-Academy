JournalApp.Collections.Posts = Backbone.Collection.extend({
  model: JournalApp.Models.Post,
  url: 'posts',

  getOrFetch: function (id) {
    var post = this.get(id);
    if (!post){
      post = new JournalApp.Models.Post({id: id});
      this.add(post);
    }
    post.fetch();
    return post;
  }

});
