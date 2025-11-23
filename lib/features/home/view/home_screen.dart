import 'package:flutter/material.dart';

// Impor kustom Anda (SAYA TIDAK MENGUBAH INI)
import '../../../constants/app_colors.dart'; // For kPrimaryBlue
import '../../../shared_widgets/its_logo.dart'; // For the logo
import 'widgets/service_card.dart'; // For the ServiceCard

// Impor file API service kita yang baru
import '../../../services/api_service.dart'; // <- SESUAIKAN PATH INI

// --- MODIFIKASI DIMULAI DI SINI ---
// 1. Ubah dari StatelessWidget menjadi StatefulWidget
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // 2. Tambahkan state variables
  final TextEditingController _searchController = TextEditingController();
  bool _isLoading = false;
  List<dynamic> _results = []; // List untuk menampung hasil JSON
  String? _error;
  bool _isSearchActive = false; // Untuk tahu kapan harus menampilkan hasil

  // --- 3. Tambahkan Fungsi Panggilan API (sekarang lebih bersih) ---
  Future<void> _searchServices(String query) async {
    // Jika kueri kosong, reset ke tampilan awal
    if (query.isEmpty) {
      setState(() {
        _isSearchActive = false;
        _results = [];
        _error = null;
      });
      return;
    }

    // Mulai loading
    setState(() {
      _isLoading = true;
      _isSearchActive = true; // Kita sedang dalam mode pencarian
      _error = null;
    });

    try {
      // Panggil logic dari file terpisah
      final List<dynamic> apiResults = await ApiService.searchServices(query);
      
      // Sukses: simpan hasil
      setState(() {
        _results = apiResults;
      });
    } catch (e) {
      // Gagal: simpan pesan error
      setState(() {
        _error = e.toString();
      });
    } finally {
      // Selesai: matikan loading
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryBlue,
        elevation: 0,
        // --- 4. Hubungkan TextField ke Controller & Fungsi API ---
        title: TextField(
          controller: _searchController, // Hubungkan controller
          style: const TextStyle(color: Colors.white), // Teks input jadi putih
          decoration: InputDecoration(
            hintText: 'Find what you need (mis: "website murah")',
            hintStyle: const TextStyle(color: Colors.white70),
            prefixIcon: const Icon(Icons.search, color: Colors.white),
            filled: true,
            fillColor: Colors.white.withOpacity(0.2),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            // Tambahkan tombol 'clear'
            suffixIcon: _searchController.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear, color: Colors.white),
                    onPressed: () {
                      _searchController.clear();
                      _searchServices(""); // Kirim kueri kosong untuk reset
                    },
                  )
                : null,
          ),
          onSubmitted:
              _searchServices, // Panggil API saat pengguna menekan 'Enter'
          onChanged: (value) {
            // Update UI tombol clear (hanya me-refresh state)
            setState(() {});
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_outlined,
                color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      backgroundColor: Colors.grey[50],
      // --- 5. Ganti Body untuk Menampilkan Hasil Pencarian ---
      body: _isLoading
          ? const Center(
              child:
                  CircularProgressIndicator()) // Tampilkan loading di tengah
          : _isSearchActive
              ? _buildResultsBody() // Tampilkan hasil pencarian
              : _buildDefaultBody(), // Tampilkan body asli (logo, kategori, dll)
    );
  }

  // Ini adalah body asli Anda, dibungkus dalam sebuah fungsi
  Widget _buildDefaultBody() {
    // Semua spasi ilegal (non-breaking spaces) telah dihapus dari sini.
    return ListView(
      // The ListView needs to start from the top
      padding: EdgeInsets.zero,
      children: [
        // --- 1. SEPARATE BLUE LOGO BLOCK ---
        Container(
          color: kPrimaryBlue,
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: ItsLogo(
              color: Colors.white,
              size: 64, // You can adjust this size
            ),
          ),
        ),

        // --- 2. SEPARATE WHITE CATEGORY BLOCK ---
        Container(
          padding: const EdgeInsets.all(16.0),
          color: Colors.white, // White background for this section
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // Call the "inverted" helper
                  _buildInvertedCategoryIcon(
                      Icons.phone_android, 'PC Service'),
                  _buildInvertedCategoryIcon(Icons.computer, 'Laptop/PC'),
                  _buildInvertedCategoryIcon(Icons.code, 'Web Dev'),
                  _buildInvertedCategoryIcon(Icons.brush, 'Design'),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildInvertedCategoryIcon(
                      Icons.support_agent, 'IT Consult'),
                  _buildInvertedCategoryIcon(Icons.cloud, 'Cloud'),
                  _buildInvertedCategoryIcon(Icons.security, 'Cyber'),
                  _buildInvertedCategoryIcon(Icons.grid_view, 'View All'),
                ],
              ),
            ],
          ),
        ),
        
        const SizedBox(height: 10), // Small spacer

        // --- 3. RECOMMENDATION LIST ---
        Container(
          color: Colors.white, // White background for this section
          padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
          child: Text(
            'Recomendation',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),

        // Service Cards will sit on the grey[50] background
        ServiceCard(
          title: 'Buana Phone Service',
          specialty: 'Specialty in phone service',
          price: 'Rp 50.000',
          rating: '5',
          isOpen: true,
          onTap: () {
            Navigator.pushNamed(context, '/service_detail');
          },
        ), // <-- Typo _), sudah diperbaiki di sini
        ServiceCard(
          title: 'Another Service',
          specialty: 'Web design',
          price: 'Rp 150.000',
          rating: '4.8',
          isOpen: false,
          onTap: () {}, // <-- Typo : () {}, sudah diperbaiki di sini
        ),
      ],
    );
  }

  // --- 6. Tambahkan Widget untuk Menampilkan Hasil Pencarian ---
  Widget _buildResultsBody() {
    // Tampilkan error jika ada
    if (_error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            // Tampilkan pesan error dari API Service
            _error!,
            style: const TextStyle(color: Colors.red, fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    // Tampilkan jika hasil kosong
    if (_results.isEmpty) {
      return const Center(child: Text("Tidak ada hasil ditemukan."));
    }

    // Tampilkan hasil dalam ListView
    return ListView.builder(
      padding: const EdgeInsets.all(8.0), // Beri sedikit padding
      itemCount: _results.length,
      itemBuilder: (context, index) {
        final item = _results[index];
        
        // Menggunakan ServiceCard custom Anda, tapi dengan data dari API
        return ServiceCard(
          // Ambil data dari JSON 'item'
          title: item['NamaJasa'] ?? 'Tanpa Judul',
          specialty: (item['DeskripsiJasa'] as String).length > 50
              ? (item['DeskripsiJasa'] as String).substring(0, 50) + '...'
              : item['DeskripsiJasa'],
          price: 'Rp ${item['HargaMulai']}',
          rating: (item['RatingRataRata'] ?? 0.0).toString(),
          isOpen: true, // Anda perlu menambahkan data ini di API jika ada
          onTap: () {
            // Arahkan ke halaman detail dengan JasaID
            // Navigator.pushNamed(context, '/service_detail', arguments: item['JasaID']);
            print("Tapped on JasaID: ${item['JasaID']}");
          },
        );
      },
    );
  }

  // --- Ini adalah helper widget asli Anda ---
  Widget _buildInvertedCategoryIcon(IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: kPrimaryBlue.withOpacity(0.05), // Very light blue
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: kPrimaryBlue, size: 30), // Blue icon
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(color: Colors.black87, fontSize: 12), // Dark text
        ),
      ],
    );
  }
}