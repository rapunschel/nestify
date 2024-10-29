import 'package:flutter/material.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart' as firebase_ui;
import 'package:go_router/go_router.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile Screen')),
      body: Center(
          child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                // Profile Picture
                CircleAvatar(
                  radius: 50, // Adjust size by changing the radius
                  backgroundImage: AssetImage(
                      'assets/img/cool-profile-pictures-63a5e8ee8cdcfab2f952bcd46a73e5c4-263720879.jpg'),
                ),

                // Column med textrader som är aligned till vänster
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text("Emil Emilsson"),
                  Text("Have more text here?")
                ]),
              ],
            ),
          ),

          // A Button for Home Screen
          // ElevatedButton(
          //   onPressed: () => context.go('/'),
          //   child: const Text('Go back to the Home screen'),
          // ),

          Expanded(
            child: Container(
              margin: const EdgeInsets.only(
                top: 7,
              ),
              child: ListView(
                children: [
                  buildListTile("Favourites", "List of your favourite builds",
                      Icons.favorite, context, '/profile/favorites'
                      ),
                  buildListTile("My Builds", "List of your own blueprints",
                      Icons.bungalow_outlined, context, '/profile/mybuilds'
                      ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0), // Set horizontal and vertical padding
                    child: firebase_ui.SignOutButton()) ,
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }

  // Function to create a ListTile
  Widget buildListTile(String title, String subtitle, IconData leadingIcon, BuildContext context, String route) {
    return Container(
      margin: const EdgeInsets.only(
        top: 0,
        right: 16,
        bottom: 10,
        left: 16,
      ),
      child: Card(
        elevation: 1, // Shadow effect
        shape: RoundedRectangleBorder(
          // side: BorderSide(color: Colors.blueAccent, width: 2), // Outline
          borderRadius: BorderRadius.circular(8), // Rounded corners (optional)
        ),

        child: ListTile(
          leading: Icon(leadingIcon),
          title: Text(title),
          subtitle: Text(subtitle),
          trailing: const Icon(Icons.arrow_forward),
          onTap: () {
            // Handle tap here, e.g., navigate or perform some action
            context.go(route);
          },
        ),
      ),
    );
  }
}
