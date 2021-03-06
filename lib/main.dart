import 'dart:typed_data';

import 'package:convert_widget_image_example/utils.dart';
import 'package:convert_widget_image_example/widget/card_widget.dart';
import 'package:convert_widget_image_example/widget/title_widget.dart';
import 'package:convert_widget_image_example/widget/widget_to_image.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final String title = 'Convertir Widget a Imagen';

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: title,
        theme: ThemeData(primarySwatch: Colors.deepOrange),
        home: MainPage(title: title),
      );
}

class MainPage extends StatefulWidget {
  final String title;

  const MainPage({
    @required this.title,
  });

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  GlobalKey key1;
  GlobalKey key2;
  Uint8List bytes1;
  Uint8List bytes2;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: ListView(
          padding: EdgeInsets.all(16),
          children: [
            TitleWidget('Widgets'),
            WidgetToImage(
              builder: (key) {
                this.key1 = key;

                return CardWidget(
                    title: 'Titulo1', description: 'Descripcion1');
              },
            ),
            WidgetToImage(
              builder: (key) {
                this.key2 = key;

                return CardWidget(
                    title: 'Titulo2', description: 'Descripcion2');
              },
            ),
            TitleWidget('Imagen'),
            buildImage(bytes1),
            buildImage(bytes2),
          ],
        ),
        bottomSheet: Container(
          color: Theme.of(context).accentColor,
          padding: EdgeInsets.all(16),
          child: Container(
            width: double.infinity,
            child: RaisedButton(
              color: Colors.white,
              child: Text('Captura'),
              onPressed: () async {
                final bytes1 = await Utils.capture(key1);
                final bytes2 = await Utils.capture(key2);

                setState(() {
                  this.bytes1 = bytes1;
                  this.bytes2 = bytes2;
                });
              },
            ),
          ),
        ),
      );

  Widget buildImage(Uint8List bytes) =>
      bytes != null ? Image.memory(bytes) : Container();
}
