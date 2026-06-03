class MealItem {
  final String id;
  final String name;
  final String price;
  final String description;
  final String? image1;
  final String? image2;
  final String? image3;
  final String category;
  final String quantity;
  final List<String> mainIngredients;
  final List<String> extraIngredients;

  const MealItem({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    this.image1,
    this.image2,
    this.image3,
    required this.category,
    required this.quantity,
    required this.mainIngredients,
    required this.extraIngredients,
  });

  MealItem copyWith({
    String? id,
    String? name,
    String? price,
    String? description,
    String? image1,
    String? image2,
    String? image3,
    String? category,
    String? quantity,
    List<String>? mainIngredients,
    List<String>? extraIngredients,
  }) {
    return MealItem(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      description: description ?? this.description,
      image1: image1 ?? this.image1,
      image2: image2 ?? this.image2,
      image3: image3 ?? this.image3,
      category: category ?? this.category,
      quantity: quantity ?? this.quantity,
      mainIngredients: mainIngredients ?? this.mainIngredients,
      extraIngredients: extraIngredients ?? this.extraIngredients,
    );
  }
}
