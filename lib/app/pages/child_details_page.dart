import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parental_control/common_widgets/bar_chart.dart';
import 'package:parental_control/common_widgets/custom_raised_button.dart';
import 'package:parental_control/common_widgets/empty_content.dart';
import 'package:parental_control/common_widgets/show_alert_dialog.dart';
import 'package:parental_control/common_widgets/show_exeption_alert.dart';
import 'package:parental_control/models/child_model.dart';
import 'package:parental_control/services/database.dart';
import 'package:provider/provider.dart';

import '../../models/notification_model.dart';

class ChildDetailsPage extends StatefulWidget {
  const ChildDetailsPage({
    required this.database,
    required this.childModel,
  });

  final Database database;
  final ChildModel childModel;

  static Future<void> show(BuildContext context, ChildModel model) async {
    final database = Provider.of<Database>(context, listen: false);
    await Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: false,
        builder: (context) => ChildDetailsPage(database: database, childModel: model),
      ),
    );
  }

  @override
  _ChildDetailsPageState createState() => _ChildDetailsPageState();
}

class _ChildDetailsPageState extends State<ChildDetailsPage> {
  Future<void> _delete(BuildContext context, ChildModel model) async {
    try {
      await widget.database.deleteChild(model);
    } on FirebaseException catch (e) {
      await showExceptionAlertDialog(
        context,
        title: 'operation_failed'.tr,
        exception: e,
      );
    }
  }

  var isPushed = false;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ChildModel>(
        stream: widget.database.childStream(childId: widget.childModel.id),
        builder: (context, snapshot) {
          final child = snapshot.data;
          final childName = child?.name ?? '';
          return Scaffold(
            appBar: AppBar(
              elevation: 2.0,
              title: Text(childName),
              actions: <Widget>[
                //TODO: Reset The edit button if wanted
                // TextButton(
                //   child: Text(
                //     'Edit',
                //     style: TextStyle(fontSize: 18.0, color: Colors.white),
                //   ),
                //   onPressed: () => EditChildPage.show(context,
                //       database: widget.database, model: child),
                // ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _confirmDelete(context, widget.childModel),
                ),
              ],
            ),
            body: _buildContentTemporary(context, child),
            floatingActionButton: FloatingActionButton(
                child: Icon(Icons.more_vert),
                onPressed: () {
                  setState(() {
                    isPushed = !isPushed;
                  });
                  print('more is pushed');
                }),
          );
        });
  }

  Widget _buildContentTemporary(BuildContext context, ChildModel? model) {
    if (model != null) {
      return SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                _buildProfile(model),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    children: [
                      Text(
                        'input_code_to_child_version'.tr,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black.withOpacity(0.35)),
                      ),
                      SizedBox(height: 10),
                      Text(
                        model.id,
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.deepOrangeAccent),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    margin: const EdgeInsets.symmetric(horizontal: 18),
                    height: 205,
                    width: double.infinity,
                    child: model.appsUsageModel?.isNotEmpty ?? false
                        ? AppUsageChart(isEmpty: false, name: model.name)
                        : AppUsageChart(isEmpty: true, name: model.name)),
                SizedBox(height: 6),
              ],
            ),
            SizedBox(height: 18),
            SizedBox(
              height: 2,
              width: double.infinity,
              child: Container(
                color: Colors.indigo,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: RichText(
                textAlign: TextAlign.start,
                text: TextSpan(text: "send_child_version_notification".tr, style: TextStyle(color: Colors.indigo, fontSize: 14)),
              ),
            ),
            SizedBox(height: 2),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: RichText(
                textAlign: TextAlign.start,
                text: TextSpan(text: 'press_button'.tr, style: TextStyle(color: Colors.grey, fontSize: 11)),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              decoration: BoxDecoration(color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(75.0, 22, 75, 12),
                    child: CustomRaisedButton(
                      child: Text(
                        'bed_time'.tr,
                        style: TextStyle(fontSize: 17, color: Colors.white),
                      ),
                      borderRadius: 12,
                      color: Colors.indigo,
                      height: 45,
                      onPressed: () async {
                        try {
                          await widget.database.setNotification(
                              NotificationModel(
                                id: model.id,
                                title: '${"hey".tr}${model.name}',
                                body: 'news_in_there'.tr,
                                message: 'go_to_bed'.tr,
                              ),
                              model);
                          await showAlertDialog(context, title: 'success'.tr, content: 'notification_send_to'.trArgs([model.name]), defaultActionText: 'OK');
                          print('Notification sent to device');
                        } on FirebaseException catch (e) {
                          await showExceptionAlertDialog(context, title: 'error_occurred'.tr, exception: e);
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(75.0, 12, 75, 6),
                    child: CustomRaisedButton(
                      child: Text(
                        'time_home_work'.tr,
                        style: TextStyle(fontSize: 17),
                        textAlign: TextAlign.center,
                      ),
                      borderRadius: 12,
                      color: Colors.indigo,
                      height: 45,
                      onPressed: () async {
                        try {
                          await widget.database.setNotification(
                              NotificationModel(
                                id: model.id,
                                title: '${"hey".tr}${model.name}',
                                body: 'news_in_there'.tr,
                                message: 'time_home_work'.tr,
                              ),
                              model);
                          await showAlertDialog(context, title: 'success'.tr, content: 'notification_send_to'.trArgs([model.name]), defaultActionText: 'OK');
                          print('Notification sent to device');
                        } on FirebaseException catch (e) {
                          await showExceptionAlertDialog(context, title: 'error_occurred'.tr, exception: e);
                        }
                      },
                    ),
                  ),
                ],
              ),
              height: 150,
            ),
            SizedBox(height: 58),
            isPushed == true
                ? ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: model.appsUsageModel?.length,
                    itemBuilder: (context, index) {
                      return SingleChildScrollView(
                        physics: NeverScrollableScrollPhysics(),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            ListTile(
                              leading: Icon(Icons.phone_android),
                              title: Text(
                                '${model.appsUsageModel![index]['appName']}',
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              trailing: Text(
                                parseResult(model.appsUsageModel![index]['usage']),
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.indigo),
                              ),
                            )
                          ],
                        ),
                      );
                    })
                : EmptyContent(
                    message: 'tap_to_see'.tr,
                    title: 'see_app_statistics'.tr,
                    fontSizeMessage: 12,
                    fontSizeTitle: 23,
                  ),
            SizedBox(height: 50)
          ],
        ),
      );
    } else {
      return EmptyContent(title: 'nothing_not_found'.tr, message: 'there_child_data'.tr);
    }
  }

  Widget _buildProfile(ChildModel model) {
    return Container(
      width: 120,
      height: 140,
      padding: EdgeInsets.all(3),
      child: Container(
        alignment: Alignment.topLeft,
        child: model.image == null
            ? Container(
                height: 120,
                decoration: BoxDecoration(borderRadius: const BorderRadius.all(Radius.circular(16)), color: Colors.black.withOpacity(0.10)),
              )
            : Container(
                alignment: Alignment.topLeft,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(model.image!),
                  ),
                ),
              ),
      ),
    );
  }

  Future<void> _confirmDelete(BuildContext context, ChildModel model) async {
    final didConfirmDelete = await showAlertDialog(context,
        title: 'delete_child_data'.tr, content: 'sure_to_delete_child'.tr, defaultActionText: 'delete'.tr, cancelActionText: 'cancel'.tr);
    if (didConfirmDelete == true) {
      await _delete(context, model);
      Navigator.of(context).pop();
    }
    return;
  }

  String parseResult(String value) {
    var removeColon = value.replaceAll(':', ' ');
    var result = removeColon.replaceAll('.', '');

    result = result.replaceRange(1, 1, ' ${"day".tr} ');
    result = result.replaceRange(9, 9, ' ${"hour".tr} ');
    result = result.replaceRange(18, null, ' ${"minute".tr} ');

    if (result.contains('00 ${"hour".tr}')) {
      result = result.replaceRange(0, 14, '');
      return result;
    } else if (result.contains('0 ${"day".tr}')) {
      result = result.replaceRange(0, 5, '');
      return result;
    }
    return result;
  }
}
