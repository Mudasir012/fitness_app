import 'package:flutter/material.dart';

import '../app_style.dart';

class WorkoutScreen extends StatelessWidget {
  const WorkoutScreen({super.key, required this.onAsk});
  final VoidCallback onAsk;

  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.all(18),
    children: [
      _PageHeader(
        title: 'HEALTH',
        trailing: Icons.chat_bubble_outline,
        onTap: onAsk,
      ),
      const SizedBox(height: 22),
      const _Headline('Find your rhythm', 'Move better. Feel stronger.'),
      const SizedBox(height: 19),
      Container(
        height: 245,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF8C9288), Color(0xFF262A28)],
          ),
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.sports_gymnastics, color: Colors.white, size: 42),
            Spacer(),
            Text(
              "TODAY'S PICK",
              style: TextStyle(color: Colors.white70, letterSpacing: 1),
            ),
            SizedBox(height: 5),
            Text(
              'Full Body Strength',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 23,
              ),
            ),
            SizedBox(height: 5),
            Text(
              '35 MIN  •  INTERMEDIATE  •  8 EXERCISES',
              style: TextStyle(color: Colors.white, fontSize: 10),
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      FilledButton.icon(
        onPressed: () => ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Workout selected'))),
        style: FilledButton.styleFrom(
          backgroundColor: red,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.all(15),
        ),
        icon: const Icon(Icons.play_arrow),
        label: const Text('Start workout'),
      ),
      const SizedBox(height: 25),
      const _Label('EXPLORE TRAINING'),
      const SizedBox(height: 10),
      const Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          _Chip('Strength', Icons.fitness_center),
          _Chip('Cardio', Icons.bolt),
          _Chip('Flexibility', Icons.self_improvement),
          _Chip('Recovery', Icons.favorite_border),
        ],
      ),
      const SizedBox(height: 24),
      const _Label('POPULAR WORKOUTS'),
      const SizedBox(height: 10),
      const _ListItem(
        'Chest & Triceps',
        '30 min • Intermediate',
        Icons.fitness_center,
      ),
      const _ListItem('Leg Day', '40 min • Advanced', Icons.directions_run),
      const _ListItem(
        'Morning Cardio',
        '20 min • Beginner',
        Icons.directions_walk,
      ),
      const _ListItem(
        'Full Body Mobility',
        '15 min • Beginner',
        Icons.self_improvement,
      ),
    ],
  );
}

class InsightsScreen extends StatelessWidget {
  const InsightsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const bars = [46.0, 62.0, 87.0, 58.0, 72.0, 34.0, 25.0];
    return ListView(
      padding: const EdgeInsets.all(18),
      children: [
        const _PageHeader(title: 'INSIGHTS'),
        const SizedBox(height: 23),
        const _Headline(
          'Your body.\nYour progress.',
          'Small steps. Meaningful changes.',
        ),
        const SizedBox(height: 20),
        const _Label('ACTIVITY OVERVIEW'),
        const SizedBox(height: 9),
        _Card(
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
              const _Label('MOVEMENT • THIS WEEK'),
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
        const _Label('YOUR VITALS'),
        const SizedBox(height: 9),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1.5,
          children: const [
            _Metric(
              '72 BPM',
              'RESTING HEART RATE',
              Icons.monitor_heart_outlined,
            ),
            _Metric('7.5 HRS', 'SLEEP DURATION', Icons.nightlight_outlined),
            _Metric('1.8 L', 'WATER INTAKE', Icons.water_drop_outlined),
            _Metric('18.4 KM', 'WEEKLY DISTANCE', Icons.route_outlined),
          ],
        ),
        const SizedBox(height: 22),
        const _Label('YOUR CONSISTENCY'),
        const SizedBox(height: 9),
        const _Card(
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
                  _DayDot(true),
                  _DayDot(true),
                  _DayDot(true),
                  _DayDot(true),
                  _DayDot(false),
                  _DayDot(false),
                  _DayDot(false),
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

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.all(20),
    children: [
      const _PageHeader(title: 'PROFILE', trailing: Icons.settings_outlined),
      const SizedBox(height: 22),
      const _Headline('Your space.', 'A little progress, every day.'),
      const SizedBox(height: 16),
      _Card(
        child: Column(
          children: [
            const CircleAvatar(
              radius: 39,
              backgroundColor: raisedSurface,
              child: Icon(Icons.person, size: 43, color: muted),
            ),
            const SizedBox(height: 12),
            const Text(
              'Mudasir Hussain',
              style: TextStyle(
                color: ink,
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
            const Text(
              'mudasirhussain@gmail.com',
              style: TextStyle(color: muted, fontSize: 12),
            ),
            const SizedBox(height: 15),
            OutlinedButton(onPressed: () {}, child: const Text('Edit profile')),
          ],
        ),
      ),
      const SizedBox(height: 22),
      const _Label('YOUR DETAILS'),
      const SizedBox(height: 9),
      const _Card(
        child: Column(
          children: [
            _ProfileRow(Icons.cake_outlined, 'Age', '22 years'),
            Divider(),
            _ProfileRow(Icons.height, 'Height', '179 cm'),
            Divider(),
            _ProfileRow(Icons.monitor_weight_outlined, 'Weight', '75 kg'),
            Divider(),
            _ProfileRow(Icons.flag_outlined, 'Daily step goal', '10,000'),
          ],
        ),
      ),
      const SizedBox(height: 22),
      const _Label('PREFERENCES'),
      const SizedBox(height: 9),
      const _Card(
        child: Column(
          children: [
            _MenuRow(Icons.notifications_none, 'Notifications'),
            _MenuRow(Icons.favorite_border, 'Health preferences'),
            _MenuRow(Icons.help_outline, 'Help & support'),
            _MenuRow(Icons.privacy_tip_outlined, 'Privacy'),
          ],
        ),
      ),
    ],
  );
}

class _PageHeader extends StatelessWidget {
  const _PageHeader({required this.title, this.trailing, this.onTap});
  final String title;
  final IconData? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      const Icon(Icons.donut_large, color: ink, size: 25),
      const SizedBox(width: 9),
      const Text(
        'HEALTH',
        style: TextStyle(color: ink, fontSize: 11, fontWeight: FontWeight.w700),
      ),
      const Spacer(),
      Text(
        title,
        style: const TextStyle(
          color: ink,
          fontWeight: FontWeight.w700,
          letterSpacing: .8,
        ),
      ),
      const Spacer(),
      if (trailing != null)
        IconButton(
          onPressed: onTap,
          icon: Icon(trailing, color: ink),
        ),
    ],
  );
}

class _Headline extends StatelessWidget {
  const _Headline(this.title, this.subtitle);
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: const TextStyle(
          color: ink,
          fontSize: 29,
          height: 1.1,
          fontWeight: FontWeight.w300,
          letterSpacing: -.6,
        ),
      ),
      const SizedBox(height: 6),
      Text(subtitle, style: const TextStyle(color: muted, fontSize: 14)),
    ],
  );
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

class _Card extends StatelessWidget {
  const _Card({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) => Material(
    color: surface,
    borderRadius: BorderRadius.circular(25),
    clipBehavior: Clip.antiAlias,
    child: Padding(padding: const EdgeInsets.all(18), child: child),
  );
}

class _Chip extends StatelessWidget {
  const _Chip(this.text, this.icon);
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) => Chip(
    avatar: Icon(icon, size: 17, color: red),
    label: Text(text),
    backgroundColor: surface,
    side: BorderSide.none,
  );
}

class _ListItem extends StatelessWidget {
  const _ListItem(this.title, this.subtitle, this.icon);
  final String title;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: _Card(
      child: Row(
        children: [
          Icon(icon, color: red),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: ink,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(color: muted, fontSize: 11),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: muted),
        ],
      ),
    ),
  );
}

class _Metric extends StatelessWidget {
  const _Metric(this.value, this.label, this.icon);
  final String value;
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) => _Card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: orange),
        const SizedBox(height: 12),
        FittedBox(
          alignment: Alignment.centerLeft,
          fit: BoxFit.scaleDown,
          child: Text(
            value,
            style: const TextStyle(
              color: ink,
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(color: muted, fontSize: 9)),
      ],
    ),
  );
}

class _DayDot extends StatelessWidget {
  const _DayDot(this.active);
  final bool active;

  @override
  Widget build(BuildContext context) => Container(
    width: 25,
    height: 9,
    decoration: BoxDecoration(
      color: active ? orange : raisedSurface,
      borderRadius: BorderRadius.circular(8),
    ),
  );
}

class _ProfileRow extends StatelessWidget {
  const _ProfileRow(this.icon, this.label, this.value);
  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 9),
    child: Row(
      children: [
        Icon(icon, color: orange, size: 19),
        const SizedBox(width: 12),
        Expanded(
          child: Text(label, style: const TextStyle(color: muted)),
        ),
        Text(
          value,
          style: const TextStyle(color: ink, fontWeight: FontWeight.w600),
        ),
      ],
    ),
  );
}

class _MenuRow extends StatelessWidget {
  const _MenuRow(this.icon, this.title);
  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) => ListTile(
    contentPadding: EdgeInsets.zero,
    leading: Icon(icon, color: muted),
    title: Text(title, style: const TextStyle(color: ink, fontSize: 14)),
    trailing: const Icon(Icons.chevron_right, color: muted),
    onTap: () {},
  );
}
