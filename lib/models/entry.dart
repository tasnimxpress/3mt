class Entry {
  final String id;
  final String type; // 'earning' | 'expense' | 'saving'
  final double amount;
  final String categoryId;
  final String date; // 'YYYY-MM-DD'
  final String? note;
  final bool isRecurring;
  final String? recurPeriod; // 'monthly' | 'weekly'
  final String? recurRuleId;
  final String createdAt;

  const Entry({
    required this.id,
    required this.type,
    required this.amount,
    required this.categoryId,
    required this.date,
    this.note,
    this.isRecurring = false,
    this.recurPeriod,
    this.recurRuleId,
    required this.createdAt,
  });

  factory Entry.fromMap(Map<String, dynamic> map) => Entry(
        id: map['id'] as String,
        type: map['type'] as String,
        amount: (map['amount'] as num).toDouble(),
        categoryId: map['category_id'] as String,
        date: map['date'] as String,
        note: map['note'] as String?,
        isRecurring: (map['is_recurring'] as int? ?? 0) == 1,
        recurPeriod: map['recur_period'] as String?,
        recurRuleId: map['recur_rule_id'] as String?,
        createdAt: map['created_at'] as String,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'type': type,
        'amount': amount,
        'category_id': categoryId,
        'date': date,
        'note': note,
        'is_recurring': isRecurring ? 1 : 0,
        'recur_period': recurPeriod,
        'recur_rule_id': recurRuleId,
        'created_at': createdAt,
      };

  Entry copyWith({
    String? id,
    String? type,
    double? amount,
    String? categoryId,
    String? date,
    String? note,
    bool? isRecurring,
    String? recurPeriod,
    String? recurRuleId,
    String? createdAt,
  }) =>
      Entry(
        id: id ?? this.id,
        type: type ?? this.type,
        amount: amount ?? this.amount,
        categoryId: categoryId ?? this.categoryId,
        date: date ?? this.date,
        note: note ?? this.note,
        isRecurring: isRecurring ?? this.isRecurring,
        recurPeriod: recurPeriod ?? this.recurPeriod,
        recurRuleId: recurRuleId ?? this.recurRuleId,
        createdAt: createdAt ?? this.createdAt,
      );
}
