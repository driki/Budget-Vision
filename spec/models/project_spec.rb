require 'spec_helper'

describe Project do

  it { should belong_to(:organization) }
  it { should have_many(:categories) }
  it { should have_many(:goals) }
  it { should have_many(:forecasts) }
  it { should have_many(:sources) }

  it "should have a paper trail"

  it { should_not allow_mass_assignment_of(:organization) }
  it { should_not allow_mass_assignment_of(:user) }

  it { should validate_presence_of(:year).with_message(/greater than 1900/) }
  it { should validate_numericality_of(:year).with_message(/greater than 1900/) }
  it { should allow_mass_assignment_of :year }
  it { should_not allow_value(1950.2).for(:year) }
  it { should_not allow_value(1899).for(:year) }
  it { should allow_value(1950).for(:year) }

  it { should allow_mass_assignment_of :title }
  it { should ensure_length_of(:title).is_at_least(0).is_at_most(150) }

  it { should allow_mass_assignment_of :average_tax_bill }
  it { should validate_numericality_of(:average_tax_bill).with_message(/must be greater than 0/) }
  it { should_not allow_value(-1).for(:average_tax_bill) } 
  it { should allow_value(0).for(:average_tax_bill) } 
  it { should_not allow_value("hello").for(:average_tax_bill) } 

  it { should allow_mass_assignment_of :expense_budget }
  it { should_not allow_value("hello").for(:expense_budget) } 
  it { should validate_numericality_of(:expense_budget).with_message(/must be greater than 0/) }
  it { should_not allow_value(-1).for(:expense_budget) } 
  it { should allow_value(0).for(:expense_budget) } 

  it { should allow_mass_assignment_of :revenue_budget }
  it { should_not allow_value("hello").for(:revenue_budget) } 
  it { should validate_numericality_of(:revenue_budget).with_message(/must be greater than 0/) }
  it { should_not allow_value(-1).for(:revenue_budget) } 
  it { should allow_value(0).for(:revenue_budget) } 

  it { should allow_mass_assignment_of :description }
  it { should ensure_length_of(:description).is_at_least(0).is_at_most(2000) }

  it { should allow_mass_assignment_of :summary }
  it { should ensure_length_of(:summary).is_at_least(0).is_at_most(2000) }

  it { should allow_mass_assignment_of :enable_comments }

  it { should allow_mass_assignment_of :enable_tips }

  it { should allow_mass_assignment_of :is_demo }
end


