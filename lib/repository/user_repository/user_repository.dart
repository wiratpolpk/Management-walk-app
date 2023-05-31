import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:management_walk/features/models/user_model.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  // createUser(UserModel user) async {
  //   await _db
  //       .collection("users")
  //       // .add(user.toJson())
  //       // .whenComplete(
  //       //   () => Get.snackbar("Success", "You infomation saved.",
  //       //       snackPosition: SnackPosition.BOTTOM,
  //       //       backgroundColor: Colors.lightGreen.withOpacity(0.1),
  //       //       colorText: Colors.green),
  //       // )
  //       .catchError((error, StackTrace) {
  //     // Get.snackbar("Error", "Something went wrong. Try again",
  //     //     snackPosition: SnackPosition.BOTTOM,
  //     //     backgroundColor: Colors.redAccent.withOpacity(0.1),
  //     //     colorText: Colors.red);
  //     print(error.toString());
  //   });
  // }
}
