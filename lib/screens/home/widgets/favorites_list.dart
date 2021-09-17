import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:my_bus/cubit/cubit.dart';
import 'package:my_bus/models/models.dart';
import 'package:my_bus/screens/home/widgets/favorite_arrival_card.dart';
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
          return NoDataWidget(
              title: 'No Favorites Selected',
              subTitle: '',
              caption: '',
              onTap: () {},
              showButton: false);
          //return CenteredText(text: 'No Favorites Selected');
        } else {
          return SizedBox(
            height: 126,
            child: ListView.builder(
              itemCount: state.data.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final fav = state.data[index];
                final cubit = context.read<FavoritesCubit>();
                final arrival = BusArrivalCubit();
                return BlocProvider<BusArrivalCubit>(
                  create: (context) => arrival
                    ..getBusArrival(fav.busStopCode, fav.serviceNo, true),
                  child: Slidable(
                    direction: Axis.vertical,
                    actions: [
                      IconSlideAction(
                        //caption: 'Delete',
                        color: Colors.red,
                        icon: Icons.delete,
                        onTap: () => cubit.removeFavorite(
                            fav.busStopCode, fav.serviceNo),
                      ),
                    ],
                    actionPane: SlidableDrawerActionPane(),
                    child: FavoriteCardContent(favorite: fav),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}

class FavoriteCardHeader extends StatelessWidget {
  final Favorite favorite;
  const FavoriteCardHeader({Key? key, required this.favorite})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      height: 29,
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              favorite.serviceNo,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const Text(
              ' @ ',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Text(
              favorite.busStopCode,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.blueAccent),
            )
          ],
        ),
      ),
    );
  }
}

class FavoriteCardContent extends StatelessWidget {
  final Favorite favorite;
  const FavoriteCardContent({Key? key, required this.favorite})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: 150,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FavoriteCardHeader(key: ValueKey('header'), favorite: favorite),
            Expanded(
              child: FavoriteArrivalCard(fave: favorite),
            ),
          ],
        ),
      ),
    );
  }
}
