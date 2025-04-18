import 'package:flutter/material.dart';
import 'widgets/side_panel.dart';
import 'widgets/river_scene.dart';
import 'screens/profile_screen.dart';
import 'screens/settings_screen.dart';

void main() => runApp(const Null2App());

class Null2App extends StatelessWidget {
  const Null2App({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const Null2Home(),
    );
  }
}

class Null2Home extends StatefulWidget {
  const Null2Home({Key? key}) : super(key: key);
  @override
  State<Null2Home> createState() => _Null2HomeState();
}

class _Null2HomeState extends State<Null2Home> {
  final List<String> thoughts = ['これは NULL² の思考', 'あなたが今ここにいる'];
  bool showInput = false;
  final TextEditingController _ctrl = TextEditingController();

  void _addThought(String text) {
    setState(() {
      thoughts.insert(0, text);
      if (thoughts.length > 20) thoughts.removeLast();
    });
  }

  void _openInput() => setState(() => showInput = true);
  void _closeInput() => setState(() {
    showInput = false;
    _ctrl.clear();
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SidePanel(child: RiverScene(thoughts: thoughts)),
      floatingActionButton: FloatingActionButton(
        onPressed: _openInput,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      // Input overlay
      extendBody: true,
      body: Stack(
        children: [
          SidePanel(child: RiverScene(thoughts: thoughts)),
          if (showInput)
            Positioned.fill(
              child: GestureDetector(
                onTap: _closeInput,
                child: Container(color: Colors.black54),
              ),
            ),
          if (showInput)
            Center(
              child: Container(
                padding: const EdgeInsets.all(16),
                color: Colors.black87,
                width: MediaQuery.of(context).size.width * 0.8,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _ctrl,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          hintText: 'Thought...',
                          hintStyle: TextStyle(color: Colors.white54),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.send, color: Colors.white),
                      onPressed: () {
                        if (_ctrl.text.trim().isNotEmpty) {
                          _addThought(_ctrl.text.trim());
                        }
                        _closeInput();
                      },
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
