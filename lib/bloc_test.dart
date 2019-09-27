import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BlocTest extends ChangeNotifier {
  int _txt = 0;
  set txt(newValue) {
    _txt = newValue;
  }

  int get txt => _txt;

  String _text = 'Rakib';

  set text(newValue) {
    _text = newValue;
  }

  String get text => _text;

  List _names = ['Rakib', 'Rimi', '7'];

  set names(val) {
    _names = names;
  }

  List get names => _names;

  _increment() {
    txt = txt + 1;
    text = 'Rakib Bhuiyan';
    // names.add('djfhf');
    notifyListeners();
  }

  _decrement() {
    txt--;
    text = 'Rakib';

    notifyListeners();
  }
}

class LoveIcon {
  Icon love = Icon(Icons.favorite_border);
  Icon love1 = Icon(Icons.favorite);
}

class BlocPage extends StatelessWidget {
  const BlocPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoveIcon loveIcon = LoveIcon();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          builder: (contex) => BlocTest(),
        )
      ],
      child: Consumer<BlocTest>(
        builder: (context, bloctest, child) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(bloctest.txt.toString()),
                  RaisedButton(
                    child: Text(bloctest.text),
                    onPressed: () {
                      bloctest._increment();
                      bloctest.names.add('djfhf');
                    },
                  ),
                  RaisedButton(
                    onPressed: () {
                      bloctest._decrement();
                      bloctest.names.removeLast();
                    },
                  ),
                  Icon(loveIcon.love1.icon),
                  Container(height: 50, child: TextWidget()),
                  Expanded(
                    child: ListView.builder(
                      itemCount: bloctest.names.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Text(bloctest.names[index]),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class TextWidget extends StatelessWidget {
  const TextWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          builder: (contex) => BlocTest(),
        )
      ],
      child: Consumer<BlocTest>(
        builder: (context, bloctest, child) {
          return Scaffold(
            body: Center(
              child: Text(bloctest.names.length.toString()),
            ),
          );
        },
      ),
    );
  }
}
