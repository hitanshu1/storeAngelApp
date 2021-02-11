
import 'package:url_launcher/url_launcher.dart';

class MapService{
  static void openMap(String destination)async{
    final url = Uri.encodeFull('https://www.google.com/maps/dir/current+location/$destination');
//                  String googleUrl = 'https://www.google.com/maps/search/?api=1&query=${model.currentLocation.latitude},${model.currentLocation.longitude}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not open the map.';
    }
  }
}