import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // --- ALAMAT IP SERVER ANDA ---
  // Gunakan '10.0.2.2' jika menjalankan di Android Emulator
  // Gunakan '127.0.0.1' jika menjalankan di iOS Simulator atau Web/Desktop
  static const String _baseUrl = "http://10.0.2.2:8000";

  // --- FUNGSI PENCARIAN UTAMA ---
  // Fungsi ini dipanggil dari UI (HomeScreen)
  static Future<List<dynamic>> searchServices(String query) async {
    // Buat URL yang lengkap dan aman
    final Uri apiUrl =
        Uri.parse('$_baseUrl/search?query=${Uri.encodeComponent(query)}');

    try {
      // 1. Kirim permintaan GET ke server
      final response = await http.get(apiUrl).timeout(const Duration(seconds: 15));

      // 2. Periksa apakah server merespons dengan sukses
      if (response.statusCode == 200) {
        // 3. Ubah (decode) data JSON dari server
        final data = json.decode(response.body);
        
        // 4. Kembalikan hanya list 'results'-nya
        if (data['results'] is List) {
          return data['results'] as List<dynamic>;
        } else {
          // Jika 'results' tidak ada atau bukan list
          throw Exception('Format data tidak terduga dari server');
        }
      } else {
        // Jika server memberikan error (misal: 500, 404)
        throw Exception('Server error: ${response.statusCode}');
      }
    } catch (e) {
      // Jika koneksi gagal (timeout, server mati, tidak ada internet)
      // Kita lempar error agar UI bisa menampilkannya
      throw Exception('Koneksi ke server gagal. Pastikan server API berjalan.\n$e');
    }
  }
}