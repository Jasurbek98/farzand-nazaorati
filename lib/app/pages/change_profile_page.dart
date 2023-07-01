import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parental_control/common_widgets/custom_input.dart';

class ChangeProfilePage extends StatefulWidget {
  const ChangeProfilePage({Key? key}) : super(key: key);

  @override
  State<ChangeProfilePage> createState() => _ChangeProfilePageState();
}

class _ChangeProfilePageState extends State<ChangeProfilePage> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _passwordTxtCtrl = TextEditingController();
    final _newPasswordTxtCtrl = TextEditingController();
    final _confirmNewPasswordTxtCtrl = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text("update_profile".tr),
      ),
      bottomNavigationBar: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          if (_formKey.currentState!.validate()) {
            setState(() {
              Get.back();
              showDialog(
                  context: context,
                  builder: (builder) {
                    return Dialog(
                      backgroundColor: Colors.transparent,
                      insetPadding: EdgeInsets.symmetric(horizontal: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(15.0),
                        margin: EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("success".tr, style: TextStyle(color: Colors.indigo, fontSize: 15.0, fontWeight: FontWeight.bold)),
                            SizedBox(height: 15.0),
                            Flexible(child: Text("password_changed_successfully".tr, textAlign: TextAlign.center)),
                            SizedBox(height: 15.0),
                            GestureDetector(
                              onTap: () => Get.back(),
                              child: Text("confirm".tr, textAlign: TextAlign.center, style: TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            });
          }
        },
        child: Container(
          height: 50,
          margin: EdgeInsets.all(20.0),
          padding: EdgeInsets.all(15.0),
          decoration: BoxDecoration(
            color: Colors.indigo,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Center(child: Text("confirm".tr, style: TextStyle(color: Colors.white, fontSize: 16))),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomInput(
                controller: _passwordTxtCtrl,
                labelText: "password".tr,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'required_field'.tr;
                  }
                  return null;
                },
              ),
              SizedBox(height: 40),
              CustomInput(
                controller: _newPasswordTxtCtrl,
                labelText: 'new_password'.tr,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'required_field'.tr;
                  } else if(value == _passwordTxtCtrl.text) {
                    return "new_password_cant_be_equal_now".tr;
                  }
                  return null;
                },
              ),
              CustomInput(
                controller: _confirmNewPasswordTxtCtrl,
                labelText: 'confirm_new_password'.tr,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'required_field'.tr;
                  } else if(value == _newPasswordTxtCtrl.text) {
                    return null;
                  }
                  return "password_incompatible".tr;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
