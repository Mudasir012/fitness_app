import 'package:flutter/material.dart';

import '../app_style.dart';
import 'active_workout_screen.dart';
import 'screen_components.dart';

class WorkoutDetailScreen extends StatelessWidget {
  final String title;
  final String duration;
  final String level;
  final String calories;
  final List<String> targetMuscles;
  final List<String> equipment;
  final List<WorkoutExercise> exercises;

  const WorkoutDetailScreen({
    super.key,
    required this.title,
    required this.duration,
    required this.level,
    required this.calories,
    required this.targetMuscles,
    required this.equipment,
    required this.exercises,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: canvas,
      appBar: AppBar(
        backgroundColor: canvas,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: ink),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'WORKOUT OVERVIEW',
          style: TextStyle(
            color: ink,
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 1,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark_border, color: ink),
            onPressed: () {},
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        decoration: BoxDecoration(
          color: surface,
          border: Border(top: BorderSide(color: divider.withValues(alpha: 0.3))),
        ),
        child: SizedBox(
          height: 52,
          child: ElevatedButton.icon(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => ActiveWorkoutScreen(
                    workoutTitle: title,
                    exercises: exercises,
                  ),
                ),
              );
            },
            icon: const Icon(Icons.play_arrow),
            label: const Text(
              'Start Workout Now',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: red,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(26),
              ),
              elevation: 4,
              shadowColor: red.withValues(alpha: 0.4),
            ),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Banner Card
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              gradient: const LinearGradient(
                colors: [Color(0xFF8C9288), Color(0xFF262A28)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    level.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.8,
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.4,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '$duration  •  $calories EST. BURN  •  ${exercises.length} EXERCISES',
                  style: const TextStyle(color: Colors.white70, fontSize: 11),
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),

          // Target Muscles
          const SectionLabel('TARGET MUSCLES'),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: targetMuscles
                .map(
                  (m) => Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: surface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: divider.withValues(alpha: 0.4),
                      ),
                    ),
                    child: Text(
                      m,
                      style: const TextStyle(
                        color: ink,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 22),

          // Equipment needed
          const SectionLabel('EQUIPMENT'),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: equipment
                .map(
                  (eq) => Chip(
                    avatar: const Icon(Icons.check, size: 14, color: orange),
                    label: Text(
                      eq,
                      style: const TextStyle(color: muted, fontSize: 12),
                    ),
                    backgroundColor: surface,
                    side: BorderSide.none,
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 24),

          // Exercise Routine Breakdown
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SectionLabel('EXERCISES'),
              Text(
                '${exercises.length} total',
                style: const TextStyle(color: muted, fontSize: 11),
              ),
            ],
          ),
          const SizedBox(height: 12),

          for (int i = 0; i < exercises.length; i++) ...[
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: surface,
                borderRadius: BorderRadius.circular(22),
              ),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: raisedSurface,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(exercises[i].icon, color: red, size: 22),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          exercises[i].name,
                          style: const TextStyle(
                            color: ink,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${exercises[i].sets} sets × ${exercises[i].reps}',
                          style: const TextStyle(color: muted, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: raisedSurface,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '#${i + 1}',
                      style: const TextStyle(
                        color: orange,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
