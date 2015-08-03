function range(start, end) {
  if (start > end) {return [];}
  if (start === end) {return [end];}
  return [start].concat(range(start + 1, end));
}

function sum(arr) {
  if (arr.length === 1) {return arr[0]}
  return arr[0] + sum(arr.slice(1, arr.length + 1))
}

function exp(base, exponent) {
  if (exponent <= 0) { return 1 }
  return base * exp(base, exponent - 1)
}

function exp2(base, exponent) {
  if (exponent <= 0) { return 1 }
  if (exponent === 1) { return base }
  if (exponent % 2 === 0) {
    var result = exponent(base, exponent / 2)^2
    return result * result
  } else {
    var result = exp(base, (exponent - 1)/2)
    return base * (result * result)
  }
}

function fibonacci(number) {
  if (number === 1) { return [0] }
  if (number === 2) { return [0, 1] }
  var result = fibonacci(number - 1)
  var self = result[result.length - 1] + result[result.length - 2]
  return result.concat(self)
}

function binarySearch(arr, target) {
  if (arr.length === 0) { return null }
  var mid = Math.round((arr.length - 1) / 2)
  var pivot = arr[mid]

  if (pivot == target) { return mid }
  switch (pivot < target) {
    case (false): return binarySearch(arr.slice(0, mid), target)
    case (true): return mid + 1 + binarySearch(arr.slice(mid + 1, arr.length), target)
  }
}

function makeChange(total, coins) {
  if (total == 0) {return [];}
  if (total - coins[0] >= 0) {
    var newTotal = total - coins[0]
    var first = [coins[0]].concat(makeChange(newTotal, coins))
  }
  else { return makeChange(total, coins.slice(1)) }
  var second = []
  if (coins.length > 1) { second = second.concat(makeChange(total, coins.slice(1))) }
  if ((second.length < first.length) && second.length > 0 ) {return second}
  return first
}

Array.prototype.mergeSort = function (){
  if (this.length === 1 || this.length === 0) { return this }

  var mid = Math.round((this.length - 1) / 2);
  var left = this.slice(mid, this.length);
  var right = this.slice(0, mid);

  return merge(left.mergeSort(), right.mergeSort())
}

function merge(left, right) {
  var sorted = []

  while (left.length > 0 && right.length > 0) {
    switch (left[0] > right[0]) {
    case (true):
      sorted.push(right[0]);
      right = right.slice(1);
      break;
    case (false):
      sorted.push(left[0]);
      left = left.slice(1);
      break;
    }
  }

  return sorted.concat(left).concat(right);
}

Array.prototype.subsets = function () {
  if (this.length === 0) {return [[]]; }
  var adder = this[this.length - 1];
  var copy = this.slice(0, this.length - 1);
  var subs = copy.subsets();
  var result = subs.map(function (arg) {
    return [adder].concat(arg)
  });
  return subs.concat(result);
};
