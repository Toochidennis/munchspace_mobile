class CartRestaurant {
  final String id;
  final String name;
  final int itemCount;
  final List<CartItem> items;

  CartRestaurant({
    required this.id,
    required this.name,
    required this.itemCount,
    required this.items,
  });
}

class CartItem {
  final String id;
  final String name;
  final int price;
  final String image;
  final int quantity;

  CartItem({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.quantity,
  });
}
