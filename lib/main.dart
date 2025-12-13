import 'package:flutter/material.dart';
import 'package:p_ud5_bici/viewmodels/bici_report_vm.dart';
import 'package:p_ud5_bici/views/screens/bici_report_page.dart';
import 'package:p_ud5_bici/views/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider(
  create: (_) => BiciReportVm(repo)..loadEstaciones(),
  child: const BiciReportPage(),)
);
    
  }
}