import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_bus/cubit/cubit.dart';

class BusArrivalWidget extends StatelessWidget {
  static const id = 'arrivalWidget';

  static Route route() => MaterialPageRoute(
        builder: (context) => BusArrivalWidget(),
        settings: RouteSettings(name: BusArrivalWidget.id),
      );

  const BusArrivalWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: BlocConsumer<BusArrivalCubit, BusArrivalState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            return Center(
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(shape: StadiumBorder()),
                child: Text('Close'),
              ),
            );
          },
        ),
      ),
    );
  }
}
