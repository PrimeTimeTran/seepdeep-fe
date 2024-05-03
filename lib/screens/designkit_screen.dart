import 'package:app/all.dart' as prefix;
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

enum Calendar { day, week, month, year }

class DesignKitScreen extends StatefulWidget {
  const DesignKitScreen({super.key});

  @override
  State<DesignKitScreen> createState() => _DesignKitScreenState();
}

enum Sizes { extraSmall, small, medium, large, extraLarge }

class _DesignKitScreenState extends State<DesignKitScreen> {
  Calendar calendarView = Calendar.day;
  bool? isChecked = false;

  @override
  Widget build(BuildContext context) {
    final ButtonStyle outlineButtonStyle = OutlinedButton.styleFrom(
      foregroundColor: Colors.black87,
      minimumSize: const Size(88, 36),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(2)),
      ),
    ).copyWith(
      side: MaterialStateProperty.resolveWith<BorderSide?>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.pressed)) {
            return BorderSide(
              color: Theme.of(context).colorScheme.primary,
              width: 1,
            );
          }
          return null;
        },
      ),
    );

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Buttons',
                    style: TextStyle(fontSize: 30),
                  ),
                  buildDefaultButtons(),
                  buildCustomStyledButtons(outlineButtonStyle),
                  buildTexts(),
                ],
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Icons',
                  style: TextStyle(fontSize: 30),
                ),
                buildIconButtons(),
                buildSegmentedButtons(),
                const Gap(25),
                buildBadges(),
                buildCheckboxes(),
                buildChips(),
              ],
            ),
          )
        ],
      ),
    );
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
        const Text(
          'from Custom Style',
          style: TextStyle(fontSize: 25),
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
        const Text(
          'from Color Scheme',
          style: TextStyle(fontSize: 25),
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
        const Text(
          'Display',
          style: TextStyle(fontSize: 30),
        ),
        Text(
          'displaySmall',
          style: Theme.of(context).textTheme.displaySmall!,
        ),
        Text(
          'displayMedium',
          style: Theme.of(context).textTheme.displayMedium!,
        ),
        Text(
          'displayLarge',
          style: Theme.of(context).textTheme.displayLarge!,
        ),
        const Gap(30),
        const Text(
          'Headline',
          style: TextStyle(fontSize: 30),
        ),
        Text(
          'headlineSmall',
          style: Theme.of(context).textTheme.headlineSmall!,
        ),
        Text(
          'headlineMedium',
          style: Theme.of(context).textTheme.headlineMedium!,
        ),
        Text(
          'headlineLarge',
          style: Theme.of(context).textTheme.headlineLarge!,
        ),
        const Gap(30),
        const Text(
          'Title',
          style: TextStyle(fontSize: 30),
        ),
        Text(
          'titleSmall',
          style: Theme.of(context).textTheme.titleSmall!,
        ),
        Text(
          'titleMedium',
          style: Theme.of(context).textTheme.titleMedium!,
        ),
        Text(
          'titleLarge',
          style: Theme.of(context).textTheme.titleLarge!,
        ),
        const Gap(30),
        const Text(
          'Label',
          style: TextStyle(fontSize: 30),
        ),
        Text(
          'labelSmall',
          style: Theme.of(context).textTheme.labelSmall!,
        ),
        Text(
          'labelMedium',
          style: Theme.of(context).textTheme.labelMedium!,
        ),
        Text(
          'labelLarge',
          style: Theme.of(context).textTheme.labelLarge!,
        ),
        const Gap(30),
        const Text(
          'Body',
          style: TextStyle(fontSize: 30),
        ),
        Text(
          'bodySmall',
          style: Theme.of(context).textTheme.bodySmall!,
        ),
        Text(
          'bodyMedium',
          style: Theme.of(context).textTheme.bodyMedium!,
        ),
        Text(
          'bodyLarge',
          style: Theme.of(context).textTheme.bodyLarge!,
        ),
      ],
    );
  }
}
