class AddColumnAcceptToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :accept, :boolean, :default=>false
  end
end
