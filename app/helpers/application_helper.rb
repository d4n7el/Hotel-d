module ApplicationHelper
	def calculate_payments reservation
		pago = 0
		debt = Debt.where(reservation_id: reservation).limit(1)
		payments = Payment.where(reservation_id: reservation)
		payments.each do|p|
			pago = pago + p.value.to_i
		end
		deuda = debt[0].value.to_i - pago
		html =  "<p class='col m12'><i class='material-icons'>assignment_ind</i> Pago Cliente : $ #{pago}</p>"\
				"<p class='col m12'><i class='material-icons'>assignment_ind</i> Deuda Actual : $ #{deuda}</p>"
		html.html_safe
	end
end

