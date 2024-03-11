import 'package:flutter/material.dart';
import 'game_model.dart'; // Make sure to create this file with the game model code
import 'dart:math'; // Import for using Point

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Candy Crush Clone'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GameBoard board = GameBoard(rows: 6, columns: 6);
  Point<int>?
      firstSelectedTile; // Add this line to track the first selected tile

  @override
  void initState() {
    super.initState();
    board.initialize();
  }

  void handleTileTap(int row, int column) {
    final currentSelection = Point(row, column);

    if (firstSelectedTile == null) {
      setState(() {
        firstSelectedTile = currentSelection;
      });
    } else {
      // Check if the selected tile is adjacent to the first
      if (isAdjacent(firstSelectedTile!, currentSelection)) {
        setState(() {
          board.swapTiles(
              firstSelectedTile!.x, firstSelectedTile!.y, row, column);
          // You could add logic here to check for matches
        });
      }
      firstSelectedTile =
          null; // Reset the selection after swap or if not adjacent
    }
  }

  bool isAdjacent(Point<int> first, Point<int> second) {
    return (first.x == second.x && (first.y - second.y).abs() == 1) ||
        (first.y == second.y && (first.x - second.x).abs() == 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: board.columns,
          crossAxisSpacing: 4.0,
          mainAxisSpacing: 4.0,
        ),
        itemCount: board.rows * board.columns,
        itemBuilder: (context, index) {
          final row = index ~/ board.columns;
          final column = index % board.columns;
          final tile = board.board[row][column];

          return GestureDetector(
            onTap: () => handleTileTap(row, column),
            child: Container(
              decoration: BoxDecoration(
                color:
                    Colors.primaries[tile.colorCode % Colors.primaries.length],
                border: Border.all(color: Colors.white),
              ),
            ),
          );
        },
      ),
    );
  }
}
