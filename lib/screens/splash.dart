import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'login/login_binding.dart';
import 'login/login_view.dart';

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
      setState(() {
        selected = true;
      });
      Future.delayed(const Duration(seconds: 3), () async {
        setState(() {
          Get.offAll(() => LoginView(), bindings: [LoginBinding()]);
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
        image: DecorationImage(image: AssetImage("assets/images/splash-bg.png"), alignment: Alignment.topRight, fit: BoxFit.contain, scale: 1.3),
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
                  Get.offAll(() => LoginView(), bindings: [LoginBinding()]);
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
