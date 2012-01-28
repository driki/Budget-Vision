class FixColumnTypeForGoalNameToString < ActiveRecord::Migration
  def up
  	change_column(:goals, :name, :string)
  end

  def down
  	change_column(:goals, :name, :text)
  end
end
