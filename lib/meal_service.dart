import 'dart:convert';
import 'package:http/http.dart' as http;
import 'meal.dart';

class MealService {
  final String baseUrl = "https://www.themealdb.com/api/json/v1/1";

  Future<List<Meal>> searchMeal(String keyword) async {
    if (keyword.isEmpty) return [];

    final response =
    await http.get(Uri.parse("$baseUrl/search.php?s=$keyword"));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data['meals'] == null) return [];

      return (data['meals'] as List)
          .map((e) => Meal.fromJson(e))
          .toList();
    } else {
      throw Exception("Gagal search");
    }
  }

  Future<Meal> getDetail(String id) async {
    final response =
    await http.get(Uri.parse("$baseUrl/lookup.php?i=$id"));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Meal.fromJson(data['meals'][0]);
    } else {
      throw Exception("Gagal ambil detail");
    }
  }
}