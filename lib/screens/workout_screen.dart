import 'package:flutter/material.dart';

import '../app_style.dart';
import 'active_workout_screen.dart';
import 'screen_components.dart';
import 'workout_detail_screen.dart';

class WorkoutScreen extends StatelessWidget {
  const WorkoutScreen({super.key, required this.onAsk});

  final VoidCallback onAsk;

  void _openWorkout(BuildContext context, {
    required String title,
    required String duration,
    required String level,
    required String calories,
    required List<String> targetMuscles,
    required List<String> equipment,
    required List<WorkoutExercise> exercises,
  }) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => WorkoutDetailScreen(
          title: title,
          duration: duration,
          level: level,
          calories: calories,
          targetMuscles: targetMuscles,
          equipment: equipment,
          exercises: exercises,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final todaysPickExercises = const [
      WorkoutExercise(
        name: 'Dumbbell Goblet Squats',
        sets: 3,
        reps: '12 reps',
        tip: 'Keep chest upright and drive through heels on ascent.',
        icon: Icons.fitness_center,
      ),
      WorkoutExercise(
        name: 'Push-Ups (Chest Focus)',
        sets: 3,
        reps: '15 reps',
        tip: 'Lower slowly with control, engage core throughout.',
        icon: Icons.sports_gymnastics,
      ),
      WorkoutExercise(
        name: 'Dumbbell Romanian Deadlift',
        sets: 3,
        reps: '10 reps',
        tip: 'Hinge at the hips with a slight bend in your knees.',
        icon: Icons.fitness_center,
      ),
      WorkoutExercise(
        name: 'Plank Hold',
        sets: 3,
        reps: '45 sec',
        tip: 'Keep glutes squeezed and avoid sagging your hips.',
        icon: Icons.timer_outlined,
      ),
    ];

    return ListView(
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

        // Hero Card (Today's Pick)
        GestureDetector(
          onTap: () => _openWorkout(
            context,
            title: 'Full Body Strength',
            duration: '35 MIN',
            level: 'Intermediate',
            calories: '340 KCAL',
            targetMuscles: ['Full Body', 'Quads', 'Chest', 'Core'],
            equipment: ['Dumbbells', 'Exercise Mat'],
            exercises: todaysPickExercises,
          ),
          child: Container(
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
                  '35 MIN  •  INTERMEDIATE  •  4 EXERCISES',
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        FilledButton.icon(
          onPressed: () => _openWorkout(
            context,
            title: 'Full Body Strength',
            duration: '35 MIN',
            level: 'Intermediate',
            calories: '340 KCAL',
            targetMuscles: ['Full Body', 'Quads', 'Chest', 'Core'],
            equipment: ['Dumbbells', 'Exercise Mat'],
            exercises: todaysPickExercises,
          ),
          style: FilledButton.styleFrom(
            backgroundColor: red,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.all(15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          icon: const Icon(Icons.play_arrow),
          label: const Text('Start workout', style: TextStyle(fontWeight: FontWeight.w700)),
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

        WorkoutListItem(
          'Chest & Triceps',
          '30 min • Intermediate',
          Icons.fitness_center,
          onTap: () => _openWorkout(
            context,
            title: 'Chest & Triceps',
            duration: '30 MIN',
            level: 'Intermediate',
            calories: '280 KCAL',
            targetMuscles: ['Chest', 'Triceps', 'Front Delts'],
            equipment: ['Dumbbells', 'Bench'],
            exercises: const [
              WorkoutExercise(
                name: 'Incline Dumbbell Press',
                sets: 3,
                reps: '10-12 reps',
                tip: 'Drive dumbbells up with elbows at roughly 45 degrees.',
                icon: Icons.fitness_center,
              ),
              WorkoutExercise(
                name: 'Dumbbell Floor Flyes',
                sets: 3,
                reps: '12 reps',
                tip: 'Focus on stretching the chest and squeezing at top.',
                icon: Icons.fitness_center,
              ),
              WorkoutExercise(
                name: 'Bench Dips',
                sets: 3,
                reps: '15 reps',
                tip: 'Keep torso upright to emphasize triceps over shoulders.',
                icon: Icons.accessibility_new,
              ),
              WorkoutExercise(
                name: 'Diamond Push-ups',
                sets: 2,
                reps: '10 reps',
                tip: 'Hands together under chest to target inner triceps.',
                icon: Icons.sports_gymnastics,
              ),
            ],
          ),
        ),

        WorkoutListItem(
          'Leg Day',
          '40 min • Advanced',
          Icons.directions_run,
          onTap: () => _openWorkout(
            context,
            title: 'Leg Day Blast',
            duration: '40 MIN',
            level: 'Advanced',
            calories: '420 KCAL',
            targetMuscles: ['Quads', 'Hamstrings', 'Glutes', 'Calves'],
            equipment: ['Barbell / Dumbbells'],
            exercises: const [
              WorkoutExercise(
                name: 'Barbell Back Squats',
                sets: 4,
                reps: '8-10 reps',
                tip: 'Break at knees and hips together, depth below parallel.',
                icon: Icons.fitness_center,
              ),
              WorkoutExercise(
                name: 'Walking Lunges',
                sets: 3,
                reps: '20 steps',
                tip: 'Maintain upright posture, knee touches ground lightly.',
                icon: Icons.directions_walk,
              ),
              WorkoutExercise(
                name: 'Romanian Deadlifts',
                sets: 3,
                reps: '12 reps',
                tip: 'Feel the stretch in your hamstrings before rising.',
                icon: Icons.fitness_center,
              ),
              WorkoutExercise(
                name: 'Standing Calf Raises',
                sets: 3,
                reps: '20 reps',
                tip: 'Pause at the peak of contraction for 1 second.',
                icon: Icons.height,
              ),
            ],
          ),
        ),

        WorkoutListItem(
          'Morning Cardio',
          '20 min • Beginner',
          Icons.directions_walk,
          onTap: () => _openWorkout(
            context,
            title: 'Morning Cardio Burn',
            duration: '20 MIN',
            level: 'Beginner',
            calories: '180 KCAL',
            targetMuscles: ['Cardiovascular', 'Calves', 'Core'],
            equipment: ['Bodyweight only'],
            exercises: const [
              WorkoutExercise(
                name: 'Jumping Jacks',
                sets: 3,
                reps: '45 sec',
                tip: 'Land softly on the balls of your feet.',
                icon: Icons.directions_run,
              ),
              WorkoutExercise(
                name: 'High Knees',
                sets: 3,
                reps: '30 sec',
                tip: 'Drive knees up to hip height, pump your arms.',
                icon: Icons.sports_gymnastics,
              ),
              WorkoutExercise(
                name: 'Mountain Climbers',
                sets: 3,
                reps: '30 sec',
                tip: 'Keep hips low and drive knees quickly toward chest.',
                icon: Icons.fitness_center,
              ),
            ],
          ),
        ),

        WorkoutListItem(
          'Full Body Mobility',
          '15 min • Beginner',
          Icons.self_improvement,
          onTap: () => _openWorkout(
            context,
            title: 'Full Body Mobility & Stretch',
            duration: '15 MIN',
            level: 'Beginner',
            calories: '90 KCAL',
            targetMuscles: ['Hips', 'Spine', 'Shoulders'],
            equipment: ['Yoga Mat'],
            exercises: const [
              WorkoutExercise(
                name: 'Cat-Cow Flow',
                sets: 2,
                reps: '60 sec',
                tip: 'Coordinate spinal movement with deep breathing.',
                icon: Icons.self_improvement,
              ),
              WorkoutExercise(
                name: 'World’s Greatest Stretch',
                sets: 2,
                reps: '5 per side',
                tip: 'Reach arm high to ceiling for thoracic opening.',
                icon: Icons.accessibility_new,
              ),
              WorkoutExercise(
                name: 'Child’s Pose to Cobra',
                sets: 2,
                reps: '8 reps',
                tip: 'Ease gently into lower back extension.',
                icon: Icons.self_improvement,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
