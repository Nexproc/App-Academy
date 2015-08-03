var Game = function () {
  this.board = new Board();
  this.currentPlayer = "O";
};

Game.prototype.run = function () {
  var winner = this.board.isWon();
  var that = this;
  if (this.board.isTieGame()) {
    console.log("Cat's Game");
  } else if (winner) {
      console.log("Congratulations player " + winner + "!");
  } else {
    that.switchPlayer();
    that.playTurn();
  }
};

Game.prototype.playTurn = function (player) {
  this.board.draw();
  var input = prompt("Where would you like to move?");
  var pos = input.split(",").map(function(el) {return parseInt(el);});
  this.board.placePiece(pos, this.currentPlayer);
  var that = this;
  that.run();
};

Game.prototype.switchPlayer = function () {
  this.currentPlayer = this.currentPlayer === "X" ? "O" : "X";
};


var newGame = new Game();
newGame.run();

// row works, column doesnt
