import 'package:flutter/material.dart';
import 'meal_service.dart';
import 'meal.dart';
import 'page_detail.dart';

class PageHome extends StatefulWidget {
  @override
  _PageHomeState createState() => _PageHomeState();
}
class _PageHomeState extends State<PageHome> {
  final service = MealService();
  final TextEditingController controller = TextEditingController();

  List<Meal> meals = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    searchMeal("chicken");
  }

  void searchMeal(String value) async {
    if (value.trim().isEmpty) {
      value = "chicken";
    }

    setState(() {
      isLoading = true;
    });

    try {
      final result = await service.searchMeal(value);
      setState(() {
        meals = result;
      });
    } catch (e) {
      meals = [];
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Masakan"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,

                    onSubmitted: searchMeal,

                    onChanged: (value) {
                      if (value.isEmpty) {
                        searchMeal("chicken");
                      }},
                    decoration: InputDecoration(
                      hintText: "Cari makanan...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 10),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.search, color: Colors.white),
                    onPressed: () {
                      searchMeal(controller.text);
                    },
                  ),)],
            ),),
          if (isLoading)
            Padding(padding: EdgeInsets.all(10),
              child: CircularProgressIndicator(),
            ),
          Expanded(
            child: GridView.builder(
              padding:
              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1.1,
              ),
              itemCount: meals.length,
              itemBuilder: (context, index) {
                final meal = meals[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            PageDetail(id: meal.id),
                      ),
                    );
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(8),
                    ),
                    elevation: 2,
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [

                        ClipRRect(
                          borderRadius:
                          BorderRadius.vertical(
                            top: Radius.circular(12),
                          ),
                          child: Image.network(
                            meal.thumb,
                            height: 300,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),),

                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            meal.name,
                            maxLines: 2,
                            overflow:
                            TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight:
                              FontWeight.bold,
                              fontSize: 25,
                            ),
                          ),),

                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8),
                          child: Text(
                            meal.area ?? "",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 18,
                            ),
                          ),),
                      ],),),
                );},
            ),
          ),],),
    );}
}