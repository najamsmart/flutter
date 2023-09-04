import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatDetailedPage extends StatefulWidget {
  final String senderId;
  final String receiverId;

  ChatDetailedPage({required this.senderId, required this.receiverId});

  @override
  _ChatDetailedPageState createState() => _ChatDetailedPageState();
}

class _ChatDetailedPageState extends State<ChatDetailedPage> {
  List<Map<String, dynamic>> _chatMessages = [];
  bool _isFetchingData = true;
  String? _errorMessage;
    // Use the correct IP address based on the platform (10.0.2.2 for Android, 127.0.0.1 for iOS)
    String ipAddress = '10.0.2.2'; // For Android Emulator

  @override
  void initState() {
    super.initState();
    _fetchChatHistory();
  }

  void _fetchChatHistory() async {
  final apiUrl = 'http://$ipAddress:3000/chat_messages/${widget.senderId}/${widget.receiverId}';

  try {
    final response = await http.get(Uri.parse(apiUrl));
    print('Response Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    
      if (response.statusCode == 200) {
        setState(() {
          _chatMessages = List<Map<String, dynamic>>.from(json.decode(response.body));
          _isFetchingData = false; // Data fetched successfully
        });
      } else {
        setState(() {
          _isFetchingData = false; // Data fetching failed
          _errorMessage = 'Failed to fetch chat history. Please try again.';
        });
      }
    } catch (e) {
      setState(() {
        _isFetchingData = false; // Data fetching failed
        _errorMessage = 'An error occurred. Please check your internet connection and try again.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat History'),
      ),
      body: _isFetchingData
          ? Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? Center(
                  child: Text(_errorMessage!),
                )
              : _chatMessages.isEmpty
                  ? Center(
                      child: Text('No chat history available.'),
                    )
                  : _buildChatHistory(),
    );
  }

  Widget _buildChatHistory() {
    return ListView.builder(
      itemCount: _chatMessages.length,
      itemBuilder: (context, index) {
        final message = _chatMessages[index]['message'];
        final isSentByCurrentUser = _chatMessages[index]['sender_id'] == widget.senderId;

        return ListTile(
          title: Text(message),
          subtitle: Text(isSentByCurrentUser ? 'You' : 'Friend'),
          trailing: Text(_chatMessages[index]['timestamp']),
        );
      },
    );
  }
}
