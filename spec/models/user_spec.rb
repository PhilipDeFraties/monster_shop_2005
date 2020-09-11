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

      user_1 = User.create(name: 'Jeff Bezos',
                          address: '123 Main Street',
                          city: 'Denver',
                          state: 'CO',
                          zip: '80123',
                          email: 'jbezos@amazon.com',
                          password: 'Hunter2')

      expect(user_1.role).to eq("default")
      expect(user_1.default?).to be_truthy
    end

    it "can be created as a merchant" do

      merchant_1 = User.create(name: 'Bill Gates',
                          address: '1000 Microsoft Drive',
                          city: 'Seattle',
                          state: 'WA',
                          zip: '00123',
                          email: 'bill.gates@outlook.com',
                          password: '@%)abc123#$.',
                          role: 1)

      expect(merchant_1.role).to eq("merchant")
      expect(merchant_1.merchant?).to be_truthy
    end

    it "can be created as an admin" do

      merchant_1 = User.create(name: 'Warren Buffet',
                          address: '9999 Buffet Street',
                          city: 'New York',
                          state: 'NY',
                          zip: '70007',
                          email: 'warrenbuffet@gmail.com',
                          password: 'Password1234',
                          role: 2)

      expect(merchant_1.role).to eq("admin")
      expect(merchant_1.admin?).to be_truthy
    end
  end
end
