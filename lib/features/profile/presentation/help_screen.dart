import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        title: const Text(
          "Help Center",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Search bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 10,
                ),
              ],
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search for help...",
                hintStyle: TextStyle(color: Colors.grey[400]),
                prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                border: InputBorder.none,
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Quick Actions
          Row(
            children: [
              Expanded(
                child: _QuickAction(
                  icon: Icons.chat_bubble_outline,
                  title: "Live Chat",
                  onTap: () => _showChat(context),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _QuickAction(
                  icon: Icons.email_outlined,
                  title: "Email Us",
                  onTap: () => _showEmail(context),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _QuickAction(
                  icon: Icons.phone_outlined,
                  title: "Call Us",
                  onTap: () => _showPhone(context),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // FAQ Section
          const Text(
            "Frequently Asked Questions",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),

          ...[
                _FaqItem(
                  question: "How do I track my order?",
                  answer:
                      "You can track your order by going to My Orders section in your profile. Each order has a tracking number that you can use to see real-time updates.",
                ),
                _FaqItem(
                  question: "What is the return policy?",
                  answer:
                      "We offer a 30-day return policy for all unused items in their original packaging. Simply contact our support team to initiate a return.",
                ),
                _FaqItem(
                  question: "How can I change my shipping address?",
                  answer:
                      "Go to Profile > Shipping Address to add, edit, or remove your shipping addresses. You can set a default address for faster checkout.",
                ),
                _FaqItem(
                  question: "What payment methods are accepted?",
                  answer:
                      "We accept Visa, Mastercard, American Express, PayPal, Apple Pay, and Cash on Delivery in select areas.",
                ),
                _FaqItem(
                  question: "How do I contact customer support?",
                  answer:
                      "You can reach us via Live Chat (available 24/7), email at support@shop.com, or call us at 1-800-SHOP-NOW during business hours.",
                ),
              ]
              .asMap()
              .entries
              .map(
                (e) => e.value
                    .animate()
                    .fade(duration: 400.ms, delay: (100 * e.key).ms)
                    .slideX(begin: 0.05, duration: 400.ms),
              )
              ,
        ],
      ),
    );
  }

  void _showChat(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Live chat coming soon!"),
        duration: Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showEmail(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Email: support@shop.com"),
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showPhone(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Phone: 1-800-SHOP-NOW"),
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

class _QuickAction extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _QuickAction({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 10,
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: const Color(0xFF003D29).withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: const Color(0xFF003D29)),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

class _FaqItem extends StatefulWidget {
  final String question;
  final String answer;

  const _FaqItem({required this.question, required this.answer});

  @override
  State<_FaqItem> createState() => _FaqItemState();
}

class _FaqItemState extends State<_FaqItem> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
          ),
        ],
      ),
      child: ExpansionTile(
        title: Text(
          widget.question,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
        trailing: Icon(
          _isExpanded ? Icons.remove : Icons.add,
          color: const Color(0xFF003D29),
        ),
        onExpansionChanged: (value) => setState(() => _isExpanded = value),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Text(
              widget.answer,
              style: TextStyle(color: Colors.grey[600], height: 1.5),
            ),
          ),
        ],
      ),
    );
  }
}
