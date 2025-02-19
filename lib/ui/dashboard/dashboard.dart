import 'package:flutter/material.dart';
import 'package:jewelbook_calculator/ui/login_screen/login_screen.dart';
import 'package:jewelbook_calculator/ui/setting_screen/setting_Screen.dart';
import 'package:jewelbook_calculator/ui/users_screen/admin_user_list.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: _appBar(context),
      body: _body(context),
      drawer: _buildDrawer(context),
    );
  }

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      elevation: 10.0,
      backgroundColor: const Color(0xFF000000),
      titleSpacing: 0,
      leading: Builder(
        builder: (context) {
          return InkWell(
            onTap: () {
              Scaffold.of(context).openDrawer(); // Open the drawer
            },
            child: const Padding(
              padding: EdgeInsets.all(12.0),
              child: Icon(
                Icons.menu_rounded,
                size: 28,
                color: Colors.amber, // Golden icon to match UI theme
              ),
            ),
          );
        },
      ),
      title: const Text(
        'JewelBook Rates Admin',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: Colors.amber, // Golden text color
          letterSpacing: 1.2, // Slight spacing for a premium look
        ),
      ),
      centerTitle: true,
      shadowColor: Colors.amber.withOpacity(0.4), // Soft golden shadow effect
    );
  }

  Widget _body(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                AdminUserList(), // Replace with your target page
          ),
        );
      },
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // User block with improved design
            Container(
              width: 160.0, // Slightly larger size
              height: 160.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.amber.shade300,
                    Colors.amber.shade500,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(25.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.orange.withOpacity(0.4),
                    blurRadius: 15,
                    spreadRadius: 2,
                    offset: const Offset(4, 8),
                  ),
                ],
                border: Border.all(
                  color: Colors.white,
                  width: 3,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Users',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 26.0,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 8.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 6,
                          offset: const Offset(2, 4),
                        ),
                      ],
                    ),
                    child: const Text(
                      '20',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30.0,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.black, // Black background for a premium look
        child: Column(
          children: [
            // Drawer Header with Image and Version
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: const BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50), // Circular image
                    child: Image.asset(
                      'assets/images/app_icon.png',
                      width: 130,
                      height: 100,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Version: 1.0.0', // Update version dynamically if needed
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            // Drawer Items with Scrollable List
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildDrawerItem(
                        icon: Icons.home_filled,
                        title: 'Dashboard',
                        onTap: () {
                          Navigator.pop(context);
                        }),
                    _buildDrawerItem(
                        icon: Icons.settings,
                        title: 'Setting',
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const settingScreen(),
                              ));
                        }),

                    // Gradient Divider for Styling
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      height: 2,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.amber, Colors.transparent],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                    ),

                    // Logout Button
                    _buildDrawerItem(
                      icon: Icons.logout,
                      title: 'Logout',
                      onTap: () {},
                      isLogout: true,
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

// Custom Drawer Item with Hover Effect
  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isLogout = false,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: isLogout ? Colors.red : Colors.amber, // Red for logout
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isLogout ? Colors.white : Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      onTap: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      hoverColor: Colors.amber.withOpacity(0.2), // Subtle hover effect
    );
  }
}
