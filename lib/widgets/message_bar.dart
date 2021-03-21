import 'package:flutter/material.dart';
import 'package:flutterzin/utils/constants.dart';

class MessageBar extends StatelessWidget {
  final void Function(String) addMessage;
  final _controller = TextEditingController();

  MessageBar(this.addMessage);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Constants.BORDER_COLOR,
          ),
        ),
      ),
      height: 75,
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                controller: _controller,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  hintText: 'Digite sua mensagem',
                ),
              ),
            ),
          ),
          IconButton(
            color: Colors.black,
            icon: Icon(Icons.send),
            onPressed: () {
              if (_controller.text.isNotEmpty) {
                addMessage(_controller.text);
                _controller.text = '';
              }
            },
          ),
        ],
      ),
    );
  }
}
