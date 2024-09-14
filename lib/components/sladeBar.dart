import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';

class SladeBar extends StatelessWidget {
  const SladeBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * .4,
      child: SidebarX(
        theme: const SidebarXTheme(
          margin: EdgeInsets.all(0),
          decoration: BoxDecoration(
            color: Color.fromARGB(196, 138, 44, 7),
          ),
          itemTextPadding: EdgeInsets.only(left: 30),
          selectedItemTextPadding: EdgeInsets.only(left: 30),
          itemDecoration: BoxDecoration(
              // color: Color.fromARGB(80, 176, 176, 216),
              // border: Border(bottom: BorderSide.none),
              ),
          selectedItemDecoration: BoxDecoration(
            color: Color.fromARGB(83, 164, 164, 238),
          ),
        ),
        controller: SidebarXController(selectedIndex: 0, extended: true),
        items: [
          SidebarXItem(
            icon: Icons.home,
            label: 'Home',
            onTap: () {
              if (context == context) {
              } else {
                Navigator.pushNamed(context, '/home');
              }
            },
          ),
          SidebarXItem(
              icon: Icons.person_2,
              label: 'Perfil',
              onTap: () {
                Navigator.pushNamed(context, '/perfil_screen');
              }),
          SidebarXItem(
              icon: Icons.food_bank,
              label: 'starbucks',
              onTap: () {
                Navigator.pushNamed(context, '/starbuckScreen');
              }),
        ],
      ),
    );
  }
}
