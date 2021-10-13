import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CenteredSpinner extends StatelessWidget {
  const CenteredSpinner({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitCubeGrid(color: Colors.green),
      // child: CircularProgressIndicator(color: Colors.greenAccent),
    );
  }
}
