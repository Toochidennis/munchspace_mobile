class Order {
  final String id;
  final String status;
  final String storeName;
  final String code;
  final double progress; // 0.0 to 1.0
  final DateTime placedAt;
  final List<OrderItem> items;
  final List<OrderTimelineStep> timeline;
  final double deliveryFee;
  final String paymentMethod;

  Order({
    required this.id,
    required this.status,
    required this.storeName,
    required this.code,
    required this.progress,
    required this.placedAt,
    required this.items,
    required this.timeline,
    required this.deliveryFee,
    required this.paymentMethod,
  });
}

class OrderItem {
  final String name;
  final double price;
  final int quantity;

  OrderItem({required this.name, required this.price, required this.quantity});
}

class OrderTimelineStep {
  final String title;
  final DateTime time;
  final String? description;
  final bool isCompleted;
  final bool isCurrent;

  OrderTimelineStep({
    required this.title,
    required this.time,
    this.description,
    this.isCompleted = false,
    this.isCurrent = false,
  });
}
