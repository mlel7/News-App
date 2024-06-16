import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:newsapp/binding/home_binding.dart';
import 'package:newsapp/view/home.dart';
late Box box;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  box = await Hive.openBox("theme");
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}
ThemeMode themeMode = box.get("mode")==null?ThemeMode.system:box.get("mode") == "dark"?ThemeMode.dark:ThemeMode.light;
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple,brightness: Brightness.light),
        useMaterial3: true,
      ),
      themeMode: themeMode,
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple,brightness: Brightness.dark),
        useMaterial3: true,
      ),
      initialRoute: "/home",
      initialBinding: HomeBinding(),
      getPages: [
        GetPage(name: "/home", page: () => HomePage())
      ],
    );
  }
}
class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}