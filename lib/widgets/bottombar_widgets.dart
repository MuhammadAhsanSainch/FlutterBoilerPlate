import "package:flutter/material.dart";

import "../utilities/app_theme.dart";

class BottomBarWidget extends StatefulWidget {
  const BottomBarWidget({super.key});

  @override
  State<BottomBarWidget> createState() => _BottomBarWidgetState();
}

class _BottomBarWidgetState extends State<BottomBarWidget> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 10,
      child: SizedBox(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MaterialButton(
                  minWidth: 40,
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pushNamed("/Product");
                  },
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.shop,
                        color: AppThemes.primaryColor,
                      ),
                      Text(
                        "Shop",
                        style: TextStyle(
                          color: AppThemes.primaryColor,
                        ),
                      )
                    ],
                  ),
                ),
                MaterialButton(
                  minWidth: 40,
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pushNamed("/Category");
                  },
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.category,
                        color: AppThemes.primaryColor,
                      ),
                      Text(
                        "Category",
                        style: TextStyle(
                          color: AppThemes.primaryColor,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.center,
                  clipBehavior: Clip.none,
                  children: [
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true).pushNamed("/CheckoutCart");
                      },
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.shopping_cart,
                            color: AppThemes.primaryColor,
                          ),
                          Text(
                            "Cart",
                            style: TextStyle(
                              color: AppThemes.primaryColor,
                            ),
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      right: 10,
                      top: 5,
                      child: Container(
                        padding: const EdgeInsets.only(left: 2.0, top: 2.0, bottom: 2.0, right: 2.0),
                        decoration: const BoxDecoration(color: AppThemes.primaryColor, shape: BoxShape.circle),
                        height: 15,
                        width: 15,
                        child: const Text(
                          "0",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 10, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                MaterialButton(
                  minWidth: 40,
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pushNamed("/Account");
                  },
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person,
                        color: AppThemes.primaryColor,
                      ),
                      Text(
                        "Profile",
                        style: TextStyle(
                          color: AppThemes.primaryColor,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
