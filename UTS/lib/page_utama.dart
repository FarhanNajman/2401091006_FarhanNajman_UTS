import 'package:flutter/material.dart';
import 'page_home_hospital.dart';
import 'page_maps.dart';

class PageUtamaHospital extends StatelessWidget {
  const PageUtamaHospital({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Menu Utama"),
        backgroundColor: Colors.orange,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Tombol daftar RS
            SizedBox(
              width: 200,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  textStyle: const TextStyle(fontSize: 16),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const PageHomeHospital()),
                  );
                },
                child: const Text("Daftar Rumah Sakit"),
              ),
            ),
            const SizedBox(height: 20),
            // Tombol peta RS
            SizedBox(
              width: 200,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  textStyle: const TextStyle(fontSize: 16),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const PageMainMaps()),
                  );
                },
                child: const Text("Lihat Peta"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
