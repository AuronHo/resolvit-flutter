import 'package:flutter/material.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  // --- CONTROLLERS ---
  // These hold the text you are editing
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    // Initialize with existing data
    _nameController = TextEditingController(text: "Buana Phone Service");
    _emailController = TextEditingController(text: "sule123@gmail.com");
    _phoneController = TextEditingController(text: "0895712544455");
  }

  @override
  void dispose() {
    // Clean up to prevent memory leaks
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color brandBlue = Color(0xFF4981FB);

    return Scaffold(
      backgroundColor: Colors.white,
      
      // --- APP BAR ---
      appBar: AppBar(
        backgroundColor: brandBlue,
        elevation: 0,
        centerTitle: true,
        // Force White Icons & Text
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(
          color: Colors.white, 
          fontWeight: FontWeight.bold, 
          fontSize: 18
        ),
        
        // Back Button
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Standard Pop
            Navigator.of(context).pop();
          },
        ),
        
        title: const Text('Edit Profile'),
        
        // Save Button
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Center(
              child: SizedBox(
                height: 32,
                child: ElevatedButton(
                  onPressed: () {
                    // Logic to Save Data would go here
                    
                    // Go Back
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: brandBlue,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                  child: const Text("Save", style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          )
        ],
        // Rounded Bottom
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
        ),
      ),
      
      // --- BODY ---
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            // 1. IMAGE PICKER SECTION
            _buildProfileImage(),

            const SizedBox(height: 30),
            const Divider(height: 1, thickness: 1, color: Colors.grey),

            // 2. INPUT FIELDS
            _buildInputRow("Business Name*", _nameController),
            _buildInputRow("Email*", _emailController),
            _buildInputRow("Phone Number*", _phoneController),
          ],
        ),
      ),
    );
  }

  // --- WIDGET: IMAGE PICKER ---
  Widget _buildProfileImage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Row(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              // Avatar
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[300],
                  image: const DecorationImage(
                    image: NetworkImage('https://via.placeholder.com/150'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Dark Overlay with Text
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black.withOpacity(0.4),
                ),
                alignment: Alignment.center,
                child: const Text(
                  "Change",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 20),
          const Text(
            "Put your best picture!",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
        ],
      ),
    );
  }

  // --- WIDGET: SIMPLE INPUT ROW ---
  Widget _buildInputRow(String label, TextEditingController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
      decoration: const BoxDecoration(
        // Bottom border line separator
        border: Border(bottom: BorderSide(color: Colors.grey, width: 0.5)),
      ),
      child: Row(
        children: [
          // LABEL (Fixed Width to align nicely)
          SizedBox(
            width: 140, 
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.black,
              ),
            ),
          ),
          
          // INPUT FIELD
          Expanded(
            child: TextField(
              controller: controller,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black54, // Dark Grey text
              ),
              decoration: const InputDecoration(
                border: InputBorder.none, // No border box, just the text
                contentPadding: EdgeInsets.symmetric(vertical: 14),
                isDense: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}