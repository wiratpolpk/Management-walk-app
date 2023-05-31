import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:management_walk/common_widgets/button_widget.dart';
import 'package:management_walk/common_widgets/form_header_widget.dart';
import 'package:management_walk/constants/image_strings.dart';
import 'package:management_walk/constants/text_strings.dart';
import 'package:management_walk/features/models/report1_model.dart';
import 'package:management_walk/features/screens/home_screen/home_page.dart';
import 'package:management_walk/features/screens/reports/report2_screen.dart';
import 'package:management_walk/features/screens/reports/report3_screen.dart';
import 'package:management_walk/features/screens/reports/report4_screen.dart';
import 'package:management_walk/features/screens/reports/report5_screen.dart';
import 'package:management_walk/features/screens/reports/report6_screen.dart';
import 'package:management_walk/features/screens/reports/report7_screen.dart';
import 'package:management_walk/features/screens/reports/report8_screen.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

import '../../../api/api_connection.dart';

class Report1Screen extends StatefulWidget {
  const Report1Screen({super.key});

  @override
  State<Report1Screen> createState() => _Report1ScreenState();
}

class _Report1ScreenState extends State<Report1Screen> {
  List<Report1Model> report1s = [];

  List<Report1Model> chart1s = [];

  @override
  void initState() {
    super.initState();
    report1s = [];
    chart1s = [];

    _getReport1();

    _getChart1();
  }

  //REPORT 1

  _getReport1() {
    getReport1().then((value) {
      setState(() {
        report1s = value;
      });
    });
  }

  _getChart1() {
    getChart1().then((value) {
      setState(() {
        chart1s = value;
      });
    });
  }

  Future<List<Report1Model>> getReport1() async {
    try {
      final response = await http.get(Uri.parse(API.report1));
      // print('getReport1 response: ${response.body}');
      if (200 == response.statusCode) {
        List<Report1Model> list = parseResponse(response.body);
        return list;
      } else {
        return <Report1Model>[];
      }
    } catch (e) {
      return <Report1Model>[];
    }
  }

  Future<List<Report1Model>> getChart1() async {
    try {
      final response = await http.get(Uri.parse(API.chart1));
      // print('getReport1 response: ${response.body}');
      if (200 == response.statusCode) {
        List<Report1Model> list = parseResponse(response.body);
        return list;
      } else {
        return <Report1Model>[];
      }
    } catch (e) {
      return <Report1Model>[];
    }
  }

  static List<Report1Model> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<Report1Model>((json) => Report1Model.fromJson(json))
        .toList();
  }

  Widget buildDataTableReport1() {
    // final columns = ['ประเภทการประเมิน', 'Yes'];
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
            'Yes',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ],
      rows: report1s
          .map(
            (report1) => DataRow(cells: [
              DataCell(
                Text(
                  report1.category!,
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
              ),
              DataCell(
                Text(
                  report1.countOfYes.toString(),
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
                  "พฤติกรรมที่เหมาะสมแบ่งตามประเภทการประเมิน",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 400,
                  child: SfCircularChart(
                    // title: ChartTitle(text: 'Report 1'),
                    legend: Legend(
                        isVisible: true,
                        overflowMode: LegendItemOverflowMode.wrap),
                    series: <CircularSeries>[
                      PieSeries<Report1Model, String>(
                          dataSource: chart1s,
                          dataLabelSettings:
                              const DataLabelSettings(isVisible: true),
                          xValueMapper: (Report1Model data, _) => data.category,
                          yValueMapper: (Report1Model data, _) =>
                              data.countOfYes),
                    ],
                  ),
                ),
                buildDataTableReport1(),
                const SizedBox(
                  height: 16,
                ),
                // buildExport(),
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

  Widget buildExport() => ButtonWidget(
      text: 'Export to Excel',
      onClicked: () async {
        // Get.to(() => const Report1Screen());
        // final response = await http.get(Uri.parse(API.report1Export));

        await launchUrl(
          Uri.parse(API.report1Export),
          mode: LaunchMode.inAppWebView,
        );
      });
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
