(function() {
  var Item, line, lines, savedViewModel, viewModel, _fn, _i, _len;

  $(function() {
    return (function() {
      viewModel.save();
      return setTimeout(arguments.callee, 10 * 1000);
    })();
  });

  Item = (function() {

    function Item(text, bought, soldout) {
      this.text = text;
      this.bought = bought != null ? bought : 0;
      this.soldout = soldout != null ? soldout : 0;
    }

    Item.prototype.observabled = function() {
      return {
        text: this.text,
        bought: ko.observable(this.bought),
        soldout: ko.observable(this.soldout)
      };
    };

    return Item;

  })();

  viewModel = {
    items: ko.observableArray(),
    sortByBought: function() {
      return this.items.sort(function(a, b) {
        var _ref;
        return (_ref = a.bought() < b.bought()) != null ? _ref : -{
          1: 1
        };
      });
    },
    sortBySoldout: function() {
      return this.items.sort(function(a, b) {
        var _ref;
        return (_ref = a.soldout() < b.soldout()) != null ? _ref : -{
          1: 1
        };
      });
    },
    save: function() {
      var for_storage;
      for_storage = ko.toJSON(viewModel);
      return localStorage.setItem("viewModel", for_storage);
    },
    reset: function() {
      localStorage.removeItem("viewModel");
      return location.reload();
    }
  };

  savedViewModel = localStorage.getItem("viewModel");

  if (savedViewModel) {
    lines = JSON.parse(savedViewModel).items;
    _fn = function(line) {
      var item;
      item = new Item(line.text, line.bought, line.soldout);
      return viewModel.items().push(item.observabled());
    };
    for (_i = 0, _len = lines.length; _i < _len; _i++) {
      line = lines[_i];
      _fn(line);
    }
    $(function() {
      return ko.applyBindings(viewModel);
    });
  } else {
    $.ajax("list.txt", {
      dataType: "text",
      success: function(data) {
        var line, _fn2, _j, _len2;
        lines = data.split("\n");
        _fn2 = function(line) {
          var item;
          item = new Item(line.toString());
          return viewModel.items().push(item.observabled());
        };
        for (_j = 0, _len2 = lines.length; _j < _len2; _j++) {
          line = lines[_j];
          _fn2(line);
        }
        return ko.applyBindings(viewModel);
      }
    });
  }

}).call(this);
