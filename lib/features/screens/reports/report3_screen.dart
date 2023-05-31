import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:management_walk/api/api_connection.dart';
import 'package:management_walk/common_widgets/form_header_widget.dart';
import 'package:management_walk/constants/image_strings.dart';
import 'package:management_walk/constants/text_strings.dart';
import 'package:management_walk/features/models/report3_model.dart';

import 'package:http/http.dart' as http;
import 'package:management_walk/features/screens/home_screen/home_page.dart';
import 'package:management_walk/features/screens/reports/report1_screen.dart';
import 'package:management_walk/features/screens/reports/report2_screen.dart';
import 'package:management_walk/features/screens/reports/report4_screen.dart';
import 'package:management_walk/features/screens/reports/report5_screen.dart';
import 'package:management_walk/features/screens/reports/report6_screen.dart';
import 'package:management_walk/features/screens/reports/report7_screen.dart';
import 'package:management_walk/features/screens/reports/report8_screen.dart';

class Report3Screen extends StatefulWidget {
  const Report3Screen({super.key});

  @override
  State<Report3Screen> createState() => _Report3ScreenState();
}

class _Report3ScreenState extends State<Report3Screen> {
  List<Report3Model> report3s = [];
  List<Report3Model> chart3s = [];

  @override
  void initState() {
    super.initState();
    report3s = [];
    chart3s = [];

    _getReport3();

    _getChart3();
  }

  //REPORT 3

  _getReport3() {
    getReport3().then((value) {
      setState(() {
        report3s = value;
      });
    });
  }

  _getChart3() {
    getChart3().then((value) {
      setState(() {
        chart3s = value;
      });
    });
  }

  Future<List<Report3Model>> getReport3() async {
    try {
      final response = await http.get(Uri.parse(API.report3));
      // print('getReport3 response: ${response.body}');
      if (200 == response.statusCode) {
        List<Report3Model> list = parseResponse3(response.body);
        return list;
      } else {
        return <Report3Model>[];
      }
    } catch (e) {
      return <Report3Model>[];
    }
  }

  Future<List<Report3Model>> getChart3() async {
    try {
      final response = await http.get(Uri.parse(API.chart3));
      // print('getReport3 response: ${response.body}');
      if (200 == response.statusCode) {
        List<Report3Model> list = parseResponse3(response.body);
        return list;
      } else {
        return <Report3Model>[];
      }
    } catch (e) {
      return <Report3Model>[];
    }
  }

  static List<Report3Model> parseResponse3(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<Report3Model>((json) => Report3Model.fromJson(json))
        .toList();
  }

  Widget buildDataTableReport3() {
    // final columns = ['หน่วยงาน', 'Yes'];
    return DataTable(
      border: TableBorder.all(
        width: 1.0,
      ),
      columns: const [
        DataColumn(
          label: Text(
            'หน่วยงาน',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        DataColumn(
          label: Text(
            'Yes',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ],
      rows: report3s
          .map(
            (report3) => DataRow(cells: [
              DataCell(
                Text(
                  report3.section!,
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
              DataCell(
                Text(
                  report3.countOfYes.toString(),
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
                  "พฤติกรรมที่เหมาะสมแบ่งตามหน่วยงาน",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 12,
                ),
                buildDataTableReport3(),
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
