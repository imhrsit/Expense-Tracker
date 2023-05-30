// import 'package:complaint_box/constants.dart';
import 'package:expence_tracker/constants.dart';
import 'package:flutter/material.dart';

import '../widgets/back_button.dart';

class UserProfile extends StatelessWidget {
  static const routeName = "/UserProfile";

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              // decoration: BoxDecoration(
              //   gradient: RadialGradient(
              //     colors: [Colors.white, kgradientBlue],
              //     center: Alignment.center,
              //     radius: 0.9999,
              //   ),
              // ),
              height: double.infinity,
              width: double.infinity, //Works without this
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                  child: Column(
                    children: [
                      SizedBox(height: height * 0.015),
                      Center(
                        child: CircleAvatar(
                          // foregroundImage:
                          //     NetworkImage("https://picsum.photos/200"),
                          backgroundColor: Colors.grey.shade500,
                          radius: height * 0.08,
                          child: Icon(
                            Icons.person,
                            color: Colors.grey.shade300,
                            size: height * 0.12,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          "Dhairya Arora",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: "RobotoSlab",
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          "dhairya2arora@gmail.com",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade500,
                            fontWeight: FontWeight.w500,
                            fontFamily: "RobotoSlab",
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.015,
                      ),
                      SizedBox(
                        height: height * 0.096,
                        child: ListItem(
                            icon: Icons.person,
                            title: "Personal Details",
                            onPress: () {}),
                      ),
                      SizedBox(
                        height: height * 0.096,
                        child: ListItem(
                            icon: Icons.help_outline_rounded,
                            title: "Help and Support",
                            onPress: () {}),
                      ),
                      SizedBox(
                        height: height * 0.096,
                        child: ListItem(
                            icon: Icons.settings,
                            title: "Settings",
                            onPress: () {}),
                      ),
                      SizedBox(
                        height: height * 0.096,
                        child: ListItem(
                            icon: Icons.person_add_alt_1,
                            title: "Invite a Friend",
                            onPress: () {}),
                      ),
                      SizedBox(
                        height: height * 0.096,
                        child: ListItem(
                            icon: Icons.logout_rounded,
                            title: "Logout",
                            trailings: false,
                            onPress: () {}),
                      ),
                      //  SizedBox(
                      //   height: 30,
                      // ),
                    ],
                  ),
                ),
              ),
            ),
            CustomBackButton(),
          ],
        ),
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool trailings;
  final VoidCallback onPress;

  ListItem({
    required this.icon,
    required this.title,
    required this.onPress,
    this.trailings = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
      ),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        onTap: onPress,
        leading: Icon(icon,
            color: Theme.of(context).textTheme.titleLarge!.color),
        title: Text(
          title,
          style: TextStyle(
              color: Theme.of(context).textTheme.titleLarge!.color,
              fontFamily: "Raleway"),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
        // style: ListTileStyle.list,
        trailing: trailings
            ?  Icon(
                Icons.arrow_forward,
                color: Theme.of(context).textTheme.titleLarge!.color,
              )
            : null,
      ),
    );
  }
}
