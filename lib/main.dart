import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:my_bus/blocs/blocs.dart';
import 'package:my_bus/cubit/cubit.dart';
import 'package:my_bus/cubit/favorites_cubit.dart';
import 'package:my_bus/repositories/bus_repository.dart';
import 'package:path_provider/path_provider.dart';

import 'helpers/helpers.dart';
import 'screens/bus_route/cubit/cubit.dart';
import 'screens/screens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );
  //HydratedBloc.storage.clear();
  EquatableConfig.stringify = kDebugMode;
  Bloc.observer = SimpleBlocObserver();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.black,
  ));
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp(busRepository: BusRepository()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final BusRepository busRepository;
  MyApp({required this.busRepository});
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => busRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => BusDataBloc(busRepository: busRepository)
                ..add(BusDataDownload())),
          BlocProvider(
            create: (context) => BusRouteCubit(busRepository: busRepository),
          ),
          BlocProvider(
            create: (context) => FavoritesCubit(busRepository: busRepository),
          ),
          BlocProvider(
            create: (context) => NearBusCubit(busRepository: busRepository),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: '',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          //home: SplashScreen(),
          onGenerateRoute: CustomRoute.onGenerateRoute,
          initialRoute: SplashScreen.id,
        ),
      ),
    );
  }
}
