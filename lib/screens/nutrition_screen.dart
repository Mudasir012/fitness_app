import 'package:flutter/material.dart';

import '../app_style.dart';
import 'screen_components.dart';

class MealItem {
  final String name;
  final int calories;
  final String protein;

  const MealItem(this.name, this.calories, this.protein);
}

class NutritionScreen extends StatefulWidget {
  const NutritionScreen({super.key});

  @override
  State<NutritionScreen> createState() => _NutritionScreenState();
}

class _NutritionScreenState extends State<NutritionScreen> {
  final int targetCalories = 2200;
  final int burnedCalories = 420;

  final Map<String, List<MealItem>> meals = {
    'Breakfast': [
      const MealItem('Rolled Oats with Berries', 320, '12g protein'),
      const MealItem('Whey Protein Shake', 130, '25g protein'),
    ],
    'Lunch': [
      const MealItem('Grilled Chicken & Brown Rice', 520, '42g protein'),
      const MealItem('Steamed Broccoli & Olive Oil', 90, '4g protein'),
    ],
    'Dinner': [
      const MealItem('Baked Salmon & Asparagus', 480, '38g protein'),
    ],
    'Snacks': [
      const MealItem('Greek Yogurt with Honey', 160, '15g protein'),
    ],
  };

  int get totalConsumed {
    int total = 0;
    for (final list in meals.values) {
      for (final item in list) {
        total += item.calories;
      }
    }
    return total;
  }

  void _showAddMealSheet(String mealCategory) {
    final foodController = TextEditingController();
    final caloriesController = TextEditingController();
    final proteinController = TextEditingController();

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
                Text(
                  'Add to $mealCategory',
                  style: const TextStyle(
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
            _sheetField(
              controller: foodController,
              hint: 'Food name (e.g. Scrambled Eggs)',
              icon: Icons.restaurant,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _sheetField(
                    controller: caloriesController,
                    hint: 'Calories (kcal)',
                    icon: Icons.local_fire_department_outlined,
                    isNumber: true,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _sheetField(
                    controller: proteinController,
                    hint: 'Protein (g)',
                    icon: Icons.fitness_center,
                    isNumber: true,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  final name = foodController.text.trim();
                  final cal = int.tryParse(caloriesController.text.trim()) ?? 0;
                  final pro = proteinController.text.trim().isEmpty
                      ? '10g protein'
                      : '${proteinController.text.trim()}g protein';

                  if (name.isNotEmpty && cal > 0) {
                    setState(() {
                      meals[mealCategory]?.add(MealItem(name, cal, pro));
                    });
                    Navigator.of(ctx).pop();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: red,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: const Text(
                  'Add Food Entry',
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sheetField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool isNumber = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: raisedSurface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: divider.withValues(alpha: 0.5)),
      ),
      child: TextField(
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        style: const TextStyle(color: ink, fontSize: 13),
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: orange, size: 18),
          hintText: hint,
          hintStyle: const TextStyle(color: muted, fontSize: 13),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final remaining = (targetCalories - totalConsumed + burnedCalories).clamp(0, targetCalories + 500);

    return Scaffold(
      backgroundColor: canvas,
      appBar: AppBar(
        backgroundColor: canvas,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: ink),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'NUTRITION & MACROS',
          style: TextStyle(
            color: ink,
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 1,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const ScreenHeadline('Fuel your body.', 'Healthy habits built one meal at a time.'),
          const SizedBox(height: 20),

          // Calorie Summary Card
          ScreenCard(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'DAILY CALORIES REMAINING',
                          style: TextStyle(
                            color: muted,
                            fontSize: 10,
                            letterSpacing: .8,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '$remaining',
                          style: const TextStyle(
                            fontFamily: 'DotMatrix',
                            color: ink,
                            fontSize: 36,
                          ),
                        ),
                        Text(
                          'Target: $targetCalories kcal',
                          style: const TextStyle(color: muted, fontSize: 11),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 68,
                      height: 68,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CircularProgressIndicator(
                            value: (totalConsumed / targetCalories).clamp(0.0, 1.0),
                            strokeWidth: 7,
                            backgroundColor: raisedSurface,
                            color: red,
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '${((totalConsumed / targetCalories) * 100).toInt()}%',
                                style: const TextStyle(
                                  color: ink,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12,
                                ),
                              ),
                              const Text('EATEN', style: TextStyle(color: muted, fontSize: 7)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Divider(height: 26, color: divider),
                Row(
                  children: [
                    _miniSummary(
                      icon: Icons.restaurant,
                      label: 'CONSUMED',
                      value: '$totalConsumed KCAL',
                    ),
                    const SizedBox(width: 16),
                    _miniSummary(
                      icon: Icons.local_fire_department_outlined,
                      label: 'BURNED',
                      value: '$burnedCalories KCAL',
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),

          // Macros Breakdown
          const SectionLabel('TODAY’S MACRONUTRIENTS'),
          const SizedBox(height: 10),
          ScreenCard(
            child: Column(
              children: [
                _macroProgressRow('Protein', '118g', '150g', 118 / 150, red),
                const SizedBox(height: 14),
                _macroProgressRow('Carbohydrates', '164g', '220g', 164 / 220, orange),
                const SizedBox(height: 14),
                _macroProgressRow('Healthy Fats', '48g', '65g', 48 / 65, const Color(0xFFF4B251)),
              ],
            ),
          ),
          const SizedBox(height: 22),

          // Meal Categories
          const SectionLabel('MEAL LOG'),
          const SizedBox(height: 10),

          for (final category in meals.keys) ...[
            _buildMealCategoryCard(category, meals[category]!),
            const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }

  Widget _miniSummary({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Expanded(
      child: Row(
        children: [
          Icon(icon, color: red, size: 18),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: const TextStyle(color: ink, fontSize: 12, fontWeight: FontWeight.w600),
              ),
              Text(label, style: const TextStyle(color: muted, fontSize: 8)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _macroProgressRow(
    String label,
    String current,
    String goal,
    double progress,
    Color color,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(color: ink, fontSize: 13, fontWeight: FontWeight.w600)),
            Text('$current / $goal', style: const TextStyle(color: muted, fontSize: 11)),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: progress.clamp(0.0, 1.0),
            minHeight: 6,
            color: color,
            backgroundColor: raisedSurface,
          ),
        ),
      ],
    );
  }

  Widget _buildMealCategoryCard(String category, List<MealItem> items) {
    int catCalories = items.fold(0, (sum, item) => sum + item.calories);

    return ScreenCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                category.toUpperCase(),
                style: const TextStyle(
                  color: ink,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  letterSpacing: .6,
                ),
              ),
              Row(
                children: [
                  Text(
                    '$catCalories kcal',
                    style: const TextStyle(color: orange, fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(width: 8),
                  InkWell(
                    onTap: () => _showAddMealSheet(category),
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: raisedSurface,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.add, color: ink, size: 14),
                          SizedBox(width: 2),
                          Text('Add', style: TextStyle(color: ink, fontSize: 11)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          if (items.isNotEmpty) ...[
            const SizedBox(height: 12),
            for (final item in items)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  children: [
                    const Icon(Icons.circle, color: divider, size: 6),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        item.name,
                        style: const TextStyle(color: ink, fontSize: 13),
                      ),
                    ),
                    Text(
                      '${item.protein} • ${item.calories} kcal',
                      style: const TextStyle(color: muted, fontSize: 11),
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
