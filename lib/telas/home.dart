import 'package:flutter/material.dart';
import 'package:project_par_fans/bottomNav.dart';
import 'package:project_par_fans/services/authentication.dart';
import 'package:project_par_fans/services/database.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Database _database = Database();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          colorScheme: ThemeData().colorScheme.copyWith(primary: Colors.black)),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(),
        bottomNavigationBar: Bottomnav.getBarraNav(0),
      ),
    );
  }
}
