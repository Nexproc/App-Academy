(function ($) {

$.Carousel = function(el) {
  this.$el = el;
  this.activeIdx = 0;
  this.$el.on("click", "a", this.handler.bind(this));
};

$.Carousel.prototype.handler = function (e) {
  var $target = $(e.currentTarget);
  if ($target.class === "slide-left") {
    slide(1)
  }
}



})(jQeury);
