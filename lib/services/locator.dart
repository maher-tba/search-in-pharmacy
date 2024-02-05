import 'package:get_it/get_it.dart';
import 'package:search_in_pharmacy/services/pharmacy_service.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton<Pharmacy>(Pharmacy(), signalsReady: true);
}