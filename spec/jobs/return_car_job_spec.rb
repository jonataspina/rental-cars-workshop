require 'rails_helper'

describe ReturnCarJob do
  describe '.auto_enqueue' do
    let(:car) { create(:car, status: :rented) }
    let(:rental) { create(:rental, car: car, started_at: Time.zone.now) }

    it 'should perform successfully' do
      described_class.auto_enqueue(rental.id)

      expect(Delayed::Worker.new.work_off).to eq [1, 0]
    end

    it 'should change rental to finalize' do
      mail = double('Mailer')
      mailer_spy = class_spy(RentalMailer)
      stub_const('RentalMailer', mailer_spy)
      allow(RentalMailer).to receive(:send_return_receipt).with(rental.id)
                                                          .and_return(mail)
      allow(mail).to receive(:delivery_now)

      described_class.auto_enqueue(rental.id)

      expect(Delayed::Worker.new.work_off).to eq [1, 0]
      expect(rental.reload).to be_finished
      # expect(mai)
    end
  end
end
