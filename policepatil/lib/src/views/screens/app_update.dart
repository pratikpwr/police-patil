import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:policepatil/src/config/constants.dart';
import 'package:policepatil/src/utils/utils.dart';
import 'package:shared/modules/app_version/app_version.dart';
import 'package:shared/shared.dart';

class AppUpdate extends StatefulWidget {
  const AppUpdate({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  _AppUpdateState createState() => _AppUpdateState();
}

class _AppUpdateState extends State<AppUpdate> {
  @override
  void initState() {
    BlocProvider.of<AppVersionBloc>(context).add(GetAppVersion());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AppVersionBloc, AppVersionState>(
        listener: (context, state) {
          if (state is AppVersionSuccess) {
            if (state.status == AppStatus.outdated) {
              _showCompulsoryUpdateDialog(context);
            }
            if (state.status == AppStatus.fine) {
              _showOptionalUpdateDialog(context);
            }
            if (state.status == AppStatus.latest) {
              debugPrint("App is Up to date.");
            }
          }
        },
        child: BlocBuilder<AppVersionBloc, AppVersionState>(
            builder: (context, state) {
          if (state is AppVersionLoading) {
            return const Loading();
          }
          if (state is AppVersionSuccess) {
            return widget.child;
          }
          if (state is AppVersionFailed) {
            return SomethingWentWrong();
          }
          return SomethingWentWrong();
        }),
      ),
    );
  }

  _showOptionalUpdateDialog(context) async {
    await showDialog<String>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        if (Platform.isIOS) {
          return CupertinoAlertDialog(
            title: Text(
              APP_UPDATE,
              style: Styles.titleTextStyle(),
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text(
                  UPDATE_NOW,
                  style: Styles.primaryTextStyle(),
                ),
                onPressed: () {
                  _onUpdateNowClicked();
                },
              ),
              CupertinoDialogAction(
                child: Text(
                  LATER,
                  style: Styles.primaryTextStyle(),
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        }
        return AlertDialog(
          title: Text(
            APP_UPDATE,
            style: Styles.titleTextStyle(),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                UPDATE_NOW,
                style: Styles.primaryTextStyle(),
              ),
              onPressed: () {
                _onUpdateNowClicked();
              },
            ),
            TextButton(
              child: Text(
                LATER,
                style: Styles.titleTextStyle(),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  _onUpdateNowClicked() {
    try {
      launchUrl(
          "https://play.google.com/store/apps/details?id=com.punerural.policepatil");
    } catch (e) {
      showSnackBar(context, SOMETHING_WENT_WRONG);
    }
  }

  _showCompulsoryUpdateDialog(context) async {
    await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Platform.isIOS
            ? CupertinoAlertDialog(
                title: Text(
                  APP_UPDATE,
                  style: Styles.titleTextStyle(),
                ),
                actions: <Widget>[
                  CupertinoDialogAction(
                    child: Text(
                      UPDATE_NOW,
                      style: Styles.primaryTextStyle(),
                    ),
                    isDefaultAction: true,
                    onPressed: () {
                      _onUpdateNowClicked();
                    },
                  ),
                ],
              )
            : AlertDialog(
                title: Text(
                  APP_UPDATE,
                  style: Styles.titleTextStyle(),
                ),
                actions: <Widget>[
                  TextButton(
                    child: Text(
                      UPDATE_NOW,
                      style: Styles.primaryTextStyle(),
                    ),
                    onPressed: () {
                      _onUpdateNowClicked();
                    },
                  ),
                ],
              );
      },
    );
  }
}
