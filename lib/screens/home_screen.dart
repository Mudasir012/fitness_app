import 'package:flutter/material.dart';

import '../app_style.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.onAsk});
  final VoidCallback onAsk;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double water = 1.2;

  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.fromLTRB(20, 18, 20, 28),
    children: [
      Row(
        children: [
          const Icon(Icons.donut_large, color: ink, size: 26),
          const SizedBox(width: 9),
          const Text(
            'HEALTH',
            style: TextStyle(
              color: ink,
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 1,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: widget.onAsk,
            icon: const Icon(Icons.chat_bubble_outline, color: red),
            tooltip: 'Ask assistant',
          ),
          const CircleAvatar(
            backgroundColor: red,
            child: Icon(Icons.person_outline, color: ink),
          ),
        ],
      ),
      const SizedBox(height: 24),
      const Text(
        'Good morning, Alex',
        style: TextStyle(
          color: ink,
          fontSize: 27,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.6,
        ),
      ),
      const SizedBox(height: 5),
      const Text(
        'A little progress goes a long way.',
        style: TextStyle(color: muted, fontSize: 14),
      ),
      const SizedBox(height: 22),
      _assistantCard(),
      const SizedBox(height: 25),
      const _Label('TODAY AT A GLANCE'),
      const SizedBox(height: 10),
      _activityCard(),
      const SizedBox(height: 24),
      const _Label('DAILY WELLNESS'),
      const SizedBox(height: 10),
      Row(
        children: [
          Expanded(
            child: _wellness(
              icon: Icons.water_drop_outlined,
              label: 'Hydration',
              value: '${water.toStringAsFixed(1)} L',
              note: 'of 2.5 L goal',
              progress: water / 2.5,
              action: 'ADD 250 ML',
              onTap: () => setState(
                () => water = (water + 0.25).clamp(0.0, 2.5).toDouble(),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _wellness(
              icon: Icons.nightlight_outlined,
              label: 'Sleep',
              value: '7.5 hrs',
              note: 'Rest and recover',
              progress: .94,
            ),
          ),
        ],
      ),
      const SizedBox(height: 24),
      const _Label('YOUR NEXT STEP'),
      const SizedBox(height: 10),
      _card(
        child: const Row(
          children: [
            Icon(Icons.directions_walk, color: red, size: 24),
            SizedBox(width: 13),
            Expanded(
              child: Text(
                'Take a 10-minute walk\nA short reset can move you closer to your goal.',
                style: TextStyle(color: ink, height: 1.5, fontSize: 13),
              ),
            ),
          ],
        ),
      ),
    ],
  );

  Widget _assistantCard() => Material(
    color: raisedSurface,
    borderRadius: BorderRadius.circular(26),
    child: InkWell(
      onTap: widget.onAsk,
      borderRadius: BorderRadius.circular(26),
      child: const Padding(
        padding: EdgeInsets.all(19),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Color(0xFF3B2A2C),
              child: Icon(Icons.auto_awesome, color: Color(0xFFFF806D)),
            ),
            SizedBox(width: 13),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your fitness assistant',
                    style: TextStyle(color: ink, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Ask about training, food or recovery',
                    style: TextStyle(color: muted, fontSize: 12),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: ink, size: 16),
          ],
        ),
      ),
    ),
  );

  Widget _activityCard() => _card(
    child: Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'STEPS',
                    style: TextStyle(
                      color: muted,
                      fontSize: 10,
                      letterSpacing: .7,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    '8,240',
                    style: TextStyle(
                      fontFamily: 'DotMatrix',
                      color: ink,
                      fontSize: 38,
                    ),
                  ),
                  const Text(
                    'of 10,000 daily goal',
                    style: TextStyle(color: muted, fontSize: 12),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 62,
              height: 62,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const SizedBox(
                    width: 62,
                    height: 62,
                    child: CircularProgressIndicator(
                      value: .824,
                      strokeWidth: 6,
                      backgroundColor: raisedSurface,
                      color: red,
                    ),
                  ),
                  const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '82%',
                        style: TextStyle(
                          color: ink,
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                        ),
                      ),
                      Text('GOAL', style: TextStyle(color: muted, fontSize: 7)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        const Divider(height: 28, color: divider),
        const Row(
          children: [
            Expanded(
              child: _MiniStat(
                icon: Icons.local_fire_department_outlined,
                value: '385 KCAL',
                label: 'ACTIVE ENERGY',
              ),
            ),
            Expanded(
              child: _MiniStat(
                icon: Icons.timer_outlined,
                value: '42 MIN',
                label: 'ACTIVE TIME',
              ),
            ),
          ],
        ),
      ],
    ),
  );

  Widget _wellness({
    required IconData icon,
    required String label,
    required String value,
    required String note,
    required double progress,
    String? action,
    VoidCallback? onTap,
  }) {
    final card = _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: red, size: 20),
          const SizedBox(height: 12),
          Text(label, style: const TextStyle(color: muted, fontSize: 11)),
          const SizedBox(height: 3),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              value,
              style: const TextStyle(
                color: ink,
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 3),
          Text(note, style: const TextStyle(color: muted, fontSize: 10)),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress.clamp(0.0, 1.0).toDouble(),
              minHeight: 5,
              color: red,
              backgroundColor: raisedSurface,
            ),
          ),
          if (action != null) ...[
            const SizedBox(height: 9),
            Text(
              action,
              style: const TextStyle(
                color: red,
                fontSize: 9,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ],
      ),
    );
    return onTap == null
        ? card
        : Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(24),
              onTap: onTap,
              child: card,
            ),
          );
  }
}

class _Label extends StatelessWidget {
  const _Label(this.text);
  final String text;

  @override
  Widget build(BuildContext context) => Text(
    text,
    style: const TextStyle(
      color: muted,
      fontSize: 10,
      fontWeight: FontWeight.w700,
      letterSpacing: .8,
    ),
  );
}

class _MiniStat extends StatelessWidget {
  const _MiniStat({
    required this.icon,
    required this.value,
    required this.label,
  });
  final IconData icon;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Icon(icon, color: red, size: 18),
      const SizedBox(width: 8),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: const TextStyle(
              color: ink,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(label, style: const TextStyle(color: muted, fontSize: 8)),
        ],
      ),
    ],
  );
}

Widget _card({required Widget child}) => Container(
  padding: const EdgeInsets.all(18),
  decoration: BoxDecoration(
    color: surface,
    borderRadius: BorderRadius.circular(25),
  ),
  child: child,
);
