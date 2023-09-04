import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddGroupPage extends StatefulWidget {
  @override
  _AddGroupPageState createState() => _AddGroupPageState();
}

class _AddGroupPageState extends State<AddGroupPage> {
  TextEditingController _groupNameController = TextEditingController();
  TextEditingController _groupAdminIdController = TextEditingController();
  TextEditingController _membersController = TextEditingController();

  void _addGroup() async {
    String groupName = _groupNameController.text;
    String groupAdminId = _groupAdminIdController.text;
    List<String> members = _membersController.text.split(',');

    // Use the correct IP address based on the platform (10.0.2.2 for Android, 127.0.0.1 for iOS)
    String ipAddress = '10.0.2.2'; // For Android Emulator
    // String ipAddress = '127.0.0.1'; // For iOS Simulator

    final apiUrl = 'http://$ipAddress:3000/add_group';
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({'group_name': groupName, 'group_admin_id': groupAdminId, 'members': members});

    try {
      final response = await http.post(Uri.parse(apiUrl), headers: headers, body: body);
      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');
      if (response.statusCode == 200) {
        // Group added successfully, you can show a success message or navigate to another page.
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Success'),
            content: Text('Group added successfully!'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('OK'),
              ),
            ],
          ),
        );
      } else {
        // Handle error response
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text('Failed to add group. Please try again.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      // Handle network or server error
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('An error occurred. Please check your internet connection and try again.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Group'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _groupNameController,
              decoration: InputDecoration(labelText: 'Group Name'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _groupAdminIdController,
              decoration: InputDecoration(labelText: 'Group Admin ID'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _membersController,
              decoration: InputDecoration(labelText: 'Members (comma-separated user IDs)'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _addGroup,
              child: Text('Create Group'),
            ),
          ],
        ),
      ),
    );
  }
}
