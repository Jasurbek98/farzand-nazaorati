import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmptyContent extends StatelessWidget {
  const EmptyContent(
      {Key? key,
      this.title = 'nothing_exist',
      this.fontSizeMessage = 18.0,
      this.fontSizeTitle = 32.0,
      this.message = 'add_new_chapter'})
      : super(key: key);

  final String title;
  final double fontSizeTitle;
  final double fontSizeMessage;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title.tr,
            style: TextStyle(
              fontSize: fontSizeTitle,
              color: Colors.black54,
            ),
          ),
          Text(
            message.tr,
            style: TextStyle(
              fontSize: fontSizeMessage,
              color: Colors.black54,
            ),
          )
        ],
      ),
    );
  }
}
