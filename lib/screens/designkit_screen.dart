import 'package:app/all.dart' as prefix;
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
                  Text(
                    'Buttons',
                    style: Style.titleL,
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
                Text(
                  'Icons',
                  style: Style.titleL,
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
        Text(
          'Display',
          style: Style.titleL,
        ),
        Text(
          'displaySmall',
          style: Style.displayS,
        ),
        Text(
          'displayMedium',
          style: Style.displayM,
        ),
        Text(
          'displayLarge',
          style: Style.displayL,
        ),
        const Gap(30),
        Text(
          'Headline',
          style: Style.titleL,
        ),
        Text(
          'headlineSmall',
          style: Style.headlineS,
        ),
        Text(
          'headlineMedium',
          style: Style.headlineM,
        ),
        Text(
          'headlineLarge',
          style: Style.headlineL,
        ),
        const Gap(30),
        Text(
          'Title',
          style: Style.titleL,
        ),
        Text(
          'titleSmall',
          style: Style.titleS,
        ),
        Text(
          'titleMedium',
          style: Style.titleM,
        ),
        Text(
          'titleLarge',
          style: Style.titleL,
        ),
        const Gap(30),
        Text(
          'Label',
          style: Style.titleL,
        ),
        Text(
          'labelSmall',
          style: Style.labelS,
        ),
        Text(
          'labelMedium',
          style: Style.labelM,
        ),
        Text(
          'labelLarge',
          style: Style.labelL,
        ),
        const Gap(30),
        Text(
          'Body',
          style: Style.titleL,
        ),
        Text(
          'bodySmall',
          style: Style.bodyS,
        ),
        Text(
          'bodyMedium',
          style: Style.bodyM,
        ),
        Text(
          'bodyLarge',
          style: Style.bodyL,
        ),
      ],
    );
  }
}
