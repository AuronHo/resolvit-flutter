import 'package:flutter/material.dart';
import '../../../constants/app_colors.dart'; // For kPrimaryBlue

class ServiceDetailScreen extends StatefulWidget {
  const ServiceDetailScreen({super.key});

  @override
  State<ServiceDetailScreen> createState() => _ServiceDetailScreenState();
}

// We need a TickerProvider for the TabController animation
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Buana Phone Service'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        actions: [
          IconButton(icon: Icon(Icons.bookmark_border), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          // Top Info Card
          _buildInfoCard(context),
          
          // Tab Bar (Portfolio / Review)
          TabBar(
            controller: _tabController,
            labelColor: kPrimaryBlue,
            unselectedLabelColor: Colors.grey,
            tabs: const [
              Tab(text: 'Portofolio'),
              Tab(text: 'Review'),
            ],
          ),
          
          // Tab Bar View (The Content)
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Screen 116: Portfolio Tab
                _buildPortfolioTab(),
                // Screen 117: Review Tab
                _buildReviewTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- Helper Widgets for this Screen ---

  Widget _buildInfoCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // This Row contains the info from the pop-up card
          Row(
            children: [
              Container(width: 60, height: 60, color: Colors.grey[200], child: Icon(Icons.store)),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Buana Phone Service', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 16),
                        Text('5'),
                        SizedBox(width: 8),
                        Text('Specialty in phone service'),
                      ],
                    ),
                    Text('Price start from Rp 50.000'),
                    Text('Open everyday (24/7)', style: TextStyle(color: Colors.green)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Chat and View Details Buttons
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('Chat Now'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryBlue,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  child: Text('View Details'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: kPrimaryBlue,
                    side: BorderSide(color: kPrimaryBlue),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Placeholder for Portfolio Tab (Screen 116)
  Widget _buildPortfolioTab() {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        Text('Professional work', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        // Placeholder for portfolio images
        Container(
          height: 200,
          color: Colors.grey[200],
          child: Center(child: Text('Portfolio Image Grid')),
        ),
      ],
    );
  }

  // Placeholder for Review Tab (Screen 117)
  Widget _buildReviewTab() {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Sort by', style: TextStyle(fontWeight: FontWeight.bold)),
            // Placeholder for filter chips
            Row(
              children: [
                Chip(label: Text('All'), backgroundColor: kPrimaryBlue.withOpacity(0.1)),
                SizedBox(width: 4),
                Chip(label: Text('5 ★')),
                SizedBox(width: 4),
                Chip(label: Text('4 ★')),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Placeholder for a review
        Card(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Sule', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Layanannya bgs, murah tp bukan kaleng. Pengerjaan cpt.'),
                SizedBox(height: 8),
                Container(
                  height: 100,
                  color: Colors.grey[200],
                  child: Center(child: Text('Review Image')),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}