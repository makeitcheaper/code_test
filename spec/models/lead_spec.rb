require 'rails_helper'

describe Lead do

  before do
    @lead = Lead.new(name: "Example User", email: "user@example.com",
                     business_name: "foobar", telephone_number: "01344123456",
                     contact_time: DateTime.now.to_formatted_s(:db))
  end

  subject { @lead }

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:business_name) }
  it { should respond_to(:telephone_number) }
  it { should respond_to(:contact_time) }
  it { should respond_to(:notes) }
  it { should respond_to(:reference) }

  it { should be_valid }

  describe "when name is not present" do
    before { @lead.name = " " }
    it { should_not be_valid }
  end

  describe "when email is not present" do
    before { @lead.email = " " }
    it { should_not be_valid }
  end

  describe "when name is too long" do
    before { @lead.name = "a" * 101 }
    it { should_not be_valid }
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com foo@bar..com]
      addresses.each do |invalid_address|
        @lead.email = invalid_address
        expect(@lead).not_to be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @lead.email = valid_address
        expect(@lead).to be_valid
      end
    end
  end

  describe "when business name is not present" do
    before { @lead.business_name = " " }
    it { should_not be_valid }
  end

  describe "when business name is too long" do
    before { @lead.business_name = "a" * 101 }
    it { should_not be_valid }
  end

  describe "when telephone number is not present" do
    before { @lead.telephone_number = " " }
    it { should_not be_valid }
  end

  describe "when notes is too long" do
    before { @lead.telephone_number = "a" * 51}
    it { should_not be_valid }
  end

  describe "when reference is too long" do
    before { @lead.telephone_number = "a" * 256}
    it { should_not be_valid }
  end
end
