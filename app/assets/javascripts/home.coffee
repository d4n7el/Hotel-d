# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ready = ->
	$('.carousel').carousel()
	$('img#individual_slader').attr 'src', $('a.carousel-item img').attr 'src'
	$('a.carousel-item img').on 'click', (e) ->
		cambio = $('img#individual_slader').attr 'src', $(this).attr 'src'
		cambio.fadeOut 0
		cambio.fadeIn 200
$(document).ready(ready)
$(document).on "page:load", ready