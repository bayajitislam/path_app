import 'package:flutter/material.dart';
import 'package:path_app/core/widgets/app_bg.dart';

class JoinLobbyPage extends StatefulWidget {
  const JoinLobbyPage({super.key});

  @override
  State<JoinLobbyPage> createState() => _JoinLobbyPageState();
}

class _JoinLobbyPageState extends State<JoinLobbyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBg(child: Center(child: Text('Under Development'))),
    );
  }
}
