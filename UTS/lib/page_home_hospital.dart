import 'package:flutter/material.dart';
import 'hospital.dart';
import 'page_detail_hospital.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class PageHomeHospital extends StatefulWidget {
  const PageHomeHospital({super.key});

  @override
  State<PageHomeHospital> createState() => _PageHomeHospitalState();
}

class _PageHomeHospitalState extends State<PageHomeHospital> {
  List<Hospital> hospitals = [];
  List<Hospital> filtered = [];
  bool isGrid = false; // default ListView

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    try {
      String jsonString = await rootBundle.loadString('assets/hospital.json');
      List<dynamic> jsonData = jsonDecode(jsonString);

      setState(() {
        hospitals = jsonData.map((e) => Hospital.fromJson(e)).toList();
        filtered = hospitals;
      });
    } catch (e) {
      debugPrint("Error load JSON: $e");
    }
  }

  void searchHospital(String query) {
    setState(() {
      if (query.isEmpty) {
        filtered = hospitals;
      } else {
        filtered = hospitals
            .where((h) =>
            h.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Explore Rumah Sakit Padang"),
        backgroundColor: Colors.orange,
        actions: [
          IconButton(
            icon: Icon(isGrid ? Icons.list : Icons.grid_view),
            onPressed: () {
              setState(() {
                isGrid = !isGrid; // toggle state
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Cari Rumah Sakit...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
              ),
              onChanged: searchHospital,
            ),
          ),
          // List/Grid hospitals
          Expanded(
            child: filtered.isEmpty
                ? const Center(child: Text("Data tidak ditemukan"))
                : isGrid
                ? GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: filtered.length,
              itemBuilder: (context, index) {
                final hospital = filtered[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            PageDetailHospital(hospital: hospital),
                      ),
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Image.asset(
                          hospital.image,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        hospital.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        hospital.desc,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                );
              },
            )
                : ListView.builder(
              itemCount: filtered.length,
              itemBuilder: (context, index) {
                final hospital = filtered[index];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              PageDetailHospital(hospital: hospital),
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          hospital.image,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 180,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            hospital.name,
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 4.0),
                          child: Text(hospital.desc),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
