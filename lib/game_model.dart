class GameTile {
  final int colorCode;
  GameTile({required this.colorCode});
}

class GameBoard {
  final int rows;
  final int columns;
  List<List<GameTile>> board;

  GameBoard({required this.rows, required this.columns})
      : board = List.generate(
            rows, (_) => List.generate(columns, (_) => GameTile(colorCode: 0)));

  void initialize() {
    for (var i = 0; i < rows; i++) {
      for (var j = 0; j < columns; j++) {
        board[i][j] = GameTile(colorCode: (i + j) % 5 + 1);
      }
    }
  }

  // Swap two tiles
  void swapTiles(int row1, int col1, int row2, int col2) {
    var temp = board[row1][col1];
    board[row1][col1] = board[row2][col2];
    board[row2][col2] = temp;
  }

  List<GameTile> checkForMatches() {
    return [];
  }
}
