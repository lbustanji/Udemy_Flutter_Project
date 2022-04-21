import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udimy_flutter/layout/news_app/cubit/cubit.dart';
import 'package:udimy_flutter/layout/shop_app/shop_layout.dart';
import 'package:udimy_flutter/layout/social_app/cubit/cubit.dart';
import 'package:udimy_flutter/layout/social_app/social_layout.dart';
import 'package:udimy_flutter/modules/NativeCodeScreen.dart';
import 'package:udimy_flutter/modules/shop_app/cubit/cubit.dart';
import 'package:udimy_flutter/modules/shop_app/login/shop_login_screen.dart';
import 'package:udimy_flutter/modules/shop_app/on_boarding/on_boarding_screen.dart';
import 'package:udimy_flutter/modules/social_app/social_login/social_login_screen.dart';
import 'package:udimy_flutter/shared/bloc_observer.dart';
import 'package:udimy_flutter/shared/components/components.dart';
import 'package:udimy_flutter/shared/components/constants.dart';
import 'package:udimy_flutter/shared/cubit/cubit.dart';
import 'package:udimy_flutter/shared/cubit/states.dart';
import 'package:udimy_flutter/shared/network/local/cache_helper.dart';
import 'package:udimy_flutter/shared/network/remote/dio_helper.dart';
import 'package:udimy_flutter/shared/styles/themes.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var token = await FirebaseMessaging.instance.getToken();

  FirebaseMessaging.onMessage.listen((event) {
    showToast(text: "on message", state: ToastState.SUCCESS);
  });

  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    showToast(text: "on message Opened App", state: ToastState.SUCCESS);
  });

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  BlocOverrides.runZoned(
    () {
      // Use cubits...
    },
    blocObserver: MyBlocObserver(),
  );
  DioHelper.init();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getData(key: 'isDark');
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token') ?? '';
  uId = CacheHelper.getData(key: 'uId') ?? '';
  Widget widget;
  if (onBoarding != null) {
    if (token != null) {
      widget = ShopLayout();
    } else {
      widget = ShopLoginScreen();
    }
  } else {
    widget = OnBoardingScreen();
  }
  if (uId.toString().isEmpty) {
    widget = SocialLoginScreen();
  } else {
    widget = SocialLayout();
  }
  widget=NativeCodeScreen();
  runApp(MyApp(isDark, widget));
}

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  showToast(text: "on Background message", state: ToastState.SUCCESS);
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  Widget startWidget;

  MyApp(this.isDark, this.startWidget);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => NewsCubit()
              ..getBusiness()
              ..getSports()
              ..getScience()),
        BlocProvider(
            create: (BuildContext context) =>
                AppCubit()..changeAppMode(isDarkFromShared: isDark)),
        BlocProvider(
            create: (BuildContext context) => ShopCubit()
              ..getHomeData()
              ..getCategoriesData()
              ..getFavoritesData()
              ..getUserData()),
        BlocProvider(
            create: (BuildContext context) => SocialCubit()
              ..getUserData()
              ..getPosts()),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: lightTheme,
            themeMode:
                // AppCubit.get(context).isDark ? ThemeMode.dark :
                ThemeMode.light,
            darkTheme: darkTheme,
            home: startWidget,
          );
        },
      ),
    );
  }
}
