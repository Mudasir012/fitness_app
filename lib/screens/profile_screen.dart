import 'package:flutter/material.dart';

import '../app_style.dart';
import 'screen_components.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name = 'Mudasir Hussain';
  String email = 'mudasirhussain@gmail.com';
  String age = '22';
  String height = '179';
  String weight = '75';
  String stepGoal = '10,000';

  bool notificationsEnabled = true;

  void _showEditProfileSheet() {
    final nameCtrl = TextEditingController(text: name);
    final ageCtrl = TextEditingController(text: age);
    final heightCtrl = TextEditingController(text: height);
    final weightCtrl = TextEditingController(text: weight);
    final stepGoalCtrl = TextEditingController(text: stepGoal);

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 24,
          bottom: MediaQuery.of(ctx).viewInsets.bottom + 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Edit Profile Details',
                  style: TextStyle(
                    color: ink,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: muted),
                  onPressed: () => Navigator.of(ctx).pop(),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _editField(label: 'Full Name', controller: nameCtrl, icon: Icons.person_outline),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _editField(label: 'Age (years)', controller: ageCtrl, icon: Icons.cake_outlined, isNumber: true),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _editField(label: 'Height (cm)', controller: heightCtrl, icon: Icons.height, isNumber: true),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _editField(label: 'Weight (kg)', controller: weightCtrl, icon: Icons.monitor_weight_outlined, isNumber: true),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _editField(label: 'Step Goal', controller: stepGoalCtrl, icon: Icons.flag_outlined, isNumber: true),
                ),
              ],
            ),
            const SizedBox(height: 22),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (nameCtrl.text.isNotEmpty) name = nameCtrl.text.trim();
                    if (ageCtrl.text.isNotEmpty) age = ageCtrl.text.trim();
                    if (heightCtrl.text.isNotEmpty) height = heightCtrl.text.trim();
                    if (weightCtrl.text.isNotEmpty) weight = weightCtrl.text.trim();
                    if (stepGoalCtrl.text.isNotEmpty) stepGoal = stepGoalCtrl.text.trim();
                  });
                  Navigator.of(ctx).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: red,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: const Text('Save Changes', style: TextStyle(fontWeight: FontWeight.w700)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _editField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    bool isNumber = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: raisedSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: divider.withValues(alpha: 0.4)),
      ),
      child: TextField(
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        style: const TextStyle(color: ink, fontSize: 13),
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: orange, size: 18),
          labelText: label,
          labelStyle: const TextStyle(color: muted, fontSize: 12),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        ),
      ),
    );
  }

  void _showInfoDialog(String title, String content) {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Text(title, style: const TextStyle(color: ink)),
        content: Text(content, style: const TextStyle(color: muted)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Close', style: TextStyle(color: orange)),
          ),
        ],
      ),
    );
  }

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
            Text(
              name,
              style: const TextStyle(
                color: ink,
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
            Text(
              email,
              style: const TextStyle(color: muted, fontSize: 12),
            ),
            const SizedBox(height: 15),
            OutlinedButton.icon(
              onPressed: _showEditProfileSheet,
              icon: const Icon(Icons.edit_outlined, size: 16),
              label: const Text('Edit profile'),
              style: OutlinedButton.styleFrom(
                foregroundColor: ink,
                side: const BorderSide(color: divider),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 22),
      const SectionLabel('YOUR DETAILS'),
      const SizedBox(height: 9),
      ScreenCard(
        child: Column(
          children: [
            ProfileDetailRow(Icons.cake_outlined, 'Age', '$age years'),
            const Divider(),
            ProfileDetailRow(Icons.height, 'Height', '$height cm'),
            const Divider(),
            ProfileDetailRow(Icons.monitor_weight_outlined, 'Weight', '$weight kg'),
            const Divider(),
            ProfileDetailRow(Icons.flag_outlined, 'Daily step goal', stepGoal),
          ],
        ),
      ),
      const SizedBox(height: 22),
      const SectionLabel('PREFERENCES'),
      const SizedBox(height: 9),
      ScreenCard(
        child: Column(
          children: [
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              secondary: const Icon(Icons.notifications_none, color: muted),
              title: const Text('Daily Notifications', style: TextStyle(color: ink, fontSize: 14)),
              value: notificationsEnabled,
              activeThumbColor: orange,
              onChanged: (val) => setState(() => notificationsEnabled = val),
            ),
            ProfileMenuRow(
              Icons.favorite_border,
              'Health preferences',
              onTap: () => _showInfoDialog(
                'Health Preferences',
                'Your metric preferences: Kilometers (KM), Kilocalories (KCAL), Liters (L).',
              ),
            ),
            ProfileMenuRow(
              Icons.help_outline,
              'Help & support',
              onTap: () => _showInfoDialog(
                'Help & Support',
                'Need assistance? Chat with your AI Assistant or reach out to support@healthfit.app.',
              ),
            ),
            ProfileMenuRow(
              Icons.privacy_tip_outlined,
              'Privacy',
              onTap: () => _showInfoDialog(
                'Privacy Policy',
                'Your health and biometric data stays strictly encrypted on your local device.',
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
