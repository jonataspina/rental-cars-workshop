class RentalDecorator < ApplicationDecorator

    def started_at
        if object.scheduled?
            return '---'
        end

        return object.started_at if object.active?
    end
end