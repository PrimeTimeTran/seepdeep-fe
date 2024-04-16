import 'package:animated_tree_view/animated_tree_view.dart';
import 'package:app/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

const expandChildrenOnReady = true;
const showSnackBar = false;

final Map<int, Color> colorMapper = {
  0: Colors.white,
  1: Colors.blueGrey[50]!,
  2: Colors.blueGrey[100]!,
  3: Colors.blueGrey[200]!,
  4: Colors.blueGrey[300]!,
  5: Colors.blueGrey[400]!,
  6: Colors.blueGrey[500]!,
  7: Colors.blueGrey[600]!,
  8: Colors.blueGrey[700]!,
  9: Colors.blueGrey[800]!,
  10: Colors.blueGrey[900]!,
};

final dsaTOC = TreeNode.root()
  ..addAll([
    TreeNode(key: "Array")
      ..addAll([
        TreeNode(key: "Two Sum"),
        TreeNode(key: "Three Sum"),
        TreeNode(key: "Four Sum"),
        TreeNode(key: "Five Sum"),
      ]),
    TreeNode(key: "Two Pointers"),
    TreeNode(key: "Stacks"),
    TreeNode(key: "Binary Search"),
    TreeNode(key: "Sliding Window"),
    TreeNode(key: "Linked List"),
    TreeNode(key: "Trees"),
    TreeNode(key: "Tries"),
    TreeNode(key: "Backtracking"),
    TreeNode(key: "Graphs"),
    TreeNode(key: "1D DP"),
    TreeNode(key: "0C1C"),
    TreeNode(key: "Heap / Priority Queue"),
    TreeNode(key: "Intervals"),
    TreeNode(key: "Greedy"),
  ]);
// TreeNode(key: "Trees")
//   ..addAll([
//     TreeNode(key: "Tries"),
//     TreeNode(key: "Backtracking")
//       ..addAll([
//         TreeNode(key: "Graphs"),
//         TreeNode(key: "1D DP"),
//         TreeNode(key: "0C1C")
//       ]),
//     TreeNode(key: "Heap / Priority Queue")
//       ..addAll([
//         TreeNode(key: "Intervals"),
//         TreeNode(key: "Greedy"),
//       ])
//   ]),

// ..addAll([
//   TreeNode(key: "0C1A"),
//   TreeNode(key: "0C1B"),
//   TreeNode(key: "0C1C")
//     ..addAll([
//       TreeNode(key: "0C1C2A")
//         ..addAll([
//           TreeNode(key: "0C1C2A3A"),
//           TreeNode(key: "0C1C2A3B"),
//           TreeNode(key: "0C1C2A3C"),
//         ]),
//     ]),
// ]),
// TreeNode(key: "0D"),
// TreeNode(key: "0E"),

class DrawerContent extends StatefulWidget {
  const DrawerContent({super.key});

  @override
  State<DrawerContent> createState() => _DrawerContentState();
}

class _DrawerContentState extends State<DrawerContent> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 500,
      child: Column(
        children: [
          const SizedBox(
            height: 200,
            width: double.infinity,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Problem Sets'),
            ),
          ),
          ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: getHeight() - 200,
                    child: TreeView.simple(
                      tree: dsaTOC,
                      showRootNode: false,
                      expansionIndicatorBuilder: (context, node) =>
                          ChevronIndicator.rightDown(
                        tree: node,
                        color: Colors.blue[700],
                        padding: const EdgeInsets.all(8),
                      ),
                      indentation:
                          const Indentation(style: IndentStyle.squareJoint),
                      onItemTap: (item) {
                        if (kDebugMode) print("Item tapped: ${item.key}");

                        if (showSnackBar) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Item tapped: ${item.key}"),
                              duration: const Duration(milliseconds: 750),
                            ),
                          );
                        }
                      },
                      onTreeReady: (controller) {
                        if (expandChildrenOnReady) {
                          // controller.expandAllChildren(dsaTOC);
                        }
                      },
                      builder: (context, node) => Card(
                        color: colorMapper[
                            node.level.clamp(0, colorMapper.length - 1)]!,
                        child: ListTile(
                          title: Text("Item ${node.level}-${node.key}"),
                          subtitle: Text('Level ${node.level}'),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

extension ColorUtil on Color {
  Color byLuminance() =>
      computeLuminance() > 0.4 ? Colors.black87 : Colors.white;
}
