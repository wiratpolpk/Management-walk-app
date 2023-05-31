import 'package:flutter/material.dart';
import 'package:management_walk/api/sheets/management_walk_sheet_api.dart';
import 'package:management_walk/api/sheets/section_sheets_api.dart';
import 'package:management_walk/api/sheets/user_sheets_api.dart';
import 'package:management_walk/common_widgets/button_widget.dart';
import 'package:management_walk/constants/text_strings.dart';
import 'package:management_walk/features/models/management_walk_model.dart';
import 'package:management_walk/features/screens/home_screen/user_form_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../api/sheets/work_commitment_api.dart';
import '../../../common_widgets/navigate_users_widget.dart';
import '../../models/section_model.dart';
import '../../models/user_model.dart';
import '../../models/work_commitment_model.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // User? user;
  List<User> users = [];
  List<ManagementWalk> managementWalks = [];
  int index = 0;
  int managementWalkIndex = 0;
  List<WorkCommitment> workCommitments = [];

  @override
  void initState() {
    super.initState();

    getUsers();
    getWorkCommitment();
  }

  Future getUsers({int index = 0}) async {
    final users = await UserSheetsApi.getAll();

    setState(() {
      this.users = users;
    });
  }

  Future getManagementWalk({int index = 0}) async {
    final managementWalks = await ManagementWalkSheetsApi.getAll();

    setState(() {
      this.managementWalks = managementWalks;
    });
  }

  Future getWorkCommitment({int index = 0}) async {
    final workCommitments = await WorkCommitmentSheetApi.getAll();

    setState(() {
      this.workCommitments = workCommitments;
    });

    for (var element in workCommitments) {
      print(element.questionID);
      print(element.questionDesc);
      print(element.workCommitment);
      print(element.group1);
      print(element.group2);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tAppName),
        centerTitle: true,
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(16),
          children: [
            UserFormWidget(
              user: users.isEmpty ? null : users[index],
              managementWalk: managementWalks.isEmpty
                  ? null
                  : managementWalks[managementWalkIndex],
              onSavedUser: (user) async {
                final id = await UserSheetsApi.getRowCount() + 1;
                // final newUser = user.copy(id: id);
                // await UserSheetsApi.insert([newUser.toJson()]);

                // await UserSheetsApi.update(user.id!, user.toJson());

                // UserSheetsApi.updateCell(
                //     id: 4, key: 'section', value: 'test update');
              },
              onSaveManagementWalk: (managementWalk) async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                // _commentQ0101.text = prefs.getString('comment_Q0101') ?? "";
                final idtemp = prefs.getString('managementWalkID') ?? "";

                // workCommitments.forEach((element) async {
                //   final id = '$idtemp';
                // final newManagementWalk = managementWalk.copy(id: id);
                // await ManagementWalkSheetsApi.insert(
                //     [newManagementWalk.toJson()]);
                // });
                final id = '$idtemp';
                // final newManagementWalk = managementWalk.copy(runID: "1");
                // await ManagementWalkSheetsApi.insert(
                //     [newManagementWalk.toJson()]);
              },
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 100,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text(
                      "รีเซ็ต",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 40,
                ),
                SizedBox(
                  width: 100,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text(
                      "บันทีก",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
            // const SizedBox(height: 16),
            // if (users.isNotEmpty) buildUserControls(),
          ],
        ),
      ),
    );
  }

  Widget buildUserControls() => Column(
        children: [
          // ButtonWidget(text: 'Delete', onClicked: deleteUser),
          NavigateUsersWidget(
            text: '${index + 1}/${users.length} Users',
            onClickedNext: () {
              final nextIndex = index >= users.length - 1 ? 0 : index + 1;

              setState(() {
                index = nextIndex;
              });
            },
            onClickedPrevious: () {
              final previousIndex = index <= 0 ? users.length - 1 : index - 1;

              setState(() {
                index = previousIndex;
              });
            },
          ),
        ],
      );

  Future deleteUser() async {
    final user = users[index];

    // await UserSheetsApi.deleteById(user.id!);

    //For updating UI after deleted
    final newIndex = index > 1 ? index - 1 : 0;
    await getUsers(index: newIndex);
  }
}
