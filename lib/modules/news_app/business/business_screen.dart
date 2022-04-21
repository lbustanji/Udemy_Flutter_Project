import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:udimy_flutter/layout/news_app/cubit/cubit.dart';
import 'package:udimy_flutter/layout/news_app/cubit/states.dart';
import 'package:udimy_flutter/shared/components/components.dart';

class BusinessScreen extends StatelessWidget {
  const BusinessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = NewsCubit.get(context).business;
        return ScreenTypeLayout(
          mobile: Builder(
            builder: (context) {
              NewsCubit.get(context).setDesktop(false);
              return articleBuilder(list, context);
            },
          ),
          desktop: Builder(
            builder: (context) {
              NewsCubit.get(context).setDesktop(true);
              return Row(
                children: [
                  Expanded(
                    child: articleBuilder(list, context),
                  ),
                  if (list.length > 0)
                    Expanded(
                      child: Container(
                        color: Colors.grey[200],
                        height: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Text(
                            list[NewsCubit.get(context).businessSelectedItem]
                            ['description'],
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
          breakpoints: ScreenBreakpoints(
            desktop: 900.0,
            tablet: 600.0,
            watch: 100.0,
          ),
        );
      },
    );
  }
}
