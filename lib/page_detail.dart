import 'package:flutter/material.dart';
import 'meal_service.dart';
import 'meal.dart';

class PageDetail extends StatefulWidget {
  final String id;

  PageDetail({required this.id});

  @override
  _PageDetailState createState() => _PageDetailState();
}

class _PageDetailState extends State<PageDetail> {
  final service = MealService();
  late Future<Meal> meal;

  @override
  void initState() {
    super.initState();
    meal = service.getDetail(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detail Masakan")),
      body: FutureBuilder<Meal>(
        future: meal,
        builder: (context, snapshot) {

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          final data = snapshot.data!;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🔥 GAMBAR BESAR
                Image.network(
                  data.thumb,
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                ),

                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    data.name,
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text("Kategori: ${data.category}"),
                ),

                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text("Asal: ${data.area}"),
                ),

                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text("Bahan:",
                      style:
                      TextStyle(fontWeight: FontWeight.bold)),
                ),

                ...data.ingredients.entries.map((e) => Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text("${e.key} - ${e.value}"),
                )),

                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text("Instruksi:",
                      style:
                      TextStyle(fontWeight: FontWeight.bold)),
                ),

                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(data.instructions ?? ""),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}