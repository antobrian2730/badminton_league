class LeaderboardsController < ApplicationController
  helper_method :player_win_ratio
  
  def index
    @players = Player.order(wins: :desc, losses: :asc)
  end

  private

  def player_win_ratio(player)
    total_matches = player.wins + player.losses
    return 0 if total_matches.zero?
    ((player.wins.to_f / total_matches) * 100).round(2)
  end
end