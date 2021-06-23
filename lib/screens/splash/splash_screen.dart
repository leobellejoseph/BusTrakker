import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_bus/blocs/blocs.dart';
import 'package:my_bus/screens/screens.dart';

class SplashScreen extends StatelessWidget {
  static const id = 'splash';
  static Route route() => MaterialPageRoute(
        settings: RouteSettings(name: SplashScreen.id),
        builder: (context) => SplashScreen(),
      );

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocListener<BusStopBloc, BusStopState>(
        listener: (context, state) async {
          if (state.status == BusStopStatus.loaded) {
            Navigator.pushNamed(context, HomeScreen.id);
          }
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Loading...'),
              const SizedBox(height: 10),
              CircularProgressIndicator(
                color: Colors.lightBlueAccent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
