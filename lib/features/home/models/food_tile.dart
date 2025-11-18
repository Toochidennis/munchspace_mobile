class FoodTile {
  final String image;
  final String name;
  final String deliveryTime;
  final double rating;
  final double price;
  final int? discount;
  final bool showAddBtn;
  final bool isPreorder;

  FoodTile({
    required this.image,
    required this.name,
    required this.deliveryTime,
    required this.rating,
    required this.price,
    this.discount,
    this.showAddBtn = true,
    this.isPreorder = false,
  });
}
