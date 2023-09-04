// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// import 'add_friend_page.dart';
// import 'add_group_page.dart';
// import 'chat_detailed_page.dart';
// import 'group_detail_page.dart';

// void main() => runApp(ChatApp());

// class ChatApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Chat App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       initialRoute: '/add_group',
//       routes: {
//         '/add_friend': (context) => AddFriendPage(),
//         '/chat_detailed': (context) => ChatDetailedPage(receiverId: 'receiver_user_id', senderId: 'sender_user_id',),
//         '/add_group': (context) => AddGroupPage(),
//         '/group_detail': (context) => GroupDetailPage(groupId: 1,),
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';

import 'homepage.dart';
// ignore: depend_on_referenced_packages
 // Import the homepage.dart file

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue, // Set the primary color for the app
      ),
      home: HomePage(), // Set the HomePage as the initial route
    );
  }
}
