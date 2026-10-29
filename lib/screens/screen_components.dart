import 'package:flutter/material.dart';

import '../app_style.dart';

class ScreenHeader extends StatelessWidget {
  const ScreenHeader({super.key, required this.title, this.trailing, this.onTap});

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

class ScreenHeadline extends StatelessWidget {
  const ScreenHeadline(this.title, this.subtitle, {super.key});

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

class SectionLabel extends StatelessWidget {
  const SectionLabel(this.text, {super.key});

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

class ScreenCard extends StatelessWidget {
  const ScreenCard({super.key, required this.child, this.onTap});

  final Widget child;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final card = Material(
      color: surface,
      borderRadius: BorderRadius.circular(25),
      clipBehavior: Clip.antiAlias,
      child: Padding(padding: const EdgeInsets.all(18), child: child),
    );

    if (onTap == null) return card;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(25),
        onTap: onTap,
        child: card,
      ),
    );
  }
}

class WorkoutCategoryChip extends StatelessWidget {
  const WorkoutCategoryChip(this.text, this.icon, {super.key, this.onTap});

  final String text;
  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => ActionChip(
    avatar: Icon(icon, size: 17, color: red),
    label: Text(text, style: const TextStyle(color: ink, fontSize: 12)),
    backgroundColor: surface,
    side: BorderSide.none,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    onPressed: onTap ?? () {},
  );
}

class WorkoutListItem extends StatelessWidget {
  const WorkoutListItem(
    this.title,
    this.subtitle,
    this.icon, {
    super.key,
    this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: ScreenCard(
      onTap: onTap,
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

class InsightMetric extends StatelessWidget {
  const InsightMetric(this.value, this.label, this.icon, {super.key});

  final String value;
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) => ScreenCard(
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

class ActiveDayDot extends StatelessWidget {
  const ActiveDayDot(this.active, {super.key});

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

class ProfileDetailRow extends StatelessWidget {
  const ProfileDetailRow(this.icon, this.label, this.value, {super.key});

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

class ProfileMenuRow extends StatelessWidget {
  const ProfileMenuRow(this.icon, this.title, {super.key, this.onTap});

  final IconData icon;
  final String title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => ListTile(
    contentPadding: EdgeInsets.zero,
    leading: Icon(icon, color: muted),
    title: Text(title, style: const TextStyle(color: ink, fontSize: 14)),
    trailing: const Icon(Icons.chevron_right, color: muted),
    onTap: onTap,
  );
}
