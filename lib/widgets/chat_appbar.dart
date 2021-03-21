import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterzin/utils/constants.dart';

class ChatAppBar extends StatefulWidget implements PreferredSizeWidget {
  ChatAppBar({Key key})
      : preferredSize = Size.fromHeight(75),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  _ChatAppBar createState() => _ChatAppBar();
}

class _ChatAppBar extends State<ChatAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      toolbarHeight: 75,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(75),
        child: Container(
          height: 1,
          color: Constants.BORDER_COLOR,
        ),
      ),
      actions: [
        DropdownButtonHideUnderline(
          child: DropdownButton(
            icon: Icon(Icons.more_vert),
            items: [
              DropdownMenuItem(
                value: 'logout',
                child: Container(
                  child: Row(
                    children: [
                      Icon(
                        Icons.exit_to_app,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text('Sair'),
                    ],
                  ),
                ),
              ),
            ],
            onChanged: (value) {
              if (value == 'logout') FirebaseAuth.instance.signOut();
            },
          ),
        )
      ],
      title: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 25,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              'Nome',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
        ],
      ),
    );
  }
}
