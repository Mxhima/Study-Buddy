import 'package:flutter/material.dart';
import 'package:flutter_dnd/flutter_dnd.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_apps/device_apps.dart';

import '../../models/donotdisturb_app_model.dart';

class DNDAppListScreen extends StatefulWidget {
  const DNDAppListScreen({super.key});

  @override
  State<DNDAppListScreen> createState() => _DNDAppListScreenState();
}

class _DNDAppListScreenState extends State<DNDAppListScreen> {
  List<Application> _appList = [];
  bool _isDNDenabled = false;

  @override
  void initState() {
    super.initState();
    _getAppList();
    _checkDNDPermission();
  }

  Future<void> _getAppList() async {
    // final apps = await FlutterDnd.getCurrentInterruptionFilter();
    // setState(() {
    //   _apps = apps.map();
    // });
    List<Application> apps = await DeviceApps.getInstalledApplications(
      onlyAppsWithLaunchIntent: true,
      includeSystemApps: true,
      includeAppIcons: true,
    );

    setState(
      () {
        _appList = apps;
      },
    );
  }

  Future<void> _checkDNDPermission() async {
    if (await Permission.notification.isGranted) {
      bool? isDNDEnabled = await FlutterDnd.isNotificationPolicyAccessGranted;
      setState(
        () {
          _isDNDenabled = isDNDEnabled!;
        },
      );
    } else {
      await Permission.notification.request();
    }
  }

  Future<void> _toggleDND() async {
    if (await Permission.notification.isGranted) {
      if (_isDNDenabled) {
        await FlutterDnd.setInterruptionFilter(2);
      } else {
        await FlutterDnd.setInterruptionFilter(3);
      }
      bool? isDNDEnabled = await FlutterDnd.setInterruptionFilter(1);
      setState(
        () {
          _isDNDenabled = isDNDEnabled!;
        },
      );
    } else {
      await Permission.notification.request();
    }
  }

  Future<void> _addAppToDndList(Application app) async {
    await FlutterDnd.setInterruptionFilter(
        FlutterDnd.INTERRUPTION_FILTER_PRIORITY);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add to DND"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              _isDNDenabled
                  ? "Do not Disturb Mode is On"
                  : "Do not Disturb Mode is Off",
              style: const TextStyle(fontSize: 20),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _appList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  // leading: Image.memory(
                  //   _appList[index].icon,
                  //   height: 40,
                  //   width: 40,
                  // ),
                  title: Text(_appList[index].appName),
                  trailing: ElevatedButton(
                    onPressed: () {
                      _addAppToDndList(_appList[index]);
                    },
                    child: const Text("Add to DND List"),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
