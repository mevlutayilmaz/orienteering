import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../utils/constants/constants.dart';
import '../../model/user/user_model.dart';
import '../../services/user/auth_services.dart';
import '../../utils/validators/custom_validators.dart';
import '../../widgets/custom_profile_text_field.dart';

class EditProfileScreen extends StatefulWidget {
  final UserModel user;
  const EditProfileScreen({super.key, required this.user});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final _tName = TextEditingController(text: widget.user.name);
  late final _tEmail = TextEditingController(text: widget.user.email);
  late final _tPassword = TextEditingController();
  late final _tPasswordConfirm = TextEditingController();
  final auth = FirebaseAuth.instance;
  late String _message;

  @override
  void dispose() {
    _tName.dispose();
    _tEmail.dispose();
    _tPassword.dispose();
    _tPasswordConfirm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(padding: EdgeInsets.zero, onPressed: () => Navigator.pop(context), icon: const Icon(Icons.arrow_back_ios_rounded)),
      title: Text(LocaleConstants.editProfile.tr()));
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              const SizedBox(height: 50),
              CustomProfileTextField(controller: _tName, text: LocaleConstants.fullName.tr(), iconData: Icons.person_outline_rounded, isEnabled: false,),
              CustomProfileTextField(controller: _tEmail, text: LocaleConstants.email.tr(), iconData: Icons.mail_outline_rounded, isEnabled: false,),
              CustomProfileTextField(controller: _tPassword, text: LocaleConstants.newPassword.tr(), iconData: Icons.fingerprint_rounded, visibleSuffixIcon: true, validator: (value) => CustomValidators.passwordValidator(value)),
              CustomProfileTextField(controller: _tPasswordConfirm, text: LocaleConstants.confirmPassword.tr(), iconData: Icons.fingerprint_rounded, visibleSuffixIcon: true, validator: (value) => CustomValidators.passwordValidator(value)),
              const SizedBox(height: 20),
              _buildEditButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEditButton() {
    return ElevatedButton(
      onPressed: () {
        if(_formKey.currentState!.validate()){
          _message = LocaleConstants.passwordsDoNotMatch.tr();
        
          if(_tPassword.text == _tPasswordConfirm.text){
            AuthService().updateUser(documentId: widget.user.documentId.toString(), password: _tPassword.text);
            _message = LocaleConstants.passwordChanged.tr();
            Navigator.pop(context);
          }
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(_message),
              behavior: SnackBarBehavior.floating
            ),
          );
        }
      },
      style: const ButtonStyle().copyWith(fixedSize: const MaterialStatePropertyAll(Size(double.maxFinite, 45))),
      child: Text(LocaleConstants.editProfile.tr()),
    );
  }
}
