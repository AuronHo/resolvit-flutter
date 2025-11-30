import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../main_navigation/logic/theme_controller.dart'; 


class VerificationCodeScreen extends StatefulWidget {
  const VerificationCodeScreen({super.key});

  @override
  State<VerificationCodeScreen> createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
  // Controller untuk 5 kotak
  final List<TextEditingController> _controllers = List.generate(5, (index) => TextEditingController());
  
  // FocusNode untuk mengatur perpindahan fokus keyboard
  final List<FocusNode> _focusNodes = List.generate(5, (index) => FocusNode());

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeController = context.watch<ThemeController>();
    final isDark = themeController.isDarkMode;

    final Color dynamicTextColor = isDark ? Colors.white : Colors.black;
    const Color buttonColor = Color(0xFF4981FB); 

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: dynamicTextColor),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: isDark
                ? [const Color(0xFF0F2027), const Color(0xFF2C5364)] 
                : [
                    const Color(0xFFFFFFFF), 
                    const Color(0xFF9BBAFD), 
                    const Color(0xFF3573FA), 
                  ],
            stops: isDark ? null : [0.0, 0.5, 1.0], 
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                
                Center(
                  child: Text(
                    'Reset Password',
                    style: TextStyle(
                      fontSize: 24, 
                      fontWeight: FontWeight.bold,
                      color: dynamicTextColor,
                    ),
                  ),
                ),
                
                const SizedBox(height: 40),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Code',
                      style: TextStyle(fontWeight: FontWeight.bold, color: dynamicTextColor),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Resend code',
                        style: TextStyle(color: Color(0xFF3573FA), fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                
                // --- 5 KOTAK KODE (FIXED) ---
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(5, (index) {
                    return Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          )
                        ],
                      ),
                      child: TextField(
                        controller: _controllers[index],
                        focusNode: _focusNodes[index], // Pasang FocusNode
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        // Pastikan warna teks HITAM agar terlihat di kotak putih
                        style: const TextStyle(
                          fontSize: 24, 
                          fontWeight: FontWeight.bold, 
                          color: Colors.black
                        ),
                        decoration: const InputDecoration(
                          counterText: "",
                          border: InputBorder.none,
                          // --- INI PERBAIKANNYA ---
                          // Mengatur padding vertikal agar angka pas di tengah
                          contentPadding: EdgeInsets.symmetric(vertical: 12), 
                        ),
                        onChanged: (value) {
                          // Logic Pindah Fokus Otomatis
                          if (value.isNotEmpty) {
                            // Jika sudah diisi, pindah ke kotak berikutnya
                            if (index < 4) {
                              FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
                            } else {
                              // Jika kotak terakhir, hilangkan keyboard
                              FocusScope.of(context).unfocus();
                            }
                          } else if (value.isEmpty) {
                            // Jika dihapus, mundur ke kotak sebelumnya
                            if (index > 0) {
                              FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
                            }
                          }
                        },
                      ),
                    );
                  }),
                ),

                const SizedBox(height: 16),
                Text(
                  'Enter the code that we sent',
                  style: TextStyle(color: isDark ? Colors.grey[400] : Colors.grey[700]),
                ),

                const SizedBox(height: 30),

                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/new_password');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
                    foregroundColor: Colors.white,
                    elevation: 2,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    minimumSize: const Size(double.infinity, 55),
                  ),
                  child: const Text('Next', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}