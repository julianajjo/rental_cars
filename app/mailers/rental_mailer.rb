class RentalMailer < ApplicationMailer

  def rental_scheduled(rental_id)
    @rental = Rental.find(rental_id)
    customer = @rental.customer
    #return if customer.cancelled?

    mail(to: customer.email, subject: "Confirmação de Agendamento - #{ @rental.code }" )
  end


end
