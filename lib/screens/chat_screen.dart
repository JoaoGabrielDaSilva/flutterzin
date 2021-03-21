import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutterzin/widgets/chat_appbar.dart';
import 'package:flutterzin/widgets/message_bar.dart';
import 'package:flutterzin/widgets/message_bubble.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final void Function() changeTheme;

  ChatScreen(this.changeTheme);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _scrollController = ScrollController();

  Future<void> addMessage(String message) async {
    FirebaseFirestore.instance.collection('chats').add(
      {
        'name': (await FirebaseFirestore.instance
                .collection('users')
                .doc(FirebaseAuth.instance.currentUser.uid)
                .get())
            .get('name'),
        'userId': FirebaseAuth.instance.currentUser.uid,
        'message': message,
        'timestamp': Timestamp.now(),
      },
    );
    SystemSound.play(SystemSoundType.click);
    _scrollController.animateTo(_scrollController.position.minScrollExtent,
        duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChatAppBar(widget.changeTheme),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('chats')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData)
                  return Center(child: CircularProgressIndicator());
                final doc = snapshot.data.docs;
                return ListView.builder(
                  controller: _scrollController,
                  reverse: true,
                  itemCount: doc.length,
                  itemBuilder: (context, i) {
                    return MessageBubble(
                      isMine: doc[i].get('userId') ==
                          FirebaseAuth.instance.currentUser.uid,
                      name: doc[i].get('name'),
                      message: doc[i].get('message'),
                    );
                  },
                );
              },
            ),
          ),
          MessageBar(addMessage),
        ],
      ),
    );
  }
}
