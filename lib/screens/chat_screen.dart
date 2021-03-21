import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterzin/widgets/chat_appbar.dart';
import 'package:flutterzin/widgets/message_bar.dart';
import 'package:flutterzin/widgets/message_bubble.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChatAppBar(),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('chats')
                  .orderBy('timestamp')
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData)
                  return Center(child: CircularProgressIndicator());
                final doc = snapshot.data.docs;
                return ListView.builder(
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
