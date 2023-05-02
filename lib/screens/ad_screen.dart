import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fytd/screens/download_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;

class Adscreen extends StatefulWidget {
  final String urllink;
  const Adscreen({super.key, required this.urllink});

  @override
  State<Adscreen> createState() => _AdscreenState();
}

class _AdscreenState extends State<Adscreen> {
  var mapresponse = {};

  void switchScreen(context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Downscreen(
                  urldata: mapresponse['dlink'],
                  pict: mapresponse['pic'],
                  header: mapresponse['heads'],
                  totals: mapresponse['total'],
                )));
  }

  Future apicall() async {
    final response = await http.get(Uri.parse(
        'https://ytdownloader.cyclic.app/api?url=${widget.urllink}&quali=480'));
    if (response.statusCode == 200) {
      mapresponse = jsonDecode(response.body);
      print(mapresponse);
      // ignore: use_build_context_synchronously
      switchScreen(context);
      return mapresponse;
    }
  }

  @override
  void initState() {
    super.initState();
    apicall();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: const WebView(
          initialUrl: 'https://asad32432t234231.github.io/',
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
