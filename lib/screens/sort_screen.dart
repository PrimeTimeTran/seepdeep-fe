import 'dart:async';
import 'dart:math';

import 'package:app/all.dart';
import 'package:flutter/material.dart';

class SortItem {
  Color color;
  num value;
  String label;
  double height;
  double width;
  late int position;
  late bool sorting = false;
  SortItem({
    required this.value,
    required this.height,
    required this.width,
    required this.color,
    required this.position,
    required this.label,
  });
}

class SortScreen extends StatefulWidget {
  const SortScreen({super.key});

  @override
  State<SortScreen> createState() => _SortScreenState();
}

class _SortScreenState extends State<SortScreen>
    with SingleTickerProviderStateMixin {
  int count = 25;
  int iterations = 0;
  late List<int> nums;
  bool finishedSort = false;
  late List<SortItem> sortItems = [];
  SortOption sortType = SortOption.bubble;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            buildSortItemOptions(),
            buildSortPanel(),
            Expanded(
              child: Column(
                children: [
                  const Modal(type: GiffyType.image),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () => _sort(sortType),
                        style: const ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(Colors.green)),
                        child: const Text(
                          'Sort',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        Transform.translate(
          offset: const Offset(0, -100),
          child: SizedBox(
            height: ((count / 5) * 80),
            width: 125 + ((count / 5) * 125),
            child: Stack(
              children: [
                buildInfoPanel(),
                ...List.generate(
                  sortItems.length,
                  buildSortItem,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  ElevatedButton buildButton(SortOption option) {
    ButtonStyle? style;
    TextStyle? textStyle;
    if (sortType == option) {
      textStyle = const TextStyle(color: Colors.white);
      style = const ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(
          Colors.green,
        ),
      );
    }
    return ElevatedButton(
      style: style,
      onPressed: () {
        setState(() => sortType = option);
      },
      child: Text(buildSortLabel(option), style: textStyle),
    );
  }

  Column buildInfoPanel() {
    return Column(
      children: [
        Row(
          children: [
            Text('# Items: $count'),
          ],
        ),
        Row(
          children: [
            Text('# Comparisons: $iterations'),
          ],
        ),
      ],
    );
  }

  Widget buildSortItem(index) {
    SortItem item = sortItems[index];
    Border? border =
        item.sorting ? Border.all(color: Colors.black, width: 2) : null;

    return AnimatedPositioned(
      duration: const Duration(milliseconds: 500),
      left: item.width + 50,
      bottom: 0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: 20,
            height: item.height,
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: finishedSort ? Colors.lightGreen : item.color,
              border: border,
            ),
            child: Center(child: Text(item.label)),
          ),
          Text(item.value.toString()),
          Text(nums[index].toString()),
        ],
      ),
    );
  }

  Expanded buildSortItemOptions() {
    return Expanded(
      child: Row(
        children: [
          const SizedBox(width: 5),
          ElevatedButton(
            onPressed: () {
              if (count > 45) return;
              makeItems(count += 5);
            },
            child: const Text('Add Items'),
          ),
          const SizedBox(width: 5),
          ElevatedButton(
            onPressed: () {
              if (count < 10) return;
              makeItems(count -= 5);
            },
            child: const Text('Remove Items'),
          ),
          const SizedBox(width: 5),
          ElevatedButton(
            onPressed: () {
              setState(() {
                iterations = 0;
                finishedSort = false;
              });
              makeItems(count);
            },
            child: const Text('Shuffle'),
          ),
        ],
      ),
    );
  }

  String buildSortLabel(type) {
    return type.toString().split('.')[1].split('Sort')[0].capitalize();
  }

  Expanded buildSortPanel() {
    return Expanded(
      child: Row(
        children: [
          const SizedBox(width: 5),
          buildButton(SortOption.bubble),
          const SizedBox(width: 5),
          buildButton(SortOption.selection),
          const SizedBox(width: 5),
          buildButton(SortOption.insertion),
          const SizedBox(width: 5),
          buildButton(SortOption.merge),
          const SizedBox(width: 5),
        ],
      ),
    );
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    makeItems(count);
  }

  makeItems(count) {
    nums = sample(count, count);
    nums.shuffle();
    sortItems = List.generate(
      nums.length,
      (index) {
        num item = nums[index];
        Color color = Color.fromRGBO(
          Random().nextInt(256),
          Random().nextInt(256),
          Random().nextInt(256),
          1.0,
        );
        return SortItem(
          color: color,
          value: item,
          position: index,
          width: index * 25,
          label: item.toString(),
          height: item.toDouble() * 15,
        );
      },
    );
    var needsShuffle = nums[0] > 18 || nums[1] > 18 || nums[2] > 18;
    while (needsShuffle) {
      nums.shuffle();
      needsShuffle = nums[0] > 18 || nums[1] > 18 || nums[2] > 18;
    }

    setState(() {
      count = count;
      nums = nums;
      sortItems = sortItems;
    });
  }

  Future<List<SortItem>> _merge(
      List<SortItem> left, List<SortItem> right) async {
    List<SortItem> res = [];
    int l = 0, r = 0;
    while (l < left.length && r < right.length) {
      if (left[l].value < right[r].value) {
        res.add(left[l]);
        left[l].sorting = true;
        l++;
      } else {
        res.add(right[r]);
        right[r].sorting = true;
        r++;
      }
    }

    res.addAll(left);
    res.addAll(right);
    await Future.delayed(const Duration(milliseconds: 100), () {
      left[l].sorting = true;
      right[r].sorting = true;
      setState(() => {});
    });
    return res;
  }

  _sort(SortOption option) async {
    switch (option) {
      case SortOption.bubble:
        await _sortBubble(sortItems);
        break;
      case SortOption.selection:
        await _sortSelection(sortItems);
        break;
      case SortOption.insertion:
        await _sortInsertion(sortItems);
        break;
      default:
    }
    setState(() {
      finishedSort = true;
    });
  }

  Future<void> _sortBubble(List<SortItem> items) async {
    int n = items.length;
    bool sorted = false;
    while (!sorted) {
      sorted = true;
      for (int i = 0; i < n - 1; i++) {
        SortItem left = items[i];
        SortItem right = items[i + 1];
        bool shouldSwap = left.value > right.value;
        if (shouldSwap) {
          sorted = false;

          // Bubble sort works
          // var rightPosition = right.width;
          // var leftPosition = left.width;

          // left.width = rightPosition;
          // right.width = leftPosition;
          // items[i] = right;
          // items[i + 1] = left;
          // await Future.delayed(const Duration(milliseconds: 500), () {
          //   setState(() {});
          // });

          // Sort works and animation "kinda" works.
          // The right item, the one being move, disappears from the UI for every iteration of the loop.
          // It then appears for a moment at the end of the animation but "blinks". and disappears.
          // The sort item in the position it "moves correctly" to the next spot(when it should have been the same one moving).
          // The problem is that if I setState immediately, the items don't need to swap, so the animation doesn't play.
          // However if I don't setState with the swapped items, then the "original" item inside the left spot animates to the right. Once it gets there then the "correct" right item blinks, and the process restarts.
          var rightPosition = right.width;
          var leftPosition = left.width;
          right.width = leftPosition;
          left.width = rightPosition;
          right.sorting = true;
          left.sorting = true;

          setState(() {});
          await Future.delayed(const Duration(milliseconds: 100), () {
            items[i + 1] = left;
            items[i] = right;
            right.sorting = false;
            left.sorting = false;
          });
        }
        setState(() {
          iterations = iterations + 1;
        });
      }
    }
    setState(() {
      iterations = iterations + 1;
    });
  }

  Future<void> _sortInsertion(List<SortItem> items) async {
    int n = items.length;

    // Sort works beautifully but the animation doesn't.
    for (int i = 1; i < n; i++) {
      SortItem right = items[i];
      while (i > 0 && items[i - 1].value > items[i].value) {
        var left = items[i - 1];
        var leftPosition = left.width;
        var rightPosition = right.width;
        left.width = rightPosition;
        right.width = leftPosition;
        items[i] = left;
        items[i - 1] = right;
        i -= 1;
        await Future.delayed(const Duration(milliseconds: 100), () {});
        setState(() {});
      }
    }

    setState(() {});
  }

  Future<List<SortItem>> _sortMerge(List<SortItem> items) async {
    if (items.length < 2) {
      return items;
    }
    await Future.delayed(const Duration(milliseconds: 500));

    int midIdx = items.length ~/ 2;

    List<SortItem> left = items.sublist(0, midIdx);
    List<SortItem> right = items.sublist(midIdx);
    return _merge(await _sortMerge(left), await _sortMerge(right));
  }

  Future<void> _sortSelection(List<SortItem> items) async {
    int limit = items.length;
    for (int i = 0; i < limit; i++) {
      int min = i;
      for (int j = i + 1; j < limit; j++) {
        if (items[min].value > items[j].value) {
          min = j;
        }
        setState(() {
          iterations = iterations + 1;
        });
      }
      // Sort works beautifully but the animation doesn't.
      // if (min != i) {
      //   SortItem right = items[i];
      //   SortItem left = items[min];
      //   var leftPosition = left.width;
      //   var rightPosition = right.width;
      //   items[i].width = leftPosition;
      //   items[min].width = rightPosition;

      //   await Future.delayed(const Duration(milliseconds: 100), () {
      //     items[i] = left;
      //     items[min] = right;
      //   });
      // }

      // setState(() {});
      // await Future.delayed(const Duration(milliseconds: 500), () {
      //   items[i].sorting = false;
      //   items[min].sorting = false;
      // });
      if (min != i) {
        SortItem right = items[i];
        SortItem left = items[min];
        var leftPosition = left.width;
        var rightPosition = right.width;

        items[i].width = leftPosition;
        items[min].width = rightPosition;
        items[i].sorting = true;
        items[min].sorting = true;

        await Future.delayed(const Duration(milliseconds: 100), () {
          items[i] = left;
          items[min] = right;
        });
      }

      setState(() {
        iterations = iterations + 1;
      });
      await Future.delayed(const Duration(milliseconds: 100), () {
        items[i].sorting = false;
        items[min].sorting = false;
      });
    }
  }
}
