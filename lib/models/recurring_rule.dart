class RecurringRule {
  final String id;
  final String type;
  final double amount;
  final String categoryId;
  final String period;
  final String? note;
  final String nextDate;
  final String createdAt;

  const RecurringRule({
    required this.id,
    required this.type,
    required this.amount,
    required this.categoryId,
    required this.period,
    this.note,
    required this.nextDate,
    required this.createdAt,
  });

  factory RecurringRule.fromMap(Map<String, dynamic> map) => RecurringRule(
        id: map['id'] as String,
        type: map['type'] as String,
        amount: (map['amount'] as num).toDouble(),
        categoryId: map['category_id'] as String,
        period: map['period'] as String,
        note: map['note'] as String?,
        nextDate: map['next_date'] as String,
        createdAt: map['created_at'] as String,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'type': type,
        'amount': amount,
        'category_id': categoryId,
        'period': period,
        'note': note,
        'next_date': nextDate,
        'created_at': createdAt,
      };
}
