import 'package:flutter/material.dart';
import 'package:intern_project/pages/index.dart';
import 'package:intern_project/theme/colors.dart';
import 'package:intern_project/pages/detail_view.dart';

void main() => runApp(
  MaterialApp(
  debugShowCheckedModeBanner: false,
  theme: ThemeData(
    primaryColor: primary
  ),
  home: IndexPage(),
)
);
