// Generated by CoffeeScript 1.7.1
(function() {
  var generateTyles;

  $(function() {
    var ppArray;
    ppArray = function(array) {
      var row, _i, _len, _results;
      _results = [];
      for (_i = 0, _len = array.length; _i < _len; _i++) {
        row = array[_i];
        _results.push(console.log(row));
      }
      return _results;
    };
    this.board = [0, 1, 2, 3].map(function() {
      return [0, 1, 2, 3].map(function() {
        return 0;
      });
    });
    return ppArray(this.board);
  });

  generateTyles = function(board) {};

}).call(this);

//# sourceMappingURL=main.map