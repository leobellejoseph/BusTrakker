import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_bus/blocs/blocs.dart';

class BusServiceView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusDataBloc, BusDataState>(
      builder: (context, state) {
        if (state.status == BusDataStatus.busServiceLoading) {
          return SliverToBoxAdapter(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1.5,
              mainAxisSpacing: 0,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final item = state.serviceData[index];
                return Card(
                  //shape: RoundedRectangleBorder(
                  //   borderRadius: BorderRadius.circular(20),
                  // ),
                  color: Colors.lightBlueAccent,
                  child: RawMaterialButton(
                    highlightColor: Colors.blue,
                    // shape: RoundedRectangleBorder(
                    //   borderRadius: BorderRadius.circular(20),
                    // ),
                    onPressed: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(item.operatorName,
                              style: TextStyle(color: Colors.grey.shade800)),
                          Expanded(
                            child: Container(
                              color: Colors.white,
                              child: Center(
                                child: Text(
                                  item.serviceNo,
                                  style: TextStyle(
                                      fontSize: 35,
                                      color: Colors.grey.shade500,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              childCount: state.serviceData.length,
            ),
          );
        }
      },
    );
  }
}
