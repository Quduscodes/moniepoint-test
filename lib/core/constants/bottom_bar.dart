import 'package:flutter/material.dart';
import 'package:moniepoint/core/extensions/string.dart';
import 'package:moniepoint/features/home/presentation/screens/view.dart';
import 'package:moniepoint/features/search/presentation/screens/view.dart';

List<String> bottomAppBarIcons = [
  "search".svg,
  "messaging".svg,
  "home".svg,
  "favourite".svg,
  "user".svg,
];

List<Widget> bottomAppBarWidgets = [
  const SearchView(),
  Container(),
  const HomeView(),
  Container(),
  Container(),
];
