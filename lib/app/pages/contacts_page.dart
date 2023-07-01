import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("contact_us".tr),
      ),
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(15.0),
        decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(10.0)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("contact".tr),
            SizedBox(height: 5.0),
            Row(
              children: [
                Icon(LineAwesomeIcons.telegram, size: 20),
                SizedBox(width: 10.0),
                GestureDetector(
                  onTap: () => launchUrl(Uri.parse("https://t.me/JasurbekKurganbayev"), mode: LaunchMode.externalApplication),
                  child: Text(
                    "Jasurbek Kurganbayev",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.indigo, decoration: TextDecoration.underline),
                  ),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Icon(LineAwesomeIcons.link, size: 20),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
