// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:management_walk/features/models/count_managementDone_model.dart';
import 'package:management_walk/features/screens/equipment.dart';
import 'package:management_walk/features/screens/home_screen/home_page.dart';
import 'package:management_walk/features/screens/machine_screen.dart';
import 'package:management_walk/features/screens/reports/report1_screen.dart';
import 'package:management_walk/features/screens/safety_screen.dart';
import 'package:management_walk/features/screens/section_store_screen.dart';
import 'package:path/path.dart' as path;
import 'package:shared_preferences/shared_preferences.dart';

import '../../api/api_connection.dart';
import '../../common_widgets/form_header_widget.dart';
import '../../constants/image_strings.dart';
import '../../constants/text_strings.dart';
import '../models/managementGroup_model.dart';
import '../models/managementWalk_model.dart';
import 'category_selection.dart';
import 'gmp_screen.dart';
import 'home_screen/home.dart';
import 'package:http/http.dart' as http;

class ManagementScreen extends StatefulWidget {
  const ManagementScreen({Key? key}) : super(key: key);

  @override
  State<ManagementScreen> createState() => _ManagementScreenState();
}

class _ManagementScreenState extends State<ManagementScreen> {
  var managementID = <int?>[];
  var managementDescs = <String>[];
  var yesChecked = <bool>[];
  var noChecked = <bool>[];
  var notApplyChecked = <bool>[];
  var commentIsSelected = <bool>[];
  var commentIsVisible = <bool>[];
  var commentText = <String>[].obs;
  var runIDText = <String>[];
  var idtemp = "";

  var countComplete = 0;
  RxBool isCanClick = false.obs;

  RxString langaugeText = "TH".obs;
  var languageSelected = "";

  final List<TextEditingController> _controllers = [];

  @override
  void initState() {
    super.initState();

    initIDTemp();

    fetchManagementGroup().then((value) async {
      for (int i = 0; i < value.length; i++) {
        var id = '$idtemp${value[i].questionID}';
        var qID = value[i].questionID.toString();

        String? mwYesCheck = "";
        String? mwNoCheck = "";
        String? mwNotApplyCheck = "";
        String? mwComment = "";
        String? mwRunID = "";

        await fetchManagementWalk(id).then((value1) {
          for (var element in value1) {
            mwYesCheck = element.yesChecked!;
            mwNoCheck = element.noChecked!;
            mwNotApplyCheck = element.notApplyChecked!;
            mwComment = element.comment ?? "";
            mwRunID = element.runID ?? "";
          }
        });

        setState(() {
          managementID.add(int.parse(value[i].questionID!));
          managementDescs.add(value[i].questionDesc!);

          if (mwYesCheck == "1") {
            yesChecked.add(true);
            updateManagementDone(qID);
            // countInt.add(1);
          } else {
            yesChecked.add(false);
            // countInt.add(0);
          }

          if (mwNoCheck == "1") {
            noChecked.add(true);
            updateManagementDone(qID);
          } else {
            noChecked.add(false);
          }

          if (mwNotApplyCheck == "1") {
            notApplyChecked.add(true);
            updateManagementDone(qID);
          } else {
            notApplyChecked.add(false);
          }

          if (mwComment != "") {
            commentText.add(mwComment!);
          } else {
            commentText.add("");
          }

          runIDText.add(mwRunID!);

          commentIsSelected.add(false);
          commentIsVisible.add(false);
        });
      }

      getManagementDone().then(
        (value) {
          countComplete = value[0].countManagementDone!;

          if (countComplete == managementDescs.length) {
            isCanClick = true.obs;
          } else {
            isCanClick = false.obs;
          }
        },
      );
    });
  }

  Future initIDTemp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    languageSelected = (prefs.getString('languageSelected') ?? "TH");

    langaugeText = languageSelected.obs;

    idtemp = prefs.getString('managementWalkID') ?? "";
    if ((prefs.getString('managementDone')) == "completed") {
      isCanClick = true.obs;
    } else {
      isCanClick = false.obs;
    }
  }

  Future<List<ManagementModel>> fetchManagementGroup() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    languageSelected = (prefs.getString('languageSelected') ?? "TH");

    langaugeText = languageSelected.obs;

    if (langaugeText == "TH") {
      final response = await http.get(Uri.parse(API.getManagementGroup));

      if (response.statusCode == 200) {
        final List result = json.decode(response.body);
        return result.map((e) => ManagementModel.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load data');
      }
    } else {
      final response = await http.get(Uri.parse(API.getManagementGroupEN));

      if (response.statusCode == 200) {
        final List result = json.decode(response.body);
        return result.map((e) => ManagementModel.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load data');
      }
    }
  }

  Future<List<ManagementWalkModel>> fetchManagementWalk(String id) async {
    final response = await http.post(
      Uri.parse(API.getManagementWalkByID),
      body: {'keyID': id},
    );

    if (response.statusCode == 200) {
      final List result = json.decode(response.body);
      return result.map((e) => ManagementWalkModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<ManagementDoneModel>> getManagementDone() async {
    try {
      final response = await http.get(Uri.parse(API.countManagementDone));
      if (200 == response.statusCode) {
        List<ManagementDoneModel> list = parseResponse(response.body);
        return list;
      } else {
        return <ManagementDoneModel>[];
      }
    } catch (e) {
      return <ManagementDoneModel>[];
    }
  }

  static List<ManagementDoneModel> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<ManagementDoneModel>((json) => ManagementDoneModel.fromJson(json))
        .toList();
  }

  Future updateCheckBox(String keyID, String finishedDate, String yesCheck,
      String noCheck, String notApplyCheck) async {
    final response = await http.post(
      Uri.parse(API.updateYesChecked),
      body: {
        'keyID': keyID,
        'finishedDate': finishedDate,
        'yesChecked': yesCheck,
        'noChecked': noCheck,
        'notApplyChecked': notApplyCheck,
      },
    );
  }

  Future updateComment(
      String keyID, String finishedDate, String comment) async {
    final response = await http.post(
      Uri.parse(API.updateComment),
      body: {
        'keyID': keyID,
        'finishedDate': finishedDate,
        'comment': comment,
      },
    );
  }

  Future updateImageUrl(
      String keyID, String finishedDate, String imageUrl) async {
    final response = await http.post(
      Uri.parse(API.updateImageUrl),
      body: {
        'keyID': keyID,
        'finishedDate': finishedDate,
        'imageUrl': imageUrl,
      },
    );
  }

  Future updateManagementDone(String questionID) async {
    final response = await http.post(
      Uri.parse(API.updateManagementDone),
      body: {
        'questionID': questionID,
      },
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

  FirebaseStorage storage = FirebaseStorage.instance;

  // ignore: unused_element
  Future<List<Map<String, dynamic>>> _loadImages() async {
    List<Map<String, dynamic>> files = [];

    final ListResult result = await storage.ref().list();
    final List<Reference> allFiles = result.items;

    await Future.forEach<Reference>(allFiles, (file) async {
      final String fileUrl = await file.getDownloadURL();
      final FullMetadata fileMeta = await file.getMetadata();
      files.add({
        "url": fileUrl,
        "path": file.fullPath,
        "uploaded_by": fileMeta.customMetadata?['uploaded_by'] ?? 'Mac-Man',
        "description": fileMeta.customMetadata?['description'] ??
            'Management Walk Activity'
      });
    });

    return files;
  }

  Future<void> _upload(
      String inputSource, int index, String runID, String keyID) async {
    final picker = ImagePicker();
    final FirebaseStorage storage = FirebaseStorage.instance;
    XFile? pickedImage;
    try {
      pickedImage = await picker.pickImage(
          source: inputSource == 'camera'
              ? ImageSource.camera
              : ImageSource.gallery,
          maxWidth: 1920);

      var imageFile = File(pickedImage!.path);
      String fileName = path.basename('managementWalk_image_ID_$runID.jpg');

      try {
        // Uploading the selected image with some custom meta data
        await storage.ref(fileName).putFile(
            imageFile,
            SettableMetadata(customMetadata: {
              'uploaded_by': 'Management Walk App',
              'description': 'Some description...'
            }));

        final Reference ref =
            storage.ref().child('managementWalk_image_ID_$runID.jpg');

        final imageUrl = await ref.getDownloadURL();
        // print(imageUrl);

        var now = DateTime.now();
        var dateText = DateFormat('dd/MM/yyyy').format(now);
        updateImageUrl(keyID, dateText, imageUrl);

        // Refresh the UI
        setState(() {});
      } on FirebaseException catch (error) {
        if (kDebugMode) {
          print(error);
        }
      }
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }
  }

  void showToast(bool isSelected, int index) {
    setState(() {
      switch (isSelected) {
        case true:
          commentIsVisible[index] = true;
          break;
        case false:
          commentIsVisible[index] = false;
          break;
      }
    });
  }

  Future<bool> _onWillPop() async {
    return await Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const CategorySelection()));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: SafeArea(
        child: Scaffold(
          endDrawer: Drawer(
            child: Obx(() => Column(
                  children: [
                    Column(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const FormHeaderWidget(
                          image: tHomeScreenImage,
                          title: tAppName,
                        ),
                      ],
                    ),
                    const Divider(),
                    ListTile(
                      title: Text(
                        langaugeText == "TH".obs ? homeTextTH : homeTextEN,
                        style: TextStyle(fontSize: 20),
                      ),
                      trailing: const Icon(Icons.menu_outlined),
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomePage()));
                      },
                    ),
                    const Divider(),
                    ListTile(
                      title: Text(
                        langaugeText == "TH".obs
                            ? categoryGmpTextTH
                            : categoryGmpTextEN,
                        style: const TextStyle(fontSize: 20),
                      ),
                      trailing: const Icon(Icons.menu_outlined),
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const GMPScreen()));
                      },
                    ),
                    ListTile(
                      title: Text(
                        langaugeText == "TH".obs
                            ? machineHeaderTextTH
                            : machineHeaderTextEN,
                        style: const TextStyle(fontSize: 20),
                      ),
                      trailing: const Icon(Icons.menu_outlined),
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MachineScreen()));
                      },
                    ),
                    ListTile(
                      title: Text(
                        langaugeText == "TH".obs
                            ? sectionStoreTextTH
                            : sectionStoreTextEN,
                        style: const TextStyle(fontSize: 20),
                      ),
                      trailing: const Icon(Icons.menu_outlined),
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SectionStoreScreen()));
                      },
                    ),
                    ListTile(
                      title: Text(
                        langaugeText == "TH".obs ? SafetyTextTH : SafetyTextEN,
                        style: const TextStyle(fontSize: 20),
                      ),
                      trailing: const Icon(Icons.menu_outlined),
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SafetyScreen()));
                      },
                    ),
                    ListTile(
                      title: Text(
                        langaugeText == "TH".obs
                            ? managementTextTH
                            : managementTextEN,
                        style: const TextStyle(fontSize: 20),
                      ),
                      trailing: const Icon(Icons.menu_outlined),
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ManagementScreen()));
                      },
                    ),
                    ListTile(
                      title: Text(
                        langaugeText == "TH".obs ? reportTextTH : reportTextEN,
                        style: TextStyle(fontSize: 20),
                      ),
                      trailing: const Icon(Icons.menu_outlined),
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Report1Screen()));
                      },
                    ),
                  ],
                )),
          ),
          appBar: AppBar(
            backgroundColor: Colors.lightBlue,
            leading: BackButton(
              color: Colors.white,
              onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CategorySelection())),
            ),
            title: Text(
                langaugeText == "TH".obs ? managementTextTH : managementTextEN),
            centerTitle: true,
          ),
          body: Column(
            children: [
              Flexible(
                flex: 10,
                child: ListView.builder(
                  itemCount: managementDescs.length,
                  itemBuilder: (context, index) {
                    _controllers.add(TextEditingController());
                    _controllers[index].text = commentText[index];
                    return Column(
                      children: [
                        Card(
                            child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Text(managementDescs[index]),
                                ),
                                Expanded(
                                    flex: 1,
                                    child: Obx(() => ElevatedButton(
                                        onPressed: () async {
                                          commentIsSelected[index] =
                                              !commentIsSelected[index];
                                          showToast(
                                              commentIsSelected[index], index);
                                        },
                                        style: ElevatedButton.styleFrom(
                                            foregroundColor: Colors.white,
                                            backgroundColor:
                                                commentText[index] == ""
                                                    ? Colors.blue
                                                    : Colors.green),
                                        child: const Text(
                                          "comment",
                                          style: TextStyle(fontSize: 12),
                                        )))),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: CheckboxListTile(
                                    onChanged: (value) async {
                                      var id = '$idtemp${managementID[index]}';
                                      var qID = managementID[index].toString();

                                      setState(() {
                                        yesChecked[index] = true;
                                        noChecked[index] = false;
                                        notApplyChecked[index] = false;
                                        var now = DateTime.now();
                                        var dateText = DateFormat('dd/MM/yyyy')
                                            .format(now);
                                        updateCheckBox(
                                            id, dateText, "1", "0", "0");
                                      });

                                      await updateManagementDone(qID);

                                      await getManagementDone().then(
                                        (value) {
                                          // print(
                                          //     'value: ${value[0].countEquipmentDone}');

                                          countComplete =
                                              value[0].countManagementDone!;

                                          if (countComplete ==
                                              managementDescs.length) {
                                            isCanClick = true.obs;
                                          } else {
                                            isCanClick = false.obs;
                                          }
                                        },
                                      );
                                    },
                                    value: yesChecked[index],
                                    contentPadding: const EdgeInsets.all(4),
                                    title: Transform.translate(
                                        offset: const Offset(20, 0),
                                        child: const Text("Yes")),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: CheckboxListTile(
                                    onChanged: (value) async {
                                      var id = '$idtemp${managementID[index]}';
                                      var qID = managementID[index].toString();

                                      setState(() {
                                        noChecked[index] = true;
                                        yesChecked[index] = false;
                                        notApplyChecked[index] = false;
                                        var now = DateTime.now();
                                        var dateText = DateFormat('dd/MM/yyyy')
                                            .format(now);
                                        updateCheckBox(
                                            id, dateText, "0", "1", "0");
                                        commentIsSelected[index] = true;
                                        showToast(
                                            commentIsSelected[index], index);
                                      });

                                      await updateManagementDone(qID);

                                      await getManagementDone().then(
                                        (value) {
                                          // print(
                                          //     'value: ${value[0].countEquipmentDone}');

                                          countComplete =
                                              value[0].countManagementDone!;

                                          if (countComplete ==
                                              managementDescs.length) {
                                            isCanClick = true.obs;
                                          } else {
                                            isCanClick = false.obs;
                                          }
                                        },
                                      );
                                    },
                                    value: noChecked[index],
                                    contentPadding: const EdgeInsets.all(4),
                                    title: Transform.translate(
                                        offset: const Offset(20, 0),
                                        child: const Text("No")),
                                  ),
                                ),
                                Expanded(
                                  flex: 3,
                                  child: CheckboxListTile(
                                    onChanged: (value) async {
                                      var id = '$idtemp${managementID[index]}';
                                      var qID = managementID[index].toString();

                                      setState(() {
                                        notApplyChecked[index] = true;
                                        yesChecked[index] = false;
                                        noChecked[index] = false;
                                        var now = DateTime.now();
                                        var dateText = DateFormat('dd/MM/yyyy')
                                            .format(now);
                                        updateCheckBox(
                                            id, dateText, "0", "0", "1");
                                      });

                                      await updateManagementDone(qID);

                                      await getManagementDone().then(
                                        (value) {
                                          // print(
                                          //     'value: ${value[0].countEquipmentDone}');

                                          countComplete =
                                              value[0].countManagementDone!;

                                          if (countComplete ==
                                              managementDescs.length) {
                                            isCanClick = true.obs;
                                          } else {
                                            isCanClick = false.obs;
                                          }
                                        },
                                      );
                                    },
                                    value: notApplyChecked[index],
                                    contentPadding: const EdgeInsets.all(8),
                                    title: Transform.translate(
                                        offset: const Offset(20, 0),
                                        child: Obx(() => Text(
                                            langaugeText == "TH".obs
                                                ? notApplyTextTH
                                                : notApplyTextEN))),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: ListTile(
                                    dense: true,
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 0.0),
                                    // leading: Image.asset(tHomeScreenImage),
                                    trailing: IconButton(
                                      onPressed: () async {
                                        var id =
                                            '${idtemp}${managementID[index]}';
                                        await _upload('camera', index,
                                            runIDText[index], id);
                                      },
                                      icon: const Icon(
                                        Icons.camera_alt_outlined,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Visibility(
                              visible: commentIsVisible[index],
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 5,
                                    child: TextField(
                                      controller: _controllers[index],
                                      autofocus: true,
                                      decoration: const InputDecoration(
                                        label: Text("comment"),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: ElevatedButton(
                                          onPressed: () async {
                                            var id =
                                                '${idtemp}${managementID[index]}';
                                            setState(() {
                                              if (noChecked[index] == true) {
                                                if (_controllers[index].text !=
                                                    "") {
                                                  commentIsSelected[index] =
                                                      !commentIsSelected[index];
                                                  commentText[index] =
                                                      _controllers[index].text;
                                                  showToast(
                                                      commentIsSelected[index],
                                                      index);
                                                  var now = DateTime.now();
                                                  var dateText =
                                                      DateFormat('dd/MM/yyyy')
                                                          .format(now);
                                                  updateComment(id, dateText,
                                                      _controllers[index].text);
                                                } else {
                                                  commentIsSelected[index] =
                                                      !commentIsSelected[index];
                                                  commentText[index] =
                                                      _controllers[index].text;
                                                  showToast(
                                                      commentIsSelected[index],
                                                      index);
                                                  var now = DateTime.now();
                                                  var dateText =
                                                      DateFormat('dd/MM/yyyy')
                                                          .format(now);
                                                  updateComment(
                                                      id, dateText, "");
                                                }
                                              } else {
                                                commentIsSelected[index] =
                                                    !commentIsSelected[index];
                                                commentText[index] =
                                                    _controllers[index].text;
                                                showToast(
                                                    commentIsSelected[index],
                                                    index);
                                                var now = DateTime.now();
                                                var dateText =
                                                    DateFormat('dd/MM/yyyy')
                                                        .format(now);
                                                updateComment(id, dateText,
                                                    _controllers[index].text);
                                              }
                                            });
                                          },
                                          child: Obx(() => Text(
                                              langaugeText == "TH".obs
                                                  ? okTextTH
                                                  : okTextEN)))),
                                ],
                              ),
                            ),
                          ],
                        )),
                      ],
                    );
                  },
                ),
              ),
              Flexible(
                flex: 1,
                child: Obx(() => ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: isCanClick == true.obs
                              ? Colors.green
                              : Colors.blue),
                      onPressed: () async {
                        if (isCanClick == true.obs) {
                          // print('count com: $countComplete');
                          // print('is can click: $isCanClick');

                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.setString('managementDone', "completed");

                          Navigator.popAndPushNamed(context, '/categoryScreen');
                        }
                      },
                      child: Text(
                        langaugeText == "TH".obs
                            ? saveReportTextTH
                            : saveReportTextEN,
                        style: const TextStyle(fontSize: 20),
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
