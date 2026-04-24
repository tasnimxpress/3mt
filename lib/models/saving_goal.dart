class SavingGoal {
  final String id;
  final String categoryId;
  final double target;
  final String createdAt;

  const SavingGoal({
    required this.id,
    required this.categoryId,
    required this.target,
    required this.createdAt,
  });

  factory SavingGoal.fromMap(Map<String, dynamic> map) => SavingGoal(
        id: map['id'] as String,
        categoryId: map['category_id'] as String,
        target: (map['target'] as num).toDouble(),
        createdAt: map['created_at'] as String,
      );
}
