import 'package:flutter/material.dart';
import '../network/app_url.dart';
import '../utilities/app_theme.dart';
import '../utilities/shared_preference.dart';

class DrawerWidgets extends StatefulWidget {
  const DrawerWidgets({super.key});

  @override
  State<DrawerWidgets> createState() => _DrawerWidgetsState();
}

class _DrawerWidgetsState extends State<DrawerWidgets> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: InkWell(
              onTap: () {},
              child: ClipOval(
                child: Material(
                  child: UserPreferences.loginData['ProfilePhoto'] == null
                      ? Image.asset(
                          "assets/default_user_image.jpg",
                          fit: BoxFit.cover,
                          width: 60,
                          height: 60,
                        )
                      : Image.network(
                          '${AppUrl.mediaUrl}${UserPreferences.loginData['ProfilePhoto']}',
                          fit: BoxFit.cover,
                          width: 60,
                          height: 60,
                          loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes != null ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes! : null,
                              ),
                            );
                          },
                        ),
                ),
              ),
            ),
            decoration: const BoxDecoration(color: AppThemes.primaryColor),
            accountName: Text(
              UserPreferences.loginData["FullName"] ?? "Guest User",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            accountEmail: Text(
              UserPreferences.loginData["Email"] ?? "Register/Login Now",
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(
              Icons.home,
              color: AppThemes.primaryColor,
            ),
            title: const Text('Home'),
            onTap: () {
              Navigator.of(context, rootNavigator: true).popAndPushNamed("/Home");
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.shop,
              color: AppThemes.primaryColor,
            ),
            title: const Text('WholeSale'),
            onTap: () {
              Navigator.of(context, rootNavigator: true).pushNamed("/Product");
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.discount,
              color: AppThemes.primaryColor,
            ),
            title: const Text('Bulk Deals'),
            onTap: () {
              Navigator.of(context, rootNavigator: true).pushNamed("/BulkDeal");
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.category,
              color: AppThemes.primaryColor,
            ),
            title: const Text('Categories'),
            onTap: () {
              Navigator.of(context, rootNavigator: true).pushNamed("/Category");
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.punch_clock,
              color: AppThemes.primaryColor,
            ),
            title: const Text('My Orders'),
            onTap: () {
              Navigator.of(context, rootNavigator: true).pushNamed("/MyOrder");
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.lock_clock,
              color: AppThemes.primaryColor,
            ),
            title: const Text('Track Order'),
            onTap: () {
              Navigator.of(context, rootNavigator: true).pushNamed("/TrackOrder");
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.error,
              color: AppThemes.primaryColor,
            ),
            title: const Text('My Complaints'),
            onTap: () {
              Navigator.of(context, rootNavigator: true).pushNamed("/Complaints");
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.person,
              color: AppThemes.primaryColor,
            ),
            title: const Text('My Account'),
            onTap: () {
              Navigator.of(context, rootNavigator: true).pushNamed("/Account");
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.help,
              color: AppThemes.primaryColor,
            ),
            title: const Text('Contact Us'),
            onTap: () {
              Navigator.of(context, rootNavigator: true).pushNamed("/ContactUs");
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.call,
              color: AppThemes.primaryColor,
            ),
            title: const Text('Get A Call'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(
              Icons.rule,
              color: AppThemes.primaryColor,
            ),
            title: const Text('Terms & Conditions'),
            onTap: () {
              Navigator.of(context, rootNavigator: true).pushNamed("/TermsScreen");
            },
          ),
          const Divider(
            thickness: 1,
          ),
          UserPreferences.authToken.isNotEmpty
              ? ListTile(
                  leading: const Icon(
                    Icons.logout,
                    color: AppThemes.primaryColor,
                  ),
                  title: const Text('Logout'),
                  onTap: () {},
                )
              : const SizedBox.shrink(),
          const AboutListTile(
            icon: Icon(
              Icons.info,
              color: AppThemes.primaryColor,
            ),
            applicationIcon: Icon(
              Icons.shopping_cart,
            ),
            applicationName: 'Tookary',
            applicationVersion: 'v1.0.0+1',
            applicationLegalese: '© 2024 Tookary',
            aboutBoxChildren: [
              SizedBox(
                height: 10,
              ),
              Text("This is a beta version release. If you have any type of issues while using this, feel free to contact our support at info@tookary.com")
            ],
            dense: false,
            child: Text('About App'),
          ),
        ],
      ),
    );
  }
}
