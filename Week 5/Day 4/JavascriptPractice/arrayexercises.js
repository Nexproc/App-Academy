function notInclude(value, array) {
  for (var i = 0; i < array.length; i++) {
    if (value === array[i]) { return false; }
  }

  return true;
}

function uniq(array) {
  var result = [];

  for (var i = 0; i < array.length; i++) {
    if ( notInclude(array[i], result)) {
      result = result.concat(array[i]);
    }
  }

  return result;
}

//WE DID IT!!!

function twoSum( array ) {
 result = [];
  for (var i = 0; i < array.length; i++) {
    for (var c = i + 1; c < array.length; c++) {
      if (array[i] + array[c] == 0) { result.push([i, c]); }
    }
  }
  return result;
}

function transpose( grid ) {
  result = []

  for (var i = 0; i < grid.length; i++) {
    result.push([]);
  }

  for (var i = 0; i < grid[0].length; i++) {
    for (var j = 0; j < grid.length; j++) {
      result[i].push(grid[j][i]);
    }
  }

  return result;
}
