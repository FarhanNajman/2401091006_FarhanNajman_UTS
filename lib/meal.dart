class Meal {
  final String id;
  final String name;
  final String thumb;
  final String? category;
  final String? area;
  final String? instructions;
  final Map<String, String> ingredients;

  Meal({
    required this.id,
    required this.name,
    required this.thumb,
    this.category,
    this.area,
    this.instructions,
    required this.ingredients,
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    Map<String, String> ingredients = {};

    for (int i = 1; i <= 20; i++) {
      var ing = json['strIngredient$i'];
      var meas = json['strMeasure$i'];

      if (ing != null && ing.toString().isNotEmpty) {
        ingredients[ing] = meas ?? "";
      }
    }

    return Meal(
      id: json['idMeal'],
      name: json['strMeal'],
      thumb: json['strMealThumb'],
      category: json['strCategory'],
      area: json['strArea'],
      instructions: json['strInstructions'],
      ingredients: ingredients,
    );
  }
}