import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Settings', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: ListView(children: [
        _tile('Account', Icons.person_outline),
        _tile('Security & Access', Icons.lock_outline),
        _tile('Monetization', Icons.monetization_on_outlined),
        _tile('Premium', Icons.star_outline),
        _tile('Timeline', Icons.timeline_outlined),
        _tile('Privacy & Safety', Icons.shield_outlined),
        _tile('Notifications', Icons.notifications_outlined),
      ]),
    );
  }

  Widget _tile(String title, IconData icon) {
    return Column(children: [
      ListTile(
        leading: Icon(icon, color: Colors.white70),
        title: Text(title, style: const TextStyle(color: Colors.white)),
        trailing: const Icon(Icons.chevron_right, color: Colors.white38),
        onTap: () {/* TODO */},
      ),
      const Divider(color: Colors.white24),
    ]);
  }
}
