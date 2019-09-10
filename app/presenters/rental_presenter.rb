class RentalPresenter < SimpleDelegator
  include Rails.application.routes.url_helpers

  def initialize(rental)
    super(rental)
  end

  def status
    if scheduled? 
      helpers.content_tag(:span, class: 'badge badge-success') do
        'Agendada'
      end
    elsif active?
      helpers.content_tag(:span, class: 'badge badge-primary') do
        'Em Andamento'
      end
    end
  end

  def link_action
    if scheduled?
      helpers.link_to 'Confirmar Retirada', withdraw_rental_path(self), method: :post
    elsif active?
      helpers.link_to 'Confirmar Devolução', new_car_return_rental_path(self)
    end
  end

  private 

  attr_reader :rental

  def helpers
    ApplicationController.helpers
  end
end