class Player < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :wins, :losses, presence: true, numericality: { greater_than_or_equal_to: 0, only_integer: true }
  
  before_create :initialize_stats
  
  def total_matches
    (wins || 0) + (losses || 0)
  end
  
  def win_rate
    return 0 if total_matches.zero?
    ((wins.to_f / total_matches) * 100).round(2)
  end
  
  private
  
  def initialize_stats
    self.wins ||= 0
    self.losses ||= 0
  end
end