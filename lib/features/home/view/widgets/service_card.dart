import 'package:flutter/material.dart';

class ServiceCard extends StatelessWidget {
  final String title;
  final String specialty;
  final String price;
  final String rating;
  final bool isOpen;
  final VoidCallback onTap;

  const ServiceCard({
    super.key,
    required this.title,
    this.specialty = '',
    this.price = '',
    this.rating = '',
    this.isOpen = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              // Placeholder for image
              Container(
                width: 80,
                height: 80,
                color: Colors.grey[200],
                child: Icon(Icons.store, color: Colors.grey[400]),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Text(specialty, style: TextStyle(color: Colors.grey[600])),
                    Text('Price start from $price'),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 16),
                        Text(rating),
                        SizedBox(width: 8),
                        Text(isOpen ? 'Open everyday (24/7)' : 'Closed', 
                             style: TextStyle(color: isOpen ? Colors.green : Colors.red)),
                      ],
                    ),
                  ],
                ),
              ),
              Icon(Icons.bookmark_border, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}