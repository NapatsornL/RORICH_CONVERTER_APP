// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:test/pages/chat.dart';
import 'package:test/pages/edit_profile.dart';
import 'package:test/pages/side_menu.dart';

class ProfileSetting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0000EB),
        elevation: 0,
        leading: Builder(
          builder: (BuildContext context) {
            return GestureDetector(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 1.0, top: 10.0, bottom: 10.0),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  margin: EdgeInsets.only(left: 1.0),
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Icon(Icons.menu, color: Colors.black),
                  ),
                ),
              ),
            );
          },
        ),
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Profile Setting',
            style: TextStyle(
              color: Color(0xFFFEC4DD),
              fontSize: 20,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
              height: 0.06,
            ),
          ),
        ),
      ),
      drawer: NavDrawer(),
      backgroundColor: Color(0xFF0000EB),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 50),
            // Circular avatar for the image
            CircleAvatar(
              radius: 75,
              backgroundImage: AssetImage(
                '/Users/dm/Documents/coding/flutter/rorich/lib/assets/profile.jpg',
              ),
            ),
            SizedBox(height: 50),
            // Using SizedBox for each container
            Container(
              height: 400,
              width: 350,
              child: Align(
                alignment: Alignment.center,
                child: SizedOverflowBox(
                  size: Size(376, 160),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFD6EC53),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: 400,
                        width: 350,
                        child: SizedOverflowBox(
                          size: Size(376, 142),
                          child: Container(
                            margin: EdgeInsets.only(top: 30),
                            decoration: BoxDecoration(
                              color: Color(0xFFFF84C3),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Container(
                                margin: EdgeInsets.only(top: 30),
                                height: 400,
                                width: 350,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 15),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  EditProfile(),
                                            ),
                                          );
                                        },
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(15.0),
                                              child: Icon(
                                                Icons.edit,
                                                color: Colors.black,
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Text(
                                              'Edit Profile',
                                              style: TextStyle(
                                                color: Color(0xFF595154),
                                                fontSize: 15,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w400,
                                                height: 0.06,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => Chat(),
                                            ),
                                          );
                                        },
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(15.0),
                                              child: Icon(
                                                Icons.chat_bubble,
                                                color: Colors.black,
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Text(
                                              'RorichChat',
                                              style: TextStyle(
                                                color: Color(0xFF595154),
                                                fontSize: 15,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w400,
                                                height: 0.06,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
