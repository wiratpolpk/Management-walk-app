import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:management_walk/api/api_connection.dart';
import 'package:management_walk/common_widgets/form_header_widget.dart';
import 'package:management_walk/constants/image_strings.dart';
import 'package:management_walk/constants/text_strings.dart';
import 'package:management_walk/features/models/report8_model.dart';

import 'package:http/http.dart' as http;
import 'package:management_walk/features/screens/home_screen/home_page.dart';
import 'package:management_walk/features/screens/reports/report1_screen.dart';
import 'package:management_walk/features/screens/reports/report2_screen.dart';
import 'package:management_walk/features/screens/reports/report3_screen.dart';
import 'package:management_walk/features/screens/reports/report4_screen.dart';
import 'package:management_walk/features/screens/reports/report5_screen.dart';
import 'package:management_walk/features/screens/reports/report6_screen.dart';
import 'package:management_walk/features/screens/reports/report7_screen.dart';

class Report8Screen extends StatefulWidget {
  const Report8Screen({super.key});

  @override
  State<Report8Screen> createState() => _Report8ScreenState();
}

class _Report8ScreenState extends State<Report8Screen> {
  List<Report8Model> report8s = [];
  List<Report8Model> chart8s = [];

  @override
  void initState() {
    super.initState();
    report8s = [];
    chart8s = [];

    _getReport8();

    _getChart8();
  }

  //REPORT 8

  _getReport8() {
    getReport8().then((value) {
      setState(() {
        report8s = value;
      });
    });
  }

  _getChart8() {
    getChart8().then((value) {
      setState(() {
        chart8s = value;
      });
    });
  }

  Future<List<Report8Model>> getReport8() async {
    try {
      final response = await http.get(Uri.parse(API.report8));
      // print('getReport8 response: ${response.body}');
      if (200 == response.statusCode) {
        List<Report8Model> list = parseResponse8(response.body);
        return list;
      } else {
        return <Report8Model>[];
      }
    } catch (e) {
      return <Report8Model>[];
    }
  }

  Future<List<Report8Model>> getChart8() async {
    try {
      final response = await http.get(Uri.parse(API.chart8));
      // print('getReport8 response: ${response.body}');
      if (200 == response.statusCode) {
        List<Report8Model> list = parseResponse8(response.body);
        return list;
      } else {
        return <Report8Model>[];
      }
    } catch (e) {
      return <Report8Model>[];
    }
  }

  static List<Report8Model> parseResponse8(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<Report8Model>((json) => Report8Model.fromJson(json))
        .toList();
  }

  Widget buildDataTableReport8() {
    // final columns = ['Supervisor', 'ไม่ตรวจ'];
    return DataTable(
      border: TableBorder.all(
        width: 1.0,
      ),
      columns: const [
        DataColumn(
          label: Text(
            'Supervisor',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        DataColumn(
          label: Text(
            'ไม่ตรวจ',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ],
      rows: report8s
          .map(
            (report8) => DataRow(cells: [
              DataCell(
                Text(
                  report8.supervisorName!,
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
              DataCell(
                Text(
                  report8.notApplyChecked.toString(),
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
            ]),
          )
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        endDrawer: const ReportDrawer(),
        appBar: AppBar(
          title: const Text('รายงาน'),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  "รายงานแสดงคำตอบ 'ไม่ตรวจ' แบ่งตามหัวหน้างาน",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 8,
                ),
                buildDataTableReport8(),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ReportDrawer extends StatelessWidget {
  const ReportDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
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
                style: TextStyle(fontSize: 16),
              ),
              trailing: const Icon(Icons.menu_outlined),
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const HomePage()));
              },
            ),
            const Divider(),
            ListTile(
              title: const Text(
                "พฤติกรรมที่เหมาะสมแบ่งตามประเภทการประเมิน",
                style: TextStyle(fontSize: 12),
              ),
              trailing: const Icon(Icons.menu_outlined),
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Report1Screen()));
              },
            ),
            ListTile(
              title: const Text(
                "พฤติกรรมที่ไม่เหมาะสมแบ่งตามประเภทการประเมิน",
                style: TextStyle(fontSize: 12),
              ),
              trailing: const Icon(Icons.menu_outlined),
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Report2Screen()));
              },
            ),
            ListTile(
              title: const Text(
                "พฤติกรรมที่เหมาะสมแบ่งตามหน่วยงาน",
                style: TextStyle(fontSize: 12),
              ),
              trailing: const Icon(Icons.menu_outlined),
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Report3Screen()));
              },
            ),
            ListTile(
              title: const Text(
                "พฤติกรรมที่ไม่เหมาะสมแบ่งตามหน่วยงาน",
                style: TextStyle(fontSize: 12),
              ),
              trailing: const Icon(Icons.menu_outlined),
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Report4Screen()));
              },
            ),
            ListTile(
              title: const Text(
                "พฤติกรรมที่เหมาะสมแบ่งตาม Work commitment",
                style: TextStyle(fontSize: 12),
              ),
              trailing: const Icon(Icons.menu_outlined),
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Report5Screen()));
              },
            ),
            ListTile(
              title: const Text(
                "พฤติกรรมที่ไม่เหมาะสมแบ่งตาม Work commitment",
                style: TextStyle(fontSize: 12),
              ),
              trailing: const Icon(Icons.menu_outlined),
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Report6Screen()));
              },
            ),
            ListTile(
              title: const Text(
                "การให้ความร่วมมือในการทำรายงานแบ่งตามหัวหน้างาน",
                style: TextStyle(fontSize: 12),
              ),
              trailing: const Icon(Icons.menu_outlined),
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Report7Screen()));
              },
            ),
            ListTile(
              title: const Text(
                "รายงานแสดงคำตอบ 'ไม่ตรวจ' แบ่งตามหัวหน้างาน",
                style: TextStyle(fontSize: 12),
              ),
              trailing: const Icon(Icons.menu_outlined),
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Report8Screen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
