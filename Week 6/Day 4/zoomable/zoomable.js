(function ($) {

$.Zoomable = function (el) {
  this.$el = $(el);
  this.focusBoxSize = 80;
  this.$el.on("mouseover", this.showFocusBox.bind(this));
  this.$el.on("mouseleave", this.removeFocusBox.bind(this));
};

$.Zoomable.prototype.showFocusBox = function (e) {
  debugger;
  var $target = $(e.currentTarget);
  var x = e.pageX;
  var y = e.pageY;

};

$.Zoomable.prototype.removeFocusBox = function (e) {
  $('.focus-box').remove();
};

$.fn.zoomable = function () {
  return this.each(function () {
    new $.Zoomable(this);
  });
};

})(jQuery);
