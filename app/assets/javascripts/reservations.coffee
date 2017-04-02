# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ready = ->
	$('.datepicker').pickadate (e) ->
		selectMonths: true,# Creates a dropdown to control month
		selectYears: 15 #Creates a dropdown of 15 years to control year
	$(document).on 'ajax:success','form#new_pay', (e,data) ->
		pago_reserva = parseInt(data.value)
		html = '<div class="col m12">
					<p class="col m6 ">Pago Reservaaa :</p>
					<h6 class="center col m6">$ '+pago_reserva+'</h6>
				</div>'
		$('h6#deuda_total').after html
		total_pagado = $('h6#total_pagado').text()
		total_pagado = parseInt pago_reserva + parseInt total_pagado
		deuda_actual = $('h6#deuda_actual').text()
		deuda_actual = parseInt deuda_actual - pago_reserva
		$('h6#total_pagado').text total_pagado
		$('h6#deuda_actual').text deuda_actual
		$('input#payment_value').val ""
$(document).ready(ready)
$(document).on "page:load", ready
