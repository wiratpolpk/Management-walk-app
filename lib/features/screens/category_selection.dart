// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:management_walk/features/screens/gmp_screen.dart';
import 'package:management_walk/features/screens/home_screen/home_page.dart';
import 'package:management_walk/features/screens/machine_screen.dart';
import 'package:management_walk/features/screens/management_screen.dart';
import 'package:management_walk/features/screens/safety_screen.dart';
import 'package:management_walk/features/screens/section_store_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common_widgets/form_header_widget.dart';
import '../../constants/image_strings.dart';
import '../../constants/sizes.dart';
import '../../constants/text_strings.dart';
import 'equipment.dart';

class CategorySelection extends StatefulWidget {
  const CategorySelection({Key? key}) : super(key: key);

  @override
  State<CategorySelection> createState() => _CategorySelectionState();
}

class _CategorySelectionState extends State<CategorySelection> {
  var equipmentCompleted = "".obs;
  var gmpCompleted = "".obs;
  var machineCompleted = "".obs;
  var safetyCompleted = "".obs;
  var sectionStoreCompleted = "".obs;
  var managementCompleted = "".obs;

  var countSave = 0;

  RxString langaugeText = "TH".obs;
  var languageSelected = "";

  @override
  void initState() {
    super.initState();

    getCompletion();
  }

  Future getCompletion() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    languageSelected = (prefs.getString('languageSelected') ?? "TH");

    langaugeText = languageSelected.obs;

    setState(() {
      equipmentCompleted = (prefs.getString('equipmentDone') ?? "").obs;
      gmpCompleted = (prefs.getString('gmpDone') ?? "").obs;
      machineCompleted = (prefs.getString('machineDone') ?? "").obs;
      safetyCompleted = (prefs.getString('safetyDone') ?? "").obs;
      sectionStoreCompleted = (prefs.getString('sectionStoreDone') ?? "").obs;
      managementCompleted = (prefs.getString('managementDone') ?? "").obs;
    });

    if (equipmentCompleted == "completed") {
      countSave = countSave + 1;
    }
    if (gmpCompleted == "completed") {
      countSave = countSave + 1;
    }
    if (machineCompleted == "completed") {
      countSave = countSave + 1;
    }
    if (safetyCompleted == "completed") {
      countSave = countSave + 1;
    }
    if (sectionStoreCompleted == "completed") {
      countSave = countSave + 1;
    }
    if (managementCompleted == "completed") {
      countSave = countSave + 1;
    }

    if (countSave == 6) {
      prefs.setString('readyToSave', "yes");
    }
  }

  Future<bool> _onWillPop() async {
    return await Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightBlue,
          leading: BackButton(
            color: Colors.white,
            onPressed: () => Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const HomePage())),
          ),
          title: Obx(() => Text(
                langaugeText == "TH".obs
                    ? categoryHeaderTextTH
                    : categoryHeaderTextEN,
              )),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: Container(
          padding: const EdgeInsets.all(tDefaultSize),
          child: Column(
            children: [
              Obx(() => FormHeaderWidget(
                    image: tHomeScreenImage,
                    title: langaugeText == "TH".obs
                        ? categorySelectTextTH
                        : categorySelectTextEN,
                  )),
              Container(
                padding: const EdgeInsets.symmetric(vertical: tFormHeight - 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 140,
                          height: 80,
                          child: Obx(() => ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor:
                                      equipmentCompleted == "completed"
                                          ? Colors.green
                                          : Colors.blue),
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Equipment()));
                              },
                              child: Text(
                                langaugeText == "TH".obs
                                    ? categoryEquipmentTextTH
                                    : categoryEquipmentTextEN,
                                style: const TextStyle(fontSize: 14),
                              ))),
                        ),
                        const SizedBox(
                          width: 40,
                        ),
                        SizedBox(
                          width: 140,
                          height: 80,
                          child: Obx(() => ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: gmpCompleted == "completed"
                                      ? Colors.green
                                      : Colors.blue),
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const GMPScreen()));
                              },
                              child: Text(
                                langaugeText == "TH".obs
                                    ? categoryGmpTextTH
                                    : categoryGmpTextEN,
                                style: const TextStyle(fontSize: 14),
                              ))),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 140,
                          height: 80,
                          child: Obx(() => ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor:
                                      machineCompleted == "completed"
                                          ? Colors.green
                                          : Colors.blue),
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const MachineScreen()));
                              },
                              child: Text(
                                langaugeText == "TH".obs
                                    ? categoryMachineTextTH
                                    : categoryMachineTextEN,
                                style: const TextStyle(fontSize: 14),
                              ))),
                        ),
                        const SizedBox(
                          width: 40,
                        ),
                        SizedBox(
                          width: 140,
                          height: 80,
                          child: Obx(() => ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor:
                                      sectionStoreCompleted == "completed"
                                          ? Colors.green
                                          : Colors.blue),
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SectionStoreScreen()));
                              },
                              child: Text(
                                langaugeText == "TH".obs
                                    ? sectionStoreTextTH
                                    : sectionStoreTextEN,
                                style: const TextStyle(fontSize: 14),
                              ))),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 140,
                          height: 80,
                          child: Obx(() => ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor:
                                      safetyCompleted == "completed"
                                          ? Colors.green
                                          : Colors.blue),
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SafetyScreen()));
                              },
                              child: Text(
                                langaugeText == "TH".obs
                                    ? SafetyTextTH
                                    : SafetyTextEN,
                                style: const TextStyle(fontSize: 14),
                              ))),
                        ),
                        const SizedBox(
                          width: 40,
                        ),
                        SizedBox(
                          width: 140,
                          height: 80,
                          child: Obx(() => ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor:
                                      managementCompleted == "completed"
                                          ? Colors.green
                                          : Colors.blue),
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ManagementScreen()));
                              },
                              child: Text(
                                langaugeText == "TH".obs
                                    ? managementTextTH
                                    : managementTextEN,
                                style: const TextStyle(fontSize: 14),
                              ))),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
