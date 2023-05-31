import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:management_walk/common_widgets/form_header_widget.dart';
import 'package:management_walk/constants/image_strings.dart';
import 'package:management_walk/constants/text_strings.dart';
import 'package:management_walk/features/models/report2_model.dart';
import 'package:management_walk/features/screens/home_screen/home_page.dart';
import 'package:management_walk/features/screens/reports/report1_screen.dart';
import 'package:management_walk/features/screens/reports/report3_screen.dart';
import 'package:management_walk/features/screens/reports/report4_screen.dart';
import 'package:management_walk/features/screens/reports/report5_screen.dart';
import 'package:management_walk/features/screens/reports/report6_screen.dart';
import 'package:management_walk/features/screens/reports/report7_screen.dart';
import 'package:management_walk/features/screens/reports/report8_screen.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:http/http.dart' as http;

import '../../../api/api_connection.dart';

class Report2Screen extends StatefulWidget {
  const Report2Screen({super.key});

  @override
  State<Report2Screen> createState() => _Report2ScreenState();
}

class _Report2ScreenState extends State<Report2Screen> {
  List<Report2Model> report2s = [];

  List<Report2Model> chart2s = [];
  @override
  void initState() {
    super.initState();
    report2s = [];
    chart2s = [];
    _getReport2();
    _getChart2();
  }

  //REPORT 2

  _getReport2() {
    getReport2().then((value) {
      setState(() {
        report2s = value;
      });
    });
  }

  _getChart2() {
    getChart2().then((value) {
      setState(() {
        chart2s = value;
      });
    });
  }

  Future<List<Report2Model>> getReport2() async {
    try {
      final response = await http.get(Uri.parse(API.report2));
      // print('getReport2 response: ${response.body}');
      if (200 == response.statusCode) {
        List<Report2Model> list = parseResponse2(response.body);
        return list;
      } else {
        return <Report2Model>[];
      }
    } catch (e) {
      return <Report2Model>[];
    }
  }

  Future<List<Report2Model>> getChart2() async {
    try {
      final response = await http.get(Uri.parse(API.chart2));
      // print('getReport2 response: ${response.body}');
      if (200 == response.statusCode) {
        List<Report2Model> list = parseResponse2(response.body);
        return list;
      } else {
        return <Report2Model>[];
      }
    } catch (e) {
      return <Report2Model>[];
    }
  }

  static List<Report2Model> parseResponse2(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<Report2Model>((json) => Report2Model.fromJson(json))
        .toList();
  }

  Widget buildDataTableReport2() {
    // final columns = ['ประเภทการประเมิน', 'No'];
    return DataTable(
      border: TableBorder.all(
        width: 1.0,
      ),
      columns: const [
        DataColumn(
          label: Text(
            'ประเภทการประเมิน',
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
      rows: report2s
          .map(
            (report2) => DataRow(cells: [
              DataCell(
                Text(
                  report2.category!,
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
              DataCell(
                Text(
                  report2.countOfNo.toString(),
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
                  "พฤติกรรมที่ไม่เหมาะสมแบ่งตามประเภทการประเมิน",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 400,
                  child: SfCircularChart(
                    // title: ChartTitle(text: 'Report 2'),
                    legend: Legend(
                        isVisible: true,
                        overflowMode: LegendItemOverflowMode.wrap),
                    series: <CircularSeries>[
                      PieSeries<Report2Model, String>(
                          dataSource: chart2s,
                          dataLabelSettings:
                              const DataLabelSettings(isVisible: true),
                          xValueMapper: (Report2Model data, _) => data.category,
                          yValueMapper: (Report2Model data, _) =>
                              data.countOfNo),
                    ],
                  ),
                ),
                buildDataTableReport2(),
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
