import 'package:flutter/material.dart';
import 'package:avatar_plus/avatar_plus.dart';
import '/custom/theme.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Chooseing_Avatar extends StatefulWidget {
  final String userId;

  const Chooseing_Avatar({super.key, required this.userId});

  @override
  State<Chooseing_Avatar> createState() => _Chooseing_AvatarState();
}

class _Chooseing_AvatarState extends State<Chooseing_Avatar> {
  String? selectedAvatar;
  final List<String> avatars = [
    'ak',
    '3311bb6338d7888219',
    '4',
    'jonny',
    'vv',
    'lm',
    '895llkb6',
    'pplo8851',
    'pplo8c5',
    'pplo8r5',
    'pplo8r53',
    'pplo8r575',
    'p44fl8r5',
    'ppl887568r5',
  ];

  Future<void> _updateUserAvatar() async {
    if (selectedAvatar == null) return;

    try {
      final response = await http.put(
        Uri.parse('http://192.168.88.25:5000/api/users/${widget.userId}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'avatar': selectedAvatar}),
      );

      if (response.statusCode == 200) {
        // Avatar updated successfully
        print('Avatar updated successfully');
        // Navigate to home page or wherever you want
        // Navigator.pushReplacement(context, MaterialPageRoute(builder: ...));
      } else {
        print('Failed to update avatar: ${response.body}');
      }
    } catch (e) {
      print('Error updating avatar: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    double boxSize = MediaQuery.of(context).size.width - 20;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF998BCF),
        automaticallyImplyLeading: false,
        title: Text(
          'Cadeau',
          style: FlutterFlowTheme.of(context).headlineMedium.override(
            fontFamily: 'Inter Tight',
            color: Colors.white,
            fontSize: 30,
            letterSpacing: 0.0,
          ),
        ),
        elevation: 2,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          const Text(
            'Meet your new friend',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: Center(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                padding: const EdgeInsets.all(8),
                children:
                    avatars.map((avatarName) {
                      bool isSelected = selectedAvatar == avatarName;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedAvatar = avatarName;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color:
                                  isSelected
                                      ? Color(0xFF998BCF)
                                      : Colors.transparent,
                              width: 4,
                            ),
                          ),
                          child: AvatarPlus(
                            avatarName,
                            height: double.infinity,
                            width: double.infinity,
                          ),
                        ),
                      );
                    }).toList(),
              ),
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed:
                selectedAvatar != null
                    ? () async {
                      await _updateUserAvatar();
                      // Navigate to home page after selection
                      // Navigator.pushReplacement(...);
                    }
                    : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF998BCF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
            ),
            child: const Text(
              'Choose',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
