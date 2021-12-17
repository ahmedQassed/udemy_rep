import 'package:flutter/material.dart';

class use {
  final int id;
  final String name;
  final String num;

  use({required this.id, required this.name, required this.num});
}

class contacts extends StatelessWidget {
  List<use> users = [
    use(id: 1, name: 'ahmed', num: '01156245049'),
    use(id: 1, name: 'ahmed', num: '01156245049'),
    use(id: 1, name: 'ahmed', num: '01156245049'),
    use(id: 1, name: 'ahmed', num: '01156245049'),
    use(id: 1, name: 'ahmed', num: '01156245049'),
    use(id: 1, name: 'ahmed', num: '01156245049'),
    use(id: 1, name: 'ahmed', num: '01156245049'),
    use(id: 1, name: 'ahmed', num: '01156245049'),
    use(id: 1, name: 'ahmed', num: '01156245049'),
    use(id: 1, name: 'ahmed', num: '01156245049'),
    use(id: 1, name: 'ahmed', num: '01156245049'),
    use(id: 1, name: 'ahmed', num: '01156245049'),
    use(id: 1, name: 'ahmed', num: '01156245049'),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('users'),
        ),
        body: ListView.separated(
            itemBuilder: (context, index) => contactItem(users[index]),
            separatorBuilder: (context, index) => Padding(
                  padding: EdgeInsetsDirectional.only(start: 50.0),
                  child: Container(
                    width: double.infinity,
                    height: 1.0,
                    color: Colors.grey,
                  ),
                ),
            itemCount: users.length),
      ),
    );
  }

  Widget contactItem(use u) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 15.0,
            backgroundColor: Colors.blue,
            child: Text('${u.id}'),
          ),
          SizedBox(
            width: 10.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${u.name}',
              ),
              SizedBox(
                height: 10.0,
              ),
              Text('${u.num}'),
            ],
          )
        ],
      ),
    );
  }
}
