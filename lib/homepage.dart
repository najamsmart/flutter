import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Groups",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 27,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Handle the search button action here
              // Navigate to the SearchPage
              // Example: Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage()));
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 50),
          children: <Widget>[
            // Add your drawer content here, e.g., user avatar, username, logout button, etc.
          ],
        ),
      ),
      body: Center(
        child: Text("Welcome to the HomePage!"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle the floating action button (add button) action here
          // Show a pop-up dialog to create a group or navigate to a page to create a group
          // Example: showDialog(context: context, builder: (context) => CreateGroupDialog());
        },
        child: Icon(
          Icons.add,
          size: 30,
        ),
      ),
    );
  }
}
