import 'package:flutter/material.dart';
import 'package:management_walk/common_widgets/form_header_widget.dart';
import 'package:management_walk/constants/text_strings.dart';
import 'package:management_walk/features/screens/category_selection.dart';
import 'package:management_walk/features/screens/equipment_screen.dart';
import 'package:management_walk/features/screens/gmp_screen.dart';
import 'package:management_walk/features/screens/home_screen/home_screen.dart';
import 'package:management_walk/features/screens/management_screen.dart';
import 'package:management_walk/features/screens/safety_screen.dart';
import 'package:management_walk/features/screens/section_store_screen.dart';

import '../../constants/image_strings.dart';

class WorkAreaScreen extends StatefulWidget {
  const WorkAreaScreen({super.key});

  @override
  State<WorkAreaScreen> createState() => _WorkAreaScreenState();
}

class _WorkAreaScreenState extends State<WorkAreaScreen> {
  bool _valueNo_Q1 = false;
  bool _valueYes_Q1 = false;
  bool _valueNo_Q2 = false;
  bool _valueYes_Q2 = false;
  bool _valueNo_Q3 = false;
  bool _valueYes_Q3 = false;
  bool _valueNo_Q4 = false;
  bool _valueYes_Q4 = false;
  bool _valueNo_Q5 = false;
  bool _valueYes_Q5 = false;
  bool _valueNo_Q6 = false;
  bool _valueYes_Q6 = false;
  bool _valueNo_Q7 = false;
  bool _valueYes_Q7 = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          endDrawer: menuDrawer(),
          appBar: AppBar(
            backgroundColor: Colors.lightBlue,
            leading: BackButton(
              color: Colors.white,
              onPressed: () => Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => CategorySelection())),
            ),
            title: Text("เครื่องจักร/พื้นที่ทำงาน"),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: Column(
                children: [
                  Card(
                      child: Container(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Text(
                                  "ต้องไม่มีอุปกรณ์หรือสิ่งของใดๆ ที่ไม่เกี่ยวข้อง อยู่ในเครื่องจักร (ตรวจตามซอกเครื่องจักร)"),
                            ),
                            Expanded(
                                flex: 1,
                                child: ElevatedButton(
                                    onPressed: () {}, child: Text("comment"))),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CheckboxListTile(
                                onChanged: (value) {
                                  setState(() {
                                    _valueYes_Q1 = value!;
                                    _valueNo_Q1 = false;
                                  });
                                },
                                value: _valueYes_Q1,
                                title: Text("Yes"),
                              ),
                            ),
                            Expanded(
                              child: CheckboxListTile(
                                onChanged: (value) {
                                  setState(() {
                                    _valueNo_Q1 = value!;
                                    _valueYes_Q1 = false;
                                  });
                                },
                                value: _valueNo_Q1,
                                title: Text("No"),
                              ),
                            ),
                            Expanded(
                              child: ListTile(
                                dense: true,
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 0.0),
                                // leading: Image.asset(tHomeScreenImage),
                                trailing: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.camera_alt_outlined,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
                  SizedBox(
                    height: 10,
                  ),
                  Card(
                      child: Container(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Text(
                                  "ต้องไม่มีอุปกรณ์หรือสิ่งของใดๆ ที่ไม่เกี่ยวข้อง อยู่ในพื้นที่ปฏิบัติงาน"),
                            ),
                            Expanded(
                                flex: 1,
                                child: ElevatedButton(
                                    onPressed: () {}, child: Text("comment"))),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CheckboxListTile(
                                onChanged: (value) {
                                  setState(() {
                                    _valueYes_Q2 = value!;
                                    _valueNo_Q2 = false;
                                  });
                                },
                                value: _valueYes_Q2,
                                title: Text("Yes"),
                              ),
                            ),
                            Expanded(
                              child: CheckboxListTile(
                                onChanged: (value) {
                                  setState(() {
                                    _valueNo_Q2 = value!;
                                    _valueYes_Q2 = false;
                                  });
                                },
                                value: _valueNo_Q2,
                                title: Text("No"),
                              ),
                            ),
                            Expanded(
                              child: ListTile(
                                dense: true,
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 0.0),
                                // leading: Image.asset(tHomeScreenImage),
                                trailing: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.camera_alt_outlined,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
                  Card(
                      child: Container(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Text(
                                  "บริเวณที่รับผิดชอบต้องสะอาด ไม่มีเศษขยะ หรือวัสดุใดๆ ที่ไม่เกี่ยวข้องกับงานช่าง"),
                            ),
                            Expanded(
                                flex: 1,
                                child: ElevatedButton(
                                    onPressed: () {}, child: Text("comment"))),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CheckboxListTile(
                                onChanged: (value) {
                                  setState(() {
                                    _valueYes_Q3 = value!;
                                    _valueNo_Q3 = false;
                                  });
                                },
                                value: _valueYes_Q3,
                                title: Text("Yes"),
                              ),
                            ),
                            Expanded(
                              child: CheckboxListTile(
                                onChanged: (value) {
                                  setState(() {
                                    _valueNo_Q3 = value!;
                                    _valueYes_Q3 = false;
                                  });
                                },
                                value: _valueNo_Q3,
                                title: Text("No"),
                              ),
                            ),
                            Expanded(
                              child: ListTile(
                                dense: true,
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 0.0),
                                // leading: Image.asset(tHomeScreenImage),
                                trailing: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.camera_alt_outlined,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
                  Card(
                      child: Container(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Text("เครื่องจักรสะอาด ไม่มีคราบสกปรก"),
                            ),
                            Expanded(
                                flex: 1,
                                child: ElevatedButton(
                                    onPressed: () {}, child: Text("comment"))),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CheckboxListTile(
                                onChanged: (value) {
                                  setState(() {
                                    _valueYes_Q4 = value!;
                                    _valueNo_Q4 = false;
                                  });
                                },
                                value: _valueYes_Q4,
                                title: Text("Yes"),
                              ),
                            ),
                            Expanded(
                              child: CheckboxListTile(
                                onChanged: (value) {
                                  setState(() {
                                    _valueNo_Q4 = value!;
                                    _valueYes_Q4 = false;
                                  });
                                },
                                value: _valueNo_Q4,
                                title: Text("No"),
                              ),
                            ),
                            Expanded(
                              child: ListTile(
                                dense: true,
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 0.0),
                                // leading: Image.asset(tHomeScreenImage),
                                trailing: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.camera_alt_outlined,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
                  Card(
                      child: Container(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Text(
                                  "เครื่องจักรอยู่ในสภาพดี  ไม่ชำรุด  ไม่เสื่อมสภาพ"),
                            ),
                            Expanded(
                                flex: 1,
                                child: ElevatedButton(
                                    onPressed: () {}, child: Text("comment"))),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CheckboxListTile(
                                onChanged: (value) {
                                  setState(() {
                                    _valueYes_Q5 = value!;
                                    _valueNo_Q5 = false;
                                  });
                                },
                                value: _valueYes_Q5,
                                title: Text("Yes"),
                              ),
                            ),
                            Expanded(
                              child: CheckboxListTile(
                                onChanged: (value) {
                                  setState(() {
                                    _valueNo_Q5 = value!;
                                    _valueYes_Q5 = false;
                                  });
                                },
                                value: _valueNo_Q5,
                                title: Text("No"),
                              ),
                            ),
                            Expanded(
                              child: ListTile(
                                dense: true,
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 0.0),
                                // leading: Image.asset(tHomeScreenImage),
                                trailing: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.camera_alt_outlined,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
                  Card(
                      child: Container(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Text(
                                  "สถานที่ปฏิบัติงานต้องมีความปลอดภัย ไม่พบสิ่งก่อให้เกิดอันตราย"),
                            ),
                            Expanded(
                                flex: 1,
                                child: ElevatedButton(
                                    onPressed: () {}, child: Text("comment"))),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CheckboxListTile(
                                onChanged: (value) {
                                  setState(() {
                                    _valueYes_Q6 = value!;
                                    _valueNo_Q6 = false;
                                  });
                                },
                                value: _valueYes_Q6,
                                title: Text("Yes"),
                              ),
                            ),
                            Expanded(
                              child: CheckboxListTile(
                                onChanged: (value) {
                                  setState(() {
                                    _valueNo_Q6 = value!;
                                    _valueYes_Q6 = false;
                                  });
                                },
                                value: _valueNo_Q6,
                                title: Text("No"),
                              ),
                            ),
                            Expanded(
                              child: ListTile(
                                dense: true,
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 0.0),
                                // leading: Image.asset(tHomeScreenImage),
                                trailing: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.camera_alt_outlined,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
                  Card(
                      child: Container(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Text("อื่นๆ (ระบุ)"),
                            ),
                            Expanded(
                                flex: 1,
                                child: ElevatedButton(
                                    onPressed: () {}, child: Text("comment"))),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CheckboxListTile(
                                onChanged: (value) {
                                  setState(() {
                                    _valueYes_Q7 = value!;
                                    _valueNo_Q7 = false;
                                  });
                                },
                                value: _valueYes_Q7,
                                title: Text("Yes"),
                              ),
                            ),
                            Expanded(
                              child: CheckboxListTile(
                                onChanged: (value) {
                                  setState(() {
                                    _valueNo_Q7 = value!;
                                    _valueYes_Q7 = false;
                                  });
                                },
                                value: _valueNo_Q7,
                                title: Text("No"),
                              ),
                            ),
                            Expanded(
                              child: ListTile(
                                dense: true,
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 0.0),
                                // leading: Image.asset(tHomeScreenImage),
                                trailing: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.camera_alt_outlined,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ))
                ],
              ),
            ),
          )),
    );
  }
}

class menuDrawer extends StatelessWidget {
  const menuDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
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
            title: const Text(
              "Home",
              style: TextStyle(fontSize: 20),
            ),
            trailing: const Icon(Icons.menu_outlined),
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
            },
          ),
          const Divider(),
          ListTile(
            title: const Text(
              "เครื่องมือ / อะไหล่",
              style: TextStyle(fontSize: 20),
            ),
            trailing: const Icon(Icons.menu_outlined),
            onTap: () {
              // Navigator.pushReplacement(context,
              //     MaterialPageRoute(builder: (context) => EquipmentScreen()));
            },
          ),
          ListTile(
            title: const Text(
              "GMP",
              style: TextStyle(fontSize: 20),
            ),
            trailing: const Icon(Icons.menu_outlined),
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => GMPScreen()));
            },
          ),
          ListTile(
            title: const Text(
              "Section Store",
              style: TextStyle(fontSize: 20),
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
            title: const Text(
              "Safety / PPE",
              style: TextStyle(fontSize: 20),
            ),
            trailing: const Icon(Icons.menu_outlined),
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => SafetyScreen()));
            },
          ),
          ListTile(
            title: const Text(
              "การบริหารจัดการ",
              style: TextStyle(fontSize: 20),
            ),
            trailing: const Icon(Icons.menu_outlined),
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => ManagementScreen()));
            },
          ),
        ],
      ),
    );
  }
}
