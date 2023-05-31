import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:management_walk/api/api_connection.dart';
import 'package:management_walk/common_widgets/form_header_widget.dart';
import 'package:management_walk/constants/image_strings.dart';
import 'package:management_walk/constants/text_strings.dart';
import 'package:management_walk/features/models/report4_model.dart';

import 'package:http/http.dart' as http;
import 'package:management_walk/features/screens/home_screen/home_page.dart';
import 'package:management_walk/features/screens/reports/report1_screen.dart';
import 'package:management_walk/features/screens/reports/report2_screen.dart';
import 'package:management_walk/features/screens/reports/report3_screen.dart';
import 'package:management_walk/features/screens/reports/report5_screen.dart';
import 'package:management_walk/features/screens/reports/report6_screen.dart';
import 'package:management_walk/features/screens/reports/report7_screen.dart';
import 'package:management_walk/features/screens/reports/report8_screen.dart';

class Report4Screen extends StatefulWidget {
  const Report4Screen({super.key});

  @override
  State<Report4Screen> createState() => _Report4ScreenState();
}

class _Report4ScreenState extends State<Report4Screen> {
  List<Report4Model> report4s = [];
  List<Report4Model> chart4s = [];

  @override
  void initState() {
    super.initState();
    report4s = [];
    chart4s = [];

    _getReport4();

    _getChart4();
  }

  //REPORT 4

  _getReport4() {
    getReport4().then((value) {
      setState(() {
        report4s = value;
      });
    });
  }

  _getChart4() {
    getChart4().then((value) {
      setState(() {
        chart4s = value;
      });
    });
  }

  Future<List<Report4Model>> getReport4() async {
    try {
      final response = await http.get(Uri.parse(API.report4));
      // print('getReport4 response: ${response.body}');
      if (200 == response.statusCode) {
        List<Report4Model> list = parseResponse4(response.body);
        return list;
      } else {
        return <Report4Model>[];
      }
    } catch (e) {
      return <Report4Model>[];
    }
  }

  Future<List<Report4Model>> getChart4() async {
    try {
      final response = await http.get(Uri.parse(API.chart4));
      // print('getReport4 response: ${response.body}');
      if (200 == response.statusCode) {
        List<Report4Model> list = parseResponse4(response.body);
        return list;
      } else {
        return <Report4Model>[];
      }
    } catch (e) {
      return <Report4Model>[];
    }
  }

  static List<Report4Model> parseResponse4(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<Report4Model>((json) => Report4Model.fromJson(json))
        .toList();
  }

  Widget buildDataTableReport4() {
    // final columns = ['หน่วยงาน', 'No'];
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
            'No',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ],
      rows: report4s
          .map(
            (report4) => DataRow(cells: [
              DataCell(
                Text(
                  report4.section!,
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
              DataCell(
                Text(
                  report4.countOfNo.toString(),
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
                  "พฤติกรรมที่ไม่เหมาะสมแบ่งตามหน่วยงาน",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 12,
                ),
                buildDataTableReport4(),
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
