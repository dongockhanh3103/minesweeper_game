module Games
  class InitializeBoard < BaseOperation
    def initialize(game)
      @game = game
    end

    def call
      game.board = generate_board
      game.status = 'initial'
      game.revealed = Array.new(game.width) { Array.new(game.height, false) }.to_json

      game.save
    end

    private

    attr_reader :game

    def generate_board
      board = Array.new(game.width) { Array.new(game.height, 0) }

      # Randomly place mines
      placed_mines = 0
      while placed_mines < game.number_of_mines
        row = rand(0...game.width)
        col = rand(0...game.height)
        if board[row][col] != 'M'
          board[row][col] = 'M'
          placed_mines += 1
        end
      end

      for row in 0...game.width
        for col in 0...game.height
          next if board[row][col] == 'M'
          board[row][col] = count_mines_around(board, row, col)
        end
      end

      board
    end

    def count_mines_around(board, row, col)
      directions = [-1, 0, 1].repeated_permutation(2).to_a - [[0, 0]]
      mine_count = 0
      directions.each do |dx, dy|
        r = row + dx
        c = col + dy
        mine_count += 1 if r.between?(0, game.width - 1) && c.between?(0, game.height - 1) && board[r][c] == 'M'
      end

      mine_count
    end
  end
end