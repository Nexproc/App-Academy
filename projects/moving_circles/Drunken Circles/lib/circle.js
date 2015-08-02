(function () {
  if (typeof Circles === "undefined") {
    window.Circles = {};
  }

  var Circle = Circles.Circle = function (centerX, centerY, radius, color) {
    this.centerX = centerX;
    this.centerY = centerY;
    this.radius = radius;
    this.color = color;
    this.dx = Circle.randomDir();
    this.dy = Circle.randomDir();
  };


  Circle.randomCircle = function (maxX, maxY, numCircles) {
    return new Circle(
      maxX * Math.random(),
      maxY * Math.random(),
      Circle.radius(maxX, maxY, numCircles),
      Circle.randomColor()
    );
  };

  var HEX_DIGITS = "0123456789ABCDEF";
  Circle.randomColor = function () {
    var color = "#";
    for (var i = 0; i < 6; i++) {
      color += HEX_DIGITS[Math.floor((Math.random() * 16))];
    }

    return color;
  };

  Circle.radius = function (maxX, maxY, numCircles) {
    var targetCircleArea = (maxX * maxY) / numCircles;
    var targetRadius = Math.sqrt(targetCircleArea / Math.PI);
    return 2 * targetRadius;
  };

  Circle.prototype.move = function (maxX, maxY) {
    this.centerX = Circle.moveHelper(this.centerX, this.dx, this.radius, maxX);
    this.centerY = Circle.moveHelper(this.centerY, this.dy, this.radius, maxY);
  };

  Circle.randomDir = function () {
    return (Math.random() * 2) - 1;
  };

  Circle.moveHelper = function (x, dx, rad, max) {
    pos = x + (dx * rad * 0.1);
    diam = rad*2;
    if (pos < 0 - diam) { return max; }
    if (pos > max + diam) { return 0 - diam; }
    return pos;
  };

  Circle.prototype.render = function (ctx) {
    ctx.fillStyle = this.color;
    ctx.beginPath();

    ctx.arc(
      this.centerX,
      this.centerY,
      this.radius,
      0,
      2 * Math.PI,
      false
    );

    ctx.fill();
  };
})();
