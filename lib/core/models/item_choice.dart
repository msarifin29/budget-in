class ItemChoice {
  final int id;
  final String label;

  ItemChoice(this.id, this.label);

  ItemChoice copyWith({int? id, String? label}) {
    return ItemChoice(id ?? this.id, label ?? this.label);
  }
}
