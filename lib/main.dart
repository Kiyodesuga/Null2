import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(const Null2App());

class Null2App extends StatelessWidget {
  const Null2App({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Null2Home(),
    );
  }
}

class Null2Home extends StatefulWidget {
  const Null2Home({super.key});
  @override
  State<Null2Home> createState() => _Null2HomeState();
}

class _Null2HomeState extends State<Null2Home> with SingleTickerProviderStateMixin {
  final List<String> thoughts = [
    'これは NULL² の思考',
    'あなたが今 ここにいる',
    '揺れるだけの粒子',
    '意味以前の兆し'
  ];
  final Random rnd = Random();
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
    return Scaffold(
      backgroundColor: Colors.black,
      body: AnimatedBuilder(
        animation: _ctrl,
        builder: (context, _) {
          return Stack(
            children: List.generate(thoughts.length, (i) {
              double progress = (_ctrl.value + i * 0.25) % 1.0;
              double top = MediaQuery.of(context).size.height * progress - 50;
              double sway = sin((_ctrl.value + i) * 2 * pi) * 20;
              return Positioned(
                top: top,
                left: 40 + sway,
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
      ),
    );
  }
}
