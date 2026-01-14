import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/theme/cubit/theme_cubit.dart';
import '../../../core/theme/cubit/theme_state.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool _orderUpdates = true;
  bool _promotions = true;
  bool _newArrivals = false;
  bool _priceDrops = true;
  bool _emailNotifications = true;
  bool _pushNotifications = true;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Notifications",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildSection("Appearance", [
            BlocBuilder<ThemeCubit, ThemeState>(
              builder: (context, state) {
                return SwitchListTile(
                  secondary: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: colorScheme.primary.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      state.isDarkMode ? Icons.dark_mode : Icons.light_mode,
                      color: colorScheme.primary,
                      size: 20,
                    ),
                  ),
                  title: const Text(
                    "Dark Mode",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(
                    state.isDarkMode
                        ? "Dark theme enabled"
                        : "Light theme enabled",
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                  value: state.isDarkMode,
                  onChanged: (v) => context.read<ThemeCubit>().toggleTheme(),
                  activeTrackColor: colorScheme.primary.withValues(alpha: 0.3),
                  thumbColor: WidgetStateProperty.resolveWith((states) {
                    if (states.contains(WidgetState.selected)) {
                      return colorScheme.primary;
                    }
                    return Colors.grey;
                  }),
                );
              },
            ),
          ]),
          const SizedBox(height: 24),
          _buildSection("Shopping", [
            _NotificationTile(
              icon: Icons.local_shipping_outlined,
              title: "Order Updates",
              subtitle: "Get notified about your order status",
              value: _orderUpdates,
              onChanged: (v) => setState(() => _orderUpdates = v),
            ),
            _NotificationTile(
              icon: Icons.local_offer_outlined,
              title: "Promotions",
              subtitle: "Special offers and discounts",
              value: _promotions,
              onChanged: (v) => setState(() => _promotions = v),
            ),
            _NotificationTile(
              icon: Icons.new_releases_outlined,
              title: "New Arrivals",
              subtitle: "Be the first to know about new products",
              value: _newArrivals,
              onChanged: (v) => setState(() => _newArrivals = v),
            ),
            _NotificationTile(
              icon: Icons.trending_down_outlined,
              title: "Price Drops",
              subtitle: "Alerts when items in wishlist go on sale",
              value: _priceDrops,
              onChanged: (v) => setState(() => _priceDrops = v),
            ),
          ]),
          const SizedBox(height: 24),
          _buildSection("Notification Channels", [
            _NotificationTile(
              icon: Icons.email_outlined,
              title: "Email Notifications",
              subtitle: "Receive updates via email",
              value: _emailNotifications,
              onChanged: (v) => setState(() => _emailNotifications = v),
            ),
            _NotificationTile(
              icon: Icons.notifications_outlined,
              title: "Push Notifications",
              subtitle: "Receive push notifications",
              value: _pushNotifications,
              onChanged: (v) => setState(() => _pushNotifications = v),
            ),
          ]),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF003D29),
          ),
        ),
        const SizedBox(height: 12),
        Container(
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
          child: Column(children: children),
        ),
      ],
    );
  }
}

class _NotificationTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _NotificationTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      secondary: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFF003D29).withValues(alpha: 0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: const Color(0xFF003D29), size: 20),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(
        subtitle,
        style: TextStyle(color: Colors.grey[600], fontSize: 12),
      ),
      value: value,
      onChanged: onChanged,
      activeTrackColor: const Color(0xFF003D29).withValues(alpha: 0.3),
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const Color(0xFF003D29);
        }
        return Colors.grey;
      }),
    );
  }
}
