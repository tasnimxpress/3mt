class BudgetLimit {
  final String id;
  final String categoryId;
  final double amount;
  final String createdAt;

  const BudgetLimit({
    required this.id,
    required this.categoryId,
    required this.amount,
    required this.createdAt,
  });

  factory BudgetLimit.fromMap(Map<String, dynamic> map) => BudgetLimit(
        id: map['id'] as String,
        categoryId: map['category_id'] as String,
        amount: (map['amount'] as num).toDouble(),
        createdAt: map['created_at'] as String,
      );
}
