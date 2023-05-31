import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:management_walk/api/sheets/user_sheets_api.dart';
import 'package:management_walk/common_widgets/form_header_widget.dart';
import 'package:management_walk/constants/image_strings.dart';
import 'package:management_walk/constants/sizes.dart';
import 'package:management_walk/constants/text_strings.dart';
import 'package:management_walk/features/controllers/home_screen_controller.dart';
import 'package:management_walk/features/models/user_model.dart';
import 'package:management_walk/features/screens/category_selection.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _date = TextEditingController();
  final TextEditingController _section = TextEditingController();
  final TextEditingController _area = TextEditingController();
  final TextEditingController _name = TextEditingController();

  @override
  void initState() {
    super.initState();

    removePrefs();
  }

  // Future insertUsers() async {
  //   final users = [
  //     User(1, 'John', 'PF1', 'Store', '07/03/2023'),
  //     User(1, 'Mike', 'PF2', 'Shop', '08/03/2023'),
  //   ];

  //   final jsonUsers = users.map((user) => user.toJson()).toList();

  //   await UserSheetsApi.insert(jsonUsers);
  // }

  void removePrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('reportName');
    prefs.remove('reportDate');
    prefs.remove('section');
    prefs.remove('area');

    prefs.remove('comment_Q0101');
    prefs.remove('comment_Q0102');
    prefs.remove('comment_Q0103');
    prefs.remove('comment_Q0104');
    prefs.remove('comment_Q0105');
    prefs.remove('comment_Q0106');
    prefs.remove('comment_Q0107');
    prefs.remove('comment_Q0108');
    prefs.remove('comment_Q0109');

    prefs.remove('image_Q0101');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(tDefaultSize),
            child: Column(
              children: [
                const FormHeaderWidget(
                  image: tHomeScreenImage,
                  title: tHomeTitle,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: tFormHeight - 10),
                  child: Form(
                      child: Column(
                    children: [
                      TextFormField(
                        controller: _name,
                        decoration: const InputDecoration(
                          label: Text(tReportByLabel),
                          prefixIcon: Icon(Icons.person_outline_rounded),
                        ),
                      ),
                      const SizedBox(height: tFormHeight - 20),
                      TextFormField(
                        controller: _section,
                        decoration: const InputDecoration(
                          label: Text(tSectionLabel),
                          prefixIcon: Icon(Icons.map_outlined),
                        ),
                      ),
                      const SizedBox(height: tFormHeight - 20),
                      TextFormField(
                        controller: _area,
                        decoration: const InputDecoration(
                          label: Text(tAreaLabel),
                          prefixIcon: Icon(Icons.map_outlined),
                        ),
                      ),
                      const SizedBox(height: tFormHeight - 20),
                      TextField(
                        controller: _date,
                        decoration: const InputDecoration(
                          label: Text(tDateLabel),
                          prefixIcon: Icon(Icons.calendar_today_outlined),
                        ),
                        onTap: () async {
                          FocusScope.of(context).unfocus();
                          DateTime? pickeddate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101));

                          if (pickeddate != null) {
                            _date.text =
                                DateFormat('dd/MM/yyyy').format(pickeddate);
                          }
                        },
                      ),
                      const SizedBox(height: tFormHeight - 20),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();

                            prefs.setString('reportName', _name.text);
                            prefs.setString('reportDate', _date.text);
                            prefs.setString('section', _section.text);
                            prefs.setString('area', _area.text);

                            Get.to(const CategorySelection());
                          },
                          child: const Text(
                            tButtonNext,
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
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
                              onPressed: () {
                                removePrefs();
                                _name.text = "";
                                _section.text = "";
                                _area.text = "";
                                _date.text = "";
                              },
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
                              onPressed: () async {
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                // insertUsers();
                                // ignore: prefer_const_constructors
                                // final user = UserModel(
                                //   report_name:
                                //       prefs.getString('reportName') ?? "",
                                //   section: prefs.getString('section') ?? "",
                                //   area: prefs.getString('area') ?? "",
                                //   report_date:
                                //       prefs.getString('reportDate') ?? "",
                                //   comment_Q0101:
                                //       prefs.getString('comment_Q0101') ?? "",
                                //   image_Q0101:
                                //       prefs.getString('image_Q0101') ?? "",
                                // );
                                // HomeScreenController.instance.createUser(user);
                              },
                              child: const Text(
                                "บันทีก",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
