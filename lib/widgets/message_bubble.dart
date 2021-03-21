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
          constraints: BoxConstraints(
            minWidth: 100,
            maxWidth: MediaQuery.of(context).size.width * 0.6,
          ),
          decoration: BoxDecoration(
            color: isMine ? Colors.green : null, //Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
              topLeft: Radius.circular(isMine ? 10 : 0),
              topRight: Radius.circular(isMine ? 0 : 10),
            ),
            border: isMine
                ? null
                : Border.all(
                    color: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .color
                        .withOpacity(0.2),
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
                  color: isMine
                      ? Colors.white
                      : Theme.of(context).textTheme.bodyText1.color,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
