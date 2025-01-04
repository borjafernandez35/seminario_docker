import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/widgets/bottomNavigationBar.dart';
import 'package:flutter_application_1/screen/experiencies.dart';
import 'package:flutter_application_1/screen/logIn.dart';
import 'package:flutter_application_1/screen/perfil.dart';
import 'package:flutter_application_1/screen/register.dart';
import 'package:flutter_application_1/screen/user.dart';
import 'package:flutter_application_1/screen/home.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_application_1/controllers/userModelController.dart';
import 'package:flutter_application_1/controllers/experienceController.dart';
import 'package:flutter_application_1/controllers/experienceListController.dart';

void main() async {
  await GetStorage.init();
  Get.put(UserModelController());
  
  

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      getPages: [
        // Ruta de inicio de sesión
        GetPage(
          name: '/login',
          page: () => const LogInPage(),
        ),
        // Ruta de registro
        GetPage(
          name: '/register',
          page: () => const RegisterPage(),
        ),
        // Ruta de la pantalla principal con BottomNavScaffold
        GetPage(
          name: '/home',
          page: () => BottomNavScaffold(child: const HomePage()),
        ),
        GetPage(
          name: '/usuarios',
          page: () => BottomNavScaffold(child: const UserPage()),
        ),
        GetPage(
          name: '/experiencies',
          page: () => BottomNavScaffold(child: ExperiencePage()),
        ),
        GetPage(
          name: '/perfil',
          page: () => BottomNavScaffold(child: const PerfilPage()),
        ),
      ],
    );
  }
}
