import 'package:flutter/material.dart';
import 'package:test/pages/side_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditProfile extends StatelessWidget {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  Future<void> _updateProfile(
      BuildContext context, String name, String phone) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      String uid = user?.uid ?? '';

      // Update profile data in Firebase Authentication
      await user?.updateProfile(displayName: name);

      // Update profile data in Firestore
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'userID': uid,
        'name': name,
        'phone': phone,
      });

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Profile Updated"),
            content: Text("Your profile has been updated successfully."),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );

      print('Profile updated successfully');
    } catch (error) {
      print('Failed to update profile: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                    color: Colors.black,
                  ),
                  margin: EdgeInsets.only(left: 1.0),
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Icon(Icons.menu, color: Colors.white),
                  ),
                ),
              ),
            );
          },
        ),
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Edit Profile',
            style: TextStyle(
              color: Color(0xFF0101EB),
              fontSize: 20,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
              height: 0.06,
            ),
          ),
        ),
      ),
      drawer: NavDrawer(),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 50),
            CircleAvatar(
              radius: 75,
              backgroundImage: AssetImage(
                '/Users/dm/Documents/coding/flutter/rorich/lib/assets/profile.jpg',
              ),
            ),
            SizedBox(height: 50),
            Container(
              width: 250,
              child: TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: "Name",
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: 250,
              child: TextField(
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: "Phone Number",
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
                ),
              ),
            ),
            SizedBox(height: 50),
            SizedBox(
              width: 100,
              child: ElevatedButton(
                onPressed: () {
                  String name = _nameController.text.trim();
                  String phone = _phoneController.text.trim();
                  _updateProfile(context, name, phone);
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Color(0xFF0101EB)),
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                child: Text('Submit', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
