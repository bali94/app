import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:juba/constants.dart';
import 'package:juba/generated/l10n.dart';
import 'package:juba/helpers/apiHelper.dart';
import 'package:juba/helpers/mainHelper.dart';
import 'package:juba/pages/nav/components/sharedOfferDetails.dart';
import 'package:juba/pages/nav2/components/offers/offersList.dart';
import 'package:juba/pages/nav2/navigation2.dart';
import 'package:juba/providers/globalProvider.dart';
import 'package:juba/providers/offerProvider.dart';
import 'package:juba/widgets/globalwidget.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
final dynamic storageRef = firebase_storage.FirebaseStorage.instance.ref();
class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage>  {
  String? image;

  @override
  Widget build(BuildContext context) {
    var globalProvider = context.watch<GlobalProvider>();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return
    Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
     Stack(
       children: [
        InkWell(
          onTap: ()async {

            MainHelper.routeTo(context, Navigation2());
          },
          child: Column(

            children: [
              Container(
                width: double.infinity,
                height:  height * 0.40,
                alignment: Alignment.bottomCenter,
                decoration:const  BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/dom.png',),fit: BoxFit.fill,
                  )
                ),
                child: Text('')
              ),
              InkWell(
                onTap: ()async {

                  MainHelper.routeTo(context, Navigation2());
                },
                child: Center(
                  child: Container(
                    alignment: Alignment.center,
                    decoration:const  BoxDecoration(
                        color: kBlueColor3,
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30))
                    ),
                    width: double.infinity,
                    height: 60,
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child:image!= null ? Image.file(File(image!)): Text(S.of(context).yourFuture,style: TextStyle(color: globalProvider.getTheme().colorScheme.primary, fontSize: kMediumSize),),
                    ),),
                ),
              )
            ],
          ),
        ),
       ],
     ),
       SizedBox(height:height < 781 ? 0:75)
      ],
    );
  }
}
