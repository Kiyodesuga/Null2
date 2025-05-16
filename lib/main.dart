import 'package:flutter/material.dart';

void main() {
  runApp(Null2App());
}

class Null2App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NULL²',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        fontFamily: 'NotoSansJP',
      ),
      home: WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 3800));
    _opacityAnim =
        Tween<double>(begin: 1, end: 0).animate(CurvedAnimation(
      parent: _controller,
      curve: Interval(0.75, 1.0, curve: Curves.easeOut),
    ));
    _controller.forward();
    Future.delayed(Duration(milliseconds: 4000), () {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => MainFeedScreen()));
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) => Center(
          child: Opacity(
            opacity: 1 - _controller.value * 0.8,
            child: ShaderMask(
              shaderCallback: (Rect bounds) {
                return LinearGradient(
                  colors: [Colors.white, Colors.blueGrey.shade900],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ).createShader(bounds);
              },
              child: Text(
                'Welcome to NULL²',
                style: TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 3,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      blurRadius: 32,
                      color: Colors.blueGrey.withOpacity(0.48),
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MainFeedScreen extends StatefulWidget {
  @override
  State<MainFeedScreen> createState() => _MainFeedScreenState();
}

class _MainFeedScreenState extends State<MainFeedScreen> {
  List<Post> posts = [];
  final TextEditingController _controller = TextEditingController();
  bool showSidebar = false;

  void _addPost(String text) {
    if (text.trim().isEmpty) return;
    setState(() {
      posts.insert(
          0, Post(content: text.trim(), isMe: true, timestamp: DateTime.now()));
      if (posts.length > 10) posts.removeLast();
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          // 水面風の投稿空間
          Positioned.fill(
            child: Container(
              color: Colors.black,
              child: Column(
                children: [
                  const SizedBox(height: 36),
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      reverse: false,
                      itemCount: posts.length,
                      separatorBuilder: (context, idx) =>
                          Divider(color: Colors.white10, thickness: 0.4),
                      itemBuilder: (context, idx) => WaterSurfacePostTile(
                        post: posts[idx],
                        isMine: posts[idx].isMe,
                        width: width,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    child: Row(
                      children: [
                        Expanded(
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 400),
                            decoration: BoxDecoration(
                              color: Colors.white10,
                              borderRadius: BorderRadius.circular(22),
                              border: Border.all(
                                  color: Colors.white24, width: 0.7),
                            ),
                            child: TextField(
                              controller: _controller,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                hintText: '思考を浮かべて…',
                                hintStyle: TextStyle(color: Colors.white38),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 10),
                              ),
                              onSubmitted: _addPost,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        GestureDetector(
                          onTap: () => _addPost(_controller.text),
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 280),
                            padding: EdgeInsets.all(11),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white.withOpacity(0.08),
                            ),
                            child: Icon(Icons.water_drop_outlined,
                                color: Colors.blueGrey.shade100),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),

          // サイドバー
          if (showSidebar)
            SidebarWidget(
              onClose: () => setState(() => showSidebar = false),
            ),

          // サイドバーアイコン
          Positioned(
            top: 16,
            left: 20,
            child: GestureDetector(
              onTap: () => setState(() => showSidebar = !showSidebar),
              child: CircleAvatar(
                backgroundColor: Colors.white12,
                radius: 22,
                child: Icon(Icons.menu, color: Colors.white70),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Post {
  final String content;
  final DateTime timestamp;
  final bool isMe;
  Post({required this.content, required this.timestamp, required this.isMe});
}

class WaterSurfacePostTile extends StatelessWidget {
  final Post post;
  final bool isMine;
  final double width;

  WaterSurfacePostTile(
      {required this.post, required this.isMine, required this.width});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 650),
      margin: EdgeInsets.symmetric(vertical: 5),
      alignment: Alignment.centerLeft,
      child: Stack(
        children: [
          Container(
            width: width * 0.98,
            padding: EdgeInsets.symmetric(vertical: 14, horizontal: 14),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(isMine ? 0.13 : 0.07),
              border: isMine
                  ? Border.all(
                      color: Colors.blueGrey.withOpacity(0.19), width: 0.8)
                  : null,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.blueGrey.withOpacity(0.06),
                  blurRadius: 14,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Text(
              post.content,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  letterSpacing: 0.7,
                  shadows: [
                    Shadow(
                      blurRadius: 2,
                      color: Colors.blueGrey.withOpacity(0.22),
                      offset: Offset(0, 1),
                    ),
                  ]),
            ),
          ),
        ],
      ),
    );
  }
}

class SidebarWidget extends StatelessWidget {
  final VoidCallback onClose;
  SidebarWidget({required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      top: 0,
      bottom: 0,
      width: 260,
      child: Material(
        color: Colors.black.withOpacity(0.97),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 26),
            IconButton(
              icon: Icon(Icons.arrow_back_ios_new, color: Colors.white60),
              onPressed: onClose,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SidebarItem(icon: Icons.person, text: "Profile"),
                  SizedBox(height: 24),
                  _SidebarItem(icon: Icons.list_alt, text: "Thought Log"),
                  SizedBox(height: 24),
                  _SidebarItem(icon: Icons.waves, text: "Wave Graph"),
                  SizedBox(height: 24),
                  _SidebarItem(icon: Icons.settings, text: "Settings"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SidebarItem extends StatelessWidget {
  final IconData icon;
  final String text;
  _SidebarItem({required this.icon, required this.text});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.blueGrey.shade100, size: 26),
        SizedBox(width: 16),
        Text(
          text,
          style: TextStyle(
            color: Colors.white70,
            fontSize: 20,
            fontWeight: FontWeight.w500,
            letterSpacing: 1.3,
          ),
        ),
      ],
    );
  }
}
