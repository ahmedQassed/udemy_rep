import 'package:flutter/material.dart';
import 'package:im/modules/shop_modules/shop_login/shop_login.dart';
import 'package:im/shared/component/componant.dart';
import 'package:im/shared/network/local/cache_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  String image;
  String title;
  String sub;

  BoardingModel({required this.image, required this.title, required this.sub});
}

class OnBoardPage extends StatefulWidget {
  @override
  _OnBoardPageState createState() => _OnBoardPageState();
}

void skipOnBoard(context) {
  CacheHelper.SaveData(key: 'opened', value: true).then((value) {
    if (value) {
      navigateAndFinish(context, ShopLogin());
    }
  });
}

class _OnBoardPageState extends State<OnBoardPage> {
  var ControllerPage = PageController();

  List<BoardingModel> b = [
    BoardingModel(image: 'ahmed/shop.jpg', title: 'ahmed', sub: '1'),
    BoardingModel(image: 'ahmed/shop2.jpg', title: 'ebrahem', sub: '2'),
    BoardingModel(image: 'ahmed/shop3.jpg', title: 'yousif', sub: '3'),
  ];

  bool last = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
                onPressed: () {
                  skipOnBoard(context);
                },
                child: Text(
                  'SKIP',
                ))
          ],
        ),
        body: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: ControllerPage,
                  onPageChanged: (int index) {
                    if (index == b.length - 1) {
                      setState(() {
                        last = true;
                      });
                    } else {
                      setState(() {
                        last = false;
                      });
                    }
                  },
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) => board(b[index]),
                  itemCount: b.length,
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Row(
                children: [
                  SmoothPageIndicator(
                    controller: ControllerPage,
                    count: b.length,
                    effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      dotHeight: 10.0,
                      dotWidth: 10.0,
                      spacing: 5.0,
                      activeDotColor: Colors.deepPurple,
                      expansionFactor: 5,
                    ),
                  ),
                  Spacer(),
                  FloatingActionButton(
                    onPressed: () {
                      if (last) {
                        skipOnBoard(context);
                      } else {
                        ControllerPage.nextPage(
                            duration: Duration(milliseconds: 1000),
                            curve: Curves.fastOutSlowIn);
                      }
                    },
                    child: Icon(Icons.arrow_forward_ios),
                  )
                ],
              )
            ],
          ),
        ));
  }

  Widget board(BoardingModel m) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(image: AssetImage(m.image)),
          ),
          Text(m.title),
          SizedBox(
            height: 10.0,
          ),
          Text(m.sub),
        ],
      );
}
