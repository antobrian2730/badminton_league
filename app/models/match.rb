class Match < ApplicationRecord
  belongs_to :player1, class_name: 'Player'
  belongs_to :player2, class_name: 'Player'
  belongs_to :winner, class_name: 'Player'
  
  # Add these validations BEFORE the presence validations
  validates :player1_id, :player2_id, :winner_id, :match_date, presence: true
  validate :players_must_be_different
  validate :winner_must_be_participant
  
  before_create :update_player_stats
  before_destroy :revert_player_stats
  
  scope :recent, -> { order(match_date: :desc) }
  
  # Calculate the loser (opposite of winner)
  def loser
    if player1_id == winner_id
      player2
    elsif player2_id == winner_id
      player1
    else
      nil
    end
  end
  
  def opponent(player)
    player == player1 ? player2 : player1
  end
  
  def formatted_date
    match_date.strftime("%B %d, %Y at %l:%M %p")
  end
  
  private
  
  def players_must_be_different
    if player1_id.present? && player2_id.present? && player1_id == player2_id
      errors.add(:base, "Players must be different")
    end
  end
  
  def winner_must_be_participant
    unless [player1_id, player2_id].include?(winner_id)
      errors.add(:base, "Winner must be one of the players")
    end
  end
  
  def update_player_stats
    winner.increment!(:wins)
    loser.increment!(:losses)
  end
  
  def revert_player_stats
    winner.decrement!(:wins)
    loser.decrement!(:losses)
  end
end