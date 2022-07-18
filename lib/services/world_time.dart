import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location = ""; // location name for UI
  String time = ""; // the time in that location
  String flag = ""; // url for asset flag icon
  String url = ""; // location url for api endpoint
  bool isDaytime = false; // true or false for night or day image display
  WorldTime({required this.location, required this.flag, required this.url});

  Future<void> getTime() async {
    try {
      Response response =
          await get(Uri.parse('https://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);

      //get properties from data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);

      // create DateTime object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      // set time property
      isDaytime = now.hour > 6 && now.hour < 19 ? true : false;
      time = DateFormat.jm().format(now); // formats datetime to output time.
    } catch (e) {
      print('Caught error $e');
      time = 'Could not retrieve the time data';
    }
  }
}
