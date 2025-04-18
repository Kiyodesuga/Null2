import 'package:flutter/material.dart';
import '../screens/profile_screen.dart';
import '../screens/settings_screen.dart';

class SidePanel extends StatefulWidget {
  final Widget child;
  const SidePanel({required this.child, Key? key}) : super(key: key);

  @override
  State<SidePanel> createState() => _SidePanelState();
}

class _SidePanelState extends State<SidePanel> with SingleTickerProviderStateMixin {
  static const double expandedWidth = 408;
  late final AnimationController _ctrl = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 450),
  );

  bool get isOpen => _ctrl.status == AnimationStatus.completed;

  void open() => _ctrl.forward();
  void close() => _ctrl.reverse();

  void _navigate(Widget screen) {
    close();
    Future.delayed(const Duration(milliseconds: 450), () {
      Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      AnimatedBuilder(
        animation: _ctrl,
        builder: (_, __) {
          final panelWidth = Tween<double>(begin: 0, end: expandedWidth)
              .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic));
          return Positioned(
            left: panelWidth.value,
            top: 0, bottom: 0, right: 0,
            child: widget.child,
          );
        },
      ),
      Positioned(
        left: 0, top: 0, bottom: 0,
        child: AnimatedBuilder(
          animation: _ctrl,
          builder: (_, __) {
            final w = Tween<double>(begin: 0, end: expandedWidth)
                .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOutCubic)).value;
            return Container(
              width: w, color: Colors.black,
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const SizedBox(height: 24),
                _menuButton('Profile', Icons.person, () => _navigate(const ProfileScreen())),
                _menuButton('Thought Log', Icons.history, () => close()),
                _menuButton('Wave Graph', Icons.show_chart, () => close()),
                _menuButton('Settings', Icons.settings, () => _navigate(const SettingsScreen())),
              ]),
            );
          },
        ),
      ),
      Positioned(
        left: 16, top: 16,
        child: isOpen
            ? const SizedBox.shrink()
            : GestureDetector(
                onTap: open,
                child: Container(
                  width: 40, height: 40,
                  decoration: BoxDecoration(
                    color: Colors.black, borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white24),
                  ),
                  alignment: Alignment.center,
                  child: const Text('☰', style: TextStyle(color: Colors.white, fontSize: 20)),
                ),
              ),
      ),
      if (isOpen)
        Positioned.fill(
          child: GestureDetector(
            onTap: close,
            child: Container(color: Colors.transparent),
          ),
        ),
    ]);
  }

  Widget _menuButton(String label, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(children: [
          Icon(icon, size: 18, color: Colors.white70),
          const SizedBox(width: 8),
          Text(label, style: const TextStyle(color: Colors.white70)),
        ]),
      ),
    );
  }
}
