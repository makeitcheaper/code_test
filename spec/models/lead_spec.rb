require 'rails_helper'


RSpec.describe Lead, type: :model do
  it "validates correct instance" do
    lead = build(:lead_thomas)
    assert lead.valid?
  end


  describe "full_name validations" do
    it "in invalid if it is empty" do
      lead = build(:lead_thomas, full_name: "")
      assert lead.invalid?
    end
  end


  describe "business_name validations" do
    it "in invalid if it is empty" do
      lead = build(:lead_thomas, business_name: "")
      assert lead.invalid?
    end
  end


  describe "email validations" do
    it "is invalid if it is empty" do
      lead = build(:lead_thomas, email: "")
      assert lead.invalid?
    end

    it "is invalid if missing @ sign" do
      lead = build(:lead_thomas, email: "asdf")
      assert lead.invalid?
    end

    it "is invalid if longer than 80 characters" do
      email = 'a' * 81
      lead = build(:lead_thomas, email: email)
      assert lead.invalid?
    end
  end


  describe "phone number validations" do
    it "is invalid if it is empty" do
      lead = build(:lead_thomas, phone_number: "")
      assert lead.invalid?
    end


    it "is invalid if it contains characters" do
      lead = build(:lead_thomas, phone_number: "a123321")
      assert lead.invalid?
    end
  end
end
