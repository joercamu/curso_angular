# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
app = angular.module "app", []
app.directive "jcImageavantar", ->
	(scope,element,attrs) ->
		attrs.$observe "jcImageavantar", (value)->
			element.css {
				'background':"url(#{value})"
				'background-size':'cover'
				'background-position':'center'
			}
app.directive "jcAutocomplete" , ->
	{
	link: (scope,element,attrs) ->
		$(element).autocomplete
			source:scope.$eval attrs.jcAutocomplete
			select:(e,ui) ->
				e.preventDefault()
				scope.change_repo_selected  ui.item.label
				console.log ui
	}
app.controller "appController", ['$scope', '$http',($scope,$http)->
	$scope.repos = []
	$scope.repos_name = []
	$scope.repo_selected = false
	$http.get "https://api.github.com/users/joercamu/repos"
	.success (data) ->
		$scope.repos = data
		for repo in data
			$scope.repos_name.push(repo.name)
		console.log data
	.error (error) ->
		console.log error
	$scope.change_repo_selected = (data) ->
		$scope.$apply ->
			$scope.repo_selected = data
]