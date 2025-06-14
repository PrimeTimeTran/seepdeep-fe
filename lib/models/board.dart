import 'dart:async';
import 'dart:collection';
import 'dart:math';

import '../utils/constants.dart';
import '../utils/utils.dart';
import 'node.dart';

List<bool> clearWallChance = [
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  true
];
typedef UpdateCallback = void Function();

class Board {
  int speed = 300;
  int rows = ROWS;
  int cols = COLS;
  List stack = [];
  List<Node> nodes = [];
  List<Future> futures = [];
  String endId = '${ROWS ~/ 2},${COLS - 5}';
  late String startId = START_NODE;
  late UpdateCallback updateCallback;
  bool instantSearch = false;

  late List<List<Node>> board;
  Board() {
    board = generateBoard();
  }

  get endNode {
    final keys = endId.split(',');
    return board[int.parse(keys[0])][int.parse(keys[1])];
  }

  get startNode {
    final keys = startId.split(',');
    return board[int.parse(keys[0])][int.parse(keys[1])];
  }

  Future<void> calculateLayers() async {
    Set seen = <String>{};
    Queue<Node> queue = Queue();
    queue.add(startNode);
    seen.add(startNode.id);
    int layerIdx = 0;

    while (queue.isNotEmpty) {
      int layerSize = queue.length;
      for (int i = 0; i < layerSize; i++) {
        Node cur = queue.removeFirst();
        cur.layer = layerIdx;

        List<List<dynamic>> neighbors = getNeighbors(cur);
        for (var [nr, nc] in neighbors) {
          if (inBounds(nr, nc)) {
            Node neighbor = board[nr][nc];
            if (!seen.contains(neighbor.id) && !neighbor.wall) {
              seen.add(neighbor.id);
              queue.add(neighbor);
            }
          }
        }
      }
      layerIdx += 1;
    }
  }

  List<List<Node>> generateBoard() {
    List<List<Node>> board = [];
    for (int r = 0; r < rows; r++) {
      List<Node> items = [];
      board.add(items);
      for (int c = 0; c < cols; c++) {
        String rc = '$r,$c';
        Node cur = Node(id: rc, row: r, col: c);
        board[r].add(cur);
        nodes.add(cur);
        board[r][c] = cur;
      }
    }
    return board;
  }

  List<List<dynamic>> getNeighbors(Node cur) {
    int r = cur.row!;
    int c = cur.col!;
    List<List> neighbors = [
      [r - 1, c],
      [r + 1, c],
      [r, c + 1],
      [r, c - 1]
    ];
    return neighbors;
  }

  handleFound(cur, parentMap, delay) async {
    List<Node> path = [cur];
    while (cur != startNode) {
      cur = parentMap[cur]!;
      path.add(cur);
      if (!instantSearch) {
        await Future.delayed(delay);
      }
      updateCallback();
    }
    for (var cur in path.reversed) {
      cur.path = true;
      if (!instantSearch) {
        await Future.delayed(delay);
      }
      updateCallback();
    }
  }

  bool inBounds(int r, int c) {
    return r >= 0 && r < rows && c >= 0 && c < cols;
  }

  void makeHoles() {
    clearWallChance.shuffle();
    for (int r = 0; r < rows; r++) {
      for (int c = 0; c < cols; c++) {
        if (inBounds(r, c)) {
          Node node = board[r][c];
          clearWallChance.shuffle();
          bool random = clearWallChance.first;
          if (random) {
            node.wall = false;
          }
        }
      }
    }
  }

  makeMaze() {
    reset();
    makeWalls();
    makeHoles();
    resetEndNode();
    calculateLayers();
    updateCallback();
  }

  void makeWalls() {
    stack.add(Node(id: '15,5', row: 10, col: 0));
    while (stack.isNotEmpty) {
      Node next = stack.removeLast();
      if (validNextNode(next)) {
        board[next.row!][next.col!].wall = true;
        List<Node> neighbors = [];
        if (next.row! - 1 >= 0) {
          var leftNeighbor = board[next.row! - 1][next.col!];
          neighbors.add(leftNeighbor);
        }
        if (next.row! + 1 < rows) {
          var right = board[next.row! + 1][next.col!];
          neighbors.add(right);
        }
        if (next.col! - 1 >= 0) {
          var top = board[next.row!][next.col! - 1];
          neighbors.add(top);
        }
        if (next.col! + 1 < cols) {
          var bot = board[next.row!][next.col! + 1];
          neighbors.add(bot);
        }
        randomlyAddNodesToStack(neighbors);
      }
    }
  }

  node(r, c) => board[r][c];

  randomize() {
    futures.clear();
    board[endNode.row][endNode.col].isEnd = false;
    int r = sample(rows - 1, 1)[0];
    int c = sample(cols - 1, 1)[0];
    endId = '$r,$c';

    board[r][c].isEnd = true;
    board[r][c].wall = false;
  }

  void randomlyAddNodesToStack(List<Node> nodes) {
    while (nodes.isNotEmpty) {
      int targetIndex = Random().nextInt(nodes.length);
      stack.add(nodes.removeAt(targetIndex));
    }
  }

  reset() {
    futures.clear();
    // WIP: Remove old animations
    // Animations continue still
    for (int r = 0; r < rows; r++) {
      for (int c = 0; c < cols; c++) {
        var node = board[r][c];
        node.layer = 0;
        node.wall = false;
        node.visited = false;
        node.isEnd = false;
        node.path = false;
      }
    }
    resetEndNode();
  }

  resetEndNode() {
    endNode.wall = false;
    endNode.isEnd = true;
    endNode.visited = false;
  }

  resizeBoard(newRows, newCols) {
    rows = newRows;
    cols = newCols;
    endId = '${newRows ~/ 2},${newCols - 5}';
    board = generateBoard();
    makeMaze();
  }

  searchBFS() async {
    Queue<Node> queue = Queue();
    var seen = <dynamic>{};
    Map<Node, Node> parentMap = {};

    queue.add(startNode);
    while (queue.isNotEmpty) {
      updateCallback();
      Node cur = queue.removeFirst();
      if (cur.isEnd) {
        handleFound(cur, parentMap, Duration(microseconds: speed));
        return;
      }
      if (!cur.start && !cur.isEnd) {
        if (instantSearch) {
          cur.setVisited(true);
          updateCallback();
        } else {
          final delayedFuture =
              Future.delayed(Duration(microseconds: speed), () {
            cur.setVisited(true);
            updateCallback();
          });
          futures.add(delayedFuture);
          await Future.wait(futures);
        }
      }

      List<List<dynamic>> neighbors = getNeighbors(cur);
      for (var [nr, nc] in neighbors) {
        if (inBounds(nr, nc) && !seen.contains('$nr,$nc')) {
          seen.add('$nr,$nc');
          Node neighbor = board[nr][nc];

          if (!neighbor.visited && !neighbor.wall) {
            queue.add(neighbor);
            parentMap[neighbor] = cur;
          }
        }
      }
    }
  }

  bool validNextNode(Node node) {
    int numNeighboringOnes = 0;
    for (int r = node.row! - 1; r < node.row! + 2; r++) {
      for (int c = node.col! - 1; c < node.col! + 2; c++) {
        if (inBounds(r, c) && board[r][c].wall) {
          numNeighboringOnes++;
        }
      }
    }
    bool random = Random().nextBool();
    if (random) {
      numNeighboringOnes += 1;
    }
    return (numNeighboringOnes < 3) && board[node.row!][node.col!] != 1;
  }
}
