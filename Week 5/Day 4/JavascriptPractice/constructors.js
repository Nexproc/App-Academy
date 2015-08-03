var Cat = function(options) {
  this.name = options.name;
  this.owner = options.owner;
  this.cuteStatement = function () {
    return this.owner + " loves " + this.name;
  }

  this.meow = function() {
    return this.name + " meows";
  }
}

var Student = function (options) {
  this.fname = options.fname;
  this.lname = options.lname;
  this.name = this.fname + " " + this.lname;
  this.courses = [];

  this.enroll = function (course) {
    if (this.courses.notInclude(course)) {
      this.courses = this.courses.concat(course);
    }
  }

  this.course_load = function () {
    var thingy = {}
    for (var i = 0; i < this.courses.length; i++) {
      var dept = this.courses[i].dept;
      var creds = this.courses[i].credits;
      if (thingy[dept] == undefined) {thingy[dept] = 0;}
      thingy[dept] = parseInt(thingy[dept]) + parseInt(creds);
    }

    return thingy
  }


}
var Course = function (options) {
  this.name = options.name;
  this.dept = options.dept;
  this.credits = options.credits;

  this.add_student = function (student) { student.enroll(this); }
}

Array.prototype.notInclude = function (value) {
  for (var i = 0; i < this.length; i++) {
    if (value === this[i]) { return false; }
  }

  return true;
}
