class Category {
  final String id;
  final String type;
  final String name;
  final String? icon;
  final String? color;
  final int sortOrder;
  final bool isDefault;

  const Category({
    required this.id,
    required this.type,
    required this.name,
    this.icon,
    this.color,
    required this.sortOrder,
    required this.isDefault,
  });

  factory Category.fromMap(Map<String, dynamic> map) => Category(
        id: map['id'] as String,
        type: map['type'] as String,
        name: map['name'] as String,
        icon: map['icon'] as String?,
        color: map['color'] as String?,
        sortOrder: map['sort_order'] as int? ?? 0,
        isDefault: (map['is_default'] as int? ?? 0) == 1,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'type': type,
        'name': name,
        'icon': icon,
        'color': color,
        'sort_order': sortOrder,
        'is_default': isDefault ? 1 : 0,
      };
}
