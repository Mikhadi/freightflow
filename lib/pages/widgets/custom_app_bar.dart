import 'package:flutter/material.dart';
import 'package:freiightflow/core/constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:freiightflow/pages/settings_page.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.blue,

      titleSpacing: 0,
      leading: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: CircleAvatar(backgroundColor: greenColor, child: Text("U")),
      ),
      title: Text(AppLocalizations.of(context)!.user_name, style: textStyle,),
      actions: [
        PopupMenuButton(
          icon: Icon(Icons.more_vert),
          onSelected: (value) {
            if (value == 'settings') {
              Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage()));
            } 
          },
          itemBuilder:
              (context) => [
                PopupMenuItem(
                  value: 'settings',
                  child: ListTile(
                    title: Text(AppLocalizations.of(context)!.settings),
                    leading: Icon(Icons.settings),
                  ),
                ),
                PopupMenuItem(
                  value: 'log out',
                  child: ListTile(
                    title: Text(AppLocalizations.of(context)!.log_out),
                    leading: Icon(Icons.logout),
                  ),
                ),
              ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}
