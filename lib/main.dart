import 'package:flutter/material.dart';
import 'widgets/side_panel.dart';
import 'screens/profile_screen.dart';
import 'screens/settings_screen.dart';

void main() => runApp(const Null2App());

class Null2App extends StatelessWidget {
  const Null2App({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: SidePanel(child: RiverScene())),
      theme: ThemeData.dark(),
    );
  }
}

class RiverScene extends StatefulWidget {
  const RiverScene({Key? key}) : super(key: key);
  @override
  State<RiverScene> createState() => _RiverSceneState();
}

class _RiverSceneState extends State<RiverScene> with SingleTickerProviderStateMixin {
  final List<String> thoughts = [
    'これは NULL² の思考',
    'あなたが今ここにいる',
    '揺れるだけの粒子',
    '意味以前の兆し',
  ];
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(seconds: 20))
      ..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (context, _) {
        final size = MediaQuery.of(context).size;
        return Stack(
          children: List.generate(thoughts.length, (i) {
            final progress = (_ctrl.value + i * 0.25) % 1.0;
            final top = size.height * progress - 50;
            final sway = 40 + 20 * (i % 2 == 0 ? 1 : -1) * (_ctrl.value);
            return Positioned(
              top: top,
              left: sway + 408, // offset for panel mask
              child: Opacity(
                opacity: 0.8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white24, width: 0.8),
                  ),
                  child: Text(
                    thoughts[i],
                    style: const TextStyle(color: Colors.white, fontSize: 22),
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
