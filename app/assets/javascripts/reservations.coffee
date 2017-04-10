# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ready = ->
	$('.datepicker').pickadate (e) ->
		selectMonths: true,# Creates a dropdown to control month
		selectYears: 15 #Creates a dropdown of 15 years to control year
	$(document).on 'ajax:success','form#new_pay', (e,data) ->
		if parseInt(data.value) > 0
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
	$(document).on 'ajax:error',(e,data) ->
		$('div.alerta_js').removeClass 'hide'
		html = 	'<i class="material-icons">money_off</i>
				<p class="alert">La cantidad no es valida </p>'
		$('div.alerta_js').html html
		setTimeout (->
			$('div.alerta_js').addClass 'hide'
		), 3000
	$('div.picker__holder').mouseenter ->
		url = document.URL
		url = url.split("bedrooms")
		url = url[1].split("/")
		url = url[1]
		formData = url
		$.ajax
			url: '../../../../reservations/'+formData+'/get_calendar'
			type: 'post'
			dataType: 'JSON'
			data: formData
			cache: false
			contentType: false
			processData: false
			success: (res) ->
				x = 0
				while x < res.length
					admission = res[x].admission_date
					departure = res[x].departure_date
					fecha_admission = new Date(admission);
					fecha_departure = new Date(departure);
					while fecha_admission < fecha_departure
						fecha_admission = fecha_admission.setDate(fecha_admission.getDate()+ 1,64e+7);
						fecha_admission = new Date(fecha_admission)
						parse_date(fecha_admission)
					x++
					if fecha_admission.getDate == fecha_departure.getDate
						fecha_admission = fecha_admission.setDate(fecha_admission.getDate()+ 1,64e+7);
						fecha_admission = new Date(fecha_admission)
						parse_date(fecha_admission)
					
			error: ->
$(document).ready(ready)
$(document).on "page:load", ready

parse_date = (date)->
	date = date.toString()
	date = date.split(" ")
	year_init = date[3]
	month_init = date[1]
	date_init = date[2]
	parse_month(year_init,date_init,month_init)
parse_month = (year,date,month)->
	date = date
	year = year
	month = month
	switch month
  		when 'Jan'
  			month = 'January'
  		when 'Feb'
  			month = 'February'
  		when 'Mar'
  			month = 'March'
  		when 'Apr'
  			month = 'April'
  		when 'May'
  			month = 'May'
  		when 'Jun'
  			month = 'June'
  		when 'Jul'
  			month = 'July'
  		when 'Aug'
  			month = 'August'
  		when 'Sep'
  			month = 'September'
  		when 'Oct'
  			month = 'October'
  		when 'Nov'
  			month = 'November'
  		when 'Dec'
  			month = 'December'
  	switch date
  		when '01'
  			date = '1'
  		when '02'
  			date = '2'
  		when '03'
  			date = '3'
  		when '04'
  			date = '4'
  		when '05'
  			date = '5'
  		when '06'
  			date = '6'
  		when '07'
  			date = '7'
  		when '08'
  			date = '8'
  		when '09'
  			date = '9'
  	console.log month
  	date_disable(date,month,year)
date_disable = (date,month,year)->
	selector = "#{date} #{month}, #{year}"
	$( "div[aria-label='"+selector+"' ]" ).removeClass "picker__day picker__day--infocus" 
	$( "div[aria-label='"+selector+"' ]" ).addClass "picker__day picker__day--outfocus" 