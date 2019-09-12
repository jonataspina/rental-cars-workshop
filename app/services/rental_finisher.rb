class RentalFinisher

  def initialize(rental, car_km, mailer = RentalMailer)
    @rental = rental
    @car_km = car_km
    @customer = rental.customer
    @car = rental.car
  end

  def finish
    car.update(car_km: @car_km, status: :available)
  end
  
  private
  
  def rental_finished
    rental.update(finished_at: Time.zone.now, status: :finished)
  end 
  
  def notify_user
    RentalMailer.send_return_receipt(rental.id).delivery_now
  end
  
  attr_reader :rental, :car_km, :customer, :car
end