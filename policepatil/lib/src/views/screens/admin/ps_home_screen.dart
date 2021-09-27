import 'package:flutter/material.dart';
import 'package:policepatil/src/utils/responsive.dart';
import 'package:policepatil/src/views/screens/admin/arms_widget.dart';
import 'package:policepatil/src/views/widgets/side_menu.dart';

class PSHomeScreen extends StatefulWidget {
  const PSHomeScreen({Key? key}) : super(key: key);

  @override
  _PSHomeScreenState createState() => _PSHomeScreenState();
}

class _PSHomeScreenState extends State<PSHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              const Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: SideMenu(),
              ),
            const Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: ArmsWidget(),
            ),
          ],
        ),
      ),
    );
  }
}

