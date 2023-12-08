import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medapp/profilepage/userprofile.dart';
import 'package:medapp/provider/auth_provider.dart';
import 'package:provider/provider.dart';

import '../Navigation/menu.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    final currentTime = TimeOfDay.now();
    String greeting = _getGreeting(currentTime);
    return Scaffold(
      key: _key,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.white),
          onPressed: () => _key.currentState!.openDrawer(),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
        title: const Text("Home", style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const UserProfile()),
              );
            },
            icon: const Icon(Icons.verified_user, color: Colors.white),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          HealthQuote(),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              color: Colors.deepOrange,
              margin: const EdgeInsets.all(16.0),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "$greeting, \n${ap.userModel.name.toUpperCase()} :)",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Welcome to Hims App! Your health companion.",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    // Add additional content if needed
                  ],
                ),
              ),
            ),
          ),
          const Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("Created with 💖 by CAREMATES"),
            ],
          )
        ],
      ),
      drawer: const Navigation(),
    );
  }

  String _getGreeting(TimeOfDay currentTime) {
    if (currentTime.hour < 12) {
      return 'GOOD MORNING';
    } else if (currentTime.hour < 18) {
      return 'GOOD AFTERNOON';
    } else {
      return 'GOOD NIGHT';
    }
  }
}

class HealthQuote extends StatefulWidget {
  @override
  State<HealthQuote> createState() => _HealthQuoteState();
}

class _HealthQuoteState extends State<HealthQuote> {
  late Timer _timer;
  List<String> healthQuotes = [
    "Health is the greatest gift, contentment the greatest wealth, faithfulness the best relationship. - Buddha",
    "The greatest wealth is health. - Virgil",
    "Take care of your body. It's the only place you have to live. - Jim Rohn",
    "An apple a day keeps the doctor away. - Proverb",
    "To keep the body in good health is a duty... otherwise, we shall not be able to keep our mind strong and clear. - Buddha",
    "Health is not about the weight you lose, but about the life you gain. - Dr. Axe",
    "The first wealth is health. - Ralph Waldo Emerson",
    "Your body hears everything your mind says. Stay positive. Be positive.",
    "A healthy outside starts from the inside. - Robert Urich",
    "Wellness is the complete integration of body, mind, and spirit - the realization that everything we do, think, feel, and believe has an effect on our state of well-being. - Greg Anderson",
    "Let food be thy medicine and medicine be thy food. - Hippocrates",
    "The groundwork for all happiness is good health. - Leigh Hunt",
    "He who has health, has hope; and he who has hope, has everything. - Thomas Carlyle",
    "Health is a state of body. Wellness is a state of being. - J. Stanford",
    "The human body is the best work of art. - Jess C. Scott",
    "Sleep is that golden chain that ties health and our bodies together. - Thomas Dekker",
    "Physical fitness is not only one of the most important keys to a healthy body, but it is also the basis of dynamic and creative intellectual activity. - John F. Kennedy",
    "An ounce of prevention is worth a pound of cure. - Benjamin Franklin",
    "The only way to keep your health is to eat what you don't want, drink what you don't like, and do what you'd rather not. - Mark Twain",
    "The doctor of the future will no longer treat the human frame with drugs, but rather will cure and prevent disease with nutrition. - Thomas Edison"
  ];

  String currentQuote = "";

  @override
  void initState() {
    super.initState();
    _updateQuote(); // Initial update
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      _updateQuote();
    });
  }

  void _updateQuote() {
    setState(() {
      currentQuote = healthQuotes[DateTime.now().microsecondsSinceEpoch % healthQuotes.length];
    });
  }

  @override
  Widget build(BuildContext context) {
    String randomQuote = healthQuotes[DateTime.now().microsecondsSinceEpoch % healthQuotes.length];

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        color: Colors.deepPurpleAccent,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            randomQuote,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}