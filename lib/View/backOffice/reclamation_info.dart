import 'package:flutter/material.dart';

class MyReclaInfo extends StatelessWidget {
  final int _id;
  final String _date;

  const MyReclaInfo(this._id, this._date);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(10, 10, 20, 10),
            ),
            Text(_id.toString()),
            Text(_date)
          ],
        ),
      ),
    );
  }
}
