import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:juba/helpers/mainHelper.dart';
import 'package:juba/pages/nav/components/questionAnswer.dart';
import 'package:juba/pages/nav/components/templatePage.dart';
import 'package:provider/provider.dart';
import 'package:searchfield/searchfield.dart';

import '../../../constants.dart';
import '../../../providers/globalProvider.dart';
import '../../../widgets/globalwidget.dart';

class Templates extends StatefulWidget {

  @override
  State<Templates> createState() => _TemplatesState();
}
class _TemplatesState extends State<Templates> {
  final _formKey = GlobalKey<FormState>();
  Future<void>? launched;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    var globalProvider = context.watch<GlobalProvider>();
    return Scaffold(
      body: Container(
        decoration:
        BoxDecoration(gradient: GlobalWidgets().gradient(globalProvider)),
        child: Column(
          children: <Widget>[
            GlobalWidgets().logoAndBAckButton(context, globalProvider,
                withFilterButton: true, width: width),
            SizedBox(height: 10,),

            Text(
              'Vorlagen',
              style: TextStyle(color: Colors.white,fontSize: 16.0,
                fontWeight: FontWeight.bold,),
            ),

            Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            key: _formKey,
            child: ExpansionTile(
              title: Text(
                'Laden Sie hier die gewünschte Vorlage herunter',
                style: TextStyle(color: Colors.white,fontSize: 16.0,
                  fontWeight: FontWeight.bold,),
              ),
              children: [
                ListTile(
                  title: const Text(
                    'Ausbildung',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: FlatButton(
                    color: Colors.white,
                    shape:  OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.transparent, width: 1)
                    ),
                    onPressed: () => setState(() {
                      launched = MainHelper().launchInBrowser(
                          'https://firebasestorage.googleapis.com/v0/b/zyncompany-6065d.appspot.com/o/2021-07-21%2022%3A09%3A19.875%2Fimage.jpg?alt=media&token=8dbc8179-3d67-4112-9726-8c9ecefd34d0');
                    }),
                    child: Text('herunterladen',),
                  ),
                ),
                ListTile(
                  title: const Text(
                    'Bewerbungen',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: FlatButton(
                      color: Colors.white,
                    shape:  OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.transparent, width: 1)
                    ),
                    onPressed: () => setState(() {
                      launched = MainHelper().launchInBrowser(
                          'https://firebasestorage.googleapis.com/v0/b/zyncompany-6065d.appspot.com/o/2021-07-21%2022%3A09%3A19.875%2Fimage.jpg?alt=media&token=8dbc8179-3d67-4112-9726-8c9ecefd34d0');
                    }),
                    child: Text('herunterladen'),
                  ),
                ),
                ListTile(
                  title: const Text(
                    'Referenzen',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: FlatButton(
                    color: Colors.white,
                    shape:  OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.transparent, width: 1)
                    ),
                    onPressed: () => setState(() {
                      launched = MainHelper().launchInBrowser(
                          'https://firebasestorage.googleapis.com/v0/b/zyncompany-6065d.appspot.com/o/2021-07-21%2022%3A09%3A19.875%2Fimage.jpg?alt=media&token=8dbc8179-3d67-4112-9726-8c9ecefd34d0');
                    }),
                    child: Text('herunterladen'),
                  ),
                ),
                ListTile(
                  title: const Text(
                    'Praktikum',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: FlatButton(
                    color: Colors.lightBlue,
                    shape:  OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.transparent, width: 1)
                    ),
                    onPressed: () => setState(() {
                      launched = MainHelper().launchInBrowser(
                          'https://firebasestorage.googleapis.com/v0/b/zyncompany-6065d.appspot.com/o/2021-07-21%2022%3A09%3A19.875%2Fimage.jpg?alt=media&token=8dbc8179-3d67-4112-9726-8c9ecefd34d0');
                    }),
                    child: Text('herunterladen', style: TextStyle(color: Colors.white)),
                  ),
                ),
                ListTile(
                  title: const Text(
                    'Jugendliche',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: FlatButton(
                    color: Colors.lightBlue,
                    shape:  OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.transparent, width: 1)
                    ),
                    onPressed: () => setState(() {
                      launched = MainHelper().launchInBrowser(
                          'https://firebasestorage.googleapis.com/v0/b/zyncompany-6065d.appspot.com/o/2021-07-21%2022%3A09%3A19.875%2Fimage.jpg?alt=media&token=8dbc8179-3d67-4112-9726-8c9ecefd34d0');
                    }),
                    child: Text('herunterladen', style: TextStyle(color: Colors.white)),
                  ),
                ),
                ListTile(
                  title: const Text(
                    'Ausbildung',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: FlatButton(
                    color: Colors.lightBlue,
                    shape:  OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.transparent, width: 1)
                    ),
                    onPressed: () => setState(() {
                      launched = MainHelper().launchInBrowser(
                          'https://firebasestorage.googleapis.com/v0/b/zyncompany-6065d.appspot.com/o/2021-07-21%2022%3A09%3A19.875%2Fimage.jpg?alt=media&token=8dbc8179-3d67-4112-9726-8c9ecefd34d0');
                    }),
                    child: Text('herunterladen', style: TextStyle(color: Colors.white)),
                  ),
                ),
                ListTile(
                  title: const Text(
                    'Bewerbungen',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: FlatButton(
                    color: Colors.lightBlue,
                    shape:  OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.transparent, width: 1)
                    ),
                    onPressed: () => setState(() {
                      launched = MainHelper().launchInBrowser(
                          'https://firebasestorage.googleapis.com/v0/b/zyncompany-6065d.appspot.com/o/2021-07-21%2022%3A09%3A19.875%2Fimage.jpg?alt=media&token=8dbc8179-3d67-4112-9726-8c9ecefd34d0');
                    }),
                    child: Text('herunterladen', style: TextStyle(color: Colors.white)),
                  ),
                ),
                ListTile(
                  title: const Text(
                    'Referenzen',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: FlatButton(
                    color: Colors.lightBlue,
                    shape:  OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.transparent, width: 1)
                    ),
                    onPressed: () => setState(() {
                      launched = MainHelper().launchInBrowser(
                          'https://firebasestorage.googleapis.com/v0/b/zyncompany-6065d.appspot.com/o/2021-07-21%2022%3A09%3A19.875%2Fimage.jpg?alt=media&token=8dbc8179-3d67-4112-9726-8c9ecefd34d0');
                    }),
                    child: Text('herunterladen', style: TextStyle(color: Colors.white)),
                  ),
                ),
                ListTile(
                  title: const Text(
                    'Praktikum',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: FlatButton(
                    color: Colors.lightBlue,
                    shape:  OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.transparent, width: 1)
                    ),
                    onPressed: () => setState(() {
                      launched = MainHelper().launchInBrowser(
                          'https://firebasestorage.googleapis.com/v0/b/zyncompany-6065d.appspot.com/o/2021-07-21%2022%3A09%3A19.875%2Fimage.jpg?alt=media&token=8dbc8179-3d67-4112-9726-8c9ecefd34d0');
                    }),
                    child: Text('herunterladen', style: TextStyle(color: Colors.white)),
                  ),
                ),
                ListTile(
                  title: const Text(
                    'Jugendliche',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: FlatButton(
                    color: Colors.lightBlue,
                    shape:  OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.transparent, width: 1)
                    ),
                    onPressed: () => setState(() {
                      launched = MainHelper().launchInBrowser(
                          'https://firebasestorage.googleapis.com/v0/b/zyncompany-6065d.appspot.com/o/2021-07-21%2022%3A09%3A19.875%2Fimage.jpg?alt=media&token=8dbc8179-3d67-4112-9726-8c9ecefd34d0');
                    }),
                    child: Text('herunterladen'),
                  ),
                ),
                ListTile(
                  title: const Text(
                    'Ausbildung',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: FlatButton(
                    color: Colors.lightBlue,
                    shape:  OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.transparent, width: 1)
                    ),
                    onPressed: () => setState(() {
                      launched = MainHelper().launchInBrowser(
                          'https://firebasestorage.googleapis.com/v0/b/zyncompany-6065d.appspot.com/o/2021-07-21%2022%3A09%3A19.875%2Fimage.jpg?alt=media&token=8dbc8179-3d67-4112-9726-8c9ecefd34d0');
                    }),
                    child: Text('herunterladen'),
                  ),
                ),
                ListTile(
                  title: const Text(
                    'Bewerbungen',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: FlatButton(
                    color: Colors.lightBlue,
                    shape:  OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.transparent, width: 1)
                    ),
                    onPressed: () => setState(() {
                      launched = MainHelper().launchInBrowser(
                          'https://firebasestorage.googleapis.com/v0/b/zyncompany-6065d.appspot.com/o/2021-07-21%2022%3A09%3A19.875%2Fimage.jpg?alt=media&token=8dbc8179-3d67-4112-9726-8c9ecefd34d0');
                    }),
                    child: Text('herunterladen'),
                  ),
                ),
                ListTile(
                  title: const Text(
                    'Referenzen',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: FlatButton(
                    color: Colors.lightBlue,
                    shape:  OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.transparent, width: 1)
                    ),
                    onPressed: () => setState(() {
                      launched = MainHelper().launchInBrowser(
                          'https://firebasestorage.googleapis.com/v0/b/zyncompany-6065d.appspot.com/o/2021-07-21%2022%3A09%3A19.875%2Fimage.jpg?alt=media&token=8dbc8179-3d67-4112-9726-8c9ecefd34d0');
                    }),
                    child: Text('herunterladen'),
                  ),
                ),
                ListTile(
                  title: const Text(
                    'Praktikum',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: FlatButton(
                    color: Colors.lightBlue,
                    shape:  OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.transparent, width: 1)
                    ),
                    onPressed: () => setState(() {
                      launched = MainHelper().launchInBrowser(
                          'https://firebasestorage.googleapis.com/v0/b/zyncompany-6065d.appspot.com/o/2021-07-21%2022%3A09%3A19.875%2Fimage.jpg?alt=media&token=8dbc8179-3d67-4112-9726-8c9ecefd34d0');
                    }),
                    child: Text('download'),
                  ),
                ),
                ListTile(
                  title: const Text(
                    'Jugendliche',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: FlatButton(
                    color: Colors.lightBlue,
                    shape:  OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: Colors.transparent, width: 1)
                    ),
                    onPressed: () => setState(() {
                      launched = MainHelper().launchInBrowser(
                          'https://firebasestorage.googleapis.com/v0/b/zyncompany-6065d.appspot.com/o/2021-07-21%2022%3A09%3A19.875%2Fimage.jpg?alt=media&token=8dbc8179-3d67-4112-9726-8c9ecefd34d0');
                    }),
                    child: Text('herunterladen'),
                  ),
                ),
              ],
            ),
          ),
        ),
    ],
        ),
      ),
    );
  }
}
