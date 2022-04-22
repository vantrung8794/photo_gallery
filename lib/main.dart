import 'package:flutter/material.dart';
import 'package:photo_gallery/photo_gallery.dart';

void main() {
  runApp(const MyApp());
}

GlobalKey scaffold = GlobalKey();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final items = [
    'https://meta.vn/Data/image/2022/01/13/anh-dep-thien-nhien-3.jpg',
    'https://baoquocte.vn/stores/news_dataimages/dieulinh/012020/29/15/nhung-buc-anh-dep-tuyet-voi-ve-tinh-ban.jpg',
    'https://kenh14cdn.com/thumb_w/660/2020/7/17/brvn-15950048783381206275371.jpg',
    'https://bloganh.net/wp-content/uploads/2021/03/chup-anh-dep-anh-sang-min.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffold,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: const SizedBox(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          PhotoGallery.showPhotoGallery(context,
              urls: items, selectedIndex: 10);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
