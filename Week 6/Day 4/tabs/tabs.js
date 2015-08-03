(function ($) {

$.Tabs = function (el) {
  this.$el = $(el);
  this.$contentTabs = $(this.$el.attr("data-content-tabs"));
  this.$activeTab = this.$contentTabs.find(".active");
  this.$el.on("click", "a", this.clickTabs.bind(this));
  
};

$.Tabs.prototype.clickTabs = function (e) {
  e.preventDefault();
  this.$activeTab.addClass("transitioning");
  var $target = $(e.currentTarget);
  $(".tabs .active").removeClass("active");
  $target.addClass("active");
  this.$activeTab.one("transitionend", function () {
    this.$activeTab.removeClass("active");
    this.$activeTab.removeClass("transitioning");
    this.$activeTab = $($target.attr("for"));
    this.$activeTab.addClass("transitioning").addClass("active");
    setTimeout(function() {
      this.$activeTab.removeClass("transitioning");
    }.bind(this), 0);
  }.bind(this));
};

$.fn.tabs = function () {
  return this.each(function () {
    new $.Tabs(this);
  });
};

})(jQuery);
