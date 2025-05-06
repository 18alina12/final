import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../app_text_styles.dart';
import '../bloc/profile_state.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _usernameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final ProfileBloc _profileBloc;

  @override
  void initState() {
    super.initState();
    _profileBloc = ProfileBloc();
    _profileBloc.load();
  }

  void _onUpdatePressed() {
    if (_formKey.currentState!.validate()) {
      _profileBloc.update(_usernameController.text);
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _profileBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('profile'.tr()),
      ),
      body: ValueListenableBuilder<ProfileState>(
        valueListenable: _profileBloc,
        builder: (context, state, _) {
          if (state is ProfileLoadSuccess) {
            _usernameController.text = state.username;
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    'profile_desc'.tr(),
                    style: AppTextStyles.headline,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: 'username'.tr(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'enter_username'.tr();
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _onUpdatePressed,
                    child: Text('update'.tr()),
                  ),
                  const SizedBox(height: 20),
                  if (state is ProfileLoadInProgress)
                    const CircularProgressIndicator(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
