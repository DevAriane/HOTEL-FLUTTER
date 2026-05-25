import 'package:flutter/material.dart';
import 'package:hotel/app_color.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Compte",
          style: TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 32,
                        backgroundColor: AppColor.dGreen,
                        child: const Icon(Icons.person,
                            size: 36, color: AppColor.blanc),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ATEUMO ARIANE',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'arianeateumo@gmail.com',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),
                  Text(
                    'Paramètres',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildSettingsTile(
                      icon: Icons.person_outline,
                      title: 'Informations personnelles',
                      onTap: () {}),
                  _buildSettingsTile(
                      icon: Icons.payment_outlined,
                      title: 'Moyens de paiement',
                      onTap: () {}),
                  _buildSettingsTile(
                      icon: Icons.notifications_none,
                      title: 'Notifications',
                      onTap: () {}),
                  _buildSettingsTile(
                      icon: Icons.lock_outline,
                      title: 'Confidentialité et sécurité',
                      onTap: () {}),
                  _buildSettingsTile(
                      icon: Icons.language_outlined,
                      title: 'Langue et devise',
                      onTap: () {}),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: Colors.grey.shade700, size: 24),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16),
      ),
      trailing: Icon(Icons.chevron_right, color: Colors.grey.shade400),
      onTap: onTap,
    );
  }
}
