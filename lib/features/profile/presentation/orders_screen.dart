import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        title: const Text(
          "My Orders",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children:
            [
                  _OrderCard(
                    orderId: "#ORD-2024-001",
                    date: "Jan 10, 2024",
                    status: "Delivered",
                    statusColor: Colors.green,
                    items: 3,
                    total: "\$299.99",
                  ),
                  _OrderCard(
                    orderId: "#ORD-2024-002",
                    date: "Jan 8, 2024",
                    status: "In Transit",
                    statusColor: Colors.orange,
                    items: 1,
                    total: "\$89.99",
                  ),
                  _OrderCard(
                    orderId: "#ORD-2024-003",
                    date: "Jan 5, 2024",
                    status: "Processing",
                    statusColor: Colors.blue,
                    items: 2,
                    total: "\$159.99",
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
}

class _OrderCard extends StatelessWidget {
  final String orderId;
  final String date;
  final String status;
  final Color statusColor;
  final int items;
  final String total;

  const _OrderCard({
    required this.orderId,
    required this.date,
    required this.status,
    required this.statusColor,
    required this.items,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
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
              Text(
                orderId,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: statusColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.calendar_today, size: 14, color: Colors.grey[500]),
              const SizedBox(width: 6),
              Text(date, style: TextStyle(color: Colors.grey[600])),
              const SizedBox(width: 16),
              Icon(
                Icons.shopping_bag_outlined,
                size: 14,
                color: Colors.grey[500],
              ),
              const SizedBox(width: 6),
              Text("$items items", style: TextStyle(color: Colors.grey[600])),
            ],
          ),
          const Divider(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Total"),
              Text(
                total,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color(0xFF003D29),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
