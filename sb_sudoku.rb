# Sudoku Rules:
#   Each cell should contain a digit 1-9 such that:
#     * horizontal row contains each digit exactly once
#       [_ _ _  _ _ _  _ _ _]
#       [_ _ _  _ _ _  _ _ _]
#       [_ _ _  _ _ _  _ _ _]
#
#       [_ _ _  _ _ _  _ _ _]
#       [1 2 3  4 5 6  7 8 9]
#       [_ _ _  _ _ _  _ _ _]
#
#       [_ _ _  _ _ _  _ _ _]
#       [_ _ _  _ _ _  _ _ _]
#       [_ _ _  _ _ _  _ _ _]
#     * vertical column contains each digit exactly once
#       [_ _ _  _ 1 _  _ _ _]
#       [_ _ _  _ 2 _  _ _ _]
#       [_ _ _  _ 3 _  _ _ _]
#
#       [_ _ _  _ 4 _  _ _ _]
#       [_ _ _  _ 5 _  _ _ _]
#       [_ _ _  _ 6 _  _ _ _]
#
#       [_ _ _  _ 7 _  _ _ _]
#       [_ _ _  _ 8 _  _ _ _]
#       [_ _ _  _ 9 _  _ _ _]
#     * each 3x3 box contains each digit exactly once
#       [_ _ _  _ _ _  _ _ _]
#       [_ _ _  _ _ _  _ _ _]
#       [_ _ _  _ _ _  _ _ _]
#
#       [_ _ _  1 2 3  _ _ _]
#       [_ _ _  4 5 6  _ _ _]
#       [_ _ _  7 8 9  _ _ _]
#
#       [_ _ _  _ _ _  _ _ _]
#       [_ _ _  _ _ _  _ _ _]
#       [_ _ _  _ _ _  _ _ _]

=begin
  
board.each do |row|
      row_count += 1
      valid_count += 1 if row == row.uniq
    end
    valid_count == row_count ? valid = true : valid = false
=end


class Sudoku

  #
  # @param board [Array]
  #
  def initialize(board)
    @board = board
  end

  #
  # @return [Boolean] true if board is valid
  #
  def solved?
    #
    # TODO
    #

    board = @board
    row_count = 0
    valid_count = 0
    valid = false

    # check if vals in rows are unique
    uniq_check = Proc.new do |b|
      b.each do |row|
        row_count += 1
        valid_count += 1 if row == row.uniq
      end
      valid_count == row_count ? valid = true : valid = false
    end

    # check if vals in columns are unique
    columns = board.transpose
    uniq_check.call(columns)

    # check if each 3x3 box is unique
    # creates new array from each 3x3 box
    box1 = board[0][0..2].concat(board[1][0..2], board[2][0..2])
    box2 = board[0][3..5].concat(board[1][3..5], board[2][3..5])
    box3 = board[0][6..8].concat(board[1][6..8], board[2][6..8])
    
    box4 = board[3][0..2].concat(board[4][0..2], board[5][0..2])
    box5 = board[3][3..5].concat(board[4][3..5], board[5][3..5])
    box6 = board[3][6..8].concat(board[4][6..8], board[5][6..8])
    
    box7 = board[6][0..2].concat(board[7][0..2], board[8][0..2])
    box8 = board[6][3..5].concat(board[7][3..5], board[8][3..5])
    box9 = board[6][6..8].concat(board[7][6..8], board[8][6..8])

    # creates new board array w/ 3x3 boxes as rows
    boxes = [[box1],[box2],[box3],[box4],[box5],[box6],[box7],[box8],[box9]]  
    uniq_check.call(boxes)

    puts valid
    return valid
  end

=begin
  # @puts board [Array]
  #
  def display
    board = @board

    print "["
    board.each { |row|
        row.each { |num|
          print "#{num}, "
        }
        puts " "
    }
    print "]"

    return true
   # puts board[0]
  end
=end

end

class SudokuTest
  class << self

    def failure
      assert !Sudoku.new([
        [1,2,3, 4,5,6, 7,8,9],
        [1,2,3, 4,5,6, 7,8,9],
        [1,2,3, 4,5,6, 7,8,9],

        [1,2,3, 4,5,6, 7,8,9],
        [1,2,3, 4,5,6, 7,8,9],
        [1,2,3, 4,5,6, 7,8,9],

        [1,2,3, 4,5,6, 7,8,9],
        [1,2,3, 4,5,6, 7,8,9],
        [1,2,3, 4,5,6, 7,8,9],
      ]).solved?
    end

    def success
      assert Sudoku.new([
        [7,5,6, 4,1,2, 8,3,9],
        [4,9,2, 8,3,5, 1,7,6],
        [8,3,1, 6,7,9, 2,5,4],

        [6,4,9, 1,5,8, 7,2,3],
        [3,1,7, 2,4,6, 5,9,8],
        [2,8,5, 7,9,3, 6,4,1],

        [1,7,8, 3,2,4, 9,6,5],
        [9,2,4, 5,6,1, 3,8,7],
        [5,6,3, 9,8,7, 4,1,2],
      ]).solved?
    end

    protected

      def assert(condition)
        raise "Assertion failure" unless condition
      end

  end
end

SudokuTest.success
SudokuTest.failure