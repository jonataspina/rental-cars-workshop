class CarPresenter < SimpleDelegator
    include Rails.application.routes.url_helpers

    attr_reader :user

    def initialize(car, user)
        super(car)
        @user = user
    end

    def maintenance_link
        return '' if MaintenancePolicy.new(car, user).authorized?

        if available?
            h.link_to 'Enviar para manutenção', new_car_maintenance_path(id)
        end
    end

    def h
        ApplicationController.helpers
    end

end