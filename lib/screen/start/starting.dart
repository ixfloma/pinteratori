import 'package:flutter/material.dart';
import './status.dart';
import './request.dart';
import './dashboard.dart';
import 'package:provider/provider.dart';
import '../../models/user.dart';
class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  int selectedIndex = 0;
  final tabOption = [
    Dashboard(),
    StatusPage()
  ];

  void onItemTapped(int index){
    setState(() {
      selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    final pengguna = Provider.of<User>(context);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: tabOption.elementAt(selectedIndex),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.collections_bookmark), title: Text('Request')),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), title: Text('Profile')),
        ],
        currentIndex: selectedIndex,
        backgroundColor: Colors.blue[600],
        fixedColor: Colors.white,
        onTap: onItemTapped,
      ),
    );
  }
}

