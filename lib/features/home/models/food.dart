import 'addon.dart';

class Food {
  final String image;
  final String name;
  final String description;
  final int price;
  final double rating;
  final List<Addon> extras;
  final List<Addon> drinks;

  Food({
    required this.image,
    required this.name,
    required this.description,
    required this.price,
    required this.rating,
    this.extras = const [],
    this.drinks = const [],
  });
}
