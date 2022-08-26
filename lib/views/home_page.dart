import 'package:event_search_app/models/event.dart';
import 'package:flutter/material.dart';
import 'package:event_search_app/services/remote_service.dart';

/// Homepage class
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Event? events;
  List<EventElement>? _foundUsers = [];

  @override
  void initState() {
    super.initState();

    // fetch data from server
    getEventList('');
  }

  /// Fetch data from serve
  getEventList(str) async {
    events = await RemoteService().getEvents(str);
    // print('Total Records:: ${events?.events.length} ${events?.events != null}');
    // if the data is present then set the state
    if (events?.events != null) {
      // Refresh the UI
      setState(() {
        _foundUsers = events?.events;
      });
    }
  }

// This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    if (enteredKeyword.isNotEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      getEventList(enteredKeyword);
    } else {
      getEventList(''); // fetch all the records
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Events'),
        centerTitle: false,
        backgroundColor: Colors.grey[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextField(
              onChanged: (value) => _runFilter(value),
              decoration: const InputDecoration(
                labelText: 'Search Events',
                suffixIcon: Icon(Icons.search, color: Colors.black87),
                // border: OutlineInputBorder(),
              ),
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 20.0,
              ),
            ),
            Expanded(
              child: _foundUsers!.isNotEmpty
                  ? ListView.builder(
                      itemCount: _foundUsers!.length,
                      itemBuilder: (context, index) => Card(
                        key: ValueKey(_foundUsers![index].id),
                        margin: const EdgeInsets.symmetric(vertical: 1),
                        child: ListTile(
                            leading: const CircleAvatar(
                              backgroundImage: AssetImage('assets/thumb.jpg'),
                              radius: 25.0,
                            ),
                            title: Text(_foundUsers![index].shortTitle),
                            subtitle: Text(_foundUsers![index].title),
                            trailing: const Icon(
                              Icons.favorite_border_outlined,
                              color: Colors.grey,
                            )),
                      ),
                    )
                  : const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                        'No results found',
                        style: TextStyle(fontSize: 18),
                      ),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
