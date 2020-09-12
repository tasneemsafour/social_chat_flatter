import 'package:flutter/material.dart';

Container circuleprogress()
{
  return Container(
    alignment: Alignment.center,
    padding: EdgeInsets.only(top: 10.0),
    child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(Colors.blue[400]),
    ),
  );
}

Container linearprogress()
{
  return Container(
    padding: EdgeInsets.only(bottom: 10.0),
    child: LinearProgressIndicator(
      valueColor: AlwaysStoppedAnimation( Colors.blue[400]),
    ),
  );
}
