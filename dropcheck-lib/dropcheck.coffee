#Autosave function that runs every 10 seconds:
$ ->
	(->
	    viewModel.save();
	    setTimeout(arguments.callee, 10*1000);
	)();



# "Vare" class
class Vare
	constructor: (@text, @bought=0, @soldout=0) ->
	
	observabled: ->
		text: @text
		bought: ko.observable @bought
		soldout: ko.observable @soldout



# The knockout viewModel
viewModel = 
	varer: ko.observableArray()
	
	sortByBought: ->
		this.varer.sort (a, b) -> 
			a.bought() < b.bought() ? -1 : 1
        

	sortBySoldout: ->
		this.varer.sort (a, b) ->
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
	lines = JSON.parse(savedViewModel).varer
	
	for line in lines
		do (line) ->
			vare = new Vare(line.text, line.bought, line.soldout)
			viewModel.varer().push vare.observabled()

	$ -> ko.applyBindings viewModel


# ... else initialize viewModel from Dropbox textfile
else 
	$.ajax "dropcheck-list.txt"
		dataType: "text"
		success: (data) ->
			
			lines = data.split "\n"
			
			for line in lines
				do (line) ->
					vare = new Vare line.toString()
					viewModel.varer().push vare.observabled()

			ko.applyBindings viewModel


