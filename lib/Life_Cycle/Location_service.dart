import 'package:notes_app/Life_Cycle/Stoppable_service.dart';

class LocationService extends StoppabelService {

  @override
  void start() {
    super.start();
    //start subscription again
  }

  @override
  void stop() {
    super.stop();
    //cancel stream subscription
  }
}