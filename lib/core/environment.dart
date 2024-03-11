import '../models/enums/environments.dart';

final dartEnv = Environments.valueOf(const String.fromEnvironment('DART_ENV'));
