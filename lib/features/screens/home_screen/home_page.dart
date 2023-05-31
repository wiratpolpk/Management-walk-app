// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:management_walk/common_widgets/button_widget.dart';
import 'package:management_walk/constants/text_strings.dart';
import 'package:management_walk/features/models/lastRunID_model.dart';
import 'package:management_walk/features/models/lastUser_model.dart';
import 'package:management_walk/features/models/management_walk_model.dart';
import 'package:management_walk/features/screens/reports/report1_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../api/api_connection.dart';
import '../../../common_widgets/navigate_users_widget.dart';
import '../../models/section_model.dart';
import '../../models/supervisor_model.dart';
import '../../models/user_model.dart';
import '../../models/work_commitment_model.dart';
import '../category_selection.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // User? user;
  List<User> users = [];
  List<ManagementWalk> managementWalks = [];
  int index = 0;
  int managementWalkIndex = 0;

  List<Section> sections = [];
  // List<SupervisorModel> supervisors = [];
  List<WorkCommitment> workCommitments = [];
  var sectionDescs = <String>[];
  var supervisorName = <String>[];
  var lastRunIDText = "";
  var lastUserText = "";

  var newIsVisible = true;
  var continueIsVisible = true;

  bool value = true;

  final formKey = GlobalKey<FormState>();

  TextEditingController? _name;
  TextEditingController? _section;
  TextEditingController? _area;
  TextEditingController? _date;

  String dropdownSupervisorvalue = 'ฟารุส นุ้ยโสะ';
  String dropdownSectionvalue = '301 - Powerplant';

  var readyToSave = "".obs;

  RxString langaugeText = "TH".obs;
  var languageSelected = "";

  var startDate = "";

  @override
  void initState() {
    super.initState();
    initIDTemp();

    fetchSupervisor().then((value) async {
      for (int i = 0; i < value.length; i++) {
        setState(() {
          supervisorName.add(value[i].supervisorName!);
        });

        // supervisorName.forEach((element) {
        //   print(element);
        // });
      }
    });

    // supervisors = [];

    // _getSupervisor();

    showSection();
    // initIDTemp();
    getCompletion();
  }

  @override
  void didUpdateWidget(covariant HomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    // initIDTemp();
    getCompletion();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Future initIDTemp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    languageSelected = (prefs.getString('languageSelected') ?? "TH");

    langaugeText = languageSelected.obs;

    if (langaugeText == "TH") {
      value = true;
    } else {
      value = false;
    }

    if (prefs.getString('managementWalkID') != null) {
      final name = prefs.getString('supervisorName') ?? "ฟารุส นุ้ยโสะ";
      final section = prefs.getString('sectionValue') ?? "301 - Powerplant";
      final area = prefs.getString('areaValue') ?? "";
      startDate = prefs.getString('dateValue') ?? "";

      newIsVisible = false;
      continueIsVisible = true;

      setState(() {
        _name = TextEditingController(text: name);
        _section = TextEditingController(text: section);
        _area = TextEditingController(text: area);
        _date = TextEditingController(text: startDate);
        dropdownSupervisorvalue = name;
        dropdownSectionvalue = section;
      });
    } else {
      final name = prefs.getString('supervisorName') ?? "ฟารุส นุ้ยโสะ";
      final section = prefs.getString('sectionValue') ?? "301 - Powerplant";
      final area = prefs.getString('areaValue') ?? "";
      startDate = DateFormat('dd/MM/yyyy').format(DateTime.now());

      newIsVisible = true;
      continueIsVisible = false;

      setState(() {
        _name = TextEditingController(text: name);
        _section = TextEditingController(text: section);
        _area = TextEditingController(text: area);
        _date = TextEditingController(text: startDate);
        dropdownSupervisorvalue = name;
        dropdownSectionvalue = section;
      });
    }
  }

  Future getCompletion() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      readyToSave = (prefs.getString('readyToSave') ?? "").obs;
    });
  }

  Future<List<SupervisorModel>> fetchSupervisor() async {
    final response = await http.get(Uri.parse(API.supervisor));

    if (response.statusCode == 200) {
      final List result = json.decode(response.body);
      return result.map((e) => SupervisorModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  // List<Supervisor> supervisorFromJson(String jsonString) {
  //   final data = json.decode(jsonString);
  //   return List<Supervisor>.from(data.map((item) => Supervisor.fromJson(item)));
  // }

  List<Section> sectionFromJson(String jsonString) {
    final data = json.decode(jsonString);
    return List<Section>.from(data.map((item) => Section.fromJson(item)));
  }

  // Future<List<Supervisor>> showSupervisor() async {
  //   final response = await http.get(Uri.parse(API.supervisor));
  //   if (response.statusCode == 200) {
  //     List<Supervisor> list = supervisorFromJson(response.body);

  //     for (var element in list) {
  //       supervisorName.add(element.supervisorName);
  //     }
  //     return list;
  //   } else {
  //     return <Supervisor>[];
  //   }
  // }

  Future<List<Section>> showSection() async {
    final response = await http.get(Uri.parse(API.section));
    if (response.statusCode == 200) {
      List<Section> list = sectionFromJson(response.body);

      for (var element in list) {
        sectionDescs.add(element.sectionDesc);
      }
      return list;
    } else {
      return <Section>[];
    }
  }

  List<WorkCommitment> workCommitmentFromJson(String jsonString) {
    final data = json.decode(jsonString);
    return List<WorkCommitment>.from(
        data.map((item) => WorkCommitment.fromJson(item)));
  }

  Future<List<WorkCommitment>> showWorkCommitment() async {
    if (langaugeText == "TH") {
      final response = await http.get(Uri.parse(API.workCommitment));
      if (response.statusCode == 200) {
        List<WorkCommitment> list = workCommitmentFromJson(response.body);

        return list;
      } else {
        return <WorkCommitment>[];
      }
    } else {
      final response = await http.get(Uri.parse(API.workCommitmentEN));
      if (response.statusCode == 200) {
        List<WorkCommitment> list = workCommitmentFromJson(response.body);

        return list;
      } else {
        return <WorkCommitment>[];
      }
    }
  }

  List<ManagementWalk> managementWalkFromJson(String jsonString) {
    final data = json.decode(jsonString);
    return List<ManagementWalk>.from(
        data.map((item) => ManagementWalk.fromJson(item)));
  }

  Future<List<ManagementWalk>> showManagementWalk() async {
    final response = await http.get(Uri.parse(API.managementWalk));
    if (response.statusCode == 200) {
      List<ManagementWalk> list = managementWalkFromJson(response.body);

      return list;
    } else {
      return <ManagementWalk>[];
    }
  }

  List<LastRunID> lastRunIDFromJson(String jsonString) {
    final data = json.decode(jsonString);
    return List<LastRunID>.from(data.map((item) => LastRunID.fromJson(item)));
  }

  Future<String> getLastRunID() async {
    final response = await http.get(Uri.parse(API.getLastRunID));
    if (response.statusCode == 200) {
      List<LastRunID> list = lastRunIDFromJson(response.body);

      for (var element in list) {
        lastRunIDText = element.lastRunID.toString();
      }

      return lastRunIDText;
    } else {
      return "";
    }
  }

  List<LastUser> lastUserFromJson(String jsonString) {
    final data = json.decode(jsonString);
    return List<LastUser>.from(data.map((item) => LastUser.fromJson(item)));
  }

  Future<String> getLastUser() async {
    final response = await http.get(Uri.parse(API.getLastUser));
    if (response.statusCode == 200) {
      List<LastUser> list = lastUserFromJson(response.body);

      for (var element in list) {
        lastUserText = element.lastUser.toString();
      }

      return lastUserText;
    } else {
      return "";
    }
  }

  Future updateComplete() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var name = prefs.getString('supervisorName') ?? "ฟารุส นุ้ยโสะ";
      var section = prefs.getString('sectionValue') ?? "301 - Powerplant";
      var area = prefs.getString('areaValue') ?? "";
      var startDate = prefs.getString('dateValue') ?? "";
      await http.post(Uri.parse(API.updateCompleted), body: {
        'supervisorName': name,
        'section': section,
        'area': area,
        'startDate': startDate,
      });
    } catch (e) {
      print(e);
    }
  }

  Future addUser() async {
    // await getLastUser().then((value) async {
    var lastUser = 0;
    //   lastUser = int.parse(value);

    //   lastUser = lastUser + 1;

    User user = User(lastUser.toString(), dropdownSupervisorvalue,
        dropdownSectionvalue, _area?.text, _date?.text);

    try {
      await http.post(
        Uri.parse(API.addUser),
        body: user.toJson(),
      );
    } catch (e) {
      print(e);
    }
  }

  Future addManagementWalk() async {
    // ignore: prefer_const_constructors
    await getLastRunID().then((value) async {
      showLoading(context, text: 'Loading');
      var lastID = 0;
      final idtemp = "$dropdownSupervisorvalue${_date?.text}";
      lastID = int.parse(value);

      await showWorkCommitment().then((value) => workCommitments = value);

      for (var i = 0; i < workCommitments.length - 1; i++) {
        lastID = lastID + 1;
        var runID = "$lastID";
        var keyID = "$idtemp${workCommitments[i].questionID}";

        ManagementWalk managementWalk = ManagementWalk(
            runID,
            keyID,
            dropdownSupervisorvalue,
            dropdownSectionvalue,
            _area?.text,
            _date?.text,
            _date?.text,
            workCommitments[i].questionID,
            workCommitments[i].questionDesc,
            workCommitments[i].workCommitment,
            workCommitments[i].group1,
            workCommitments[i].group2,
            "",
            "",
            "",
            "",
            "");

        try {
          await http.post(
            Uri.parse(API.addManagementWalk),
            body: managementWalk.toJson(),
          );
          // ignore: empty_catches
        } catch (e) {}
      }

      await addUser();

      hideLoading(context);
    });
  }

  Future clearQuestionDone() async {
    final response = await http.post(
      Uri.parse(API.clearQuestionDone),
    );
  }

  void showLoading(BuildContext context, {required String text}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return SimpleDialog(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(height: 10),
                Text(text, textAlign: TextAlign.center),
              ],
            ),
          ],
        );
      },
    );
  }

  void hideLoading(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.of(context).pop();
    }
  }

  void removePrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('managementWalkID');
    prefs.remove('supervisorName');
    prefs.remove('sectionValue');
    prefs.remove('areaValue');
    prefs.remove('dateValue');
    prefs.remove('equipmentDone');
    prefs.remove('gmpDone');
    prefs.remove('machineDone');
    prefs.remove('safetyDone');
    prefs.remove('sectionStoreDone');
    prefs.remove('managementDone');
    prefs.remove('readyToSave');

    await clearQuestionDone();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(tAppName),
        centerTitle: true,
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(16),
          children: [
            Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('$langaugeText'),
                      buildLanguageSwitch(),
                    ],
                  ),
                  buildDropDownSupervisor(),
                  const SizedBox(height: 16),
                  buildDropDownSection(),
                  const SizedBox(height: 16),
                  buildArea(),
                  const SizedBox(height: 16),
                  buildDate(),
                  const SizedBox(height: 16),
                  Visibility(visible: newIsVisible, child: buildSubmit()),
                  const SizedBox(
                    height: 10,
                  ),
                  Visibility(
                      visible: continueIsVisible, child: buildContinue()),
                  const SizedBox(
                    height: 10,
                  ),
                  buildDashBoard(),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 100,
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () {
                            // addManagementWalk();
                            removePrefs();
                            setState(() {
                              _name?.text = "";
                              _section?.text = "";
                              _area?.text = "";
                              _date?.text = "";
                              startDate = DateFormat('dd/MM/yyyy')
                                  .format(DateTime.now());

                              newIsVisible = true;
                              continueIsVisible = false;

                              dropdownSupervisorvalue = 'ฟารุส นุ้ยโสะ';
                              dropdownSectionvalue = '301 - Powerplant';
                            });
                            Navigator.popAndPushNamed(context, '/homepage');
                          },
                          child: Obx(() => Text(
                                langaugeText == "TH".obs
                                    ? resetReportTextTH
                                    : resetReportTextEN,
                                style: const TextStyle(fontSize: 20),
                              )),
                        ),
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                      SizedBox(
                        width: 100,
                        height: 40,
                        child: Obx(() => ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  // ignore: unrelated_type_equality_checks
                                  backgroundColor: readyToSave == "yes"
                                      ? Colors.green
                                      : Colors.grey),
                              onPressed: () async {
                                if (readyToSave == "yes".obs) {
                                  await updateComplete();
                                  removePrefs();
                                  setState(() {
                                    _name?.text = "";
                                    _section?.text = "";
                                    _area?.text = "";
                                    _date?.text = "";
                                    startDate = DateFormat('dd/MM/yyyy')
                                        .format(DateTime.now());

                                    newIsVisible = true;
                                    continueIsVisible = false;

                                    dropdownSupervisorvalue = 'ฟารุส นุ้ยโสะ';
                                    dropdownSectionvalue = '301 - Powerplant';
                                  });

                                  Navigator.popAndPushNamed(
                                      context, '/homepage');
                                }
                              },
                              child: Obx(() => Text(
                                    langaugeText == "TH".obs
                                        ? saveReportTextTH
                                        : saveReportTextEN,
                                    style: const TextStyle(fontSize: 20),
                                  )),
                            )),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDropDownSection() => DropdownButtonFormField(
        // Initial Value
        value: dropdownSectionvalue,

        // Down Arrow Icon
        icon: const Icon(Icons.keyboard_arrow_down),

        // Array list of items
        items: sectionDescs.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: Text(items),
          );
        }).toList(),
        // After selecting the desired option,it will
        // change button value to selected value
        onChanged: (String? newValue) {
          setState(() {
            dropdownSectionvalue = newValue!;
          });
        },
      );

  Widget buildDropDownSupervisor() => DropdownButtonFormField(
        // Initial Value
        value: dropdownSupervisorvalue,

        // Down Arrow Icon
        icon: const Icon(Icons.keyboard_arrow_down),

        // Array list of items
        items: supervisorName.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: Text(items),
          );
        }).toList(),
        // After selecting the desired option,it will
        // change button value to selected value
        onChanged: (String? newValue) {
          setState(() {
            dropdownSupervisorvalue = newValue!;
          });
        },
      );

  Widget buildArea() => TextFormField(
        onChanged: (value) {
          final form = formKey.currentState;
          final isValid = form!.validate();
        },
        controller: _area,
        decoration: InputDecoration(
          errorStyle: const TextStyle(height: 0),
          label: Obx(() => Text(
                langaugeText == "TH".obs ? areaTextTH : areaTextEN,
              )),
          prefixIcon: Icon(Icons.map_outlined),
        ),
        validator: (value) => value != null && value.isEmpty
            ? langaugeText == "TH".obs
                ? areaValidateTH
                : areaValidateEN
            : null,
      );

  Widget buildDate() => TextFormField(
        enabled: false,
        controller: _date,
        decoration: InputDecoration(
          label: Text(
            langaugeText == "TH".obs ? dateTextTH : dateTextEN,
          ),
          prefixIcon: const Icon(Icons.calendar_today_outlined),
        ),
        // onTap: () async {
        //   FocusScope.of(context).unfocus();
        //   DateTime? pickeddate = await showDatePicker(
        //       context: context,
        //       initialDate: DateTime.now(),
        //       firstDate: DateTime(2000),
        //       lastDate: DateTime(2101));

        //   if (pickeddate != null) {
        //     _date?.text = DateFormat('dd/MM/yyyy').format(pickeddate);
        //   }
        //   final form = formKey.currentState;
        //   final isValid = form!.validate();
        // },
        // validator: (value) =>
        //     value != null && value.isEmpty ? 'Enter Date' : null,
      );

  Widget buildSubmit() => Obx(() => ButtonWidget(
      text: langaugeText == "TH".obs ? startReportTextTH : startReportTextEN,
      onClicked: () async {
        final form = formKey.currentState;
        final isValid = form!.validate();
        if (isValid) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString(
              'managementWalkID', "$dropdownSupervisorvalue${_date?.text}");
          prefs.setString('supervisorName', dropdownSupervisorvalue);
          prefs.setString('sectionValue', dropdownSectionvalue);
          prefs.setString('areaValue', _area?.text ?? "");
          prefs.setString('dateValue', _date?.text ?? "");

          newIsVisible = false;
          continueIsVisible = true;

          await addManagementWalk();

          Navigator.popAndPushNamed(context, '/homepage');

          // Get.to(() => const CategorySelection());

          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const CategorySelection()));
        }
      }));

  Widget buildContinue() => Obx(() => ButtonWidget(
      text: langaugeText == "TH".obs
          ? continueReportTextTH
          : continueReportTextEN,
      onClicked: () async {
        // Get.to(() => const CategorySelection());
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const CategorySelection()));
      }));

  Widget buildDashBoard() => Obx(() => ButtonWidget(
      text: langaugeText == "TH".obs ? reportTextTH : reportTextEN,
      onClicked: () async {
        Get.to(() => const Report1Screen());
      }));

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

  Widget buildLanguageSwitch() => Switch.adaptive(
      activeColor: Colors.blueAccent,
      activeTrackColor: Colors.blue.withOpacity(0.4),
      inactiveThumbColor: Colors.orange,
      inactiveTrackColor: Colors.grey,
      value: value,
      onChanged: (value) async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        setState(() {
          this.value = value;
          if (value) {
            langaugeText = "TH".obs;
            prefs.setString('languageSelected', "TH");
          } else {
            langaugeText = "EN".obs;
            prefs.setString('languageSelected', "EN");
          }
        });
      });
}
