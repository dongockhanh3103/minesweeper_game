class Game < ApplicationRecord
  enum :status, { initial: 'initial', playing: 'playing', won: 'won', lost: 'lost' }

  validates :name, :email, :width, :height, :number_of_mines, presence: true
  validates :email, format: URI::MailTo::EMAIL_REGEXP
  validates :width, :height, :number_of_mines, numericality: { other_than: 0 }
  validate :validate_number_of_mines

  after_create :initialize_board

  def initialize_board
    Games::InitializeBoard.call(self)
  end

  private

  def validate_number_of_mines
    errors.add(:number_of_mines, "must be less than #{width * height}") if number_of_mines > width * height
  end
end
