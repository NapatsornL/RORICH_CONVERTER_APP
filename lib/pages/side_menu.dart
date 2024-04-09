// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Hi there!',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.w700),
            ),
            decoration: BoxDecoration(
              color: Colors.pink[100],
            ),
          ),
          ListTile(
            leading: Icon(Icons.currency_exchange_rounded),
            title: Text('RoRich Converter'),
            onTap: () => {
              Navigator.pushNamed(context, '/convert_main'),
            },
          ),
          ListTile(
            leading: Icon(Icons.chat_outlined),
            title: Text('RoRichChat'),
            onTap: () => {
              Navigator.pushNamed(context, '/chat'),
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Profile'),
            onTap: () => {
              Navigator.pushNamed(context, '/profile_setting'),
            },
          ),
          ListTile(
            leading: Icon(Icons.auto_graph_outlined),
            title: Text('Currency Center'),
            onTap: () => {
              Navigator.pushNamed(context, '/currency_center'),
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Sign out'),
            onTap: () => {
              Navigator.pushNamed(context, '/logout'),
            },
          ),
        ],
      ),
    );
  }
}
