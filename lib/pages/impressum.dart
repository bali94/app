import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ImpressumDatenschutz extends StatefulWidget {
 final bool? isImpressum ;
  const ImpressumDatenschutz({Key? key, this.isImpressum}) : super(key: key);

  @override
  State<ImpressumDatenschutz> createState() => _ImpressumState();
}

class _ImpressumState extends State<ImpressumDatenschutz> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebView(
        initialUrl: widget.isImpressum == true ? 'https://www.juba-worms.de/impressum/': 'https://www.juba-worms.de/datenschutzerklaerung/',
      )
    );
  }
}
