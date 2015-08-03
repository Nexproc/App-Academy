var Hanoi = function() {
  this.stacks = [[1,2,3],[],[]];
};

Hanoi.prototype.isWon = function (){
  var a = this.stacks[1].length === 3;
  var b = this.stacks[2].length === 3;
  return a || b;
};

Hanoi.prototype.isValidMove = function (startTowerIdx, endTowerIdx){
  if (this.stacks[startTowerIdx].length === 0) {
    return false;
  }
  return (this.stacks[endTowerIdx].length === 0) ||
  (this.stacks[startTowerIdx][0] < this.stacks[endTowerIdx][0]);
};

Hanoi.prototype.move = function (startTowerIdx, endTowerIdx) {
  var that = this;
  console.log("I'm in move!")
  if (that.isValidMove(startTowerIdx, endTowerIdx)) {
    this.stacks[endTowerIdx].unshift(this.stacks[startTowerIdx].shift());
    return true;
  } else {
    return false;
  }
};

Hanoi.prototype.print = function () {
  console.log(JSON.stringify(this.stacks));
};

Hanoi.prototype.promptMove = function (callback) {
  var startTowerIdx = prompt("Start Tower: ");
  var endTowerIdx = prompt("End Tower: ");
  return callback(startTowerIdx, endTowerIdx);
};

Hanoi.prototype.run = function() {
  this.print();
  if(this.isWon()) {
    console.log("Congratulations, you won!");
  }
  else{
    if (this.promptMove(this.move.bind(this))) {
      this.run();
    } else {
      console.log("Please make a valid move!");
      this.run();
    }
  }
};

var newGame = new Hanoi();
newGame.run();
