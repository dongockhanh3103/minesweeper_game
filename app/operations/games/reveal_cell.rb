module Games
  class RevealCell < BaseOperation
    def initialize(game, row, col)
      @game = game
      @row = row
      @col = col
    end

    def call
      board = JSON.parse(game.board)
      revealed = JSON.parse(game.revealed)

      return game if revealed[row][col]

      revealed[row][col] = true
      game.status = Game.statuses[:playing] if game.initial?

      if board[row][col] == 'M'
        game.status = Game.statuses[:lost]
        revealed = Array.new(game.width) { Array.new(game.height, true) }
      elsif board[row][col] == 0
        reveal_adjacent_cells(row, col, board, revealed)
      end

      if game.status != Game.statuses[:lost] && revealed.flatten.count(false) == game.number_of_mines
        game.status = Game.statuses[:won]
        revealed = Array.new(game.width) { Array.new(game.height, true) }
      end

      game.revealed = revealed.to_json
      game.save!

      game
    end

    private

    attr_reader :game, :row, :col

    def reveal_adjacent_cells(row, col, board, revealed)
      directions = [-1, 0, 1].repeated_permutation(2).to_a - [[0, 0]]
      directions.each do |dx, dy|
        r = row + dx
        c = col + dy
        if r.between?(0, game.width - 1) && c.between?(0, game.height - 1) && !revealed[r][c]
          revealed[r][c] = true
          reveal_adjacent_cells(r, c, board, revealed) if board[r][c] == 0
        end
      end
    end
  end
end
