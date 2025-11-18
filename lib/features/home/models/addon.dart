class Addon {
  final String name;
  final int price;
  bool selected;
  int quantity;

  Addon({
    required this.name,
    required this.price,
    this.selected = false,
    this.quantity = 1,
  });
}
