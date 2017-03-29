# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ready = ->
# 	$('.modal').modal();
# 	$('a.reserva-btn').on 'click', (e) ->
# 		formData = $(this).attr 'habitacion'
# 		$.ajax
# 			url: 'bedrooms/'+formData+'/reservations/get_bedroom'
# 			type: 'post'
# 			dataType: 'JSON'
# 			data: formData
# 			cache: false
# 			contentType: false
# 			processData: false
# 			success: (res) ->
# 				console.log res
# 				reservar(res)
	$('input#quantity_days').focusout (e) ->
		valor = $('input#val_hab').val()
		dias = $(this).val()
		resultado = valor * dias
		$('div.pago').html '<h5 class="mensaje">el cliente debe Cancelar: $ '+resultado+'</h5>'
	$('.datepicker').pickadate (e) ->
		selectMonths: true,# Creates a dropdown to control month
		selectYears: 15 #Creates a dropdown of 15 years to control year
  	
$(document).ready(ready)
$(document).on "page:load", ready
# reservar = (res) ->
# 	html = '<div class="row">
# 				<h5 class="center col m12"> Reserva:  '+ res[0].name+'</h5>
# 				<div class="row">
# 					<p class="col m5">Descripción:</p> <p class="col m7">'+res[1].description+'</p>
# 				</div>
# 				<div class="row">
# 					<p class="col m5">tipo de servicio:</p> <h5 class="col m7">'+res[1].type_service+'</h5>
# 				</div>
# 				<div class="row">
# 					<p class="col m5">Valor habitacion:</p> <h5 class="col m7">$ '+res[1].value+'</h5>
# 				</div>
# 			</div>'

# 	$('div#modal_reserva div.modal-content').html html