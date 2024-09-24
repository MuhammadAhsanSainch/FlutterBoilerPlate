import 'package:flutter/material.dart';
import '../themes/app_theme.dart';

class AppBarWidget {
  static placeholder() {
    return AppBar(
      backgroundColor: AppThemes.primaryColor,
      toolbarHeight: 0,
    );
  }

  static mainAppBar(String title) {
    return AppBar(
      backgroundColor: AppThemes.primaryColor,
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          );
        },
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      actions: <Widget>[
        IconButton(
            tooltip: 'Logout',
            icon: const Icon(
              Icons.logout_sharp,
              color: Colors.white,
              semanticLabel: 'logout',
            ),
            onPressed: () {
              // Logout Button
            }),
      ],
    );
  }

  static backAppBar(String title) {
    return AppBar(
      backgroundColor: AppThemes.primaryColor,
      iconTheme: const IconThemeData(color: Colors.white),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      actions: <Widget>[
        IconButton(
            tooltip: 'Logout',
            icon: const Icon(
              Icons.logout_sharp,
              color: Colors.white,
              semanticLabel: 'logout',
            ),
            onPressed: () {
              // Logout Button
            }),
      ],
    );
  }
}
