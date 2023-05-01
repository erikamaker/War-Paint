class Cpu
    def initialize(board)
        @board = board
    end
    def cpus_turn
        @board.grid.each_with_index do |row, row_index|
            row.each_with_index do |cell, column_index|
                if !cell.painted?
                    @board.paint!(row_index,column_index)
                    @board.agent_is_cpu
                    return
                end
            end
        end
    end
end