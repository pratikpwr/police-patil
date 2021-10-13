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
                child: SideMenu(),
              ),
            const Expanded(
              flex: 5,
              child: ArmsWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
