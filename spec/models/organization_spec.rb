require 'spec_helper'

describe Organization do

  it { should have_many(:projects) }
  it { should have_many(:users) }

  it { should_not allow_mass_assignment_of(:id) }

  it { should validate_presence_of(:name) }
  
  it { should validate_numericality_of(:population).with_message(/greater than 0/) }
  it { should_not allow_value(1950.2).for(:population) }
  it { should_not allow_value(-1).for(:population) }

  it { should validate_presence_of(:state) }


  describe "Hamlet" do

    it "should have an annual price of $350" do

      @org = Factory(:organization, :population => 1, :state => "ME")
      @org.price.should == 350      

      @org = Factory(:organization, :population => 1000, :state => "ME")
      @org.price.should == 350
    end

  end

  describe "Village" do
    it "should have an annual price of $900" do
      @org = Factory(:organization, :population => 1001, :state => "ME")
      @org.price.should == 900

      @org = Factory(:organization, :population => 5000, :state => "ME")
      @org.price.should == 900
    end
  end

  describe "Town" do
    it "should have an annual price of $1800" do
      @org = Factory(:organization, :population => 5001, :state => "ME")
      @org.price.should == 1800

      @org = Factory(:organization, :population => 20000, :state => "ME")
      @org.price.should == 1800
    end
  end

  describe "City" do
    it "should have an annual price of $2400" do
      @org = Factory(:organization, :population => 20001, :state => "ME")
      @org.price.should == 2400

      @org = Factory(:organization, :population => 50000, :state => "ME")
      @org.price.should == 2400
    end
  end

  describe "Big City" do
    it "should have an annual price of $6000" do
      @org = Factory(:organization, :population => 50001, :state => "ME")
      @org.price.should == 6000

      @org = Factory(:organization, :population => 500000, :state => "ME")
      @org.price.should == 6000
    end
  end

  describe "Metropoplis" do
    it "should have an annual price of $12,000" do
      @org = Factory(:organization, :population => 500001, :state => "ME")
      @org.price.should == 12000

      @org = Factory(:organization, :population => 1000000, :state => "ME")
      @org.price.should == 12000
    end
  end
end