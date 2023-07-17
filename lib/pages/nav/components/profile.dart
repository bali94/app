import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:juba/generated/l10n.dart';
import 'package:juba/theme/app_colors.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(S.of(context).simpleProfileText, style: TextStyle(fontSize: 30, ),),
      )),

    );
  }
}
