class ReturnCarJob
  def perform
    rental.update_attribute(:status, :finished)
    RentalMailer.send_rental_receipt(rental.id).delivery_now
  end

  def self.auto_enqueue(rental_id)
    Delayed::Job.enqueue(ReturnCarJob.new(rental_id))
  end

  private

  attr_reader :rental

  def initialize(rental_id)
    @rental = Rental.find(rental_id)
  end
end