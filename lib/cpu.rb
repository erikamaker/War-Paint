class Cpu
    def initialize(board)
        @board = board
    end

    def take_turn
        @board.grid.each_with_index do |row, row_index|
            row.each_with_index do |cell, column_index|
                if !cell.painted?
                    @board.paint!(row_index, column_index, :cpu)
                    return
                end
            end
        end
    end
end
