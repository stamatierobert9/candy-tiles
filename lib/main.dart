import 'package:flutter/material.dart';
import 'game_model.dart'; // Make sure to create this file with the game model code

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
  final GameBoard board = GameBoard(rows: 8, columns: 8);

  @override
  void initState() {
    super.initState();
    board.initialize();
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
            onTap: () {
              print('Tapped on tile at ($row, $column)');
              // Placeholder for actual game logic (swap tiles, check for matches)
            },
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
