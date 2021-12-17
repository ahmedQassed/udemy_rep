import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:im/layouts/news_layout/cubit/cubit.dart';
import 'package:im/layouts/news_layout/cubit/states.dart';
import 'package:im/layouts/news_layout/news_app.dart';
import 'package:im/layouts/todo_layout/todo_app.dart';
import 'package:im/modules/contacts_page/contactsPage.dart';
import 'package:im/modules/counter_page/counter_page.dart';
import 'package:im/modules/messenger_page/messengerPage.dart';
import 'package:im/modules/new_tasks/new_tasks.dart';
import 'package:im/modules/shop_modules/onboard_page.dart';
import 'package:im/modules/shop_modules/shop_cubit/shop_cubit.dart';
import 'package:im/modules/shop_modules/shop_home.dart';
import 'package:im/modules/shop_modules/shop_login/shop_login.dart';
import 'package:im/modules/social_modules/social_cubit/social_cubit.dart';
import 'package:im/modules/social_modules/social_home_screen.dart';
import 'package:im/modules/social_modules/social_login_screen.dart';
import 'package:im/shared/app_cubit/app_states/app_states.dart';
import 'package:im/shared/app_cubit/cubit/app_cubit.dart';
import 'package:im/shared/bloc_observer/bloc_observer.dart';
import 'package:im/shared/component/componant.dart';
import 'package:im/shared/component/const.dart';
import 'package:im/shared/network/local/cache_helper.dart';
import 'package:im/shared/network/remote/dio_helper.dart';
import 'modules/login_page/login_page.dart';

// ### (lw ht8l 3la git m3 7d w h3ml login method) ###

// 1. checkout master  (ell t7t 3 ymen)
// 2. update master (fo2 3 ymen)
// 3. create branch (t7t 3 ymen m3 elmaster)
// 4. code....
// 5. commit (mn fo2 3 ymen)
// 6. checkout master
// 7. update master
// 8. checkout your local branch
// 9. merge master with my current branch
// 10. push (elli fo2 3 ymen)
// 11. create pull request (mn github hnak)

Future<void> ono(RemoteMessage message) async {
  ShowToast(text: 'on background message', c: messageColor.SUCCESS);
  print(' kkkkkk   ${message.data.toString()}');
}

void main() async {
  //h
  //hhhh
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  var TOKEN = await FirebaseMessaging.instance.getToken();

  print('bbbbbb   ${TOKEN}');

  FirebaseMessaging.onMessage.listen((event) {
    print('ssssss   ${event.data.toString()}');

    ShowToast(text: 'on message', c: messageColor.SUCCESS);
  });

  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print('wwwwwww    ${event.data.toString()}');

    ShowToast(text: 'on message opened app', c: messageColor.SUCCESS);
  });

  FirebaseMessaging.onBackgroundMessage(ono);

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  bool? da = CacheHelper.getBool(key: 'changeMode');

  // bool? boarding = CacheHelper.getData(key: 'opened');
  // token = CacheHelper.getData(key: 'token');

  uid = CacheHelper.getData(key: 'uid');

  Widget StartPage;

  // if (boarding != null) {
  //   if (token != null) {
  //     StartPage = ShopHome();
  //   } else {
  //     StartPage = ShopLogin();
  //   }
  // } else {
  //   StartPage = OnBoardPage();
  // }

  if (uid != null) {
    StartPage = SocialHomeScreen();
  } else {
    StartPage = SocialLoginScreen();
  }

  runApp(NewApp(da, StartPage));
}

class NewApp extends StatelessWidget {
  bool? d;
  Widget startPage;

  NewApp(this.d, this.startPage);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => NewsAppCubit()..getBusinessData(),
        ),
        BlocProvider(
          create: (BuildContext context) => AppCubit()..appMode(f: d),
        ),
        BlocProvider(
            create: (BuildContext context) => ShopCubit()
              ..HomeData()
              ..CategoriesData()
              ..getFav()
              ..getProfile()),
        BlocProvider(
            create: (BuildContext context) => SocialCubit()
              ..getSocialUserData()
              ..getPosts()),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          AppCubit modeCubit = AppCubit.get(context);
          return MaterialApp(
            theme: lightThemeCom(),
            darkTheme: darkThemeCom(),
            themeMode: ThemeMode.light,
            // modeCubit.ligh ? ThemeMode.light : ThemeMode.dark,
            home: startPage,
          );
        },
      ),
    );
  }
}
