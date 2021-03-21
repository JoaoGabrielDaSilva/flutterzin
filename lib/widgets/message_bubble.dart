import 'package:flutterzin/utils/constants.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String name;
  final bool isMine;
  final String message;

  MessageBubble({
    this.name,
    this.isMine,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.only(
            top: 5,
            right: isMine ? 20 : 0,
            left: isMine ? 0 : 20,
            bottom: 20,
          ),
          constraints: BoxConstraints(minWidth: 100),
          decoration: BoxDecoration(
            color: isMine ? Colors.green : null,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: Constants.BORDER_COLOR,
            ),
          ),
          child: Column(
            crossAxisAlignment:
                isMine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(name),
              SizedBox(
                height: 10,
              ),
              Text(
                message,
                style: TextStyle(
                  color: isMine ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
