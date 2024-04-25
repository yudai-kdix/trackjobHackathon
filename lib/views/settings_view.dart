import 'package:flutter/material.dart';

class SettingsView extends StatefulWidget {
  @override
  _SettingsViewState createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  bool notificationsEnabled = true;
  double fontSize = 16.0;
  bool darkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('設定'),
      ),
      body: ListView(
        children: <Widget>[
          SwitchListTile(
            title: Text('通知を受け取る'),
            value: notificationsEnabled,
            onChanged: (bool value) {
              setState(() {
                notificationsEnabled = value;
              });
            },
          ),
          ListTile(
            title: Text('フォントサイズ'),
            trailing: Text('${fontSize.toInt()}'),
          ),
          Slider(
            min: 10.0,
            max: 24.0,
            divisions: 7,
            value: fontSize,
            onChanged: (double value) {
              setState(() {
                fontSize = value;
              });
            },
          ),
          // その他の設定オプション
        ],
      ),
    );
  }
}
