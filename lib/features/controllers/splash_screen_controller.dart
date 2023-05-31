import 'package:get/get.dart';
import 'package:management_walk/features/screens/home_screen/home_screen.dart';

class SplashScreenController extends GetxController {
  static SplashScreenController get find => Get.find();

  RxBool animate = false.obs;

  Future startAnimation() async {
    await Future.delayed(const Duration(milliseconds: 500));
    animate.value = true;
    await Future.delayed(const Duration(milliseconds: 2000));
    Get.off(HomeScreen());
    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ImageUpload()));
  }
}
