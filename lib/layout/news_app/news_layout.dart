import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udimy_flutter/layout/news_app/cubit/cubit.dart';
import 'package:udimy_flutter/layout/news_app/cubit/states.dart';
import 'package:udimy_flutter/modules/news_app/search/search_screen.dart';
import 'package:udimy_flutter/shared/components/components.dart';
import 'package:udimy_flutter/shared/cubit/cubit.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('News App'),
            actions: [
              IconButton(onPressed: () {
                navigateTo(context, SearchScreen());
              }, icon: Icon(Icons.search)),
              IconButton(onPressed: () {
                AppCubit.get(context).changeAppMode();
              }, icon: Icon(Icons.brightness_4_outlined))
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeBottomNavBar(index);
              },
              items: cubit.bottomItems),
        );
      },
    );
  }
}
