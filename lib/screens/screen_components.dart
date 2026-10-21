import 'package:flutter/material.dart';

import '../app_style.dart';

class ScreenHeader extends StatelessWidget {
  const ScreenHeader({required this.title, this.trailing, this.onTap});

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
  const ScreenHeadline(this.title, this.subtitle);

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
  const SectionLabel(this.text);

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
  const ScreenCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => Material(
    color: surface,
    borderRadius: BorderRadius.circular(25),
    clipBehavior: Clip.antiAlias,
    child: Padding(padding: const EdgeInsets.all(18), child: child),
  );
}

class WorkoutCategoryChip extends StatelessWidget {
  const WorkoutCategoryChip(this.text, this.icon);

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

class WorkoutListItem extends StatelessWidget {
  const WorkoutListItem(this.title, this.subtitle, this.icon);

  final String title;
  final String subtitle;
  final IconData icon;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: ScreenCard(
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
  const InsightMetric(this.value, this.label, this.icon);

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
  const ActiveDayDot(this.active);

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
  const ProfileDetailRow(this.icon, this.label, this.value);

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
        Expanded(child: Text(label, style: const TextStyle(color: muted))),
        Text(
          value,
          style: const TextStyle(color: ink, fontWeight: FontWeight.w600),
        ),
      ],
    ),
  );
}

class ProfileMenuRow extends StatelessWidget {
  const ProfileMenuRow(this.icon, this.title);

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
