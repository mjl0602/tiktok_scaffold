import 'package:flutter/material.dart';

class TodoPage extends StatelessWidget {
  final String title;
  final String detail;
  final Function(BuildContext) onBack;

  const TodoPage({
    Key key,
    this.title,
    this.detail,
    this.onBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool canpop = Navigator.of(context).canPop();
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(vertical: 24, horizontal: 12),
                  child: FlutterLogo(
                    size: 120,
                  ),
                ),
                Text(
                  title ?? '未开放的页面',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    inherit: true,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 12),
                  child: Text(
                    detail ?? '正在施工中',
                    style: const TextStyle(
                      color: const Color.fromRGBO(0xff, 0xff, 0xff, .66),
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      inherit: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: (canpop || onBack != null)
                  ? GestureDetector(
                      child: Icon(
                        Icons.clear,
                        size: 30,
                        color: Colors.red,
                      ),
                      onTap: () {
                        if (canpop) {
                          Navigator.of(context).pop();
                        } else {
                          onBack?.call(context);
                        }
                      },
                    )
                  : Container(),
            ),
          ),
          Expanded(
            child: Center(),
          ),
        ],
      ),
    );
  }
}
