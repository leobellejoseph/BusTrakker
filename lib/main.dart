import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_bus/blocs/blocs.dart';
import 'package:my_bus/screens/bus_route/cubit/bus_route_cubit.dart';

import 'helpers/helpers.dart';
import 'screens/screens.dart';

void main() {
  EquatableConfig.stringify = kDebugMode;
  Bloc.observer = SimpleBlocObserver();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.black,
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    // return BlocProvider(
    //   create: (context) => BusDataBloc()
    //     ..add(
    //       BusDataDownload(),
    //     )
    //     ..add(
    //       NearBusStopsFetch(''),
    //     ),
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BusDataBloc()
            ..add(
              BusDataDownload(),
            )
            ..add(
              NearBusStopsFetch(''),
            ),
        ),
        BlocProvider(create: (context) => BusRouteCubit()),
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
