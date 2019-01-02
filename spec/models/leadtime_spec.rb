require 'rails_helper'

RSpec.describe Leadtime, type: :model do
  describe '#create' do
    context 'can save' do
      it 'is valid with a text' do
        leadtime = build(:leadtime)
        expect(leadtime).to be_valid
      end
    end
    context 'can not save' do
      it 'is invalid without text' do
        leadtime = build(:leadtime, text: nil)
        leadtime.valid?
        expect(leadtime.errors[:text]).to include("can't be blank")
      end
    end
  end
end
