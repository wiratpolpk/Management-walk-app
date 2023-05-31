import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:management_walk/api/sheets/supervisor_sheet_api.dart';
import 'package:management_walk/api/sheets/work_commitment_api.dart';
import 'package:management_walk/common_widgets/button_widget.dart';
import 'package:management_walk/features/models/management_walk_model.dart';
import 'package:management_walk/features/models/section_model.dart';
import 'package:management_walk/features/models/supervisor_model.dart';
import 'package:management_walk/features/models/user_model.dart';
import 'package:management_walk/features/models/work_commitment_model.dart';

import '../../../api/sheets/section_sheets_api.dart';
import '../../../constants/text_strings.dart';
import '../category_selection.dart';

class UserFormWidget extends StatefulWidget {
  final User? user;
  final ManagementWalk? managementWalk;
  final ValueChanged<User> onSavedUser;
  final ValueChanged<ManagementWalk> onSaveManagementWalk;

  const UserFormWidget({
    Key? key,
    this.user,
    this.managementWalk,
    required this.onSavedUser,
    required this.onSaveManagementWalk,
  }) : super(key: key);

  @override
  State<UserFormWidget> createState() => _UserFormWidgetState();
}

class _UserFormWidgetState extends State<UserFormWidget> {
  List<Section> sections = [];
  // List<Supervisor> supervisors = [];
  List<WorkCommitment> workCommitments = [];
  var sectionDescs = <String>[];
  var supervisorName = <String>[];

  final formKey = GlobalKey<FormState>();

  late TextEditingController _name;
  late TextEditingController _section;
  late TextEditingController _area;
  late TextEditingController _date;

  String dropdownSupervisorvalue = 'Amorn Kaewsrinual';
  // var itemsSupervisor = [
  //   'Supervisor',
  //   'Amorn Kaewsrinual',
  //   'Barahem Madteh',
  //   'Duangkamol Tanadechasit',
  // ];

  String dropdownSectionvalue = '301 - Powerplant';
  // var itemsSection = [
  //   'Section',
  //   '301 - Powerplant',
  //   '302 - Overhaul & Tech Service',
  //   '303 - Refrigeration',
  //   '304 - Building and Civil',
  //   '305 - Workshop',
  //   '306 - Fork-lift/Hand-lift',
  // ];

  @override
  void initState() {
    super.initState();

    initUser();
    getSection();
    // getSupervisor();
    getWorkCommitment();
  }

  @override
  void didUpdateWidget(covariant UserFormWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    initUser();
  }

  void initUser() {
    final name = widget.user == null ? '' : widget.user!.supervisorName;
    final section = widget.user == null ? '' : widget.user!.section;
    final area = widget.user == null ? '' : widget.user!.area;
    final startDate = widget.user == null ? '' : widget.user!.startDate;

    final datel = DateTime(45141);
    print(datel);

    setState(() {
      _name = TextEditingController(text: name);
      _section = TextEditingController(text: section);
      _area = TextEditingController(text: area);
      _date = TextEditingController(text: startDate);
    });
  }

  Future getSection({int index = 0}) async {
    final sections = await SectionSheetApi.getAll();

    setState(() {
      this.sections = sections.toList();

      sections.forEach((element) {
        sectionDescs.add(element.sectionDesc);
      });
    });

    print(sectionDescs);
  }

  // Future getSupervisor({int index = 0}) async {
  //   final supervisors = await SupervisorSheetApi.getAll();

  //   setState(() {
  //     // this.supervisors = supervisors.toList();

  //     for (var element in supervisors) {
  //       supervisorName.add(element.supervisorName);
  //     }
  //   });

  //   print(supervisorName);
  // }

  Future getWorkCommitment({int index = 0}) async {
    final workCommitments = await WorkCommitmentSheetApi.getAll();

    setState(() {
      this.workCommitments = workCommitments;
    });

    for (var element in workCommitments) {
      print(element.questionID);
      print(element.questionDesc);
      print(element.workCommitment);
      print(element.group1);
      print(element.group2);
    }
  }

  @override
  Widget build(BuildContext context) => Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildDropDownSupervisor(),
            const SizedBox(height: 16),
            buildDropDownSection(),
            const SizedBox(height: 16),
            buildArea(),
            const SizedBox(height: 16),
            buildDate(),
            const SizedBox(height: 16),
            buildSubmiit(),
          ],
        ),
      );

  Widget buildName() => TextFormField(
        controller: _name,
        decoration: const InputDecoration(
          label: Text(tReportByLabel),
          prefixIcon: Icon(Icons.person_outline_rounded),
        ),
        validator: (value) =>
            value != null && value.isEmpty ? 'Enter Name' : null,
      );

  Widget buildSection() => TextFormField(
        controller: _section,
        decoration: const InputDecoration(
          label: Text(tSectionLabel),
          prefixIcon: Icon(Icons.map_outlined),
        ),
        validator: (value) =>
            value != null && value.isEmpty ? 'Enter Section' : null,
      );

  Widget buildDropDownSection() => DropdownButtonFormField(
        // Initial Value
        value: dropdownSectionvalue,

        // Down Arrow Icon
        icon: const Icon(Icons.keyboard_arrow_down),

        // Array list of items
        items: sectionDescs.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: Text(items),
          );
        }).toList(),
        // After selecting the desired option,it will
        // change button value to selected value
        onChanged: (String? newValue) {
          setState(() {
            dropdownSectionvalue = newValue!;
          });
        },
      );

  Widget buildDropDownSupervisor() => DropdownButtonFormField(
        // Initial Value
        value: dropdownSupervisorvalue,

        // Down Arrow Icon
        icon: const Icon(Icons.keyboard_arrow_down),

        // Array list of items
        items: supervisorName.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: Text(items),
          );
        }).toList(),
        // After selecting the desired option,it will
        // change button value to selected value
        onChanged: (String? newValue) {
          setState(() {
            dropdownSupervisorvalue = newValue!;
          });
        },
      );

  Widget buildArea() => TextFormField(
        controller: _area,
        decoration: const InputDecoration(
          label: Text(tAreaLabel),
          prefixIcon: Icon(Icons.map_outlined),
        ),
        validator: (value) =>
            value != null && value.isEmpty ? 'Enter Area' : null,
      );

  Widget buildDate() => TextFormField(
        controller: _date,
        decoration: const InputDecoration(
          label: Text(tDateLabel),
          prefixIcon: Icon(Icons.calendar_today_outlined),
        ),
        onTap: () async {
          FocusScope.of(context).unfocus();
          DateTime? pickeddate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2101));

          if (pickeddate != null) {
            _date.text = "'${DateFormat('dd/MM/yyyy').format(pickeddate)}";
          }
        },
        validator: (value) =>
            value != null && value.isEmpty ? 'Enter Date' : null,
      );

  Widget buildSubmiit() => ButtonWidget(
      text: 'เริ่มต้น',
      onClicked: () {
        final form = formKey.currentState!;
        final isValid = form.validate();

        if (isValid) {
          final id = widget.user == null ? null : widget.user!.id;

          // final user = User(
          //     id: id,
          //     supervisorName: _name.text,
          //     section: _section.text,
          //     area: _area.text,
          //     startDate: "'${_date.text}");
          // widget.onSavedUser(user);

          // workCommitments.forEach((element) {
          //   final managementWalk = ManagementWalk(
          //     runID: id,
          //     keyID: 'kkkk',
          //     supervisorName: _name.text,
          //     section: _section.text,
          //     area: _area.text,
          //     startDate: "'${_date.text}",
          //     finishedDate: "'${_date.text}",
          //     questionID: element.questionID!,
          //     questionDesc: element.questionDesc,
          //     workCommitmentGroup: element.workCommitment,
          //     categoryGroup1: element.group1,
          //     categoryGroup2: element.group2,
          //     yesChecked: '',
          //     noChecked: '',
          //     notApplyChecked: '',
          //     comment: '',
          //     imageUrl: '',
          //   );
          //   widget.onSaveManagementWalk(managementWalk);
          // });
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const CategorySelection()));
        }
      });
}
