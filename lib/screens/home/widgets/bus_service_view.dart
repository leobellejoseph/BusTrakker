import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:my_bus/blocs/blocs.dart';
import 'package:my_bus/screens/home/widgets/service_widget.dart';
import 'package:my_bus/widgets/widgets.dart';

class BusServiceView extends StatelessWidget {
  BusServiceView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusDataBloc, BusDataState>(
      builder: (context, state) {
        if (state.status == BusDataStatus.busServiceLoading) {
          return const CenteredSpinner();
        } else if (state.status == BusDataStatus.no_internet) {
          return NoDataWidget(
              key: ValueKey('serviceNoData'),
              title: 'No Internet',
              subTitle: 'Please check connection settings.',
              caption: 'Refresh',
              onTap: () =>
                context.read<BusDataBloc>()..add(BusDataDownload())
              ,
              showButton: false);
        } else {
          return StaggeredGridView.countBuilder(
            itemCount: state.serviceData.length,
            mainAxisSpacing: 2,
            crossAxisSpacing: 2,
            crossAxisCount: 4,
            itemBuilder: (context, index) {
              final item = state.serviceData[index];
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: ServiceWidget(
                  key: ValueKey(item.serviceNo),
                  service: item,
                ),
              );
            },
            staggeredTileBuilder: (index) {
              final item = state.serviceData[index];
              final number = num.tryParse(item.serviceNo);
              return StaggeredTile.count(2, number == null ? 2 : 1);
            },
          );
        }
      },
    );
  }
}
