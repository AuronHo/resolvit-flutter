import 'package:flutter/material.dart';

class EditBusinessDetailsScreen extends StatefulWidget {
  const EditBusinessDetailsScreen({super.key});

  @override
  State<EditBusinessDetailsScreen> createState() => _EditBusinessDetailsScreenState();
}

class _EditBusinessDetailsScreenState extends State<EditBusinessDetailsScreen> {
  // Controllers
  final TextEditingController _specialityController = TextEditingController(text: "phone service");
  final TextEditingController _priceController = TextEditingController(text: "50.000");
  final TextEditingController _descController = TextEditingController(text: "perbaiki hp di sini ajah");
  final TextEditingController _locationController = TextEditingController(text: "Lucky plaza, Jl. Imam Bonjol...");

  // Toggles
  final Map<String, bool> _operationalDays = {
    'Monday': true, 'Tuesday': true, 'Wednesday': true,
    'Thursday': true, 'Friday': true, 'Saturday': true, 'Sunday': false,
  };

  @override
  void dispose() {
    _specialityController.dispose();
    _priceController.dispose();
    _descController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color brandBlue = Color(0xFF4981FB);
    // Get screen width to calculate responsive label width
    final double screenWidth = MediaQuery.of(context).size.width;
    // Label takes 30% of screen, Input takes rest
    final double labelWidth = screenWidth * 0.30; 

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true, // Allow scrolling when keyboard opens
        
        appBar: AppBar(
          backgroundColor: brandBlue,
          elevation: 0,
          centerTitle: true,
          iconTheme: const IconThemeData(color: Colors.white),
          titleTextStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              FocusScope.of(context).unfocus();
              Navigator.pop(context);
            },
          ),
          
          title: const Text('Edit details'),
          
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Center(
                child: SizedBox(
                  height: 32,
                  child: ElevatedButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: brandBlue,
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                    child: const Text("Save", style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            )
          ],
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
          ),
        ),
        
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.only(bottom: 100, top: 10),
            children: [
              // 1. Speciality
              _buildFormRow(labelWidth, 'Speciality*', _buildGreyInput(controller: _specialityController)),
              
              // 2. Price Range
              _buildFormRow(labelWidth, 'Price Range*', Row(
                children: [
                  const Text("Start from Rp ", style: TextStyle(fontSize: 12, color: Colors.black87)),
                  const SizedBox(width: 8),
                  Expanded(child: _buildGreyInput(controller: _priceController)),
                ],
              )),
              
              // 3. Description
              _buildFormRow(labelWidth, 'Description*', _buildGreyInput(controller: _descController, maxLines: 4)),

              // 4. Operational Hours
              _buildFormRow(
                labelWidth,
                'Operational hours*',
                Column(
                  children: _operationalDays.keys.map((day) {
                    return _buildDayRow(day);
                  }).toList(),
                ),
              ),

              // 5. Location
              _buildFormRow(
                labelWidth,
                'Set Location*',
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(child: Icon(Icons.location_on, color: Colors.red, size: 30)),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildGreyInput(controller: _locationController, maxLines: 3),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- HELPER 1: ROW STRUCTURE ---
  Widget _buildFormRow(double labelWidth, String label, Widget content) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade200, width: 1)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label with Responsive Width
          SizedBox(
            width: labelWidth,
            child: Text(
              label, 
              style: const TextStyle(fontSize: 13, color: Colors.black87, fontWeight: FontWeight.w500)
            ),
          ),
          // Content fills the rest
          Expanded(child: content),
        ],
      ),
    );
  }

  // --- HELPER 2: SAFE INPUT (NO CONTAINER WRAPPER) ---
  // We removed the Container wrapper. The TextField handles its own background.
  // This is the cleanest way to avoid layout crashes.
  Widget _buildGreyInput({int maxLines = 1, required TextEditingController controller}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: const TextStyle(fontSize: 13, color: Colors.black),
      decoration: InputDecoration(
        isDense: true, 
        filled: true,
        fillColor: const Color(0xFFF0F0F0), // Grey Background
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  // --- HELPER 3: TIME INPUT ---
  // Small inputs for the hours
  Widget _buildTimeInput(String initialValue) {
    return TextField(
      controller: TextEditingController(text: initialValue),
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 12, color: Colors.black),
      decoration: InputDecoration(
        isDense: true,
        filled: true,
        fillColor: const Color(0xFFF0F0F0),
        contentPadding: const EdgeInsets.symmetric(vertical: 8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildDayRow(String day) {
    bool isOpen = _operationalDays[day]!;
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          // Toggle
          SizedBox(
            width: 30,
            height: 20,
            child: Transform.scale(
              scale: 0.7,
              child: Switch(
                value: isOpen, 
                activeColor: const Color(0xFF4CAF50),
                inactiveThumbColor: const Color(0xFFFF3B30),
                inactiveTrackColor: const Color(0xFFFF3B30).withOpacity(0.3),
                trackOutlineColor: MaterialStateProperty.all(Colors.transparent),
                onChanged: (val) {
                  setState(() {
                    _operationalDays[day] = val;
                  });
                },
              ),
            ),
          ),
          const SizedBox(width: 8),
          
          // Day Name (Responsive: Uses Expanded to push inputs to the right)
          Expanded(
            flex: 2,
            child: Text(day, style: const TextStyle(fontSize: 11, color: Colors.black87))
          ),
          
          // Time Inputs or Closed Text
          if (isOpen) ...[
            Expanded(flex: 3, child: _buildTimeInput("08:00")),
            const Padding(padding: EdgeInsets.symmetric(horizontal: 4.0), child: Text("-", style: TextStyle(fontSize: 10))),
            Expanded(flex: 3, child: _buildTimeInput("22:00")),
          ] else 
            const Expanded(flex: 6, child: Text("Closed", style: TextStyle(fontSize: 11, color: Colors.grey))),
        ],
      ),
    );
  }
}