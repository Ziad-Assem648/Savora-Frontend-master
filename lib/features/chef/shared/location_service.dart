import 'package:flutter/material.dart';

class LocationService extends StatelessWidget {
  const LocationService({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFD05024),
        foregroundColor: Colors.white,
        title: const Text('تحديد الموقع', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.location_on, size: 80, color: Color(0xFFD05024)),
            SizedBox(height: 20),
            Text(
              'حدد موقعك على الخريطة',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'هذه الميزة ستكون متاحة قريباً',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

