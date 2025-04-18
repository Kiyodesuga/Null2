import 'package:flutter/material.dart';
import 'dart:math';

class RiverScene extends StatefulWidget {
  final List<String> thoughts;
  const RiverScene({required this.thoughts, Key? key}) : super(key: key);

  @override
  State<RiverScene> createState() => _RiverSceneState();
}

class _RiverSceneState extends State<RiverScene> with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  final Random rnd = Random();

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
          children: List.generate(widget.thoughts.length, (i) {
            final progress = (_ctrl.value + i * 0.1) % 1.0;
            final top = size.height * progress - 50;
            final sway = 40 + rnd.nextDouble() * 20 - 10;
            return Positioned(
              top: top,
              left: sway + 408,
              child: Opacity(
                opacity: 0.7 + 0.3 * (1 - progress),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white24, width: 0.8),
                  ),
                  child: Text(
                    widget.thoughts[i],
                    style: const TextStyle(color: Colors.white, fontSize: 20),
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
