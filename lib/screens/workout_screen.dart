import 'package:flutter/material.dart';

import '../app_style.dart';
import 'screen_components.dart';

class WorkoutScreen extends StatelessWidget {
  const WorkoutScreen({super.key, required this.onAsk});

  final VoidCallback onAsk;

  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.all(18),
    children: [
      ScreenHeader(
        title: 'HEALTH',
        trailing: Icons.chat_bubble_outline,
        onTap: onAsk,
      ),
      const SizedBox(height: 22),
      const ScreenHeadline('Find your rhythm', 'Move better. Feel stronger.'),
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
        onPressed: () => ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Workout selected'))),
        style: FilledButton.styleFrom(
          backgroundColor: red,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.all(15),
        ),
        icon: const Icon(Icons.play_arrow),
        label: const Text('Start workout'),
      ),
      const SizedBox(height: 25),
      const SectionLabel('EXPLORE TRAINING'),
      const SizedBox(height: 10),
      const Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          WorkoutCategoryChip('Strength', Icons.fitness_center),
          WorkoutCategoryChip('Cardio', Icons.bolt),
          WorkoutCategoryChip('Flexibility', Icons.self_improvement),
          WorkoutCategoryChip('Recovery', Icons.favorite_border),
        ],
      ),
      const SizedBox(height: 24),
      const SectionLabel('POPULAR WORKOUTS'),
      const SizedBox(height: 10),
      const WorkoutListItem(
        'Chest & Triceps',
        '30 min • Intermediate',
        Icons.fitness_center,
      ),
      const WorkoutListItem('Leg Day', '40 min • Advanced', Icons.directions_run),
      const WorkoutListItem(
        'Morning Cardio',
        '20 min • Beginner',
        Icons.directions_walk,
      ),
      const WorkoutListItem(
        'Full Body Mobility',
        '15 min • Beginner',
        Icons.self_improvement,
      ),
    ],
  );
}
