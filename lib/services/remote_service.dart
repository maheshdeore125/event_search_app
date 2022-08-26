import 'package:event_search_app/models/event.dart';
import 'package:http/http.dart' as http;

/// Remote service to consume API for search text
class RemoteService {
  Future<Event?> getEvents(queryString) async {
    var client = http.Client();
    var uri = Uri.parse(
        'https://api.seatgeek.com/2/events?client_id=Mjg2MzY3MjJ8MTY2MTMzNzU5Ny41NjE2Nzg2&q=${queryString}');
    print('Uri:: ${uri}');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return eventFromJson(json);
    }
    return null;
  }
}
