import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _dx = 180.0;
  var _dy = 360.0;
  var _width = 360.0;
  var _height = 720.0;
  var _ticker;
  var _startMills = DateTime.now().millisecondsSinceEpoch;
  var _random = Random();
  var _spriteXs = List<double>(300);
  var _types = List<int>(300);

  _MyAppState() {
    for (var i = 0; i < 300; i++) {
      _spriteXs[i] = (_random.nextDouble() - 0.5) * 8.0;
      _types[i] = _random.nextInt(4);
    }

    _ticker = Ticker(_refresh);
    _ticker.start();
  }

  void _refresh(Duration duration) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var xo = (0.5 - _dx / _width) * 9.5;
    var yo = (0.5 - _dy / _height) * 18.0;
    var nowMillis = DateTime.now().millisecondsSinceEpoch;
    var zo = (nowMillis / 50.0) % 10.0;
    var z1 = (nowMillis - _startMills) / 50.0;

    var widgets = [
      Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.007)
            ..scale(10.0, 10.0, 1.0)
            ..translate(xo, -5.0 + yo, 41.0 + 7 - zo)
            ..rotateX(-3.141592654 / 2.0),
          alignment: FractionalOffset.center,
          child: Center(
              child: Image(
                  image: AssetImage('images/ceiling.png'),
                  width: 10.0,
                  height: 360.0,
                  filterQuality: FilterQuality.none,
                  repeat: ImageRepeat.repeatY))),
      Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.007)
            ..scale(10.0, 10.0, 1.0)
            ..translate(5.0 + xo, yo, 41.0 + 7 - zo)
            ..rotateY(3.141592654 / 2.0),
          alignment: FractionalOffset.center,
          child: Center(
              child: Image(
                  image: AssetImage('images/wall2.png'),
                  width: 360.0,
                  height: 10.0,
                  filterQuality: FilterQuality.none,
                  repeat: ImageRepeat.repeatX))),
      Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.007)
            ..scale(10.0, 10.0, 1.0)
            ..translate(-5.0 + xo, yo, 41.0 + 7 - zo)
            ..rotateY(3.141592654 / 2.0),
          alignment: FractionalOffset.center,
          child: Center(
              child: Image(
                  image: AssetImage('images/wall2.png'),
                  width: 360.0,
                  height: 10.0,
                  filterQuality: FilterQuality.none,
                  repeat: ImageRepeat.repeatX))),
      Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.007)
            ..scale(10.0, 10.0, 1.0)
            ..translate(xo, 5.0 + yo, 41.0 + 7 - zo)
            ..rotateX(-3.141592654 / 2.0),
          alignment: FractionalOffset.center,
          child: Center(
              child: Image(
                  image: AssetImage('images/floor.png'),
                  width: 10.0,
                  height: 360.0,
                  filterQuality: FilterQuality.none,
                  repeat: ImageRepeat.repeatY))),
    ];

    var c = 0;
    for (var n = 400; n > -100; n -= 5) {
      var x = _spriteXs[c];
      switch (_types[c]) {
        case 0:
          widgets.add(Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.007)
                ..scale(10.0, 10.0, 1.0)
                ..translate(xo + x, -3.0 + yo, n - z1),
              alignment: FractionalOffset.center,
              child: Center(
                  child: Image(
                      image: AssetImage('images/meteor.png'),
                      width: 1.9,
                      height: 3.4,
                      filterQuality: FilterQuality.none))));
          break;
        case 1:
          widgets.add(Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.007)
                ..scale(10.0, 10.0, 1.0)
                ..translate(xo + x, -2.0 + yo, n - z1),
              alignment: FractionalOffset.center,
              child: Center(
                  child: Image(
                      image: AssetImage('images/cloud.png'),
                      width: 1.9,
                      height: 3.4,
                      filterQuality: FilterQuality.none))));
          break;
        case 2:
          widgets.add(Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.007)
                ..scale(10.0, 10.0, 1.0)
                ..translate(xo + x, 2.0 + yo, n - z1),
              alignment: FractionalOffset.center,
              child: Center(
                  child: Image(
                      image: AssetImage('images/tree.png'),
                      width: 6.9,
                      height: 6.0,
                      filterQuality: FilterQuality.none))));
          break;
        case 3:
          widgets.add(Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.007)
                ..scale(10.0, 10.0, 1.0)
                ..translate(xo + x, 4.1 + yo, n - z1),
              alignment: FractionalOffset.center,
              child: Center(
                  child: Image(
                      image: AssetImage('images/stump.png'),
                      width: 3.3,
                      height: 1.9,
                      filterQuality: FilterQuality.none))));
          break;
      }
      c++;
    }
    var stack = new Stack(
      textDirection: TextDirection.ltr,
      children: widgets,
    );

    return Listener(
        behavior: HitTestBehavior.opaque,
        onPointerDown: onPointerDown,
        onPointerMove: onPointerMove,
        onPointerCancel: onPointerCancel,
        onPointerUp: onPointerUp,
        child: stack);
  }

  void onPointerDown(PointerDownEvent pointerDownEvent) {}

  void onPointerMove(PointerMoveEvent pointerMoveEvent) {
    setState(() {
      _dx = pointerMoveEvent.position.dx;
      _dy = pointerMoveEvent.position.dy;
    });
  }

  void onPointerCancel(PointerCancelEvent pointerCancelEvent) {}

  void onPointerUp(PointerUpEvent pointerUpEvent) {}
}