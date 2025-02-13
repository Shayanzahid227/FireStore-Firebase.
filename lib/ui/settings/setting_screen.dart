import 'package:code_structure/ui/settings/setting_screen_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SettingScreenViewModel(),
      child: Consumer<SettingScreenViewModel>(
        builder: (context, value, child) => Scaffold(
            body: Column(
          children: [
            50.verticalSpace,
          ],
        )),
      ),
    );
  }
}
