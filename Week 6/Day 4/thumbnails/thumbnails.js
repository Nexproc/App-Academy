(function ($) {

$.Thumbnails = function (el) {
  this.$el = $(el);
  this.gutterIdx = 0;
  this.$images = $('.gutter-images img');
  this.fillGutterImages();
  this.$activeImg = $('.gutter-images :first-child');
  this.activate(this.$activeImg);
  this.picClickHandler();
  this.mouseEnterHandler();
  this.mouseLeaveHandler();
  this.navClickHandler();
};

$.Thumbnails.prototype.navClickHandler = function () {
  $('.gutter a').on("click", function(e) {
    e.preventDefault;
    var $target = $(e.currentTarget);
    if ($target.text() === "<") {
      if (this.gutterIdx > 0) { this.moveIdx(-1); }
    } else {
      if (this.gutterIdx < this.$images.length - 5) { this.moveIdx(1); }
    }
  }.bind(this));
};

$.Thumbnails.prototype.moveIdx = function (num) {
  this.gutterIdx += num;
  this.fillGutterImages();
}

$.Thumbnails.prototype.picClickHandler = function () {
  $('.gutter-images').on("click","img", function (e) {
    var $target = $(e.currentTarget);
    this.activate($target);
    this.$activeImg = $('div.active img');
  }.bind(this));
};

$.Thumbnails.prototype.fillGutterImages = function () {
  var $gutter = $('.gutter-images');
  $gutter.children().remove();
  for (var i = 0; i < 5; i++) {
    $gutter.append(this.$images[this.gutterIdx + i]);
  }
};

$.Thumbnails.prototype.mouseEnterHandler = function () {
  $('.gutter-images').on("mouseenter", "img", function (e) {
    this.activate($(e.currentTarget));
  }.bind(this));
};

$.Thumbnails.prototype.mouseLeaveHandler = function () {
  $('.gutter-images').on("mouseleave", "img", function (e) {
    this.activate(this.$activeImg);
  }.bind(this));
};

$.Thumbnails.prototype.activate = function($img) {
  $('div.active').children().remove();
  $('div.active').append($img.clone());
};

$.fn.thumbnails = function() {
  return this.each(function(){
    new $.Thumbnails(this);
  });
};



})(jQuery);
