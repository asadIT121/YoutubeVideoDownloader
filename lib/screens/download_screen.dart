import 'package:flutter/material.dart';
import 'package:external_path/external_path.dart';
import 'package:dio/dio.dart';
import 'package:permission_handler/permission_handler.dart';

class Downscreen extends StatefulWidget {
  final String urldata;
  final String pict;
  final String header;
  final String totals;

  const Downscreen(
      {super.key,
      required this.urldata,
      required this.pict,
      required this.header,
      required this.totals});

  @override
  State<Downscreen> createState() => _DownscreenState();
}

class _DownscreenState extends State<Downscreen> {
  /// checking to show CircularProgressIndicator
  bool downloading = false;

  /// Display the downloaded percentage value
  String progressString = '';

  /// Get storage premission request from user
  Future<bool> getStoragePremission() async {
    return await Permission.storage.request().isGranted;
  }

  /// Get user's phone download directory path
  Future<String> getDownloadFolderPath() async {
    return await ExternalPath.getExternalStoragePublicDirectory(
        ExternalPath.DIRECTORY_DOWNLOADS);
  }

  Future downloadFile(String downloadDirectory) async {
    Dio dio = Dio();
    var downloadedImagePath = '$downloadDirectory/${widget.header}.mp4';
    try {
      await dio.download(widget.urldata, downloadedImagePath,
          onReceiveProgress: (rec, total) {
        print("REC: $rec , TOTAL: $total");
        setState(() {
          downloading = true;
          progressString = ((rec / total) * 100).toStringAsFixed(0) + "%";
        });
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> doDownloadFile() async {
    if (await getStoragePremission()) {
      String downloadDirectory = await getDownloadFolderPath();
      await downloadFile(downloadDirectory);
      setState(() {
        downloading = false;
        progressString = "COMPLETED";
      });
    }
  }

  Future apicall() async {}

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(children: [
        Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Center(
            child: SizedBox(
                width: 130,
                height: 150,
                child: Image.asset(
                  'assets/main.png',
                )),
          ),
        ),
        Container(
          child: Column(
            children: downloading
                ? [
                    Card(
                      color: Colors.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const CircularProgressIndicator(),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Text(
                            "Downloading File: $progressString",
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                    ),
                  ]
                : [
                    Image.network(widget.pict.toString()),
                    const Divider(),
                    const SizedBox(height: 30),
                    Text(
                      'Title: ${widget.header}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      'Size: ${widget.totals}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 30),
                    ConstrainedBox(
                      constraints:
                          const BoxConstraints.tightFor(height: 60, width: 150),
                      child: ElevatedButton(
                        onPressed: () => doDownloadFile(),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            textStyle: const TextStyle(
                              fontSize: 22,
                            ),
                            elevation: 15,
                            shadowColor: Colors.black,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0))),
                        child: const Text('Downlaod'),
                      ),
                    ),
                  ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ]),
    );
  }
}
