import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:policepatil/src/core/views/screens/home_screen.dart';
import 'package:policepatil/src/features/alert_wall/presentation/alert_screen.dart';
import 'package:policepatil/src/features/profile/presentation/profile_screen.dart';

import '../../../features/app_version/presentation/app_update.dart';
import '../../config/constants.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    AlertScreen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
            !await _navigatorKeys[_selectedIndex].currentState!.maybePop();

        debugPrint(
            'isFirstRouteInCurrentTab: ' + isFirstRouteInCurrentTab.toString());

        // let system handle back button if we're on the first route
        return isFirstRouteInCurrentTab;
      },
      child: AppUpdate(
        child: Scaffold(
          body: _widgetOptions.elementAt(_selectedIndex),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: _selectedIndex,
            elevation: 5,
            selectedItemColor: PRIMARY_COLOR,
            unselectedItemColor: Colors.grey[500],
            showSelectedLabels: true,
            backgroundColor: Colors.white,
            selectedLabelStyle: GoogleFonts.poppins(),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_rounded,
                ),
                label: HOME,
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.notifications_rounded,
                ),
                label: NOTICE,
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person_rounded,
                ),
                label: PROFILE,
              ),
            ],
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context, int index) {
    return {
      '/bottomNavBar': (context) {
        return const [HomeScreen(), AlertScreen(), ProfileScreen()]
            .elementAt(index);
      },
    };
  }

  Widget _buildOffstageNavigator(int index) {
    Map<String, Widget Function(BuildContext)> routeBuilders =
        _routeBuilders(context, index);

    return Offstage(
      offstage: _selectedIndex != index,
      child: Navigator(
        key: _navigatorKeys[index],
        onGenerateRoute: (RouteSettings routeSettings) {
          return MaterialPageRoute(
            builder: (context) => routeBuilders[routeSettings.name]!(context),
          );
        },
      ),
    );
  }
}
