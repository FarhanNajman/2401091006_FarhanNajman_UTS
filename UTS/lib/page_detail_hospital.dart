import 'package:flutter/material.dart';
import 'hospital.dart';

class PageDetailHospital extends StatelessWidget {
  final Hospital hospital;

  const PageDetailHospital({super.key, required this.hospital});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(hospital.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(hospital.image, fit: BoxFit.cover),
            const SizedBox(height: 16),
            Text(
              hospital.name,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              hospital.desc,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
