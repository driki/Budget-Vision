require 'spec_helper'

describe Item do

  it { should belong_to(:category) }

  it { should_not allow_mass_assignment_of(:category) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:total) }
  
  it { should allow_mass_assignment_of :total }
  it { should_not allow_value("hello").for(:total) } 
  it { should validate_numericality_of(:total).with_message(/must be greater than 0/) }
  it { should_not allow_value(-1).for(:total) } 
  it { should allow_value(0).for(:total) } 

  it { should allow_mass_assignment_of :description }
  it { should ensure_length_of(:description).is_at_least(0).is_at_most(1000) }
end