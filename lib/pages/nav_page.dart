import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:freiightflow/pages/home_page.dart';
//import 'package:freiightflow/core/constants.dart';
import 'package:freiightflow/pages/widgets/custom_app_bar.dart';
import 'package:google_nav_bar/google_nav_bar.dart';


class NavPage extends StatefulWidget {
  const NavPage({super.key});

  @override
  State<NavPage> createState() => _NavPageState();
}

class _NavPageState extends State<NavPage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  List<Widget> _widgetOptions(BuildContext context) => <Widget>[
    HomePage(),
    Text(
      AppLocalizations.of(context)!.history,
      style: optionStyle,
    ),
    Text(
      AppLocalizations.of(context)!.search,
      style: optionStyle,
    ),
    Text(
      AppLocalizations.of(context)!.profile,
      style: optionStyle,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Center(
        child: _widgetOptions(context).elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey, width: 0.5),
          borderRadius: BorderRadius.vertical(top: Radius.circular(10))
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.blue,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[100]!,
              color: Colors.black,
              tabs: [
                GButton(
                  icon: Icons.home,
                  text: AppLocalizations.of(context)!.home,
                ),
                GButton(
                  icon: Icons.list,
                  text: AppLocalizations.of(context)!.history,
                ),
                GButton(
                  icon: Icons.search,
                  text: AppLocalizations.of(context)!.search,
                ),
                GButton(
                  icon: Icons.person,
                  text: AppLocalizations.of(context)!.profile,
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}