import 'package:flutter/material.dart';

import '../../../components/constants/AppStrings.dart';
import '../../../components/constants/TextStyles.dart';
import '../../../core/utils/appExtension.dart';
import '../../../components/coreWidgets/TextView.dart';
import 'HomeView.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  @override
  void initState() {
    super.initState();
    onCreate();
  }

  void onCreate(){
    Future.delayed(const Duration(seconds: 3),(){
      context.replaceNavigator(const HomeView());
    });
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: TextView(text: AppStrings.appName, textStyle: TextStyles.semiBold20Black,),
      ),
    );
  }
}
