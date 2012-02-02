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
		#direction = if a.bought < b.bought then -1 else 1
		this.items.sort (a, b) ->
			if a.bought() < b.bought() then -1 else 1

	sortBySoldout: ->
		this.items.sort (a, b) ->
			if a.soldout() < b.soldout() then -1 else 1

	save: ->
		for_storage = ko.toJSON(viewModel)
		localStorage.setItem("Dropcheck", for_storage)

	reset: ->
		localStorage.removeItem("Dropcheck")
		location.reload()



# If saved viewModel exists in localStorage, render that:
savedViewModel = localStorage.getItem("Dropcheck")
if savedViewModel
	lines = JSON.parse(savedViewModel).items
	
	for line in lines
		do (line) ->
			item = new Item(line.text, line.bought, line.soldout)
			viewModel.items().push item.observabled()

	$ -> ko.applyBindings viewModel



# ... else initialize viewModel from Dropbox textfile
else 
	$.ajax "list.txt"
		dataType: "text"
		success: (data) ->
			
			lines = data.split "\n"
			
			for line in lines
				do (line) ->
					item = new Item( line.toString() )
					viewModel.items().push item.observabled()

			ko.applyBindings viewModel