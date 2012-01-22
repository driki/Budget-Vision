require 'spec_helper'

describe Category do

  it { should have_many(:items) }
  it { should belong_to(:project) }

  it { should_not allow_mass_assignment_of(:project) }

  it { should validate_presence_of(:name) }
  
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

  it { should allow_mass_assignment_of :challenge }
  it { should ensure_length_of(:challenge).is_at_least(0).is_at_most(2000) }

  it { should allow_mass_assignment_of :goal }
  it { should ensure_length_of(:goal).is_at_least(0).is_at_most(2000) }
end