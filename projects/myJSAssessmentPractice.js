(function () {
  if (typeof Assessment === 'undefined') {
    window.Assessment = {};
  }

  //each
  Array.prototype.each = function (callback) {
    for (var i = 0; i < this.length; i++) {
      callback(this[i]);
    }
  };
  //inject
  Array.prototype.inject = function (callback) {
    var accu = this[0];
    this.slice(1).each(function(el){
      accu = callback(accu, el);
    });

    return accu;
  };
  //map
  Array.prototype.map = function (callback) {
    var mapper = this.slice(0);
    mapper.each(callback(el));

    return mapper;
  };

  //mergesort
  Array.prototype.mergeSort = function (comp) {
    // body...
  };

  //binarysearch
  //quicksort
  //bubblesort
  //fibbonacci
  //nPrimes
  //inherits
  //myBind
  //curry

})();
