import 'package:get/get.dart';
import 'package:management_walk/features/models/user_model.dart';
import 'package:management_walk/repository/user_repository/user_repository.dart';

class HomeScreenController extends GetxController {
  static HomeScreenController get instance => Get.find();

  final userRepo = Get.put(UserRepository());

  // Future<void> createUser(UserModel user) async {
  //   // await userRepo.createUser(user);
  // }
}
