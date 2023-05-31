import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:management_walk/features/models/report1_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../api/api_connection.dart';
import '../models/report2_model.dart';
import '../models/report3_model.dart';
import '../models/report4_model.dart';
import '../models/report5_model.dart';
import '../models/report6_model.dart';
import '../models/report7_model.dart';
import '../models/report8_model.dart';
import 'package:http/http.dart' as http;

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  List<Report1Model> report1s = [];
  List<Report2Model> report2s = [];
  List<Report3Model> report3s = [];
  List<Report4Model> report4s = [];
  List<Report5Model> report5s = [];
  List<Report6Model> report6s = [];
  List<Report7Model> report7s = [];
  List<Report8Model> report8s = [];

  List<Report1Model> chart1s = [];
  List<Report2Model> chart2s = [];
  List<Report3Model> chart3s = [];
  List<Report4Model> chart4s = [];
  List<Report5Model> chart5s = [];
  List<Report6Model> chart6s = [];
  List<Report7Model> chart7s = [];
  List<Report8Model> chart8s = [];

  @override
  void initState() {
    super.initState();
    report1s = [];
    report2s = [];
    report3s = [];
    report4s = [];
    report5s = [];
    report6s = [];
    report7s = [];
    report8s = [];
    chart1s = [];
    chart2s = [];
    chart3s = [];
    chart4s = [];
    chart5s = [];
    chart6s = [];
    chart7s = [];
    chart8s = [];

    _getReport1();
    _getReport2();
    _getReport3();
    _getReport4();
    _getReport5();
    _getReport6();
    _getReport7();
    _getReport8();

    _getChart1();
    _getChart2();
    _getChart3();
    _getChart4();
    _getChart5();
    _getChart6();
    _getChart7();
    _getChart8();
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

  //REPORT 5

  _getReport5() {
    getReport5().then((value) {
      setState(() {
        report5s = value;
      });
    });
  }

  _getChart5() {
    getChart5().then((value) {
      setState(() {
        chart5s = value;
      });
    });
  }

  Future<List<Report5Model>> getReport5() async {
    try {
      final response = await http.get(Uri.parse(API.report5));
      // print('getReport5 response: ${response.body}');
      if (200 == response.statusCode) {
        List<Report5Model> list = parseResponse5(response.body);
        return list;
      } else {
        return <Report5Model>[];
      }
    } catch (e) {
      return <Report5Model>[];
    }
  }

  Future<List<Report5Model>> getChart5() async {
    try {
      final response = await http.get(Uri.parse(API.chart5));
      // print('getReport5 response: ${response.body}');
      if (200 == response.statusCode) {
        List<Report5Model> list = parseResponse5(response.body);
        return list;
      } else {
        return <Report5Model>[];
      }
    } catch (e) {
      return <Report5Model>[];
    }
  }

  static List<Report5Model> parseResponse5(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<Report5Model>((json) => Report5Model.fromJson(json))
        .toList();
  }

  //REPORT 6

  _getReport6() {
    getReport6().then((value) {
      setState(() {
        report6s = value;
      });
    });
  }

  _getChart6() {
    getChart6().then((value) {
      setState(() {
        chart6s = value;
      });
    });
  }

  Future<List<Report6Model>> getReport6() async {
    try {
      final response = await http.get(Uri.parse(API.report6));
      // print('getReport6 response: ${response.body}');
      if (200 == response.statusCode) {
        List<Report6Model> list = parseResponse6(response.body);
        return list;
      } else {
        return <Report6Model>[];
      }
    } catch (e) {
      return <Report6Model>[];
    }
  }

  Future<List<Report6Model>> getChart6() async {
    try {
      final response = await http.get(Uri.parse(API.chart6));
      // print('getReport6 response: ${response.body}');
      if (200 == response.statusCode) {
        List<Report6Model> list = parseResponse6(response.body);
        return list;
      } else {
        return <Report6Model>[];
      }
    } catch (e) {
      return <Report6Model>[];
    }
  }

  static List<Report6Model> parseResponse6(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<Report6Model>((json) => Report6Model.fromJson(json))
        .toList();
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
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        DataColumn(
          label: Text(
            'Yes',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                    fontSize: 16,
                  ),
                ),
              ),
              DataCell(
                Text(
                  report1.countOfYes.toString(),
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ]),
          )
          .toList(),
    );
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
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        DataColumn(
          label: Text(
            'No',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                    fontSize: 16,
                  ),
                ),
              ),
              DataCell(
                Text(
                  report2.countOfNo.toString(),
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ]),
          )
          .toList(),
    );
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
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        DataColumn(
          label: Text(
            'Yes',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                    fontSize: 16,
                  ),
                ),
              ),
              DataCell(
                Text(
                  report3.countOfYes.toString(),
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ]),
          )
          .toList(),
    );
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
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        DataColumn(
          label: Text(
            'No',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                    fontSize: 16,
                  ),
                ),
              ),
              DataCell(
                Text(
                  report4.countOfNo.toString(),
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ]),
          )
          .toList(),
    );
  }

  Widget buildDataTableReport5() {
    // final columns = ['Work Commitments', 'Yes'];
    return DataTable(
      border: TableBorder.all(
        width: 1.0,
      ),
      columns: const [
        DataColumn(
          label: Text(
            'Work Commitments',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        DataColumn(
          label: Text(
            'Yes',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ],
      rows: report5s
          .map(
            (report5) => DataRow(cells: [
              DataCell(
                Text(
                  report5.workCommitment!,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              DataCell(
                Text(
                  report5.countOfYes.toString(),
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ]),
          )
          .toList(),
    );
  }

  Widget buildDataTableReport6() {
    // final columns = ['Work Commitments', 'No'];
    return DataTable(
      border: TableBorder.all(
        width: 1.0,
      ),
      columns: const [
        DataColumn(
          label: Text(
            'Work Commitments',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        DataColumn(
          label: Text(
            'No',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ],
      rows: report6s
          .map(
            (report6) => DataRow(cells: [
              DataCell(
                Text(
                  report6.workCommitment!,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              DataCell(
                Text(
                  report6.countOfNo.toString(),
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ]),
          )
          .toList(),
    );
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
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        DataColumn(
          label: Text(
            'ไม่ตรวจ',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                    fontSize: 16,
                  ),
                ),
              ),
              DataCell(
                Text(
                  report8.notApplyChecked.toString(),
                  style: const TextStyle(
                    fontSize: 16,
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
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                // PieChart(
                //   dataMap: dataMap_category_yes,
                //   animationDuration: const Duration(milliseconds: 800),
                //   chartLegendSpacing: 32,
                //   chartRadius: MediaQuery.of(context).size.width / 2,
                //   colorList: colorList,
                //   initialAngleInDegree: 0,
                //   chartType: ChartType.disc,
                //   ringStrokeWidth: 32,
                //   legendOptions: const LegendOptions(
                //     showLegendsInRow: false,
                //     // legendPosition: LegendPosition.right,
                //     showLegends: true,
                //     legendShape: BoxShape.circle,
                //     legendTextStyle: TextStyle(
                //       fontWeight: FontWeight.bold,
                //     ),
                //   ),
                //   chartValuesOptions: const ChartValuesOptions(
                //     showChartValueBackground: true,
                //     showChartValues: true,
                //     showChartValuesInPercentage: false,
                //     showChartValuesOutside: false,
                //     decimalPlaces: 0,
                //   ),
                // ),
                buildDataTableReport1(),
                const SizedBox(
                  height: 16,
                ),
                const Divider(
                  color: Colors.blue,
                ),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  "พฤติกรรมที่ไม่เหมาะสมแบ่งตามประเภทการประเมิน",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                // const SizedBox(
                //   height: 8,
                // ),
                // PieChart(
                //   dataMap: dataMap_category_no,
                //   animationDuration: const Duration(milliseconds: 800),
                //   chartLegendSpacing: 32,
                //   chartRadius: MediaQuery.of(context).size.width / 2,
                //   colorList: colorList,
                //   initialAngleInDegree: 0,
                //   chartType: ChartType.disc,
                //   ringStrokeWidth: 32,
                //   legendOptions: const LegendOptions(
                //     showLegendsInRow: false,
                //     // legendPosition: LegendPosition.right,
                //     showLegends: true,
                //     legendShape: BoxShape.circle,
                //     legendTextStyle: TextStyle(
                //       fontWeight: FontWeight.bold,
                //     ),
                //   ),
                //   chartValuesOptions: const ChartValuesOptions(
                //     showChartValueBackground: true,
                //     showChartValues: true,
                //     showChartValuesInPercentage: false,
                //     showChartValuesOutside: false,
                //     decimalPlaces: 0,
                //   ),
                // ),
                // const SizedBox(
                //   height: 16,
                // ),
                buildDataTableReport2(),
                const SizedBox(
                  height: 16,
                ),
                const Divider(
                  color: Colors.blue,
                ),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  "พฤติกรรมที่เหมาะสมแบ่งตามหน่วยงาน",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 12,
                ),
                // PieChart(
                //   dataMap: dataMap_section_yes,
                //   animationDuration: Duration(milliseconds: 800),
                //   chartLegendSpacing: 32,
                //   chartRadius: MediaQuery.of(context).size.width / 2,
                //   colorList: colorList,
                //   initialAngleInDegree: 0,
                //   chartType: ChartType.disc,
                //   ringStrokeWidth: 32,
                //   legendOptions: const LegendOptions(
                //     showLegendsInRow: false,
                //     legendPosition: LegendPosition.bottom,
                //     showLegends: false,
                //     legendShape: BoxShape.circle,
                //     legendTextStyle: TextStyle(
                //       fontWeight: FontWeight.bold,
                //     ),
                //   ),
                //   chartValuesOptions: const ChartValuesOptions(
                //     showChartValueBackground: true,
                //     showChartValues: false,
                //     showChartValuesInPercentage: false,
                //     showChartValuesOutside: false,
                //     decimalPlaces: 0,
                //   ),
                // ),
                // const SizedBox(
                //   height: 16,
                // ),
                buildDataTableReport3(),
                const SizedBox(
                  height: 16,
                ),
                const Divider(
                  color: Colors.blue,
                ),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  "พฤติกรรมที่ไม่เหมาะสมแบ่งตามหน่วยงาน",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 12,
                ),
                // PieChart(
                //   dataMap: dataMap_section_no,
                //   animationDuration: Duration(milliseconds: 800),
                //   chartLegendSpacing: 32,
                //   chartRadius: MediaQuery.of(context).size.width / 2,
                //   colorList: colorList,
                //   initialAngleInDegree: 0,
                //   chartType: ChartType.disc,
                //   ringStrokeWidth: 32,
                //   legendOptions: const LegendOptions(
                //     showLegendsInRow: false,
                //     legendPosition: LegendPosition.bottom,
                //     showLegends: false,
                //     legendShape: BoxShape.circle,
                //     legendTextStyle: TextStyle(
                //       fontWeight: FontWeight.bold,
                //     ),
                //   ),
                //   chartValuesOptions: const ChartValuesOptions(
                //     showChartValueBackground: true,
                //     showChartValues: false,
                //     showChartValuesInPercentage: false,
                //     showChartValuesOutside: false,
                //     decimalPlaces: 0,
                //   ),
                // ),
                // const SizedBox(
                //   height: 16,
                // ),
                buildDataTableReport4(),
                const SizedBox(
                  height: 16,
                ),
                const Divider(
                  color: Colors.blue,
                ),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  "พฤติกรรมที่เหมาะสมแบ่งตาม Work commitment",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 400,
                  child: SfCircularChart(
                    // title: ChartTitle(text: 'Report 5'),
                    legend: Legend(
                        isVisible: true,
                        overflowMode: LegendItemOverflowMode.wrap),
                    series: <CircularSeries>[
                      PieSeries<Report5Model, String>(
                          dataSource: chart5s,
                          dataLabelSettings:
                              const DataLabelSettings(isVisible: true),
                          xValueMapper: (Report5Model data, _) =>
                              data.workCommitment,
                          yValueMapper: (Report5Model data, _) =>
                              data.countOfYes),
                    ],
                  ),
                ),
                // const SizedBox(
                //   height: 8,
                // ),
                // PieChart(
                //   dataMap: dataMap_workCommitment_yes,
                //   animationDuration: Duration(milliseconds: 800),
                //   chartLegendSpacing: 32,
                //   chartRadius: MediaQuery.of(context).size.width / 2,
                //   colorList: colorList,
                //   initialAngleInDegree: 0,
                //   chartType: ChartType.disc,
                //   ringStrokeWidth: 32,
                //   legendOptions: const LegendOptions(
                //     showLegendsInRow: false,
                //     // legendPosition: LegendPosition.right,
                //     showLegends: true,
                //     legendShape: BoxShape.circle,
                //     legendTextStyle: TextStyle(
                //       fontSize: 10,
                //       fontWeight: FontWeight.bold,
                //     ),
                //   ),
                //   chartValuesOptions: const ChartValuesOptions(
                //     showChartValueBackground: true,
                //     showChartValues: true,
                //     showChartValuesInPercentage: false,
                //     showChartValuesOutside: false,
                //     decimalPlaces: 0,
                //   ),
                // ),
                // const SizedBox(
                //   height: 16,
                // ),
                buildDataTableReport5(),
                const SizedBox(
                  height: 16,
                ),
                const Divider(
                  color: Colors.blue,
                ),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  "พฤติกรรมที่ไม่เหมาะสมแบ่งตาม Work commitment",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 400,
                  child: SfCircularChart(
                    // title: ChartTitle(text: 'Report 6'),
                    legend: Legend(
                        isVisible: true,
                        overflowMode: LegendItemOverflowMode.wrap),
                    series: <CircularSeries>[
                      PieSeries<Report6Model, String>(
                          dataSource: chart6s,
                          dataLabelSettings:
                              const DataLabelSettings(isVisible: true),
                          xValueMapper: (Report6Model data, _) =>
                              data.workCommitment,
                          yValueMapper: (Report6Model data, _) =>
                              data.countOfNo),
                    ],
                  ),
                ),
                // const SizedBox(
                //   height: 8,
                // ),
                // PieChart(
                //   dataMap: dataMap_workCommitment_no,
                //   animationDuration: Duration(milliseconds: 800),
                //   chartLegendSpacing: 32,
                //   chartRadius: MediaQuery.of(context).size.width / 2,
                //   colorList: colorList,
                //   initialAngleInDegree: 0,
                //   chartType: ChartType.disc,
                //   ringStrokeWidth: 32,
                //   legendOptions: const LegendOptions(
                //     showLegendsInRow: false,
                //     // legendPosition: LegendPosition.right,
                //     showLegends: true,
                //     legendShape: BoxShape.circle,
                //     legendTextStyle: TextStyle(
                //       fontSize: 10,
                //       fontWeight: FontWeight.bold,
                //     ),
                //   ),
                //   chartValuesOptions: const ChartValuesOptions(
                //     showChartValueBackground: true,
                //     showChartValues: true,
                //     showChartValuesInPercentage: false,
                //     showChartValuesOutside: false,
                //     decimalPlaces: 0,
                //   ),
                // ),
                // const SizedBox(
                //   height: 16,
                // ),
                buildDataTableReport6(),
                const SizedBox(
                  height: 16,
                ),
                const Divider(
                  color: Colors.blue,
                ),
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
                const Divider(
                  color: Colors.blue,
                ),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  "รายงานแสดงคำตอบ 'ไม่ตรวจ' แบ่งตามหัวหน้างาน",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
