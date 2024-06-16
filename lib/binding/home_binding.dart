import 'package:get/get.dart';
import 'package:newsapp/controller/news_controller.dart';

class HomeBinding implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => NewsController());
  }
}