require 'rails_helper'

describe MaintenancePolicy do
    describe 'authorized?' do
        it 'should be true if admin' do
            user = build(:user, :admin)
            car = build(:car)

            result = MaintenancePolicy.new(car, user).authorized?
            
            expect(result).to be true
        end        

        it 'should be false if employee' do
            user = build(:user, role: :employee)
            car = build(:car)

            result = MaintenancePolicy.new(car, user).authorized?
            
            expect(result).to be false
        end

        it 'should be true if manager and same subsidiary' do
            subsidiary = create(:subsidiary)
            car = build(:car, subsidiary: subsidiary)
            user = build(:user, :manager, subsidiary: subsidiary)
            
            result = MaintenancePolicy.new(car, user).authorized?

            expect(result).to be true
        end

        it 'should be false if manager and other subsidiary' do
            subsidiary = create(:subsidiary, name: 'São Paulo')
            other_subsidiary = create(:subsidiary, name: 'Rio de Janeiro')
            car = build(:car, subsidiary: subsidiary)
            user = build(:user, :manager, subsidiary: other_subsidiary)
            
            result = MaintenancePolicy.new(car, user).authorized?

            expect(result).to be false
        end

        it 'should be false if guest' do
            guest = NilUser.new
            car = build(:car)

            result  = MaintenancePolicy.new(car, guest).authorized?

            expect(result).to eq false
        end
    end
end