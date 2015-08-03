Array.prototype.myEach = function (anotherFunction) {
  for (var i = 0; i < this.length; i++) {
    anotherFunction(this[i]);
  }
}

var anotherFunction = function (variable) {
  console.log(variable);
}

Array.prototype.myMap = function (anotherFunction) {
  result = [];
  function addResult(el) {
    result.push(anotherFunction(el));
  }
  this.myEach(addResult);
  return result;
}

var foo = function (el1, el2) {
  return el1 + el2;
}

Array.prototype.myInject = function (anotherFunction, accumulator) {
  if (accumulator == undefined) { accumulator = 0 }
  function accumResult(el) {
    accumulator = anotherFunction(el, accumulator);
  }
  this.myEach(accumResult);
  return accumulator;
}

function bubbleSort(array) {
  notSorted = true;

  while ( notSorted ) {
    notSorted = false;
    for (var i = 0; i < array.length - 1; i++) {
      if (array[i] > array[i+1]) {
        array[i + 1] = [array[i], array[i] = array[i + 1]][0];
        notSorted = true;
      }
    }
  }

  return array;
}

function subStrings(string) {
  result = [];

  for (var i = 0; i < string.length; i++) {
    for (var j = i + 1; j < string.length + 1; j++) {
      result.push(string.slice(i, j));
    }
  }

  return result;
}
