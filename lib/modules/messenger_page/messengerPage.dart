import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class messenger extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            titleSpacing: 20.0,
            backgroundColor: Colors.white,
            elevation: 0.0,
            title: Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('ahmed/top.jpg'),
                  radius: 23.0,
                ),
                SizedBox(
                  width: 15.0,
                ),
                Text(
                  'Chats',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ],
            ),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: CircleAvatar(
                      backgroundColor: Colors.grey[350],
                      radius: 15.0,
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.black,
                        size: 16.0,
                      ))),
              IconButton(
                  onPressed: () {},
                  icon: CircleAvatar(
                      backgroundColor: Colors.grey[350],
                      radius: 15.0,
                      child: Icon(
                        Icons.edit,
                        color: Colors.black,
                        size: 16.0,
                      )))
            ],
          ),
          body: Padding(
            padding: EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Colors.grey[350],
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.search,
                            color: Colors.black38,
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            'Search',
                            style: TextStyle(color: Colors.black38),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Container(
                    height: 110.0,
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => storyItem(),
                        separatorBuilder: (context, index) => SizedBox(
                              width: 15.0,
                            ),
                        itemCount: 10),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    child: Column(
                      children: [
                        ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) => chatItem(),
                            separatorBuilder: (context, index) => SizedBox(
                                  height: 15.0,
                                ),
                            itemCount: 20),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }

  Widget storyItem() => Container(
        width: 60.0,
        child: Column(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('ahmed/down.jpg'),
                  radius: 30.0,
                ),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 7.0,
                ),
                CircleAvatar(
                  backgroundColor: Colors.green,
                  radius: 6.0,
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              'ahmed abd elhamed qassed abd elhamed',
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ],
        ),
      );

  Widget chatItem() => Row(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: [
              CircleAvatar(
                backgroundImage: AssetImage('ahmed/down.jpg'),
                radius: 30.0,
              ),
              CircleAvatar(
                backgroundColor: Colors.white,
                radius: 7.0,
              ),
              CircleAvatar(
                backgroundColor: Colors.green,
                radius: 6.0,
              ),
            ],
          ),
          SizedBox(
            width: 20.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ahmed abd elhamed qassed abd elhamed',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 7.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'what\'s your name ? my name is ahmed abd elhamed qassed abd elhamed',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Container(
                        width: 5.0,
                        height: 5.0,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(5.0)),
                      ),
                    ),
                    Text('2:00 AM'),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
}
