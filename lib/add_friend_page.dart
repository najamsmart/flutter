import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddFriendPage extends StatefulWidget {
  @override
  _AddFriendPageState createState() => _AddFriendPageState();
}

class _AddFriendPageState extends State<AddFriendPage> {
  TextEditingController _userIdController = TextEditingController();
  TextEditingController _friendIdController = TextEditingController();

  void _addFriend() async {
    String userId = _userIdController.text;
    String friendId = _friendIdController.text;

    // Use the correct IP address based on the platform (10.0.2.2 for Android, 127.0.0.1 for iOS)
    String ipAddress = '10.0.2.2'; // For Android Emulator
    // String ipAddress = '127.0.0.1'; // For iOS Simulator

    final apiUrl = 'http://$ipAddress:3000/add_friend';
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({'user_id': userId, 'friend_id': friendId});

    try {
      final response = await http.post(Uri.parse(apiUrl), headers: headers, body: body);
      if (response.statusCode == 200) {
        // Friend added successfully, you can show a success message or navigate to another page.
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Success'),
            content: Text('Friend added successfully!'),
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
            content: Text('Failed to add friend. Please try again.'),
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
        title: Text('Add Friend'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _userIdController,
              decoration: InputDecoration(labelText: 'Your User ID'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _friendIdController,
              decoration: InputDecoration(labelText: 'Friend\'s User ID'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _addFriend,
              child: Text('Add Friend'),
            ),
          ],
        ),
      ),
    );
  }
}
