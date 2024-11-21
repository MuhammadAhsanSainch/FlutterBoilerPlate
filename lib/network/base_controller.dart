import 'package:get/get.dart';

class BaseController extends GetxController {

  static BaseController get to {
    try {
      return Get.find<BaseController>();
    } catch (e) {
      return Get.put(BaseController());
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

}
