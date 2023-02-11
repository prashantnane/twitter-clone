import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

import './post_detail_page.dart';
import './model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  List<Db> db = [];

  void datetime(String date) {
    String dateWithT = date.substring(0, 8) + 'T' + date.substring(8);
    DateTime dateTime = DateTime.parse(dateWithT);
  }

  Future<List<Db>> getData() async {
    final response = await http.get(Uri.parse(
        'https://techcrunch.com/wp-json/wp/v2/posts?per_page=2&page=4'));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in data) {
        db.add(Db.fromJson(index));
      }
      return db;
    } else {
      return db;
    }
  }

  Future<List<Db>> refresh() async {
    setState(() => db.clear());
    final response = await http.get(Uri.parse(
        'https://techcrunch.com/wp-json/wp/v2/posts?per_page=2&page=4'));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in data) {
        db.add(Db.fromJson(index));
      }
      return db;
    } else {
      return db;
    }
  }

  @override
  Widget build(BuildContext context) {
    // final post = Provider.of<Db>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "Twitter Clone",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        leading: Container(
          margin: EdgeInsets.all(7),
          child: CircleAvatar(
            backgroundColor: Colors.amber,
            backgroundImage: NetworkImage(
                "https://images.pexels.com/photos/15508042/pexels-photo-15508042.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.blue,
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,
        onTap: (int i) {},
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: ""),
          BottomNavigationBarItem(icon: Icon(Icons.mail), label: ""),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  padding: EdgeInsets.all(10),
                  itemCount: db.length,
                  itemBuilder: (content, index) {
                    return ListTile(
                      leading: const CircleAvatar(
                        backgroundImage: NetworkImage(
                            "https://images.pexels.com/photos/15508042/pexels-photo-15508042.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2"),
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                PostDetailPage(index: index, data: db)));
                      },
                      title: Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                '${db[index].title.rendered}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Flexible(
                              child: Text(
                                "@ ${db[index].primaryCategory.slug}",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                ". ${DateTime.parse(db[index].date.toString())}",
                                overflow: TextOverflow.fade,
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ],
                        )
                      ]),
                      subtitle: Column(children: [
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "${db[index].primaryCategory.description}",
                          overflow: TextOverflow.clip,
                          maxLines: 3,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            "${db[index].jetpackFeaturedMediaUrl}",
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.chat_bubble_outline, color: Colors.grey),
                            Icon(Icons.repeat, color: Colors.grey),
                            Icon(Icons.favorite_border, color: Colors.grey),
                            Icon(Icons.share, color: Colors.grey),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ]),
                    );
                  });
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.blue,
        child: Icon(Icons.add),
      ),
    );
  }
}
