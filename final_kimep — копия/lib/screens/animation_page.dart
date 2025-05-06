import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:easy_localization/easy_localization.dart';
import '../app_text_styles.dart';

class AnimationPage extends StatefulWidget {
  const AnimationPage({super.key});

  @override
  State<AnimationPage> createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    animation = Tween<double>(begin: 0, end: 300).animate(controller);
    controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('animation'.tr()),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeIn(
              child: Text(
                'animated_text'.tr(),
                style: AppTextStyles.headline,
              ),
            ),
            const SizedBox(height: 20),
            AnimatedBuilder(
              animation: animation,
              builder: (context, child) {
                return Container(
                  width: animation.value,
                  height: animation.value,
                  color: Colors.deepPurpleAccent,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
