import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_bus/blocs/blocs.dart';

import 'helpers/helpers.dart';
import 'screens/bus_route/cubit/cubit.dart';
import 'screens/screens.dart';

void main() {
  EquatableConfig.stringify = kDebugMode;
  Bloc.observer = SimpleBlocObserver();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.black,
  ));
  runApp(MyApp(busDataBloc: BusDataBloc()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final BusDataBloc busDataBloc;
  MyApp({required this.busDataBloc});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => busDataBloc
            ..add(
              BusDataDownload(),
            )
            ..add(
              NearBusStopsFetch(''),
            ),
        ),
        BlocProvider(
            create: (context) => BusRouteCubit(busDataBloc: busDataBloc)),
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
    );
  }
}
