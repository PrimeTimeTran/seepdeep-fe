import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HeatMap(
          datasets: {
            DateTime(2024, 1, 1): 30,
            DateTime(2024, 2, 2): 30,
            DateTime(2024, 3, 3): 30,
            DateTime(2024, 4, 4): 30,
          },
          colorMode: ColorMode.opacity,
          showText: false,
          scrollable: true,
          colorsets: const {
            1: Colors.red,
            3: Colors.orange,
            5: Colors.yellow,
            7: Colors.green,
            9: Colors.blue,
            11: Colors.indigo,
            13: Colors.purple,
          },
          onClick: (value) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(value.toString())));
          },
        ),
      ],
    );
  }
}
