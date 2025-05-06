import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../app_text_styles.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Widget _buildMenuButton(BuildContext context, String label, String route) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, route);
        },
        child: Text(
          label,
          style: AppTextStyles.body,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('kimep_university'.tr()),
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          children: [
            _buildMenuButton(context, 'news'.tr(), '/news'),
            _buildMenuButton(context, 'post'.tr(), '/post'),
            _buildMenuButton(context, 'animation'.tr(), '/animation'),
            _buildMenuButton(context, 'profile'.tr(), '/profile'),
          ],
        ),
      ),
    );
  }
}
