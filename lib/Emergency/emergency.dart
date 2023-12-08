import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Navigation/menu.dart';
import '../admin/admin_home.dart';

class EmergencyPage extends StatefulWidget {
  const EmergencyPage({Key? key}) : super(key: key);

  @override
  State<EmergencyPage> createState() => _EmergencyPageState();
}

class _EmergencyPageState extends State<EmergencyPage> {
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
        title: const Text("Emergency", style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const AdminHome()),
              );
            },
            icon: const Icon(Icons.home, color: Colors.white),
          ),
        ],
      ),
      body: Center(
        child: EmergencyContactsList(),
      ),
      drawer: const Navigation(),
    );
  }
}

class EmergencyContactsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('hospitals').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        // Extract data from the snapshot
        final List<Map<String, dynamic>> hospitals = snapshot.data!.docs
            .map((DocumentSnapshot document) =>
        Map<String, dynamic>.from(document.data() as Map))
            .toList();

        return ListView.builder(
          itemCount: hospitals.length,
          itemBuilder: (context, index) {
            final hospital = hospitals[index];
            return ListTile(
              title: Text(hospital['name'] ?? ''),
              subtitle: Text(hospital['contact'] ?? ''),
              onTap: () {
                _callHospital(hospital['contact']);
              },
              // Add more styling or functionality as needed
            );
          },
        );
      },
    );
  }

  void _callHospital(String? contact) async{
    if (contact != null && contact.isNotEmpty) {
      if (await canLaunch("tel:$contact")) {
    await launch("tel:$contact");
    } else {
    throw "Error occured trying to call that number.";
    }
    } else {
      // Handle case where contact number is not available
      print('Contact number not available.');
    }
  }
}
