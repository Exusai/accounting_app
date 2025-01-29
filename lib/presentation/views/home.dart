import 'package:accounting_app/presentation/views/insert_data/insert_data.dart';
import 'package:accounting_app/presentation/views/sheet/sheet.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: const Sheet()),
        InsertData()
      ],
    );
  }
}