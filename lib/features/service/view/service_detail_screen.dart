import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart';
import 'view_details_screen.dart';

class ServiceDetailScreen extends StatefulWidget {
  const ServiceDetailScreen({super.key});

  @override
  State<ServiceDetailScreen> createState() => _ServiceDetailScreenState();
}

class _ServiceDetailScreenState extends State<ServiceDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Warna biru spesifik sesuai request sebelumnya
    const Color brandBlue = Color(0xFF3573FA); // Atau kPrimaryBlue

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // Background abu sangat muda
      appBar: AppBar(
        backgroundColor: brandBlue,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Buana Phone Service',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // --- BAGIAN ATAS (BANNER + INFO CARD) ---
            Stack(
              clipBehavior: Clip.none,
              children: [
                // 1. Background Biru & Gambar Banner
                Container(
                  height: 180,
                  width: double.infinity,
                  color: brandBlue, // Dasar biru
                  child: Stack(
                    children: [
                      // Placeholder Gambar Toko (Banner)
                      // Ganti Image.asset(...) dengan gambar toko asli Anda
                      Opacity(
                        opacity:
                            0.3, // Dibuat agak transparan agar teks terbaca
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          color: Colors.black, // Placeholder warna gelap
                          // child: Image.asset('assets/images/banner_toko.png', fit: BoxFit.cover),
                        ),
                      ),
                    ],
                  ),
                ),

                // 2. Kartu Putih Melayang (Floating Card)
                Container(
                  margin: const EdgeInsets.fromLTRB(
                    20,
                    100,
                    20,
                    0,
                  ), // Margin atas 100 agar menumpuk banner
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Avatar Toko (Bulat)
                          CircleAvatar(
                            radius: 35,
                            backgroundColor: Colors.grey[300],
                            // backgroundImage: AssetImage('assets/images/toko_avatar.png'),
                            child: const Icon(
                              Icons.store,
                              size: 30,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(width: 16),
                          // Info Teks
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Buana Phone Service',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: const [
                                    Text(
                                      '5',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 16,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Speciality in phone service',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  'Price start from Rp 50.000',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  'Open (08:00 - 22:00)',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Tombol Chat & View Details
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(
                                  0xFF4981FB,
                                ), // Biru terang
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: const Text('Chat Now'),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {
                                // --- TAMBAHKAN NAVIGASI INI ---
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ViewDetailsScreen(),
                                  ),
                                );
                              },
                              style: OutlinedButton.styleFrom(
                                foregroundColor: const Color(0xFF4981FB),
                                side: const BorderSide(
                                  color: Color(0xFF4981FB),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: const Text('View Details'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // --- TAB BAR (Portofolio / Review) ---
            Container(
              color: Colors.white,
              child: TabBar(
                controller: _tabController,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                indicatorColor: brandBlue,
                indicatorWeight: 3,
                tabs: const [
                  Tab(text: 'Portofolio'),
                  Tab(text: 'Review'),
                ],
              ),
            ),

            // --- ISI KONTEN (Portofolio Dummy) ---
            // Kita gunakan logic sederhana: Jika tab 0 tampilkan portofolio, jika 1 tampilkan review
            // Karena ini di dalam SingleScrollView, kita gunakan AnimatedBuilder/Listener atau hanya widget statis.
            // Untuk simplifikasi tampilan "Dummy" sesuai gambar, saya langsung render list portofolio.
            ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true, // Agar bisa di dalam SingleChildScrollView
              physics:
                  const NeverScrollableScrollPhysics(), // Scroll ikut parent
              itemCount: 2, // Dummy 2 item sesuai gambar
              itemBuilder: (context, index) {
                return _buildPortfolioItem(index);
              },
            ),

            const SizedBox(height: 100), // Padding bawah untuk bottom bar
          ],
        ),
      ),

      // --- VISUAL BOTTOM BAR (Sesuai Gambar) ---
      // Biasanya halaman detail tidak ada bottom bar, tapi karena di gambar ada,
      // kita pasang widget visualnya saja (tanpa fungsi navigasi kompleks).
      bottomNavigationBar: Container(
        margin: const EdgeInsets.fromLTRB(24, 0, 24, 20),
        decoration: BoxDecoration(
          color: const Color(0xFF4981FB),
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: BottomNavigationBar(
            backgroundColor: const Color(0xFF4981FB),
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white.withOpacity(0.6),
            showSelectedLabels: true,
            showUnselectedLabels: true,
            selectedFontSize: 10,
            unselectedFontSize: 10,
            elevation: 0,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_filled),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.chat_bubble_outline),
                label: 'Chat',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.bookmark),
                label: 'Saved',
              ), // Saved aktif/ikon bookmark
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                label: 'Profile',
              ),
            ],
            currentIndex: 0, // Dummy index
            onTap: (val) {
              // Di aplikasi nyata, kita akan pop halaman ini dan ganti index di main shell
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }

  // --- WIDGET ITEM PORTOFOLIO DUMMY ---
  Widget _buildPortfolioItem(int index) {
    // Data dummy berbeda sedikit untuk tiap item
    final String time = index == 0 ? '1d' : '2d';
    final String caption = index == 0
        ? 'Professional work'
        : 'HP rusak? Konsul disini aja duluh';

    return Container(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Post (Avatar, Nama, Waktu)
          Row(
            children: [
              const CircleAvatar(
                radius: 20,
                backgroundColor: Colors.grey,
                child: Icon(Icons.store, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Buana Phone Service',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      time,
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.more_vert, color: Colors.grey),
            ],
          ),
          const SizedBox(height: 10),

          // Caption
          Text(caption),
          const SizedBox(height: 10),

          // Gambar Pekerjaan (Placeholder)
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
              image: const DecorationImage(
                // Ganti dengan aset gambar portofolio Anda
                // image: AssetImage('assets/images/portfolio1.png'),
                image: NetworkImage(
                  'https://via.placeholder.com/400x200',
                ), // Placeholder online
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
