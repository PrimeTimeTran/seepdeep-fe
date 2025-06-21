import 'package:app/all.dart';
import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:provider/provider.dart' as provider;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildProfileSidebar(),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        // ColoredCard(
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                        //     children: [
                        //       const LineChartSample1(),
                        //       BarChartSample3()
                        //     ],
                        //   ),
                        // ),
                        // ColoredCard(
                        //   child: Row(
                        //     children: [
                        //       Expanded(
                        //         child: ColoredCard(
                        //           color: Colors.red,
                        //           child: const Row(
                        //             children: [
                        //               Expanded(
                        //                 flex: 1,
                        //                 child: Column(
                        //                   children: [
                        //                     Text('sososo'),
                        //                     GFAvatar(
                        //                       backgroundImage: NetworkImage(
                        //                         "https://i.pravatar.cc/150?img=3",
                        //                       ),
                        //                     ),
                        //                   ],
                        //                 ),
                        //               ),
                        //               Expanded(
                        //                 flex: 5,
                        //                 child: Padding(
                        //                   padding: EdgeInsets.symmetric(
                        //                     vertical: 50,
                        //                   ),
                        //                   child: Column(
                        //                     crossAxisAlignment:
                        //                         CrossAxisAlignment.start,
                        //                     children: [
                        //                       LinearProgressIndicator(
                        //                         value: .9,
                        //                         minHeight: 15,
                        //                         color: Colors.red,
                        //                         semanticsValue: '40',
                        //                         semanticsLabel:
                        //                             'Linear progress indicator',
                        //                         borderRadius: BorderRadius.all(
                        //                             Radius.circular(10)),
                        //                       ),
                        //                       Spacer(),
                        //                       LinearProgressIndicator(
                        //                         value: .5,
                        //                         minHeight: 15,
                        //                         color: Colors.blue,
                        //                         semanticsValue: '40',
                        //                         semanticsLabel:
                        //                             'Linear progress indicator',
                        //                         borderRadius: BorderRadius.all(
                        //                             Radius.circular(10)),
                        //                       ),
                        //                       Spacer(),
                        //                       LinearProgressIndicator(
                        //                         value: .9,
                        //                         minHeight: 15,
                        //                         color: Colors.green,
                        //                         semanticsValue: '40',
                        //                         semanticsLabel:
                        //                             'Linear progress indicator',
                        //                         borderRadius: BorderRadius.all(
                        //                             Radius.circular(10)),
                        //                       ),
                        //                     ],
                        //                   ),
                        //                 ),
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //       ),
                        //       const Gap(5),
                        //       Expanded(
                        //         child: ColoredCard(
                        //           color: Colors.blue,
                        //           child: const Row(
                        //             children: [
                        //               HorizontalBarChart(),
                        //             ],
                        //           ),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        buildHeatMap(),
                        buildSubmissionsList()
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  buildHeatMap() {
    final submissionsProvider =
        provider.Provider.of<SubmissionProvider>(context);
    final Map<DateTime, int> counts =
        countItemsPerDay(submissionsProvider.submissions);

    return ColoredCard(
      padding: 40,
      child: HeatMap(
        datasets: counts,
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
        onClick: (date) {
          final count = counts[date] ?? 0;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(
                    '$count submissions on ${date.toLocal().toString().split(' ')[0]}')),
          );
        },
      ),
    );
  }

  buildProfileSidebar() {
    final authProvider = context.watch<AuthProvider>();

    return Expanded(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ColoredCard(
              height: getHeight() * 1.75,
              child: Column(
                children: [
                  ColoredCard(
                    color: Theme.of(context).colorScheme.onSecondary,
                    child: Column(
                      children: [
                        Text(authProvider.user?.email != null
                            ? authProvider.user.email.toString()
                            : ''),
                        Text(authProvider.user?.firstName != null
                            ? authProvider.user.firstName.toString()
                            : ''),
                        Text(authProvider.user?.lastName != null
                            ? authProvider.user.lastName.toString()
                            : '')
                      ],
                    ),
                  ),
                  const Divider(),
                  ColoredCard(color: Theme.of(context).colorScheme.onSecondary),
                  const Divider(),
                  ColoredCard(color: Theme.of(context).colorScheme.onSecondary),
                  const Divider(),
                  ColoredCard(color: Theme.of(context).colorScheme.onSecondary),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  buildSubmissionsList() {
    final submissionsProvider =
        provider.Provider.of<SubmissionProvider>(context, listen: false);
    return ColoredCard(
      height: getHeight() * .5,
      child: ColoredCard(
        color: Theme.of(context).colorScheme.onSecondary,
        child: ListView.builder(
          itemCount: submissionsProvider.submissions.length,
          itemBuilder: (context, index) {
            final submission = submissionsProvider.submissions[index];
            final dateTime = submission.createdAt?.toLocal();

            return ListTile(
                title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${submission.problemTitle}'),
                Text(timeAgo(dateTime!))
              ],
            ));
          },
        ),
      ),
    );
  }

  Map<DateTime, int> countItemsPerDay(List<Submission> submissions) {
    final Map<DateTime, int> counts = {};

    for (var item in submissions) {
      final dayOnly = DateTime(
          item.createdAt!.year, item.createdAt!.month, item.createdAt!.day);

      counts.update(dayOnly, (value) => value + 1, ifAbsent: () => 1);
    }

    return counts;
  }

  @override
  void initState() {
    super.initState();
  }

  String timeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final diff = now.difference(dateTime);

    if (diff.inSeconds < 60) return 'just now';
    if (diff.inMinutes < 60)
      return '${diff.inMinutes} minute${diff.inMinutes == 1 ? '' : 's'} ago';
    if (diff.inHours < 24)
      return '${diff.inHours} hour${diff.inHours == 1 ? '' : 's'} ago';
    if (diff.inDays < 7)
      return '${diff.inDays} day${diff.inDays == 1 ? '' : 's'} ago';
    if (diff.inDays < 30)
      return '${(diff.inDays / 7).floor()} week${(diff.inDays / 7).floor() == 1 ? '' : 's'} ago';
    if (diff.inDays < 365)
      return '${(diff.inDays / 30).floor()} month${(diff.inDays / 30).floor() == 1 ? '' : 's'} ago';
    return '${(diff.inDays / 365).floor()} year${(diff.inDays / 365).floor() == 1 ? '' : 's'} ago';
  }
}
