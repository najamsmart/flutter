import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GroupDetailPage extends StatefulWidget {
  final int groupId;

  GroupDetailPage({required this.groupId});

  @override
  _GroupDetailPageState createState() => _GroupDetailPageState();
}

class _GroupDetailPageState extends State<GroupDetailPage> {
  Map<String, dynamic> _groupDetail = {};

  @override
  void initState() {
    super.initState();
    _fetchGroupDetail();
  }

  void _fetchGroupDetail() async {
    final apiUrl = 'http://localhost:3000/group_detail/${widget.groupId}';

    try {
      final response = await http.get(apiUrl as Uri);
      if (response.statusCode == 200) {
        setState(() {
          _groupDetail = Map<String, dynamic>.from(json.decode(response.body));
        });
      } else {
        // Handle error response
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text('Failed to fetch group details. Please try again.'),
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
        title: Text('Group Detail'),
      ),
      body: _groupDetail.isNotEmpty ? _buildGroupDetail() : Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildGroupDetail() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Group Name: ${_groupDetail['group_name']}'),
          SizedBox(height: 8),
          Text('Group Admin ID: ${_groupDetail['group_admin_id']}'),
          SizedBox(height: 16),
          Text('Members:'),
          for (String member in _groupDetail['members']) ...[
            ListTile(title: Text(member)),
            Divider(),
          ],
        ],
      ),
    );
  }
}
