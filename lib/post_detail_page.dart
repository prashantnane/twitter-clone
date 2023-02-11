import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';
// import 'package:provider/provider.dart';

import './model.dart';

class PostDetailPage extends StatefulWidget {
  final List<Db> data;
  int index;
  PostDetailPage({required this.data, required this.index});

  static const routeName = '/post-detail';

  @override
  State<PostDetailPage> createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  var db;

  @override
  Widget build(BuildContext context) {
    List<Db> items = [];
    // final postId = ModalRoute.of(context)!.settings.arguments as String;
    // final loadedPost = Provider.of<Db>(context,listen: false).id;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Tweet",
            style: TextStyle(color: Colors.black),
          ),
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(15),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              widget.data[widget.index].primaryCategory.name,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              '@${widget.data[widget.index].primaryCategory.slug}',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              widget.data[widget.index].title.rendered,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              width: double.infinity,
              child: Text(
                widget.data[widget.index].primaryCategory.description,
                style: TextStyle(fontSize: 20),
                overflow: TextOverflow.fade,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Link(
                target: LinkTarget.blank,
                uri: Uri.parse(widget.data[widget.index].link),
                builder: (context, followLink) => ElevatedButton(
                  style: ElevatedButton.styleFrom(shape: StadiumBorder()),
                    child: Text('Read More'), onPressed: followLink),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                      widget.data[widget.index].jetpackFeaturedMediaUrl)),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "${DateTime.parse(widget.data[widget.index].date.toString())}",
              overflow: TextOverflow.fade,
              maxLines: 1,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.normal,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Author Name: ${widget.data[widget.index].parselyMeta.parselyAuthor}",
              overflow: TextOverflow.fade,
              maxLines: 1,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ]),
        ));
  }
}
