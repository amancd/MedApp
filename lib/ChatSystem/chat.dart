import 'package:flutter/material.dart';
import 'package:medapp/Navigation/menu.dart';

import '../admin/admin_home.dart';

class UserChatApp extends StatefulWidget {
  const UserChatApp({Key? key}) : super(key: key);

  @override
  State<UserChatApp> createState() => _UserChatAppState();
}

class _UserChatAppState extends State<UserChatApp> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () => _key.currentState!.openDrawer(),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
        title: const Text("Chat With Ved", style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AdminHome()));
            },
            icon: const Icon(Icons.home, color: Colors.white),
          ),
        ],
      ),
      body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("This page is under construction!!"),
              SizedBox(height: 20),
            ],
          )),
      drawer: const Navigation(),
    );
  }
}
