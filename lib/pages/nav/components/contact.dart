import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:juba/constants.dart';
import 'package:juba/generated/l10n.dart';
import 'package:juba/helpers/mainHelper.dart';
import 'package:juba/pages/nav/components/startpage.dart';
import 'package:juba/pages/nav/navigation.dart';
import 'package:juba/providers/globalProvider.dart';
import 'package:juba/widgets/globalwidget.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../../models/message.dart';
import '../../../providers/messageProvider.dart';

class MSG extends StatelessWidget {
  final _messageidController = TextEditingController();
  final _nameController = TextEditingController();
  final _messageController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _timestampController = TextEditingController();
  final _regardController = TextEditingController();

  void _sendMessage() {
    String id = Uuid().v4();

    final _messageid = _messageController;
    final nameMSG = _nameController.text;
    final messageMSG = _messageController.text;
    final phoneMSG = _phoneController.text;
    final emailMSG = _emailController.text;
    final timestampMSG = _timestampController.text;
    final regardMSG = _regardController.text;

    messagesRef.add(Message(
      name: nameMSG,
      message: messageMSG,
      phone: phoneMSG,
      email: emailMSG,
      messageId: id,
      regard: regardMSG,
      timestamp: DateTime.now().toLocal().toString(),
    ));

    _nameController.clear();
    _messageController.clear();
    _phoneController.clear();
    _emailController.clear();
    _messageid.clear();
    _regardController.clear();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var globalProvider = context.watch<GlobalProvider>();
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        decoration:
            BoxDecoration(gradient: GlobalWidgets().gradient(globalProvider)),
        child:  _contact(context, globalProvider, width),
      ),
    );
  }

  _contact(BuildContext context, GlobalProvider globalProvider, double width ) {
    return Container(

      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            kSizedBox,
          GlobalWidgets().simpleBackButton(context, globalProvider, width),
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                    key: _formKey,
                    child: Container(
                      padding:  EdgeInsets.all(width >= 768.0 ? 80 : 30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            height: 150,
                            child: Image.asset(
                              'images/juba-worms-logo.png',
                          )),
                          SizedBox(height: 25),
                          Row(children: [
                            Expanded(child: myForm(_nameController, S.of(context).name)),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                child: myForm(_phoneController, S.of(context).number,
                                    isPhone: true)),
                          ]),
                          SizedBox(height: 15),
                          myForm(_emailController, S.of(context).email),
                          SizedBox(height: 15),
                          myForm(_regardController, S.of(context).regarding),
                          SizedBox(height: 15),
                          myForm(_messageController, S.of(context).message,
                              isMessageField: true),
                          SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Center(
                                  child: InkWell(
                                  onTap: () {
                                    _sendMessage();
                                  },
                                  child: Container(
                                      decoration: BoxDecoration(
                                          color: kBlueColor,
                                          borderRadius: BorderRadius.circular(30)),
                                      child: GlobalWidgets().text(S.of(context).send,
                                          textColor: globalProvider
                                              .getTheme()
                                              .colorScheme
                                              .secondary)
                                  ),
                                )
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),

              ),
            ),
          ]),
    );
  }

  myForm(TextEditingController controller, String label,
      {bool isPhone = false, bool isMessageField = false}) {
    return TextFormField(

      maxLines: isMessageField == true ? 6 : 1,
      keyboardType:
          isPhone == true ? TextInputType.phone : TextInputType.emailAddress,
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        hintText: label,
        hintStyle: GlobalWidgets().style(textColor: kBlue2Color),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
      ),
    );
  }
}
