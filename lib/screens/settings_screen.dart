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
        title: const Text('設定', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Column(children: [
        // Banner
        GestureDetector(
          onTap: () {/* TODO: pick banner */},
          child: Container(
            height: 120,
            color: Colors.white12,
            child: const Center(child: Text('Banner Image', style: TextStyle(color: Colors.white38))),
          ),
        ),
        // Avatar edit
        Padding(
          padding: const EdgeInsets.only(top: -40),
          child: Center(child: Stack(alignment: Alignment.bottomRight, children: [
            CircleAvatar(radius: 48, backgroundColor: Colors.white24,
              child: const Icon(Icons.person, size: 48, color: Colors.white70)),
            GestureDetector(onTap: () {/* TODO */}, child:
              const CircleAvatar(radius: 16, backgroundColor: Colors.blueAccent,
                child: Icon(Icons.camera_alt, size: 16, color: Colors.white))),
          ])),
        ),
        const SizedBox(height: 8),
        Expanded(child: ListView(padding: const EdgeInsets.all(16), children: [
          _buildField('Name', 'NULL (Kiyo)', () {/* TODO */}),
          _buildField('Bio', 'EP9 imo3 Respect for @nightz1x NuLL', () {/* TODO */}),
          _buildField('Location', 'Add location', () {/* TODO */}),
          _buildField('Web', 'Add website', () {/* TODO */}),
          _buildField('Birthday', '2004/02/24', () {/* TODO */}),
          SwitchListTile(
            value: false, title: const Text('Tips', style: TextStyle(color: Colors.white)),
            onChanged: (_) {/* TODO */}),
        ])),
      ]),
    );
  }

  Widget _buildField(String label, String value, VoidCallback onTap) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, style: const TextStyle(color: Colors.white70)),
      ListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(value, style: const TextStyle(color: Colors.white)),
        trailing: const Icon(Icons.chevron_right, color: Colors.white38),
        onTap: onTap,
      ),
      const Divider(color: Colors.white24),
    ]);
  }
}
