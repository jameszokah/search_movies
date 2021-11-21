import 'package:flutter/material.dart';
import '../service/ThemeService.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController controller = new TextEditingController();
  String searchTerm = "flash";
  late List movieData = [];

  getMovie(url) async {
    final movie = await http.get(Uri.parse(url));
    if (movie.statusCode == 200) {
      final data = jsonDecode(movie.body);
      setState(() {
        movieData = data['Search'];
      });
      print(movieData);
    }
  }

  @override
  void initState() {
    super.initState();
    final String apiKey = "3ab63c5c";
    getMovie('https://www.omdbapi.com/?s=$searchTerm&apikey=$apiKey');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: controller,
          onChanged: (value) {
            final apiKey = "3ab63c5c";
            searchTerm = controller.text;
            getMovie('https://www.omdbapi.com/?s=$searchTerm&apikey=$apiKey');
          },
          decoration: InputDecoration(
            hintText: 'Search For Movie...',
            contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0),
              borderRadius: BorderRadius.all(Radius.circular(32.0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
              borderRadius: BorderRadius.all(Radius.circular(32.0)),
            ),
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            ThemeService().switchTheme();
            print("Theme Change");
          },
          child: Icon(
            Icons.nightlight_round,
            size: 20.0,
          ),
        ),
        actions: [
          SizedBox(width: 20.0),
          Icon(
            Icons.person,
            size: 20.0,
          ),
          SizedBox(width: 20.0),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: ListView.builder(
          itemCount: movieData.length,
          itemBuilder: (BuildContext context, int i) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(movieData[i]["Title"]),
                subtitle: Text(movieData[i]["Year"]),
                isThreeLine: true,
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(movieData[i]["Poster"]),
                ),
                trailing: Icon(Icons.more_vert),
              ),
            );
          },
        ),
      ),
    );
  }
}
