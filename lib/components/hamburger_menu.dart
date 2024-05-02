import 'package:flutter/material.dart';

class HamburgerMenu extends StatelessWidget {
  const HamburgerMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          SizedBox(
            height: 80,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.grey[300],
              ),
              child: const Text(
                'メニュー',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('ホーム'),
            onTap: () {
              Navigator.pushNamed(context, '/');
            },
          ),
          ListTile(
            leading: const Icon(Icons.content_copy_rounded),
            title: const Text('単語一覧'),
            onTap: () {
              Navigator.pushNamed(context, '/word_list');
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_circle_outline),
            title: const Text('単語の追加'),
            onTap: () {
              Navigator.pushNamed(context, '/word_add');
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings_outlined),
            title: const Text('設定'),
            onTap: () {
              Navigator.pushNamed(context, '/settings');
            },
          ),
        ],
      ),
    );
  }
}
