import 'package:http/http.dart' as http;
import 'dart:convert';

Future<void> sendSMS({
  String status,
  String name,
  String phone,
  String orderID,
}) async {
  try {
    await http
        .post(
      'https://2factor.in/API/R1/?module=TRANS_SMS&apikey=ed6e1d01-e2b8-11ea-9fa5-0200cd936042&to=$phone&from=CPTSLY&templatename=CPTSLY&var1=$name&var2=$orderID&var3=$status',
    )
        .then((value) {
      print(value.body);
    });
  } catch (e) {
    throw Exception(e.toString());
  }
}

Future<String> remainingSMS() async {
  String remSMS;
  var res = await http.get(
    'http://2factor.in/API/V1/ed6e1d01-e2b8-11ea-9fa5-0200cd936042&to/ADDON_SERVICES/BAL/TRANSACTIONAL_SMS',
  );
  if (res.statusCode == 200) {
    var jsonSting = json.decode(res.body);
    remSMS = jsonSting['Details'];
    return remSMS;
  }
  return remSMS;
}
