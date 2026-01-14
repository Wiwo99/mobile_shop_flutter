import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        title: const Text(
          "Shipping Address",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showAddAddressDialog(context),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children:
            [
                  _AddressCard(
                    label: "Home",
                    name: "Test User",
                    address: "123 Main Street, Apt 4B",
                    city: "New York, NY 10001",
                    phone: "+1 (555) 123-4567",
                    isDefault: true,
                  ),
                  _AddressCard(
                    label: "Office",
                    name: "Test User",
                    address: "456 Business Ave, Floor 12",
                    city: "New York, NY 10002",
                    phone: "+1 (555) 987-6543",
                    isDefault: false,
                  ),
                ]
                .asMap()
                .entries
                .map(
                  (e) => e.value
                      .animate()
                      .fade(duration: 400.ms, delay: (100 * e.key).ms)
                      .slideX(begin: 0.1, duration: 400.ms),
                )
                .toList(),
      ),
    );
  }

  void _showAddAddressDialog(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Add address feature coming soon!"),
        duration: Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

class _AddressCard extends StatelessWidget {
  final String label;
  final String name;
  final String address;
  final String city;
  final String phone;
  final bool isDefault;

  const _AddressCard({
    required this.label,
    required this.name,
    required this.address,
    required this.city,
    required this.phone,
    required this.isDefault,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: isDefault
            ? Border.all(color: const Color(0xFF003D29), width: 2)
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    label == "Home" ? Icons.home_outlined : Icons.work_outlined,
                    color: const Color(0xFF003D29),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    label,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  if (isDefault) ...[
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF003D29),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        "Default",
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      ),
                    ),
                  ],
                ],
              ),
              IconButton(
                icon: const Icon(Icons.edit_outlined, size: 20),
                onPressed: () {},
              ),
            ],
          ),
          const Divider(height: 16),
          Text(name, style: const TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          Text(address, style: TextStyle(color: Colors.grey[600])),
          Text(city, style: TextStyle(color: Colors.grey[600])),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.phone_outlined, size: 14, color: Colors.grey[500]),
              const SizedBox(width: 6),
              Text(phone, style: TextStyle(color: Colors.grey[600])),
            ],
          ),
        ],
      ),
    );
  }
}
