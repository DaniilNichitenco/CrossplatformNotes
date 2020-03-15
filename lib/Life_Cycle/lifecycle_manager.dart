import 'package:flutter/material.dart';
import 'package:notes_app/Life_Cycle/Location_service.dart';
import 'package:notes_app/Life_Cycle/Service_locator.dart';
import 'package:notes_app/Life_Cycle/Stoppable_service.dart';

class LifeCycleManager extends StatefulWidget {
  final Widget child;
  LifeCycleManager({Key key, this.child});

  _LifeCycleManagerState createState() => _LifeCycleManagerState();
}

class _LifeCycleManagerState extends State<LifeCycleManager> with WidgetsBindingObserver {

  List<StoppabelService> services = [
    locator<LocationService>(),
  ];

  @override
  void initState() {

    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {

    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    services.forEach((service) {
      if(state == AppLifecycleState.resumed) {
        service.start();
      }
      else {
        service.stop();
      }
    });
    print('state = $state');
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      child: widget.child,
    );
  }
}