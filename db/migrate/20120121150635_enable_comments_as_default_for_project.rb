class EnableCommentsAsDefaultForProject < ActiveRecord::Migration
  def up
  	change_column_default(:projects, :enable_comments, true)
  end

  def down
  	change_column_default(:projects, :enable_comments, nil)
  end
end
