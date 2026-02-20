class Player < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :wins, :losses, presence: true,
                   numericality: { greater_than_or_equal_to: 0, only_integer: true }

  # ⭐ ADD THIS
  has_many :matches_as_player1,
         class_name: "Match",
         foreign_key: "player1_id",
         dependent: :destroy

has_many :matches_as_player2,
         class_name: "Match",
         foreign_key: "player2_id",
         dependent: :destroy

  before_create :initialize_stats

  def total_matches
    (wins || 0) + (losses || 0)
  end

  def win_ratio
    total = total_matches
    return 0 if total.zero?
    ((wins.to_f / total) * 100).round(2)
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