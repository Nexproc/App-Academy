var Board = function () {
  this.setUpGrid();
};

Board.prototype.setUpGrid = function () {
  this.grid = [];
  for (var i = 0; i < 3; i++) {
    this.grid.push(["_", "_", "_"]);
  }
};

Board.prototype.isWon = function () {
  for (var i = 0; i < 3; i++) {
    var currentCol = [];

    for (var j = 0; j < 3; j++) {
      currentCol.push(this.grid[i][j]);
    }

  //Column Check
    if (currentCol.join("") === "XXX") {
      return "X";
    }
    else if (currentCol.join("") === "OOO") {
      return "O";
    }
  //Row Check
    var currentRow = this.grid[i].join("");
    if (currentRow === "XXX") {
      return "X";
    }
    else if (currentRow === "OOO") {
      return "O";
    }
  }

  var leftDiag = this.grid[0][0] + this.grid[1][1] + this.grid[2][2];
  var rightDiag = this.grid[0][2] + this.grid[1][1] + this.grid[2][0];
  if (leftDiag === "XXX" || rightDiag === "XXX") {
    return "X";
  }
  if (leftDiag === "OOO" || rightDiag === "OOO") {
    return "O";
  }

  return false;
};

Board.prototype.isTieGame = function () {
  for (var i = 0; i < 3; i++) {
    for (var j = 0; j < 3; j++) {
      if (this.grid[i][j] === "_") {return false;}
    }
  }

  return true;
};

Board.prototype.draw = function () {
  for (var i = 0; i < 3; i++) {
    console.log(JSON.stringify(this.grid[i]));
  }
  console.log("--------------")
};

Board.prototype.placePiece = function(pos, player){
  var row = pos[0];
  var col = pos[1];
  this.grid[row][col] = player;
};
