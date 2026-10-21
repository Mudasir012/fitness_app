import 'package:flutter/material.dart';

import '../app_style.dart';
import 'screen_components.dart';

class InsightsScreen extends StatelessWidget {
  const InsightsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const bars = [46.0, 62.0, 87.0, 58.0, 72.0, 34.0, 25.0];
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        const ScreenHeader(title: 'INSIGHTS'),
        const SizedBox(height: 23),
        const ScreenHeadline(
          'Your body.\nYour progress.',
          'Small steps. Meaningful changes.',
        ),
        const SizedBox(height: 20),
        const SectionLabel('ACTIVITY OVERVIEW'),
        const SizedBox(height: 9),
        ScreenCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'TOTAL STEPS',
                style: TextStyle(color: muted, fontSize: 10),
              ),
              Text(
                '68,420',
                style: TextStyle(
                  fontFamily: 'DotMatrix',
                  fontSize: 38,
                  color: ink,
                ),
              ),
              const Text(
                '2,450 KCAL  •  4H 35M ACTIVE',
                style: TextStyle(color: muted, fontSize: 11),
              ),
              const Divider(height: 25),
              const SectionLabel('MOVEMENT • THIS WEEK'),
              const SizedBox(height: 12),
              SizedBox(
                height: 112,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: List.generate(7, (i) {
                    final active = i < 5;
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              height: bars[i],
                              decoration: BoxDecoration(
                                color: active ? orange : raisedSurface,
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(7),
                                ),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              ['M', 'T', 'W', 'T', 'F', 'S', 'S'][i],
                              style: const TextStyle(color: muted, fontSize: 9),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'MOST ACTIVE DAY     WEDNESDAY',
                style: TextStyle(
                  color: ink,
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 23),
        const SectionLabel('YOUR VITALS'),
        const SizedBox(height: 9),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1.5,
          children: const [
            InsightMetric(
              '72 BPM',
              'RESTING HEART RATE',
              Icons.monitor_heart_outlined,
            ),
            InsightMetric(
              '7.5 HRS',
              'SLEEP DURATION',
              Icons.nightlight_outlined,
            ),
            InsightMetric('1.8 L', 'WATER INTAKE', Icons.water_drop_outlined),
            InsightMetric('18.4 KM', 'WEEKLY DISTANCE', Icons.route_outlined),
          ],
        ),
        const SizedBox(height: 22),
        const SectionLabel('YOUR CONSISTENCY'),
        const SizedBox(height: 9),
        const ScreenCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '4 ACTIVE DAYS',
                style: TextStyle(color: ink, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ActiveDayDot(true),
                  ActiveDayDot(true),
                  ActiveDayDot(true),
                  ActiveDayDot(true),
                  ActiveDayDot(false),
                  ActiveDayDot(false),
                  ActiveDayDot(false),
                ],
              ),
              SizedBox(height: 14),
              Text(
                'Consistency beats intensity.',
                style: TextStyle(color: muted),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
