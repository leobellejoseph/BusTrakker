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
    print('Service:$service;Code:$code');
    final repo = context.read<BusRepository>();
    return BlocBuilder<FavoritesCubit, FavoritesState>(
      builder: (context, state) {
        if (state.status == FavoriteStatus.loading) {
          return Container();
          //return CircularProgress(key: ValueKey('progress'));
        } else {
          final isFavorite = repo.isFavorite(service: service, code: code);
          return IconButton(
            onPressed: () => onPress(),
            icon: Icon(
              isFavorite ? Icons.star : Icons.star_border,
              color: Colors.yellow.shade600,
              size: 40,
            ),
          );
        }
      },
    );
  }
}
