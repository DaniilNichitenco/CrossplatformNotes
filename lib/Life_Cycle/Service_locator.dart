import 'package:get_it/get_it.dart';
import 'package:notes_app/Life_Cycle/Location_service.dart';
import 'package:notes_app/Services/Login_service.dart';
import 'package:notes_app/Services/User_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton(LocationService());
  locator.registerSingleton(UserService());
  locator.registerFactory<LoginService>(() => LoginService());
}