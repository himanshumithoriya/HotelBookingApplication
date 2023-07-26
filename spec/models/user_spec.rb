require 'rails_helper'

RSpec.describe User, type: :model do
  context ' when creating a user' do
    let(:user) { build :user }
    # let(:user1) { create :user}

    it 'should be valid user' do
    # user.valid?.should == true
      expect(user.valid?).to eq(true)
    end
  end
end