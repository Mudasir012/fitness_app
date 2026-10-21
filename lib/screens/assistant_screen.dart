import 'package:flutter/material.dart';

import '../app_style.dart';

class AssistantScreen extends StatefulWidget {
  const AssistantScreen({super.key});

  @override
  State<AssistantScreen> createState() => _AssistantScreenState();
}

class _AssistantScreenState extends State<AssistantScreen> {
  final input = TextEditingController();
  final messages = <(String, bool)>[
    (
      'Hi Alex! I can help with training, food, hydration and recovery. What would you like help with?',
      false,
    ),
  ];
  final suggestions = [
    'Plan a quick workout',
    'What should I eat after training?',
    'How can I recover today?',
  ];

  @override
  void dispose() {
    input.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Row(
        children: [
          CircleAvatar(
            radius: 17,
            backgroundColor: raisedSurface,
            child: Icon(Icons.auto_awesome, color: orange, size: 18),
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Your assistant',
                style: TextStyle(color: ink, fontSize: 16),
              ),
              Text(
                'Fitness & everyday wellbeing',
                style: TextStyle(color: muted, fontSize: 10),
              ),
            ],
          ),
        ],
      ),
    ),
    body: SafeArea(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(18),
              children: [
                for (final message in messages)
                  _bubble(message.$1, message.$2),
                if (messages.length == 1) ...[
                  const Padding(
                    padding: EdgeInsets.only(top: 12, bottom: 8),
                    child: Text(
                      'TRY ASKING',
                      style: TextStyle(
                        color: muted,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        letterSpacing: .8,
                      ),
                    ),
                  ),
                  for (final suggestion in suggestions)
                    Align(
                      alignment: Alignment.centerLeft,
                      child: ActionChip(
                        avatar: const Icon(
                          Icons.arrow_outward,
                          color: orange,
                          size: 16,
                        ),
                        label: Text(suggestion),
                        onPressed: () => send(suggestion),
                      ),
                    ),
                ],
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(18, 0, 18, 8),
            child: Text(
              'General wellness guidance only; not medical advice.',
              textAlign: TextAlign.center,
              style: TextStyle(color: muted, fontSize: 10),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: input,
                    onSubmitted: send,
                    textInputAction: TextInputAction.send,
                    decoration: InputDecoration(
                      hintText: 'Ask about your wellbeing',
                      filled: true,
                      fillColor: surface,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton.filled(
                  onPressed: () => send(input.text),
                  style: IconButton.styleFrom(
                    backgroundColor: orange,
                    foregroundColor: Colors.white,
                  ),
                  icon: const Icon(Icons.arrow_upward),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  Widget _bubble(String text, bool mine) => Align(
    alignment: mine ? Alignment.centerRight : Alignment.centerLeft,
    child: Container(
      constraints: const BoxConstraints(maxWidth: 310),
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      decoration: BoxDecoration(
        color: mine ? orange : surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: mine ? Colors.white : ink,
          fontSize: 14,
          height: 1.4,
        ),
      ),
    ),
  );

  void send(String value) {
    final question = value.trim();
    if (question.isEmpty) return;
    final text = question.toLowerCase();
    var reply =
        'I can help with workout ideas, recovery, hydration and balanced meals. Tell me your goal and what you have available.';
    if (text.contains('workout') || text.contains('train')) {
      reply =
          'Try 3 easy rounds of squats, incline push-ups and hip hinges after a short warm-up. Keep the effort comfortable and stop if anything hurts.';
    } else if (text.contains('eat') || text.contains('food')) {
      reply =
          'A balanced post-workout meal could include a protein source, carbohydrates and fruit or vegetables, such as yogurt with oats and fruit.';
    } else if (text.contains('recover') || text.contains('sore')) {
      reply =
          'Take an easy walk, drink to thirst and prioritize sleep. Pause activity that causes pain; seek professional advice if symptoms persist.';
    } else if (text.contains('water') || text.contains('hydrat')) {
      reply =
          'Keep water nearby and drink regularly, especially during activity or warm weather. Your needs depend on your body and conditions.';
    }
    setState(() {
      messages
        ..add((question, true))
        ..add((reply, false));
      input.clear();
    });
  }
}
