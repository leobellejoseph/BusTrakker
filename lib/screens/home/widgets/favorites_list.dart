import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_bus/cubit/cubit.dart';
import 'package:my_bus/screens/home/widgets/widgets.dart';
import 'package:my_bus/widgets/centered_spinner.dart';
import 'package:my_bus/widgets/widgets.dart';

class FavoritesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesCubit, FavoritesState>(
      builder: (context, state) {
        if (state.status == FavoriteStatus.loading) {
          return CenteredSpinner();
        } else if (state.status == FavoriteStatus.no_data) {
          return NoDataWidget.noFavorites();
        } else {
          return GridView.builder(
            scrollDirection: Axis.vertical,
            itemCount: state.data.length,
            itemBuilder: (BuildContext context, int index) {
              final fav = state.data[index];
              final arrival = BusArrivalCubit();
              return BlocProvider<BusArrivalCubit>(
                create: (context) => arrival
                  ..getBusArrival(fav.busStopCode, fav.serviceNo, true),
                child: FavoriteCardContent(favorite: fav),
              );
            },
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.5,
            ),
          );
        }
      },
    );
  }
}
