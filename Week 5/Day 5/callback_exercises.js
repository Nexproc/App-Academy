var readline = require('readline');

var reader = readline.createInterface({
  input: process.stdin,
  output: process.stdout,
  terminal: false
});

function Clock () {
}

Clock.TICK = 5000;

Clock.prototype.printTime = function () {
  console.log(this.hours + ":" + this.mins + ":" + this.secs);
  // Format the time in HH:MM:SS
};

Clock.prototype.run = function () {
  // 1. Set the currentTime.
  var time = new Date();
  this.hours = time.getHours();
  this.mins = time.getMinutes();
  this.secs = time.getSeconds();
  // 2. Call printTime.
  this.printTime();
  // 3. Schedule the tick interval.

  setTimeout(this._tick.bind(this), Clock.TICK);
};

Clock.prototype._tick = function () {
  // 1. Increment the currentTime.
  this.secs += 5;
  if(this.secs >=60) {
    this.secs -= 60;
    this.mins += 1;
  }
  if(this.mins >=60) {
    this.mins -= 60;
    this.hours += 1;
  }
  if(this.hours >=13) {
    this.hours -= 12;
  }

  // 2. Call printTime.
  this.printTime();
  setTimeout(this._tick.bind(this), Clock.TICK);
};

// var clock = new Clock();
// clock.run();


function addNumbers(sum, numsLeft, completionCallback){
  if(numsLeft > 0){
    reader.question("Please provide a number: ", function (input) {
      sum += parseInt(input);
      console.log(sum);
      addNumbers(sum, numsLeft-1, completionCallback);
    });
    return null;
  } else {
      completionCallback(sum);
  }
}

// addNumbers(0, 3, function (sum) {
//   console.log("Total Sum: " + sum);
//   reader.close();
// });

function askIfGreaterThan(el1, el2, callback) {
  // Prompt user to tell us whether el1 > el2; pass true back to the
  // callback if true; else false.
  var question = "Is " + el1 + " > " + el2 + "?";
  reader.question(question, function (input) {
    if (input === 'yes') {
      callback(true);
    } else {
      callback(false);
    }
  });
}

function innerBubbleSortLoop(arr, i, madeAnySwaps, outerBubbleSortLoop) {
  if (i < arr.length - 1) {
    askIfGreaterThan(arr[i], arr[i+1], function (isGreaterThan) {
      if (isGreaterThan === true ) {
        arr[i + 1] = [arr[i], arr[i] = arr[i + 1]][0];
        madeAnySwaps = true;
      }
      innerBubbleSortLoop(arr, i + 1, madeAnySwaps, outerBubbleSortLoop);
    });
  } else {
    outerBubbleSortLoop(madeAnySwaps);
  }
  // Do an "async loop":
  // 1. If (i == arr.length - 1), call outerBubbleSortLoop, letting it
  //    know whether any swap was made.
  // 2. Else, use `askIfGreaterThan` to compare `arr[i]` and `arr[i +
  //    1]`. Swap if necessary. Call `innerBubbleSortLoop` again to
  //    continue the inner loop. You'll want to increment i for the
  //    next call, and possibly switch madeAnySwaps if you did swap.
}

function absurdBubbleSort(arr, sortCompletionCallback) {
  function outerBubbleSortLoop(madeAnySwaps) {
    if(madeAnySwaps){
      innerBubbleSortLoop(arr, 0, false, outerBubbleSortLoop);
    }
    else{
      sortCompletionCallback(arr);
    }
    // Begin an inner loop if `madeAnySwaps` is true, else call
    // `sortCompletionCallback`.
  }
  outerBubbleSortLoop(true);
  // Kick the first outer loop off, starting `madeAnySwaps` as true.
}

absurdBubbleSort([3, 2, 1], function (arr) {
  console.log("Sorted array: " + JSON.stringify(arr));
  reader.close();
});
