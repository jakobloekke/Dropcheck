
# "Vare" class
vare = (bought, text, soldout) ->
	this.bought = ko.observable(bought)
	this.text = text
	this.soldout = ko.observable(soldout)


# Declare viewModel
viewModel = 
	varer: ko.observableArray()
	
	sortByBought: ->
		this.varer.sort (a, b) -> 
			return a.bought() < b.bought() ? -1 : 1
        

	sortBySoldout: ->
		this.varer.sort (a, b) ->
			return a.soldout() < b.soldout() ? -1 : 1
    

	save: ->
		forStorage = ko.toJSON(viewModel)
		localStorage.setItem("viewModel", forStorage)

	
	reset: ->
		localStorage.removeItem("viewModel")
		location.reload()



# If saved viewModel exists in localStorage, render that:
savedViewModel = localStorage.getItem("viewModel");
if savedViewModel
	$ JSON.parse(savedViewModel).varer 
		.each ->
			viewModel.varer().push(
				new vare(this.bought, this.text, this.soldout)
			) 
	
	$ ->
		ko.applyBindings(viewModel);


# ... else initialize viewModel from Dropbox textfile
else 
	$.ajax "dropcheck-list.txt"
		dataType: "text"
		success: (data) ->
			lines = data.split "\n"
			
			$ lines
				.each ->
				viewModel.varer().push(
					new vare(0, this.toString(), 0)
				) 

			ko.applyBindings(viewModel);


