(function ($) {

$.Carousel = function(el) {
  this.$el = $(el);
  this.activeIdx = 0;
  this.$el.on("click", "a", this.handler.bind(this));
  this.oldIdx = 0;
};

$.Carousel.prototype.handler = function (e) {
  e.preventDefault;
  var $target = $(e.currentTarget);
  if ($target.attr("class") === "slide-left") {
    this.slide(1);
  } else if ( $target.attr("class") === "slide-right" ) {
    this.slide(-1);
  }
};

$.Carousel.prototype.slide = function (num) {
  if (this.transitioning) {return;}
  this.transitioning = true;
  var $items = $(".items img");
  var total = $items.length;
  var $oldActive = $items.eq(this.activeIdx);
  this.activeIdx = (this.activeIdx + total + num )% total;
  var $newActive = $items.eq(this.activeIdx);
  $newActive.addClass("active");
  if (num === -1) {
    $newActive.addClass("right");
  } else {
    $newActive.addClass("left");
  }
  setTimeout(function () {
    var $items = $(".items img");
    var total = $items.length;
    var $oldActive = $items.eq(this.oldIdx);
    var $newActive = $items.eq(this.activeIdx);
    if ($newActive.attr("class") === "active left") {
      $oldActive.addClass("right");
    } else {
      $oldActive.addClass("left");
    }
    $newActive.removeClass("right").removeClass("left");
    $oldActive.one("transitionend", function () {
      var $oldActive = $items.eq(this.oldIdx);
      $oldActive.removeClass("left").removeClass("right").removeClass("active");
      this.oldIdx = this.activeIdx;
      this.transitioning = false;
    }.bind(this));
  }.bind(this), 0);
};

$.fn.carousel = function () {
  return this.each(function () {
    new $.Carousel(this);
  });
};

})(jQuery);
