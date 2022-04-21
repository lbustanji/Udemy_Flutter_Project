import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udimy_flutter/models/shop_app/favorites_model.dart';
import 'package:udimy_flutter/modules/shop_app/cubit/cubit.dart';
import 'package:udimy_flutter/modules/shop_app/cubit/states.dart';
import 'package:udimy_flutter/shared/components/components.dart';
import 'package:udimy_flutter/shared/styles/colors.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, stat) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! ShopLoadingGetFavoritesState,
          builder:(context) => ListView.separated(
            itemBuilder: (context, index) => buildListProduct(
                ShopCubit.get(context).favoritesModel!.data.data![index].product,
                context),
            separatorBuilder: (context, index) => myDivider(),
            itemCount: ShopCubit.get(context).favoritesModel!.data.data!.length,
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

}
