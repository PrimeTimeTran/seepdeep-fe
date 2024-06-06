import 'package:app/all.dart' as prefix;
import 'package:app/screens/designkit_screen/designkit_screen.helpers.dart';
import 'package:app/utils/enums.dart';
import 'package:app/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DesignKitScreen extends StatefulWidget {
  const DesignKitScreen({super.key});

  @override
  State<DesignKitScreen> createState() => _DesignKitScreenState();
}

class _DesignKitScreenState extends State<DesignKitScreen> {
  Calendar calendarView = Calendar.day;
  bool? isChecked = false;

  @override
  Widget build(BuildContext context) {
    // return const ColorsDemo();
    final ButtonStyle outlineButtonStyle = OutlinedButton.styleFrom(
      foregroundColor: Colors.black87,
      minimumSize: const Size(88, 36),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(2)),
      ),
    ).copyWith(
      side: WidgetStateProperty.resolveWith<BorderSide?>(
        (Set<WidgetState> states) {
          if (states.contains(WidgetState.pressed)) {
            return BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: 1,
            );
          }
          return null;
        },
      ),
    );

    return Builder(builder: (context) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ScrollConfiguration(
                behavior:
                    ScrollConfiguration.of(context).copyWith(scrollbars: false),
                child: SingleChildScrollView(
                  child: Card.outlined(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // const Expanded(
                          //   child: ColorsDemo(),
                          // ),
                          Text(
                            'Typography',
                            style: Style.of(context, 'displayLUnderline'),
                          ),
                          buildTexts(),
                          Text(
                            'Buttons',
                            style: Style.of(context, 'displayLUnderline'),
                          ),
                          buildDefaultButtons(),
                          buildCustomStyledButtons(outlineButtonStyle),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Gap(25),
            Expanded(
              child: SingleChildScrollView(
                child: Card.outlined(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Icons',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        buildIconButtons(),
                        buildSegmentedButtons(),
                        const Gap(25),
                        buildBadges(),
                        buildCheckboxes(),
                        buildChips(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const Center(
              child: ColorsDemo(),
            )
          ],
        ),
      );
    });
  }

  buildBadges() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Badges',
          style: TextStyle(fontSize: 25),
        ),
        Row(
          children: [
            Badge(
              label: Text('3'),
              backgroundColor: Colors.green,
              child: Icon(
                Icons.shopping_cart,
                size: 50,
              ),
            ),
            Badge(
              label: Text('10'),
              backgroundColor: Colors.green,
              child: Icon(
                Icons.notifications,
                size: 50,
              ),
            ),
            Badge(
              label: Text('8'),
              backgroundColor: Colors.green,
              child: Icon(
                Icons.message,
                size: 50,
              ),
            ),
            Badge(
              label: Text('3'),
              backgroundColor: Colors.red,
              child: Icon(
                Icons.warning,
                size: 50,
              ),
            )
          ],
        ),
        Gap(25),
      ],
    );
  }

  buildCheckboxes() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text(
        'Checkboxes',
        style: TextStyle(fontSize: 25),
      ),
      Checkbox(
        tristate: true,
        value: isChecked,
        onChanged: (bool? value) {
          setState(() {
            isChecked = value;
          });
        },
      ),
      Checkbox(
        isError: true,
        tristate: true,
        value: isChecked,
        onChanged: (bool? value) {
          setState(() {
            isChecked = value;
          });
        },
      ),
      Checkbox(
        isError: true,
        tristate: true,
        value: isChecked,
        onChanged: null,
      ),
      Checkbox(
        tristate: true,
        value: true,
        onChanged: (bool? value) {
          setState(() {
            isChecked = value;
          });
        },
      ),
      Checkbox(
        isError: true,
        tristate: true,
        value: true,
        onChanged: (bool? value) {
          setState(() {
            isChecked = value;
          });
        },
      ),
      const Checkbox(
        isError: true,
        tristate: true,
        value: true,
        onChanged: null,
      ),
      const Gap(25),
    ]);
  }

  buildChips() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Chips',
          style: TextStyle(fontSize: 25),
        ),
        Chip(
          avatar: CircleAvatar(
            backgroundColor: Colors.grey.shade800,
            child: const Text('LT'),
          ),
          label: const Text('Loi Tran'),
        ),
        Chip(
          avatar: CircleAvatar(
            backgroundColor: Colors.grey.shade800,
            child: const Text('AB'),
          ),
          label: const Text('Aaron Burr'),
        ),
        Chip(
          avatar: CircleAvatar(
            backgroundColor: Colors.grey.shade800,
            child: const Text('EL'),
          ),
          label: const Text('Eda Lovelace'),
        )
      ],
    );
  }

  buildCustomStyledButtons(outlineButtonStyle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'from Custom Style',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        TextButtonTheme(
          data: TextButtonThemeData(style: prefix.flatButtonStyle),
          child: TextButton(onPressed: () {}, child: const Text('TextButton')),
        ),
        const Gap(5),
        ElevatedButtonTheme(
          data: ElevatedButtonThemeData(style: prefix.raisedButtonStyle),
          child: ElevatedButton(
              onPressed: () {}, child: const Text('ElevatedButton')),
        ),
        const Gap(5),
        OutlinedButtonTheme(
          data: OutlinedButtonThemeData(style: outlineButtonStyle),
          child: OutlinedButton(
            style: outlineButtonStyle,
            onPressed: () {},
            child: const Text('OutlinedButton'),
          ),
        ),
        const Gap(25),
      ],
    );
  }

  buildDefaultButtons() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'from Color Scheme',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const Gap(5),
        TextButton(onPressed: () {}, child: const Text('TextButton')),
        const Gap(5),
        ElevatedButton(onPressed: () {}, child: const Text('ElevatedButton')),
        const Gap(5),
        OutlinedButton(
          onPressed: () {},
          child: const Text('OutlinedButton'),
        ),
        const Gap(25),
      ],
    );
  }

  buildIconButtons() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Icon Button',
          style: TextStyle(fontSize: 25),
        ),
        Row(
          children: [
            IconButton(
              iconSize: 50,
              icon: const Icon(Icons.check_box),
              onPressed: () {
                // ...
              },
            ),
            IconButton(
              iconSize: 50,
              icon: const Icon(Icons.select_all),
              onPressed: () {
                // ...
              },
            ),
          ],
        ),
        const Text(
          'Segmented Button',
          style: TextStyle(fontSize: 25),
        ),
        const Gap(25),
      ],
    );
  }

  buildSegmentedButtons() {
    return SegmentedButton<Calendar>(
      segments: const <ButtonSegment<Calendar>>[
        ButtonSegment<Calendar>(
            value: Calendar.day,
            label: Text('Day'),
            icon: Icon(Icons.calendar_view_day)),
        ButtonSegment<Calendar>(
            value: Calendar.week,
            label: Text('Week'),
            icon: Icon(Icons.calendar_view_week)),
        ButtonSegment<Calendar>(
            value: Calendar.month,
            label: Text('Month'),
            icon: Icon(Icons.calendar_view_month)),
        ButtonSegment<Calendar>(
            value: Calendar.year,
            label: Text('Year'),
            icon: Icon(Icons.calendar_today)),
      ],
      selected: <Calendar>{calendarView},
      onSelectionChanged: (Set<Calendar> newSelection) {
        setState(() {
          calendarView = newSelection.first;
        });
      },
    );
  }

  buildTexts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Display',
          style: Style.of(context, 'titleGrey'),
        ),
        Text(
          'displayLarge',
          style: Style.of(context, 'displayL'),
        ),
        Text(
          'displayMedium',
          style: Style.of(context, 'displayM'),
        ),
        Text(
          'displaySmall',
          style: Style.of(context, 'displayS'),
        ),
        const Gap(30),
        Text(
          'Headline',
          style: Style.of(context, 'titleGrey'),
        ),
        Text(
          'headlineLarge',
          style: Style.of(context, 'headlineL'),
        ),
        Text(
          'headlineMedium',
          style: Style.of(context, 'headlineM'),
        ),
        Text(
          'headlineSmall',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        const Gap(30),
        Text(
          'Title',
          style: Style.of(context, 'titleGrey'),
        ),
        Text(
          'titleLarge',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Text(
          'titleMedium',
          style: Style.of(context, 'titleM'),
        ),
        Text(
          'titleSmall',
          style: Style.of(context, 'titleS'),
        ),
        const Gap(30),
        Text(
          'Label',
          style: Style.of(context, 'titleGrey'),
        ),
        Text(
          'labelLarge',
          style: Style.of(context, 'labelL'),
        ),
        Text(
          'labelMedium',
          style: Style.of(context, 'labelM'),
        ),
        Text(
          'labelSmall',
          style: Style.of(context, 'labelS'),
        ),
        const Gap(30),
        Text(
          'Body',
          style: Style.of(context, 'titleGrey'),
        ),
        Text(
          'bodyLarge',
          style: Style.of(context, 'bodyL'),
        ),
        Text(
          'bodyMedium',
          style: Style.of(context, 'bodyM'),
        ),
        Text(
          'bodySmall',
          style: Style.of(context, 'bodyS'),
        ),
        const Gap(30),
      ],
    );
  }
}
