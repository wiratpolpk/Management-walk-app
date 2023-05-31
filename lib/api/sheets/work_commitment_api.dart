import 'package:gsheets/gsheets.dart';

import '../../features/models/work_commitment_model.dart';

class WorkCommitmentSheetApi {
  static const _credentials = r'''
{
  "type": "service_account",
  "project_id": "management-walk",
  "private_key_id": "658b13832f06ee96437c2eb918f143c2d50f40b2",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDjYn42PgnLxFpc\nDx3rD4HWtRDCV0ivUnbxINnNPFu1qzQmlbKffBJcXqZwRMBVw7VmiaSk9WcUgf1N\nPEdFe84RImUamLLqo1eYr/NKI1HAkyEKtk7ed4iBU9nJmYXSEl+IAva99DBplJu2\nJ7qDcLeuJN83mmBVaTFHqdd3a8/Neoh8Bnj75mNV99aD8xF3APd0Ed0K+rwGB91A\nSNxemnjiHPZ/u1cjc56QulGPgOoJVwjLUx+4D04Hp4y49FXQkoUnId4PpImGPM/1\nhGLfgMrVwjcwS6rmRRqbo+TJ/PzCD4wDyECzK+CTZsAlvMYzcKJtu0JqwH8h7vya\ny1z1mWsPAgMBAAECggEADM2ix1bGl24mxls64d2df85HM3eAX2WDJABSXeThpxY3\nmVqW1GBt6jyRc5iIxJYrVIA4lenpfsqeTXyGPiqCnQ1fkwKjxGQjzl74kc/w+P5v\n1FoVO8qQPvP5OzRFSDcCS7bFrPF0eRAbP8Oh6WfDN++EkBgbB4Qk+GDfAdmUuarq\n62+hdV3aU8dK6nOGNfvirtGTl5TRUiOI9Iu3nAJry6o/stoEBjRWwYLKllQ5XsLn\ng1SVdEySs2iWhv/iCT9l87D7Z87UpqLh2Qp2aTy7oTwEoMOaQx3CkJaj8xjWO3eo\nFHsHlKNjcBXRGwBVOPolMtZUDzAybDwkWl1/pXfrrQKBgQD7Q4CjP6SA6VGchrbQ\nic5GeUKm0VTlUacc3Z/6stVmyIextKHvKuHqMHIGpVZPhepKJ2eH1NtYQ+m2glBn\nEq55Di+ed2c7Mh5hOpfjB3jSMjgo8Ff5VeUs4eoqo2qNTJztCCgMuC3oKVPs+05I\ncr0QTWh5CM1t5vhTQxevm/Ku9QKBgQDnq8Kl7PWJd4JwfQOZTtKzkSuQ1tfOVifP\n+i7F9rDuY8NyP8s4HG7nqkcPayUb9yfQiLItsj8YL842oANyKTFxV4mRjQ3PobMI\nJME5pafr1IG6k8kSw6bcsXelbRrkualFxUOVyRds2R946WvZ3vIoHPT3UX17pHze\nv4eZ28encwKBgAuDZVKVqPkLN+UfOyNFHUGXbtlsACLd4fVtplX7edHS4HzhFQZ7\nhYyQmbj6PIE6Vqj9Mz5DH6XkvsHRKNQARCRh5Qay2/UXb9Lut2T8w6mGCZK+qJlR\nOUYcN/mqMUi2OP6XgBZNHjVkJ2dVgJnLQCSOF3psT9V4XuqZyW0PjUg9AoGANeh/\n6MBU+mH21logxkHTQbmcG54CpZ7isMCUtbgLv80zI5i4nxvuqrWyx2G1RuaiOyIz\n4/JAQE6Pe6KMarovKSKnflkGR7RmxpRW6iUkB/pxHYtaFKW2ZFBfeP0EbwjM3NFk\nQqyCaO+1JRub3xzD2JW0YwBxZJ4H+IU09pZvxQUCgYEAz856lTxS5+IYA3zCYAH3\neJHgWHNHtrByRTiHLNnRiMzBYRGSA5QavgqBDRQdRw6J/oGIY6cNCIWdBfuRMHn0\nQGpaxdk3fwv2d608qzTGR/u0risfQQN0bBBkMDbIXM1CtOoa3uVbcYIj3ajuIA4t\nn5kIKlLv1L7LhhRKtIiLsd0=\n-----END PRIVATE KEY-----\n",
  "client_email": "gsheets@management-walk.iam.gserviceaccount.com",
  "client_id": "100624676121701366083",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/gsheets%40management-walk.iam.gserviceaccount.com"
}
''';
  static final _spreadsheetId = '16WQ_uAG7lOAbK1oKVD6r7GyqEhaV5fg78QJ93rEFQRc';
  static final _gsheets = GSheets(_credentials);
  static Worksheet? _workCommitmentSheet;

  static Future init() async {
    try {
      final spreadsheet = await _gsheets.spreadsheet(_spreadsheetId);
      _workCommitmentSheet =
          await _getWorkSheet(spreadsheet, title: 'WorkCommitment');

      final firstRow = WorkCommitmentModel.getFields();
      _workCommitmentSheet!.values.insertRow(1, firstRow);
    } catch (e) {
      print('Init Error: $e');
    }
  }

  static Future<Worksheet> _getWorkSheet(
    Spreadsheet spreadsheet, {
    required String title,
  }) async {
    try {
      return await spreadsheet.addWorksheet(title);
    } catch (e) {
      return spreadsheet.worksheetByTitle(title)!;
    }
  }

  static Future<List<WorkCommitment>> getAll() async {
    if (_workCommitmentSheet == null) return <WorkCommitment>[];

    final workCommitments = await _workCommitmentSheet!.values.map.allRows();
    return workCommitments == null
        ? <WorkCommitment>[]
        : workCommitments.map(WorkCommitment.fromJson).toList();
  }

  static Future<WorkCommitment?> getById(int id) async {
    if (_workCommitmentSheet == null) return null;

    final json =
        await _workCommitmentSheet!.values.map.rowByKey(id, fromColumn: 1);
    return json == null ? null : WorkCommitment.fromJson(json);
  }

  static Future<int> getRowCount() async {
    if (_workCommitmentSheet == null) return 0;

    final lastRow = await _workCommitmentSheet!.values.lastRow();
    return lastRow == null ? 0 : int.tryParse(lastRow.first) ?? 0;
  }
}
