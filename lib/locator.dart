import 'package:get_it/get_it.dart';
import 'package:chat_app/services/chat_service.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/services/repository_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => RepositoryService());
  locator.registerLazySingleton(() => ChatService());
  locator.registerLazySingleton(() => AuthService());
}
