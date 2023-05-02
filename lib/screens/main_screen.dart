import 'package:flutter/material.dart';
import 'package:fytd/screens/ad_screen.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  void switchScreen(str, context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Adscreen(
                  urllink: str,
                )));
  }

  void showAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => const AlertDialog(
              content: Text("⚠️Error: Please Enter URL..."),
            ));
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    return Scaffold(
      body: Column(children: [
        Container(
          alignment: Alignment.topLeft,
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
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            child: Form(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Paste Your YouTube Video Link Below",
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: controller,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.add_link,
                        color: Color.fromARGB(255, 243, 58, 58),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          borderSide: BorderSide(color: Colors.black)),
                      filled: true,
                      hintStyle: TextStyle(color: Colors.grey[800]),
                      hintText: "Enter YouTube Video URL",
                      fillColor: Colors.white70),
                ),
                const SizedBox(
                  height: 5,
                ),
                ConstrainedBox(
                  constraints:
                      const BoxConstraints.tightFor(height: 60, width: 150),
                  child: ElevatedButton(
                    onPressed: () {
                      if (controller.text == '') {
                        showAlert(context);
                      } else {
                        switchScreen(controller.text, context);
                      }
                    },
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
                )
              ],
            )),
          ),
        ),
        Container(
          color: Colors.white,
          height: 70,
        )
      ]),
    );
  }
}
