import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<bool> showAlertDialog(
  BuildContext context, {
  required String title,
  required String content,
  required String defaultActionText,
      String? cancelActionText,
}) async {
  if (!Platform.isIOS) {
    return await showDialog(
      barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
              title: Text(title),
              content: Text(content),
              actions: [
                if(cancelActionText !=null )
                  TextButton(
                    child: Text(
                      cancelActionText,
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    onPressed: () => Navigator.of(context).pop(false),
                  ),
                TextButton(
                  child: Text(defaultActionText,
                      style: TextStyle(color: Theme.of(context).primaryColor)),
                  onPressed: () => Navigator.of(context).pop(true),
                ),
              ],
            ));
  }else{
    return await showCupertinoDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            if(cancelActionText !=null )
              CupertinoDialogAction(
                child: Text(cancelActionText),
                onPressed: ()=> Navigator.of(context).pop(false),
              ),

            CupertinoDialogAction(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(defaultActionText),
            ),
          ],
        ));


  }
}
