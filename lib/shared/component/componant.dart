import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:im/modules/news_modules/web_view_page.dart';
import 'package:im/shared/app_cubit/cubit/app_cubit.dart';

Widget defaultButton({
  double? width = double.infinity,
  Color? color = Colors.deepPurple,
  required String text,
  double radius = 50.0,
  bool upperCase = true,
  required Function function,
}) =>
    Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: color,
        ),
        width: width,
        child: MaterialButton(
          onPressed: () {
            function();
          },
          child: Text(
            upperCase ? text.toUpperCase() : text,
            style: const TextStyle(color: Colors.white),
          ),
        ));

Widget defaultField({
  Function? onSub,
  required TextEditingController Controller,
  required TextInputType type,
  required String? Function(String?)? vale,
  required String lbName,
  Function()? tap,
  required IconData pre,
  IconData? suf,
  Function()? f,
  Function? change,
  bool secure = false,
}) =>
    TextFormField(
      onTap: tap,
      // onChanged: (s) {
      //   change!(s);
      // },
      onFieldSubmitted: (y) {
        onSub!();
      },
      cursorColor: Colors.deepPurple,
      controller: Controller,
      keyboardType: type,
      validator: vale,
      obscureText: secure,
      decoration: InputDecoration(
        prefixIcon: Icon(pre),
        suffixIcon: IconButton(onPressed: f, icon: Icon(suf)),
        labelText: lbName,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
      ),
    );

Widget taskLabel(Map model, context,
        {required Widget doneIcon, required Widget archivedIcon}) =>
    Dismissible(
      key: Key(model['id'].toString()),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40.0,
              child: Text('${model['time']}'),
            ),
            const SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${model['title']}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    '${model['date']}',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            IconButton(
                onPressed: () {
                  AppCubit.get(context)
                      .updateDate(updateName: 'done', id: model['id']);
                },
                icon: doneIcon),
            IconButton(
                onPressed: () {
                  AppCubit.get(context)
                      .updateDate(updateName: 'archived', id: model['id']);
                },
                icon: archivedIcon),
          ],
        ),
      ),
      onDismissed: (direction) {
        AppCubit.get(context).deleteData(id: model['id']);
      },
    );

Widget emptyPage({required IconData i, required String text}) => Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          i,
          size: 100.0,
          color: Colors.grey,
        ),
        const SizedBox(
          height: 10.0,
        ),
        Text(
          text,
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 30.0, color: Colors.grey),
        )
      ],
    ));

Widget NewsItem(Data, context) => InkWell(
      onTap: () {
        navigateTo(context, WebViewPage(Data['url']));
      },
      child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                height: 120.0,
                width: 120.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    image: DecorationImage(
                      image: NetworkImage(
                        '${Data['urlToImage']}',
                      ),
                      fit: BoxFit.cover,
                    )),
              ),
              SizedBox(
                width: 20.0,
              ),
              Expanded(
                child: Container(
                  height: 120.0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          '${Data['title']}',
                          maxLines: 3,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        '${Data['publishedAt']}',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )),
    );

Widget MyDivider() => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        height: 0.5,
        width: double.infinity,
        color: Colors.black38,
      ),
    );

Widget PageContent(list, {bool s = true}) => ConditionalBuilder(
    condition: list.isNotEmpty,
    builder: (context) => ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) => NewsItem(list[index], context),
        separatorBuilder: (context, index) => MyDivider(),
        itemCount: list.length),
    fallback: (context) =>
        s ? const Center(child: CircularProgressIndicator()) : Container());

void navigateTo(context, Widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => Widget));

void navigateAndFinish(context, Widget) {
  Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => Widget), (route) => false);
}

ThemeData darkThemeCom() => ThemeData(
    textTheme: const TextTheme(
      bodyText1: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 15.0,
          overflow: TextOverflow.ellipsis),
    ),
    primarySwatch: Colors.deepOrange,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: HexColor('142F43'),
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.deepOrange,
      unselectedItemColor: Colors.grey,
    ),
    scaffoldBackgroundColor: HexColor('142F43'),
    appBarTheme: AppBarTheme(
      actionsIconTheme: const IconThemeData(color: Colors.white54),
      backwardsCompatibility: false,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: HexColor('142F43'),
          statusBarIconBrightness: Brightness.light),
      backgroundColor: HexColor('142F43'),
      titleTextStyle: const TextStyle(
          color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0),
      elevation: 0.0,
    ));

ThemeData lightThemeCom() => ThemeData(
    textTheme: const TextTheme(
      bodyText1: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: 15.0,
          overflow: TextOverflow.ellipsis),
    ),
    primarySwatch: Colors.blue,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.blue,
    ),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      actionsIconTheme: IconThemeData(color: Colors.black54),
      backwardsCompatibility: false,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark),
      backgroundColor: Colors.white,
      titleTextStyle: TextStyle(
          color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20.0),
      elevation: 0.0,
    ));

void ShowToast({required text, required messageColor c}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: chooseColors(c),
        textColor: Colors.white,
        fontSize: 16.0);

enum messageColor { SUCCESS, ERROR, WARNING }

Color chooseColors(messageColor c) {
  Color color;
  switch (c) {
    case messageColor.SUCCESS:
      color = Colors.green;
      break;
    case messageColor.ERROR:
      color = Colors.red;
      break;
    case messageColor.WARNING:
      color = Colors.amber;
      break;
  }

  return color;
}
