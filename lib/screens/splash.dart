import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool selected = false;

  @override
  void initState() {
    super.initState();
    /// Run Code After Page UI Load
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // Run Code After Page UI Load
      Future.delayed(const Duration(seconds: 1), () async {
        setState(() {

        });
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      decoration: const BoxDecoration(
        color: Colors.white,
        image: DecorationImage(image: AssetImage("assets/vectors/vector_1.png"), alignment: Alignment.topRight, fit: BoxFit.none, scale: 1.3),
      ),
      // child: Center(
      //   child: Image.asset(
      //     "assets/images/logo.png",
      //     fit: BoxFit.cover,
      //     height: 200,
      //   ),
      // ),
      child: Stack(
        children: <Widget>[
          AnimatedPositioned(
            width: 150,
            height: 150,
            top: selected ? size.height * 0.07 : (size.height * 0.5) - 75,
            right: (size.width * 0.5) - 75,
            duration: const Duration(seconds: 4),
            curve: Curves.fastOutSlowIn,
            child: GestureDetector(
              onTap: () {
                setState(() {

                });
              },
              child: Center(
                child: Image.asset(
                  "assets/images/logo.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
