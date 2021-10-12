import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_bus/cubit/cubit.dart';
import 'package:my_bus/repositories/repositories.dart';

class FavoriteButton extends StatelessWidget {
  final String service;
  final String code;
  final Function onPress;
  FavoriteButton(
      {Key? key,
      required this.service,
      required this.code,
      required this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final repo = context.read<BusRepository>();
    return BlocBuilder<FavoritesCubit, FavoritesState>(
      builder: (context, state) {
        if (state.status == FavoriteStatus.loading) {
          return Container();
          //return CircularProgress(key: ValueKey('progress'));
        } else {
          final isFavorite = repo.isFavorite(service: service, code: code);
          return Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              highlightColor: Colors.lightBlueAccent,
              onTap: () => onPress(),
              child: Icon(
                isFavorite ? Icons.star : Icons.star_border,
                color: Colors.yellow.shade600,
                size: 40,
              ),
            ),
          );
        }
      },
    );
  }
}
