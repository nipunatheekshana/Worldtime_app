import 'package:http/http.dart'; //package imported, this package is adedd in the dipendanci of the pupspecfile
import 'dart:convert'; // use to convert api data to map data
import 'package:intl/intl.dart';

class WorldTime {
  String location;
  String time;
  String flag;
  String url;
  bool isDaytime; // true if the time is day

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async {
    try {
      //maaking the requst to the world time api
      Response response = await get(
          'http://worldtimeapi.org/api/timezone/$url'); //getting data from the api useing http package above imported
      Map data = jsonDecode(response
          .body); //converting data to map data type useing above imported dart convert package
      //print(data);

      //get properties from the data
      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);
      // print(datetime);
      // print(offset);

      //create date time object
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      //check is it day or night
      isDaytime = now.hour > 6 && now.hour < 20 ? true : false;

      //convert the datetime to string
      time = DateFormat.jm()
          .format(now); // format the time using intl package imported above
    } catch (e) {
      //error handeling try and catch
      print('error:$e');
      time = 'could not get the time';
    }
  }
}
