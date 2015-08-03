Function.prototype.myBind = function (context) {
  var fn = this;
  return function () {
    fn.apply(context);
  };
};

var testFunction = function(name) {
  console.log(name);
};

function times(num, fun) {
  for (var i = 0; i < num; i++) {
    fun(); // call is made "function-style"
  }
}

var cat = {
  age: 5,

  ageOneYear: function () {
    this.age += 1;
    console.log(this.age);
  }
};

times(10, cat.ageOneYear.myBind(cat));
