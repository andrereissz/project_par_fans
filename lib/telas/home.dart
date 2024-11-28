import 'package:flutter/material.dart';
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
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 200,
              child: TextButton(
                  onPressed: () async {
                    await Authentication().signOut();
                  },
                  child: Text('Logout')),
            )
          ],
        ),
      ),
    );
  }
}
