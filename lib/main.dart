import 'package:flutter/material.dart';
import 'package:p_ud5_bici/data/bici_api.dart';
import 'package:p_ud5_bici/data/bici_repository.dart';
import 'package:p_ud5_bici/views/screens/home_screen.dart';
import 'package:p_ud5_bici/viewmodels/bici_report_vm.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //Creamos las dependencias
    final api = BiciApi();
    final repo = BiciRepository(api);

    return MaterialApp(
      home: ChangeNotifierProvider(
        create: (_) {
          final vm = BiciReportVm(repo);
          vm.loadEstaciones();
          return vm;
        },
        child: const HomeScreen(),
      ),
    );
  }
}
