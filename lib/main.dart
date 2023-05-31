import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:management_walk/features/screens/category_selection.dart';
// import 'package:management_walk/features/controllers/home_screen_controller.dart';
import 'package:management_walk/features/screens/equipment.dart';
import 'package:management_walk/features/screens/gmp_screen.dart';
import 'package:management_walk/features/screens/machine_screen.dart';
import 'package:management_walk/features/screens/management_screen.dart';
import 'package:management_walk/features/screens/safety_screen.dart';
import 'package:management_walk/features/screens/section_store_screen.dart';
// import 'package:management_walk/features/screens/splash_screen/splash_screen.dart';
import 'package:management_walk/utils/Theme/theme.dart';
import 'features/screens/home_screen/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize a new Firebase App instance
  await Firebase.initializeApp();

  // Get.put(HomeScreenController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        // Remove the debug banner
        debugShowCheckedModeBanner: false,
        title: 'Management Walk',
        theme: TAppTheme.lightTheme,
        darkTheme: TAppTheme.darkTheme,
        home: const HomePage(),
        routes: <String, WidgetBuilder>{
          '/homepage': ((context) => const HomePage()),
          '/equipment': ((context) => const Equipment()),
          '/gmp': ((context) => const GMPScreen()),
          '/machine': ((context) => const MachineScreen()),
          '/safety': ((context) => const SafetyScreen()),
          '/sectionStore': ((context) => const SectionStoreScreen()),
          '/management': ((context) => const ManagementScreen()),
          '/categoryScreen': ((context) => const CategorySelection()),
        });
  }
}
