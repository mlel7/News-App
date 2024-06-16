import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:newsapp/main.dart';
import 'package:newsapp/model/news_model.dart';
import 'package:url_launcher/url_launcher.dart';
class NewsController extends GetxController {
  void changeTheme() {
    if (Get.isDarkMode) {
      Get.changeThemeMode(themeMode = ThemeMode.light);
      box.put("mode", "light");
    }
    else{
      Get.changeThemeMode(themeMode = ThemeMode.dark);
      box.put("mode", "dark");
    }
  }
  getData() async {
    final Uri url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=us&apiKey=56a7f38b0d184aa59bed36c6aa16c9ef");
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      try {
        return Articles.fromJson(jsonDecode(response.body));
      } catch (e) {
        Get.showSnackbar(GetSnackBar(
            title: "Error",
            message: "$e",
            duration: const Duration(seconds: 3)));
      }
    }
  }

  Future<void> openUrl(String url) async {
    try {
      await launchUrl(Uri.parse(url));
    } catch (c) {
      Get.showSnackbar(GetSnackBar(
        title: "Something Wrong",
        message: c.toString(),
      ));
    }
  }
}
