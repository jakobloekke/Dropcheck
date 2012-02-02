var savedViewModel, vare, viewModel;

vare = function(bought, text, soldout) {
  this.bought = ko.observable(bought);
  this.text = text;
  return this.soldout = ko.observable(soldout);
};

viewModel = {
  varer: ko.observableArray(),
  sortByBought: function() {
    return this.varer.sort(function(a, b) {
      var _ref;
      return (_ref = a.bought() < b.bought()) != null ? _ref : -{
        1: 1
      };
    });
  },
  sortBySoldout: function() {
    return this.varer.sort(function(a, b) {
      var _ref;
      return (_ref = a.soldout() < b.soldout()) != null ? _ref : -{
        1: 1
      };
    });
  },
  save: function() {
    var forStorage;
    forStorage = ko.toJSON(viewModel);
    return localStorage.setItem("viewModel", forStorage);
  },
  reset: function() {
    localStorage.removeItem("viewModel");
    return location.reload();
  }
};

savedViewModel = localStorage.getItem("viewModel");

if (savedViewModel) {
  $(JSON.parse(savedViewModel).varer.each(function() {
    return viewModel.varer().push(new vare(this.bought, this.text, this.soldout));
  }));
  $(function() {
    return ko.applyBindings(viewModel);
  });
} else {
  $.ajax("dropcheck-list.txt", {
    dataType: "text",
    success: function(data) {
      var lines;
      lines = data.split("\n");
      $(lines.each(function() {}));
      viewModel.varer().push(new vare(0, this.toString(), 0));
      return ko.applyBindings(viewModel);
    }
  });
}