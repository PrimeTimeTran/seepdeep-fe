import 'package:app/all.dart';
import 'package:flutter/material.dart';

var greenButton = const ButtonStyle(
  foregroundColor: MaterialStatePropertyAll(Colors.white),
  backgroundColor: MaterialStatePropertyAll(Colors.green),
);

class MazeScreen extends StatefulWidget {
  const MazeScreen({super.key});

  @override
  State<MazeScreen> createState() => _MazeScreenState();
}

class _MazeScreenState extends State<MazeScreen> {
  late Board board;
  bool play = false;
  late Toaster toaster;
  Speeds speedView = Speeds.fast;
  @override
  Widget build(BuildContext context) {
    toaster = Toaster(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          buildPanel(),
          ..._buildMatrix(),
        ],
      ),
    );
  }

  Expanded buildCol1() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text('Legend'),
            Row(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Cell(
                        node: Node(row: 0, col: 0, id: '10,20', isStart: true),
                      ),
                      const SizedBox(width: 10),
                      const Text('Start'),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Cell(
                        node: Node(row: 0, col: 0, id: '10,20', isPath: true),
                      ),
                      const SizedBox(width: 10),
                      const Text('Path'),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Cell(
                        node:
                            Node(row: 0, col: 0, id: '10,20', isEndNode: true),
                      ),
                      const SizedBox(width: 10),
                      const Text('End'),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Cell(
                        node:
                            Node(row: 0, col: 0, id: '10,20', isVisited: false),
                      ),
                      const SizedBox(width: 10),
                      const Text('Unvisited'),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Cell(
                        node: Node(row: 0, col: 0, id: '10,20', isWall: true),
                      ),
                      const SizedBox(width: 10),
                      const Text('Wall'),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(height: 30, width: 30, color: Colors.blue[500]),
                    const SizedBox(width: 5),
                    Cell(
                      node: Node(row: 0, col: 0, id: '10,20', isVisited: true),
                    ),
                    const SizedBox(width: 10),
                    const Text('Visited'),
                  ],
                ))
              ],
            ),
          ],
        ),
      ),
    );
  }

  Expanded buildCol2() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                board.makeMaze();
                toaster.displayInfoMotionToast('New maze created.');
              },
              child: const Text('New Maze'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                board.randomize();
                toaster.displayInfoMotionToast('New goal success.');
                board.updateCallback();
              },
              child: const Text('Move Goal Cell'),
            )
          ],
        ),
      ),
    );
  }

  Expanded buildCol3() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SegmentedButton<Speeds>(
              segments: const <ButtonSegment<Speeds>>[
                ButtonSegment<Speeds>(
                    value: Speeds.fast,
                    label: Text('Fast'),
                    icon: Icon(Icons.one_k)),
                ButtonSegment<Speeds>(
                    value: Speeds.faster,
                    label: Text('Faster'),
                    icon: Icon(Icons.two_k)),
                ButtonSegment<Speeds>(
                    value: Speeds.fastest,
                    label: Text('Fastest'),
                    icon: Icon(Icons.three_k)),
              ],
              selected: <Speeds>{speedView},
              onSelectionChanged: (Set<Speeds> newSelection) {
                int speed;
                if (newSelection.first == Speeds.fast) {
                  speed = 300;
                } else if (newSelection.first == Speeds.faster) {
                  speed = 150;
                } else {
                  speed = 50;
                }
                speedView = newSelection.first;
                board.speed = speed;
                toaster
                    .displayInfoMotionToast('Speed now $speed microseconds.');
                setState(() {});
              },
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              style: const ButtonStyle(
                  foregroundColor: MaterialStatePropertyAll(Colors.white),
                  backgroundColor: MaterialStatePropertyAll(Colors.green)),
              onPressed: () {
                board.instantSearch = !board.instantSearch;
              },
              child: const Text('Toggle Instant Find'),
            ),
          ],
        ),
      ),
    );
  }

  Expanded buildCol4() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(right: 60),
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: greenButton,
                onPressed: () {
                  board.searchBFS();
                },
                child: const Text('Search'),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: const ButtonStyle(
                        foregroundColor: MaterialStatePropertyAll(Colors.white),
                        backgroundColor: MaterialStatePropertyAll(
                            Color.fromARGB(255, 158, 193, 254))),
                    onPressed: () {
                      dialogBuilder(context, 'Breadth First Search',
                          'The algorithm is limited by the number of rows & cols \nwhere rows are M and cols are N O(M * N).');
                    },
                    child: const Text('Big O'),
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  icon: const Icon(Icons.clear),
                  style: const ButtonStyle(
                    foregroundColor: MaterialStatePropertyAll(Colors.white),
                    backgroundColor: MaterialStatePropertyAll(Colors.redAccent),
                  ),
                  onPressed: () {
                    board.reset();
                    toaster.displayInfoMotionToast('Path cleared');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Row buildPanel() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        buildCol1(),
        buildCol2(),
        buildCol3(),
        buildCol4(),
      ],
    );
  }

  @override
  void initState() {
    board = Board();
    super.initState();
    board.updateCallback = () {
      if (!play) {
        setState(() {});
      }
    };
    board.makeMaze();
  }

  setupCallback() {}

  _buildCell(r, c) {
    Node node = board.node(r, c);

    return Cell(node: node);
  }

  _buildMatrix() {
    return List.generate(
      board.board.length,
      (row) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          board.board[row].length,
          (col) => _buildCell(row, col),
        ),
      ),
    );
  }
}
