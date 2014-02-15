require 'spec_helper'

describe User do
  before { @user = User.new(user: "Example", password: "pass1") }

  subject { @user }

  it { should respond_to(:user) }
  it { should respond_to(:password) }
  it {should respond_to(:count)}
  it {should be_valid}

  describe "when user is not present" do
  	before { @user.user = " "}
  	it { should_not be_valid}
  end

  describe "when user name too long" do 
  	before {@user.user = "a"*200}
  	it {should_not be_valid}
  end

  describe "when user name already exists" do
  	before do 
  		@user2 = User.new(user: "Example", password: "pass2")
  		@user2.save
  	end

  	it {should_not be_valid}
  end



  describe "when password is not present" do
  	before {@user.password = ""}
  	it{should_not be_valid}
  end

  describe "when password too long" do
  	before {@user.password = "a" *200}
  	it {should_not be_valid}
  end
/
  describe "reset test" do 
  	user3 = User.new
  	val = user3.reset()
  	expect(val).to eq(1)
  end
/

end
