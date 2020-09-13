require 'rails_helper'

describe User, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :address }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zip }
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
    it { should validate_presence_of :password }
  end

  describe "roles" do
    it "can be created as a default user" do
      user_1 = create(:user)

      expect(user_1.role).to eq("default")
      expect(user_1.default?).to be_truthy
    end

    it "can be created as a merchant" do
      merchant_1 = create(:merchant_user)

      expect(merchant_1.role).to eq("merchant")
      expect(merchant_1.merchant?).to be_truthy
    end

    it "can be created as an admin" do
      admin_1 = create(:admin_user)

      expect(admin_1.role).to eq("admin")
      expect(admin_1.admin?).to be_truthy
    end
  end
end
