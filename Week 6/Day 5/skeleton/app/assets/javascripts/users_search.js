(function($){
$.UsersSearch = function (el) {
  this.$el = $(el);
  this.$input = this.$el.find("input");
  this.$users = this.$el.find("ul.users");
  this.$input.on("input", this.handleInput.bind(this));
};

$.UsersSearch.prototype.handleInput = function (e) {
  var value = this.$input.val();
  $.ajax({
    url: "/users/search",
    data: { query: value },
    dataType: "json",
    success: this.renderResults.bind(this),
    error: function() { console.log("NNOOO!!!!"); }
  });
};

$.UsersSearch.prototype.renderResults = function (result) {
  this.$users.empty();
  var that = this;
  result.forEach(function(el){
    var customName = boldify(that.$input.val(), el.username);
    var $button = $("<button>")
    var following = that.$el.current_user
    $button.followToggle(undefined, {userId: el.id, followState: "nothing"});





    var buttonText = '<button user-id=' + el.id + '></button>'
    that.$users.append('<li id="' + el.id + '"><a href="' + el.id + '">'
                          + customName + '</a></li>');
  });
}

function boldify(frag, string) {
  var left = "";
  var right = "";
  var dup = frag.slice(0);

  for (var i = 0; i + frag.length < string.length + 1; i++) {
    // debugger

    if (string.slice(i, (i+frag.length)) === frag) {
      left = string.slice(0,i);
      right = string.slice(i + frag.length);
      break;
    }
  }

  return left + "<strong>" + frag + "</strong>" + right;
}

$.fn.usersSearch = function () {
  return this.each(function () {
    new $.UsersSearch(this);
  });
};

})(jQuery);
