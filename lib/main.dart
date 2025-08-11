import 'package:flutter/material.dart';
import 'package:time_management_ai/di/injector.dart';
import 'package:time_management_ai/presentation/screens/add_schedule.dart';
import 'package:time_management_ai/presentation/screens/detail.dart';
import 'package:time_management_ai/presentation/screens/home.dart';

Future<void> main() async {
  // await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  await Injector.configureDependencies();
 
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quản Lý Thời Gian AI',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.teal),
      routes: {
        '/': (_) => HomeScreen(),
        '/detail': (_) => DetailScreen(),
        '/add_schedule': (_) => AddSchedule(),
      },
    );
  }
}
