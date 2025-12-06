import 'package:flutter/material.dart';
import '../../home/view/widgets/service_card.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({super.key});

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  // --- DATA DUMMY SERVICE YANG DISIMPAN ---
  // Ceritanya user sudah like/bookmark toko-toko ini
  final List<Map<String, dynamic>> _savedServices = [
    {
      'title': 'Mitra Komputer',
      'specialty': 'Laptop & PC Repair',
      'price': 'Rp 75.000',
      'rating': '4.8',
      'isOpen': true,
    },
    {
      'title': 'Klinik Gadget',
      'specialty': 'Speciality in phone service',
      'price': 'Rp 50.000',
      'rating': '4.7',
      'isOpen': true,
    },
    {
      'title': 'Ahli Data Recovery',
      'specialty': 'Mengembalikan data hilang',
      'price': 'Rp 200.000',
      'rating': '5',
      'isOpen': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Warna Biru Branding
    const Color brandBlue = Color(0xFF4981FB);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // Background abu muda
      body: Column(
        children: [
          // --- HEADER SECTION ---
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(
              top: 60,
              left: 24,
              right: 24,
              bottom: 20,
            ),
            decoration: const BoxDecoration(
              color: brandBlue,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Saved Services',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Your favorite workshops',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),

          // --- LIST DATA YANG DISIMPAN ---
          Expanded(
            child: _savedServices.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.bookmark_border,
                          size: 60,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "No saved services yet",
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.only(top: 20),
                    itemCount: _savedServices.length,
                    itemBuilder: (context, index) {
                      final item = _savedServices[index];

                      // Menggunakan Widget ServiceCard yang sama dengan Home
                      return ServiceCard(
                        title: item['title'],
                        specialty: item['specialty'],
                        price: item['price'],
                        rating: item['rating'],
                        isOpen: item['isOpen'],
                        // Ketika diklik tetap arahkan ke detail
                        onTap: () {
                          Navigator.pushNamed(context, '/service_detail');
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
