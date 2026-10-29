import 'dart:async';
import 'package:flutter/material.dart';

import '../app_style.dart';

class WorkoutExercise {
  final String name;
  final int sets;
  final String reps;
  final String tip;
  final IconData icon;

  const WorkoutExercise({
    required this.name,
    required this.sets,
    required this.reps,
    required this.tip,
    this.icon = Icons.fitness_center,
  });
}

class ActiveWorkoutScreen extends StatefulWidget {
  final String workoutTitle;
  final List<WorkoutExercise> exercises;

  const ActiveWorkoutScreen({
    super.key,
    required this.workoutTitle,
    required this.exercises,
  });

  @override
  State<ActiveWorkoutScreen> createState() => _ActiveWorkoutScreenState();
}

class _ActiveWorkoutScreenState extends State<ActiveWorkoutScreen> {
  int currentExerciseIndex = 0;
  int currentSet = 1;
  int totalSeconds = 0;
  bool isPaused = false;
  Timer? sessionTimer;

  bool isResting = false;
  int restSeconds = 45;
  Timer? restTimer;

  @override
  void initState() {
    super.initState();
    _startSessionTimer();
  }

  @override
  void dispose() {
    sessionTimer?.cancel();
    restTimer?.cancel();
    super.dispose();
  }

  void _startSessionTimer() {
    sessionTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!isPaused && mounted) {
        setState(() => totalSeconds++);
      }
    });
  }

  void _completeSet() {
    final currentEx = widget.exercises[currentExerciseIndex];
    if (currentSet < currentEx.sets) {
      _startRest(45);
    } else {
      if (currentExerciseIndex < widget.exercises.length - 1) {
        setState(() {
          currentExerciseIndex++;
          currentSet = 1;
        });
        _startRest(60);
      } else {
        _showFinishDialog();
      }
    }
  }

  void _startRest(int seconds) {
    setState(() {
      isResting = true;
      restSeconds = seconds;
    });
    restTimer?.cancel();
    restTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (restSeconds > 1 && mounted) {
        setState(() => restSeconds--);
      } else {
        _skipRest();
      }
    });
  }

  void _skipRest() {
    restTimer?.cancel();
    if (mounted) {
      setState(() {
        isResting = false;
        final currentEx = widget.exercises[currentExerciseIndex];
        if (currentSet < currentEx.sets) {
          currentSet++;
        }
      });
    }
  }

  void _addRestTime(int seconds) {
    setState(() => restSeconds += seconds);
  }

  String _formatTime(int sec) {
    final m = (sec ~/ 60).toString().padLeft(2, '0');
    final s = (sec % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  void _showFinishDialog() {
    sessionTimer?.cancel();
    restTimer?.cancel();

    final burnedKcal = (totalSeconds * 0.14).round() + 50;

    showModalBottomSheet<void>(
      context: context,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      builder: (ctx) => Padding(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: raisedSurface,
                shape: BoxShape.circle,
                border: Border.all(color: red, width: 2),
              ),
              child: const Icon(Icons.emoji_events, color: orange, size: 34),
            ),
            const SizedBox(height: 16),
            const Text(
              'Workout Complete!',
              style: TextStyle(
                color: ink,
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Great work pushing through today’s session.',
              style: TextStyle(color: muted, fontSize: 13),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: _statPill(
                    icon: Icons.timer_outlined,
                    label: 'DURATION',
                    value: _formatTime(totalSeconds),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _statPill(
                    icon: Icons.local_fire_department_outlined,
                    label: 'CALORIES',
                    value: '$burnedKcal kcal',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: red,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: const Text(
                  'Save & Exit',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statPill({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      decoration: BoxDecoration(
        color: raisedSurface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Icon(icon, color: red, size: 20),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              color: ink,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 2),
          Text(label, style: const TextStyle(color: muted, fontSize: 9)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentEx = widget.exercises[currentExerciseIndex];
    final nextEx = currentExerciseIndex < widget.exercises.length - 1
        ? widget.exercises[currentExerciseIndex + 1]
        : null;

    return Scaffold(
      backgroundColor: canvas,
      appBar: AppBar(
        backgroundColor: canvas,
        leading: IconButton(
          icon: const Icon(Icons.close, color: ink),
          onPressed: () => _confirmExit(),
        ),
        title: Text(
          widget.workoutTitle.toUpperCase(),
          style: const TextStyle(
            color: ink,
            fontSize: 13,
            fontWeight: FontWeight.w700,
            letterSpacing: 1,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              isPaused ? Icons.play_arrow : Icons.pause,
              color: orange,
            ),
            onPressed: () => setState(() => isPaused = !isPaused),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
          child: Column(
            children: [
              // Overall Timer & Progress
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.timer_outlined, color: muted, size: 18),
                      const SizedBox(width: 6),
                      Text(
                        _formatTime(totalSeconds),
                        style: const TextStyle(
                          color: ink,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    'Exercise ${currentExerciseIndex + 1} of ${widget.exercises.length}',
                    style: const TextStyle(
                      color: muted,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: (currentExerciseIndex + (currentSet / currentEx.sets)) /
                      widget.exercises.length,
                  minHeight: 6,
                  color: red,
                  backgroundColor: raisedSurface,
                ),
              ),
              const SizedBox(height: 24),

              Expanded(
                child: isResting
                    ? _buildRestView()
                    : _buildExerciseView(currentEx),
              ),

              // Next Exercise preview card
              if (nextEx != null && !isResting) ...[
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: surface,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: divider.withValues(alpha: 0.3)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.skip_next_outlined, color: muted, size: 20),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'UP NEXT',
                              style: TextStyle(
                                color: muted,
                                fontSize: 9,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              nextEx.name,
                              style: const TextStyle(
                                color: ink,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '${nextEx.sets} sets × ${nextEx.reps}',
                        style: const TextStyle(color: muted, fontSize: 11),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],

              // Bottom Action Button
              if (!isResting)
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    onPressed: _completeSet,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: red,
                      foregroundColor: Colors.white,
                      elevation: 4,
                      shadowColor: red.withValues(alpha: 0.4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(27),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.check, size: 20),
                        const SizedBox(width: 8),
                        Text(
                          currentSet == currentEx.sets &&
                                  currentExerciseIndex == widget.exercises.length - 1
                              ? 'Finish Workout'
                              : 'Complete Set $currentSet',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExerciseView(WorkoutExercise ex) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 110,
          height: 110,
          decoration: BoxDecoration(
            color: raisedSurface,
            shape: BoxShape.circle,
            border: Border.all(color: divider, width: 2),
          ),
          child: Icon(ex.icon, color: orange, size: 52),
        ),
        const SizedBox(height: 24),
        Text(
          ex.name,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: ink,
            fontSize: 26,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.4,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: raisedSurface,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            'SET $currentSet OF ${ex.sets}  •  ${ex.reps}',
            style: const TextStyle(
              color: orange,
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: divider.withValues(alpha: 0.4)),
          ),
          child: Row(
            children: [
              const Icon(Icons.tips_and_updates_outlined, color: red, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  ex.tip,
                  style: const TextStyle(color: muted, fontSize: 12, height: 1.4),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRestView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'REST & RECOVER',
          style: TextStyle(
            color: muted,
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 20),
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 150,
              height: 150,
              child: CircularProgressIndicator(
                value: restSeconds / 60.0,
                strokeWidth: 8,
                backgroundColor: raisedSurface,
                color: orange,
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${restSeconds}s',
                  style: const TextStyle(
                    color: ink,
                    fontSize: 38,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Text(
                  'REMAINING',
                  style: TextStyle(color: muted, fontSize: 9),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton.icon(
              onPressed: () => _addRestTime(30),
              icon: const Icon(Icons.add, size: 16),
              label: const Text('+30s'),
              style: OutlinedButton.styleFrom(
                foregroundColor: ink,
                side: const BorderSide(color: divider),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            const SizedBox(width: 14),
            ElevatedButton(
              onPressed: _skipRest,
              style: ElevatedButton.styleFrom(
                backgroundColor: raisedSurface,
                foregroundColor: orange,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                'Skip Rest',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _confirmExit() {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: const Text('End workout early?', style: TextStyle(color: ink)),
        content: const Text(
          'Your progress for this session will not be saved.',
          style: TextStyle(color: muted),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Resume', style: TextStyle(color: orange)),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              Navigator.of(context).pop();
            },
            child: const Text('Quit', style: TextStyle(color: Colors.redAccent)),
          ),
        ],
      ),
    );
  }
}
