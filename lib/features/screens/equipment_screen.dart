// // ignore_for_file: use_build_context_synchronously

// import 'dart:io';
// import 'package:flutter/foundation.dart';

// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';
// import 'package:management_walk/api/sheets/equipment_sheet_api.dart';
// import 'package:management_walk/api/sheets/key_for_search_sheet_api.dart';
// import 'package:management_walk/api/sheets/management_walk_sheet_api.dart';
// import 'package:management_walk/features/models/equipment_model.dart';
// import 'package:management_walk/features/models/key_for_search_model.dart';
// import 'package:management_walk/features/models/management_walk_model.dart';
// import 'package:management_walk/features/screens/dashboard.dart';
// import 'package:management_walk/features/screens/home_screen/home_page.dart';
// import 'package:management_walk/features/screens/machine_screen.dart';
// import 'package:management_walk/features/screens/safety_screen.dart';
// import 'package:management_walk/features/screens/section_store_screen.dart';
// import 'package:path/path.dart' as path;
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../common_widgets/form_header_widget.dart';
// import '../../constants/image_strings.dart';
// import '../../constants/text_strings.dart';
// import 'category_selection.dart';
// import 'gmp_screen.dart';
// import 'management_screen.dart';

// class Equipment extends StatefulWidget {
//   const Equipment({Key? key}) : super(key: key);

//   @override
//   State<Equipment> createState() => _EquipmentState();
// }

// class _EquipmentState extends State<Equipment> {
//   List<EquipmentGroup> equipmentGroups = [];
//   int index = 0;
//   List<ManagementWalk> managementWalks = [];
//   int managementWalkIndex = 0;
//   var equipmentID = <int?>[];
//   var equipmentDescs = <String>[];
//   var yesChecked = <bool>[];
//   var noChecked = <bool>[];
//   var notApplyChecked = <bool>[];
//   var commentIsSelected = <bool>[];
//   var commentIsVisible = <bool>[];
//   var commentText = <String>[].obs;
//   KeyForSearch? keyForSearch;
//   ManagementWalk? _managementWalk;
//   var idtemp = "";

//   var countComplete = 0;
//   var countInt = <int>[];

//   final List<TextEditingController> _controllers = [];

//   @override
//   void initState() {
//     super.initState();

//     initIDTemp();
//     getManagementWalk();
//     getEquipmentGroups();
//   }

//   @override
//   void didUpdateWidget(covariant Equipment oldWidget) {
//     super.didUpdateWidget(oldWidget);

//     // initIDTemp();
//     getEquipmentGroups();
//   }

//   Future initIDTemp() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     idtemp = prefs.getString('managementWalkID') ?? "";
//   }

//   Future getManagementWalk({int index = 0}) async {
//     final managementWalks = await ManagementWalkSheetsApi.getAll();

//     setState(() {
//       this.managementWalks = managementWalks;
//     });
//   }

//   Future getManagementWalkByID(int qID) async {
//     final _managementWalk = await ManagementWalkSheetsApi.getById(qID);

//     setState(() {
//       this._managementWalk = _managementWalk;
//     });
//   }

//   Future getRunIDByKeyID(String qID) async {
//     final keyForSearch = await KeyForSearchSheetsApi.getById(qID);

//     setState(() {
//       this.keyForSearch = keyForSearch;
//     });
//   }

//   Future getEquipmentGroups({int index = 0}) async {
//     final equipmentGroups = await EquipmentSheetApi.getAll();
//     var countComplete = 0;

//     SharedPreferences prefs = await SharedPreferences.getInstance();

//     showLoading(context, text: 'Loading');

//     setState(() {
//       this.equipmentGroups = equipmentGroups;
//     });

//     for (int i = 0; i < equipmentGroups.length; i++) {
//       var id = '$idtemp${equipmentGroups[i].questionID}';
//       await getRunIDByKeyID(id);
//       var runIDTemp = keyForSearch?.runID ?? 0;
//       final runID = runIDTemp;
//       await getManagementWalkByID(runID);
//       if (_managementWalk?.yesChecked == "true") {
//         yesChecked.add(true);
//         countInt.add(1);
//       } else {
//         yesChecked.add(false);
//         countInt.add(0);
//       }

//       if (_managementWalk?.noChecked == "true") {
//         noChecked.add(true);
//         countInt.add(1);
//       } else {
//         noChecked.add(false);
//         countInt.add(0);
//       }

//       if (_managementWalk?.notApplyChecked == "true") {
//         notApplyChecked.add(true);
//         countInt.add(1);
//       } else {
//         notApplyChecked.add(false);
//         countInt.add(0);
//       }

//       if (_managementWalk?.comment != "") {
//         commentText.add(_managementWalk?.comment ?? "");
//       } else {
//         commentText.add("");
//       }

//       equipmentID.add(equipmentGroups[i].questionID);
//       equipmentDescs.add(equipmentGroups[i].questionDesc);
//       commentIsSelected.add(false);
//       commentIsVisible.add(false);

//       if (_managementWalk?.yesChecked != null) {
//         countComplete = countComplete + 1;
//       }
//     }

//     if (countComplete == equipmentGroups.length) {
//       prefs.setString('equipmentCompleted', "yes");
//     }

//     hideLoading(context);

//     // equipmentGroups.forEach((element) async {
//     //   // print(element.questionID);
//     //   var id = '$idtemp${element.questionID}';
//     //   await getRunIDByKeyID(id);
//     //   var runIDTemp = keyForSearch?.runID ?? 0;
//     //   final runID = runIDTemp;
//     //   await getManagementWalkByID(runID);
//     //   if (_managementWalk?.yesChecked == "true") {
//     //     yesChecked.add(true);
//     //   } else {
//     //     yesChecked.add(false);
//     //   }

//     //   if (_managementWalk?.noChecked == "true") {
//     //     noChecked.add(true);
//     //   } else {
//     //     noChecked.add(false);
//     //   }

//     //   if (_managementWalk?.notApplyChecked == "true") {
//     //     notApplyChecked.add(true);
//     //   } else {
//     //     notApplyChecked.add(false);
//     //   }

//     //   if (_managementWalk?.comment != "") {
//     //     commentText.add(_managementWalk?.comment ?? "");
//     //   }

//     //   equipmentID.add(element.questionID);
//     //   equipmentDescs.add(element.questionDesc);
//     //   // yesChecked.add(false);
//     //   // noChecked.add(false);
//     //   // notApplyChecked.add(false);
//     //   commentIsSelected.add(false);
//     //   commentIsVisible.add(false);
//     // });

//     print(countInt);
//   }

//   void showLoading(BuildContext context, {required String text}) {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (_) {
//         return SimpleDialog(
//           children: <Widget>[
//             Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 CircularProgressIndicator(
//                   color: Theme.of(context).primaryColor,
//                 ),
//                 const SizedBox(height: 10),
//                 Text(text, textAlign: TextAlign.center),
//               ],
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void hideLoading(BuildContext context) {
//     if (Navigator.canPop(context)) {
//       Navigator.of(context).pop();
//     }
//   }

//   FirebaseStorage storage = FirebaseStorage.instance;

//   // ignore: unused_element
//   Future<List<Map<String, dynamic>>> _loadImages() async {
//     List<Map<String, dynamic>> files = [];

//     final ListResult result = await storage.ref().list();
//     final List<Reference> allFiles = result.items;

//     await Future.forEach<Reference>(allFiles, (file) async {
//       final String fileUrl = await file.getDownloadURL();
//       final FullMetadata fileMeta = await file.getMetadata();
//       files.add({
//         "url": fileUrl,
//         "path": file.fullPath,
//         "uploaded_by": fileMeta.customMetadata?['uploaded_by'] ?? 'Mac-Man',
//         "description": fileMeta.customMetadata?['description'] ??
//             'Management Walk Activity'
//       });
//     });

//     return files;
//   }

//   Future<void> _upload(String inputSource, int index, int runID) async {
//     final picker = ImagePicker();
//     final FirebaseStorage storage = FirebaseStorage.instance;
//     XFile? pickedImage;
//     try {
//       pickedImage = await picker.pickImage(
//           source: inputSource == 'camera'
//               ? ImageSource.camera
//               : ImageSource.gallery,
//           maxWidth: 1920);

//       var imageFile = File(pickedImage!.path);
//       String fileName = path.basename('managementWalk_image_ID_$runID.jpg');

//       // final String fileName = path.basename(pickedImage!.path);
//       // File imageFile = File(pickedImage.path);

//       // SharedPreferences prefs = await SharedPreferences.getInstance();
//       // prefs.setString('managementWalk_image_ID_$runID', fileName);

//       try {
//         // Uploading the selected image with some custom meta data
//         await storage.ref(fileName).putFile(
//             imageFile,
//             SettableMetadata(customMetadata: {
//               'uploaded_by': 'Management Walk App',
//               'description': 'Some description...'
//             }));

//         final Reference ref =
//             storage.ref().child('managementWalk_image_ID_$runID.jpg');

//         final imageUrl = await ref.getDownloadURL();
//         // print(imageUrl);

//         ManagementWalkSheetsApi.updateCell(
//             id: runID, key: 'imageUrl', value: imageUrl);

//         // Refresh the UI
//         setState(() {});
//       } on FirebaseException catch (error) {
//         if (kDebugMode) {
//           print(error);
//         }
//       }
//     } catch (err) {
//       if (kDebugMode) {
//         print(err);
//       }
//     }
//   }

//   void showToast(bool isSelected, int index) {
//     setState(() {
//       switch (isSelected) {
//         case true:
//           commentIsVisible[index] = true;
//           break;
//         case false:
//           commentIsVisible[index] = false;
//           break;
//       }
//     });
//   }

//   Future<void> generateReport1(int index) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();

//     var id = '${idtemp}${equipmentID[index]}';
//     await getRunIDByKeyID(id);
//     var runIDTemp = keyForSearch?.runID ?? 0;
//     final runID = runIDTemp;

//     if (prefs.getString('equipmentComment$runID') != "") {
//       _controllers[index].text =
//           prefs.getString('equipmentComment${runID}') ?? "";
//     } else {
//       _controllers[index].text = "";
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         endDrawer: menuDrawer(),
//         appBar: AppBar(
//           backgroundColor: Colors.lightBlue,
//           leading: BackButton(
//             color: Colors.white,
//             onPressed: () => Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) => const CategorySelection())),
//           ),
//           title: const Text("เครื่องมือ/อะไหล่"),
//           centerTitle: true,
//         ),
//         body: ListView.builder(
//           itemCount: equipmentDescs.length,
//           itemBuilder: (context, index) {
//             _controllers.add(TextEditingController());
//             // generateReport1(index);
//             _controllers[index].text = commentText[index];
//             return Column(
//               children: [
//                 Card(
//                     child: Column(
//                   children: [
//                     Row(
//                       children: [
//                         Expanded(
//                           flex: 3,
//                           child: Text(equipmentDescs[index]),
//                         ),
//                         Expanded(
//                             flex: 1,
//                             child: Obx(() => ElevatedButton(
//                                 onPressed: () async {
//                                   setState(() {
//                                     commentIsSelected[index] =
//                                         !commentIsSelected[index];
//                                     showToast(commentIsSelected[index], index);
//                                   });
//                                 },
//                                 style: ElevatedButton.styleFrom(
//                                     foregroundColor: Colors.white,
//                                     backgroundColor: commentText[index] == ""
//                                         ? Colors.blue
//                                         : Colors.green),
//                                 child: const Text("comment")))),
//                       ],
//                     ),
//                     Row(
//                       children: [
//                         Expanded(
//                           flex: 2,
//                           child: CheckboxListTile(
//                             onChanged: (value) async {
//                               var id = '$idtemp${equipmentID[index]}';
//                               await getRunIDByKeyID(id);
//                               var runIDTemp = keyForSearch?.runID ?? 0;
//                               final runID = runIDTemp;
//                               setState(() {
//                                 yesChecked[index] = true;
//                                 noChecked[index] = false;
//                                 notApplyChecked[index] = false;
//                                 ManagementWalkSheetsApi.updateCell(
//                                     id: runID, key: 'yesChecked', value: true);
//                                 ManagementWalkSheetsApi.updateCell(
//                                     id: runID, key: 'noChecked', value: false);
//                                 ManagementWalkSheetsApi.updateCell(
//                                     id: runID,
//                                     key: 'notApplyChecked',
//                                     value: false);
//                                 var now = DateTime.now();
//                                 var dateText =
//                                     DateFormat('dd/MM/yyyy').format(now);
//                                 ManagementWalkSheetsApi.updateCell(
//                                     id: runID,
//                                     key: 'finishedDate',
//                                     value: dateText);
//                               });
//                             },
//                             value: yesChecked[index],
//                             contentPadding: const EdgeInsets.all(4),
//                             title: Transform.translate(
//                                 offset: const Offset(20, 0),
//                                 child: const Text("Yes")),
//                           ),
//                         ),
//                         Expanded(
//                           flex: 2,
//                           child: CheckboxListTile(
//                             onChanged: (value) async {
//                               var id = '${idtemp}${equipmentID[index]}';
//                               await getRunIDByKeyID(id);
//                               var runIDTemp = keyForSearch?.runID ?? 0;
//                               final runID = runIDTemp;
//                               setState(() {
//                                 noChecked[index] = true;
//                                 yesChecked[index] = false;
//                                 notApplyChecked[index] = false;
//                                 ManagementWalkSheetsApi.updateCell(
//                                     id: runID, key: 'yesChecked', value: false);
//                                 ManagementWalkSheetsApi.updateCell(
//                                     id: runID, key: 'noChecked', value: true);
//                                 ManagementWalkSheetsApi.updateCell(
//                                     id: runID,
//                                     key: 'notApplyChecked',
//                                     value: false);
//                                 var now = DateTime.now();
//                                 var dateText =
//                                     DateFormat('dd/MM/yyyy').format(now);
//                                 ManagementWalkSheetsApi.updateCell(
//                                     id: runID,
//                                     key: 'finishedDate',
//                                     value: dateText);
//                                 commentIsSelected[index] = true;
//                                 showToast(commentIsSelected[index], index);
//                               });
//                             },
//                             value: noChecked[index],
//                             contentPadding: const EdgeInsets.all(4),
//                             title: Transform.translate(
//                                 offset: const Offset(20, 0),
//                                 child: const Text("No")),
//                           ),
//                         ),
//                         Expanded(
//                           flex: 3,
//                           child: CheckboxListTile(
//                             onChanged: (value) async {
//                               var id = '${idtemp}${equipmentID[index]}';
//                               await getRunIDByKeyID(id);
//                               var runIDTemp = keyForSearch?.runID ?? 0;
//                               final runID = runIDTemp;
//                               setState(() {
//                                 notApplyChecked[index] = true;
//                                 yesChecked[index] = false;
//                                 noChecked[index] = false;
//                                 ManagementWalkSheetsApi.updateCell(
//                                     id: runID, key: 'yesChecked', value: false);
//                                 ManagementWalkSheetsApi.updateCell(
//                                     id: runID, key: 'noChecked', value: false);
//                                 ManagementWalkSheetsApi.updateCell(
//                                     id: runID,
//                                     key: 'notApplyChecked',
//                                     value: true);
//                                 var now = DateTime.now();
//                                 var dateText =
//                                     DateFormat('dd/MM/yyyy').format(now);
//                                 ManagementWalkSheetsApi.updateCell(
//                                     id: runID,
//                                     key: 'finishedDate',
//                                     value: dateText);
//                               });
//                             },
//                             value: notApplyChecked[index],
//                             contentPadding: const EdgeInsets.all(8),
//                             title: Transform.translate(
//                                 offset: const Offset(20, 0),
//                                 child: const Text("ไม่ตรวจ")),
//                           ),
//                         ),
//                         Expanded(
//                           flex: 1,
//                           child: ListTile(
//                             dense: true,
//                             contentPadding:
//                                 const EdgeInsets.symmetric(horizontal: 0.0),
//                             // leading: Image.asset(tHomeScreenImage),
//                             trailing: IconButton(
//                               onPressed: () async {
//                                 var id = '${idtemp}${equipmentID[index]}';
//                                 await getRunIDByKeyID(id);
//                                 var runIDTemp = keyForSearch?.runID ?? 0;
//                                 final runID = runIDTemp;
//                                 await _upload('camera', index, runID);
//                               },
//                               icon: const Icon(
//                                 Icons.camera_alt_outlined,
//                                 color: Colors.red,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     Visibility(
//                       visible: commentIsVisible[index],
//                       child: Row(
//                         children: [
//                           Expanded(
//                             flex: 5,
//                             child: TextField(
//                               controller: _controllers[index],
//                               autofocus: true,
//                               decoration: const InputDecoration(
//                                 label: Text("comment"),
//                               ),
//                             ),
//                           ),
//                           const SizedBox(
//                             width: 5,
//                           ),
//                           Expanded(
//                               flex: 1,
//                               child: ElevatedButton(
//                                   onPressed: () async {
//                                     var id = '${idtemp}${equipmentID[index]}';
//                                     await getRunIDByKeyID(id);
//                                     var runIDTemp = keyForSearch?.runID ?? 0;
//                                     final runID = runIDTemp;
//                                     setState(() {
//                                       if (noChecked[index] == true) {
//                                         if (_controllers[index].text != "") {
//                                           commentIsSelected[index] =
//                                               !commentIsSelected[index];
//                                           commentText[index] =
//                                               _controllers[index].text;
//                                           showToast(
//                                               commentIsSelected[index], index);
//                                           ManagementWalkSheetsApi.updateCell(
//                                               id: runID,
//                                               key: 'comment',
//                                               value: _controllers[index].text);
//                                           // Navigator.popAndPushNamed(
//                                           //     context, '/equipment');
//                                         }
//                                       } else {
//                                         commentIsSelected[index] =
//                                             !commentIsSelected[index];
//                                         commentText[index] =
//                                             _controllers[index].text;
//                                         showToast(
//                                             commentIsSelected[index], index);
//                                         ManagementWalkSheetsApi.updateCell(
//                                             id: runID,
//                                             key: 'comment',
//                                             value: _controllers[index].text);
//                                         // Navigator.popAndPushNamed(
//                                         //     context, '/equipment');
//                                       }
//                                     });
//                                   },
//                                   child: const Text("ตกลง"))),
//                         ],
//                       ),
//                     ),
//                   ],
//                 )),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

// class menuDrawer extends StatelessWidget {
//   const menuDrawer({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: Column(
//         children: [
//           Column(
//             // ignore: prefer_const_literals_to_create_immutables
//             children: [
//               const FormHeaderWidget(
//                 image: tHomeScreenImage,
//                 title: tAppName,
//               ),
//             ],
//           ),
//           const Divider(),
//           ListTile(
//             title: const Text(
//               "Home",
//               style: TextStyle(fontSize: 20),
//             ),
//             trailing: const Icon(Icons.menu_outlined),
//             onTap: () {
//               Navigator.pushReplacement(
//                   context, MaterialPageRoute(builder: (context) => HomePage()));
//             },
//           ),
//           const Divider(),
//           ListTile(
//             title: const Text(
//               "GMP",
//               style: TextStyle(fontSize: 20),
//             ),
//             trailing: const Icon(Icons.menu_outlined),
//             onTap: () {
//               Navigator.pushReplacement(context,
//                   MaterialPageRoute(builder: (context) => GMPScreen()));
//             },
//           ),
//           ListTile(
//             title: const Text(
//               "เครื่องจักร / พื้นที่ทำงาน",
//               style: TextStyle(fontSize: 20),
//             ),
//             trailing: const Icon(Icons.menu_outlined),
//             onTap: () {
//               Navigator.pushReplacement(context,
//                   MaterialPageRoute(builder: (context) => MachineScreen()));
//             },
//           ),
//           ListTile(
//             title: const Text(
//               "Section Store",
//               style: TextStyle(fontSize: 20),
//             ),
//             trailing: const Icon(Icons.menu_outlined),
//             onTap: () {
//               Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => SectionStoreScreen()));
//             },
//           ),
//           ListTile(
//             title: const Text(
//               "Safety / PPE",
//               style: TextStyle(fontSize: 20),
//             ),
//             trailing: const Icon(Icons.menu_outlined),
//             onTap: () {
//               Navigator.pushReplacement(context,
//                   MaterialPageRoute(builder: (context) => SafetyScreen()));
//             },
//           ),
//           ListTile(
//             title: const Text(
//               "การบริหารจัดการ",
//               style: TextStyle(fontSize: 20),
//             ),
//             trailing: const Icon(Icons.menu_outlined),
//             onTap: () {
//               Navigator.pushReplacement(context,
//                   MaterialPageRoute(builder: (context) => ManagementScreen()));
//             },
//           ),
//           ListTile(
//             title: const Text(
//               "รายงาน",
//               style: TextStyle(fontSize: 20),
//             ),
//             trailing: const Icon(Icons.menu_outlined),
//             onTap: () {
//               Navigator.pushReplacement(context,
//                   MaterialPageRoute(builder: (context) => DashBoard()));
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
