import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_par_fans/bottomNav.dart';
import 'package:project_par_fans/controllers/config_controller.dart';

class ConfigView extends GetView<ConfigController> {
  final controller = Get.put(ConfigController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Bottomnav.getBarraNav(3),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Text(
                  "Configurações",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, // Cor vermelha
                  padding:
                      EdgeInsets.symmetric(vertical: 16.0), // Altura do botão
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(8), // Bordas arredondadas
                  ),
                ),
                onPressed: () {
                  _showSignOutDialog(context);
                },
                child: Center(
                  child: Text(
                    "Sign Out",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSignOutDialog(BuildContext context) {
    Get.dialog(
      AlertDialog(
        title: Text(
          "Are you sure?",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        actions: [
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    Get.back(); // Fecha o diálogo
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.grey), // Contorno cinza
                    padding: EdgeInsets.symmetric(vertical: 14.0),
                  ),
                  child: Text(
                    "Cancel",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(width: 10), // Espaçamento entre os botões
              Expanded(
                child: ElevatedButton(
                  onPressed: () async {
                    Get.back(); // Fecha o diálogo
                    await controller.signOut(); // Executa o método de logout
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red, // Cor do botão
                    padding: EdgeInsets.symmetric(vertical: 14.0),
                  ),
                  child: Text(
                    "Sign Out",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
