(function ($){
  $.FollowToggle = function (el) {
  this.$el = $(el);
  this.user_id = this.$el.attr("id");
  this.follow_state = this.$el.data("followed");
  this.render();
  this.$el.on("click", this.followClick.bind(this))
};

$.FollowToggle.prototype.followClick = function (e) {
  e.preventDefault();
  this.$el.prop("disabled", true)
          .text("pending...");
  var text = "POST";
  if (this.follow_state) { text = "DELETE"; }
  $.ajax({
    url:"/users/" + this.user_id + "/follow",
    type: text,
    dataType: "json",
    success: this.toggleFollow.bind(this),
    error: function() {
      console.log("NNOOO!!!!")
    }
  });
};

$.FollowToggle.prototype.render = function () {
  if (this.follow_state) {
    this.$el.text("unfollow");
  }
  else {
    this.$el.text("follow");
  }
};

$.FollowToggle.prototype.toggleFollow = function () {
  if (this.follow_state) {
    this.follow_state = false;
  } else {
    this.follow_state = true;
  }
  this.render();
  this.$el.prop("disabled", false);
};

$.fn.followToggle = function () {
  return this.each(function () {
    new $.FollowToggle(this);
  });
};

})(jQuery);
