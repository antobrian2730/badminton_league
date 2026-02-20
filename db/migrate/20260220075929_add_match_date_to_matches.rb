class AddMatchDateToMatches < ActiveRecord::Migration[7.2]
  def change
    add_column :matches, :match_date, :datetime
  end
end
