import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:management_walk/api/api_connection.dart';
import 'package:management_walk/common_widgets/form_header_widget.dart';
import 'package:management_walk/constants/image_strings.dart';
import 'package:management_walk/constants/text_strings.dart';
import 'package:management_walk/features/models/report7_model.dart';

import 'package:http/http.dart' as http;
import 'package:management_walk/features/screens/home_screen/home_page.dart';
import 'package:management_walk/features/screens/reports/report1_screen.dart';
import 'package:management_walk/features/screens/reports/report2_screen.dart';
import 'package:management_walk/features/screens/reports/report3_screen.dart';
import 'package:management_walk/features/screens/reports/report4_screen.dart';
import 'package:management_walk/features/screens/reports/report5_screen.dart';
import 'package:management_walk/features/screens/reports/report6_screen.dart';
import 'package:management_walk/features/screens/reports/report8_screen.dart';

class Report7Screen extends StatefulWidget {
  const Report7Screen({super.key});

  @override
  State<Report7Screen> createState() => _Report7ScreenState();
}

class _Report7ScreenState extends State<Report7Screen> {
  List<Report7Model> report7s = [];
  List<Report7Model> chart7s = [];

  @override
  void initState() {
    super.initState();
    report7s = [];
    chart7s = [];

    _getReport7();

    _getChart7();
  }

  //REPORT 7

  _getReport7() {
    getReport7().then((value) {
      setState(() {
        report7s = value;
      });
    });
  }

  _getChart7() {
    getChart7().then((value) {
      setState(() {
        chart7s = value;
      });
    });
  }

  Future<List<Report7Model>> getReport7() async {
    try {
      final response = await http.get(Uri.parse(API.report7));
      // print('getReport7 response: ${response.body}');
      if (200 == response.statusCode) {
        List<Report7Model> list = parseResponse7(response.body);
        return list;
      } else {
        return <Report7Model>[];
      }
    } catch (e) {
      return <Report7Model>[];
    }
  }

  Future<List<Report7Model>> getChart7() async {
    try {
      final response = await http.get(Uri.parse(API.chart7));
      // print('getReport7 response: ${response.body}');
      if (200 == response.statusCode) {
        List<Report7Model> list = parseResponse7(response.body);
        return list;
      } else {
        return <Report7Model>[];
      }
    } catch (e) {
      return <Report7Model>[];
    }
  }

  static List<Report7Model> parseResponse7(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<Report7Model>((json) => Report7Model.fromJson(json))
        .toList();
  }

  Widget buildDataTableReport7() {
    // final columns = ['Supervisor', 'Week 1', 'Week 2', 'Week 3', 'Week 4'];
    return DataTable(
      columnSpacing: 14,
      border: TableBorder.all(
        width: 1.0,
      ),
      columns: const [
        DataColumn(
          label: Text(
            'Supervisor',
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
          ),
        ),
        DataColumn(
          label: Text(
            'Week 1',
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
          ),
        ),
        DataColumn(
          label: Text(
            'Week 2',
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
          ),
        ),
        DataColumn(
          label: Text(
            'Week 3',
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
          ),
        ),
        DataColumn(
          label: Text(
            'Week 4',
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
          ),
        ),
      ],
      rows: report7s
          .map(
            (report7) => DataRow(cells: [
              DataCell(
                Text(
                  report7.supervisorName!,
                  style: const TextStyle(
                    fontSize: 10,
                  ),
                ),
              ),
              DataCell(
                Text(
                  report7.week1.toString(),
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
              DataCell(
                Text(
                  report7.week2.toString(),
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
              DataCell(
                Text(
                  report7.week3.toString(),
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
              DataCell(
                Text(
                  report7.week4.toString(),
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
                  "การให้ความร่วมมือในการทำรายงานแบ่งตามหัวหน้างาน",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 8,
                ),
                buildDataTableReport7(),
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
                style: TextStyle(fontSize: 20),
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
                style: TextStyle(fontSize: 16),
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
                style: TextStyle(fontSize: 16),
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
                style: TextStyle(fontSize: 16),
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
                style: TextStyle(fontSize: 16),
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
                style: TextStyle(fontSize: 16),
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
                style: TextStyle(fontSize: 16),
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
                style: TextStyle(fontSize: 16),
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
                style: TextStyle(fontSize: 16),
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
