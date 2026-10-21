import 'package:flutter/material.dart';

import '../app_style.dart';
import 'screen_components.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.all(20),
    children: [
      const ScreenHeader(title: 'PROFILE', trailing: Icons.settings_outlined),
      const SizedBox(height: 22),
      const ScreenHeadline('Your space.', 'A little progress, every day.'),
      const SizedBox(height: 16),
      ScreenCard(
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
      const SectionLabel('YOUR DETAILS'),
      const SizedBox(height: 9),
      const ScreenCard(
        child: Column(
          children: [
            ProfileDetailRow(Icons.cake_outlined, 'Age', '22 years'),
            Divider(),
            ProfileDetailRow(Icons.height, 'Height', '179 cm'),
            Divider(),
            ProfileDetailRow(Icons.monitor_weight_outlined, 'Weight', '75 kg'),
            Divider(),
            ProfileDetailRow(Icons.flag_outlined, 'Daily step goal', '10,000'),
          ],
        ),
      ),
      const SizedBox(height: 22),
      const SectionLabel('PREFERENCES'),
      const SizedBox(height: 9),
      const ScreenCard(
        child: Column(
          children: [
            ProfileMenuRow(Icons.notifications_none, 'Notifications'),
            ProfileMenuRow(Icons.favorite_border, 'Health preferences'),
            ProfileMenuRow(Icons.help_outline, 'Help & support'),
            ProfileMenuRow(Icons.privacy_tip_outlined, 'Privacy'),
          ],
        ),
      ),
    ],
  );
}
