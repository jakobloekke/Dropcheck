#Autosave function that runs every 10 seconds:
$ ->
	(->
	    viewModel.save();
	    setTimeout(arguments.callee, 10*1000);
	)();



# "Item" class
class Item
	constructor: (@text, @bought=0, @soldout=0) ->
	
	observabled: ->
		text: @text
		bought: ko.observable @bought
		soldout: ko.observable @soldout



# The knockout viewModel
viewModel = 
	items: ko.observableArray()
	
	sortByBought: ->
		this.items.sort (a, b) -> 
			a.bought() < b.bought() ? -1 : 1

	sortBySoldout: ->
		this.items.sort (a, b) ->
			a.soldout() < b.soldout() ? -1 : 1

	save: ->
		for_storage = ko.toJSON(viewModel)
		localStorage.setItem("viewModel", for_storage)

	reset: ->
		localStorage.removeItem("viewModel")
		location.reload()



# If saved viewModel exists in localStorage, render that:
savedViewModel = localStorage.getItem("viewModel")
if savedViewModel
	lines = JSON.parse(savedViewModel).items
	
	for line in lines
		do (line) ->
			item = new Item(line.text, line.bought, line.soldout)
			viewModel.items().push item.observabled()

	$ -> ko.applyBindings viewModel



# ... else initialize viewModel from Dropbox textfile
else 
	$.ajax "dropcheck-list.txt"
		dataType: "text"
		success: (data) ->
			
			lines = data.split "\n"
			
			for line in lines
				do (line) ->
					item = new Item( line.toString() )
					viewModel.items().push item.observabled()

			ko.applyBindings viewModel
