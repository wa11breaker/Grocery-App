import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        children: [
          ExpansionPanelList(
            expansionCallback: (int index, bool isExpanded) {},
            children: [
              ExpansionPanel(
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return ListTile(
                    title: Text('Item 1'),
                  );
                },
                body: ListTile(
                  title: Text('Item 1 child'),
                  subtitle: Text('Details goes here'),
                ),
                isExpanded: true,
              ),
              ExpansionPanel(
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return ListTile(
                    title: Text('Item 2'),
                    trailing: FlutterLogo(),
                  );
                },
                body: ListTile(
                  title: Text('Item 2 child'),
                  subtitle: Text('Details goes here'),
                ),
                isExpanded: true,
              ),
            ],
          )
        ],
      ),
    );
  }
}
