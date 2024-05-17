import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../router/routes.dart';
import '../../utils/constants/constants.dart';
import '../../services/user/auth_services.dart';
import '../../utils/size/custom_size.dart';
import '../../utils/validators/custom_validators.dart';
import '../../widgets/custom_text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _tName = TextEditingController();
  final _tEmail = TextEditingController();
  final _tPassword = TextEditingController();
  final _tConfirmPassword = TextEditingController();

  @override
  void dispose() {
    _tName.dispose();
    _tEmail.dispose();
    _tPassword.dispose();
    _tConfirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Center _buildBody(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _builtextWelcome(),
                CustomTextField(controller: _tName, hint: LocaleConstants.fullName.tr(), iconData: Icons.person_outline, validator: (value) => CustomValidators.nameValidator(value)),
                CustomTextField(controller: _tEmail, hint: LocaleConstants.email.tr(), iconData: Icons.mail_outline, validator: (value) => CustomValidators.emailValidator(value)),
                CustomTextField(controller: _tPassword, hint: LocaleConstants.password.tr(), iconData: Icons.lock_outline, visibleSuffixIcon: true, validator: (value) => CustomValidators.passwordValidator(value)),
                CustomTextField(controller: _tConfirmPassword, hint: LocaleConstants.confirmPassword.tr(), iconData: Icons.lock_outline, visibleSuffixIcon: true, validator: (value) => CustomValidators.passwordValidator(value)),
                const SizedBox(height: 20),
                ElevatedButton(onPressed: () => _signUpButtonFunction(context), style: ElevatedButton.styleFrom(fixedSize: CustomSize.maxButtonSize), child: Text(LocaleConstants.signUp.tr())),
                _buildtextContinue(),
                _buildImageRow(),
                _buildTextButton(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _builtextWelcome() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Text(LocaleConstants.welcomeAgain.tr(), style: Theme.of(context).textTheme.headlineLarge)
    );
  }

  void _signUpButtonFunction(BuildContext context){
    if(_formKey.currentState!.validate()){
      if(_tPassword.text == _tConfirmPassword.text){
        AuthService().signUp(context, name: _tName.text, email: _tEmail.text, password: _tPassword.text);
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(LocaleConstants.passwordsDoNotMatch.tr()),
            behavior: SnackBarBehavior.floating
          ),
        );
      }
    }
  }

  Widget _buildtextContinue() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          const Expanded(child: Divider()),
          Expanded(child: Center(child: Text(LocaleConstants.orContinue.tr()))),
          const Expanded(child: Divider()),
        ],
      ),
    );
  }

  Widget _buildImageRow() {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildImageButton('Google'),
            _buildImageButton('Apple'),
            _buildImageButton('Facebook'),
          ],
        ),
      );
  }

  Widget _buildImageButton(String image) => OutlinedButton(onPressed: () {}, style: OutlinedButton.styleFrom(fixedSize: CustomSize.imageButtonSize), child: Image.asset("lib/assets/images/$image.png"));

  Widget _buildTextButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(LocaleConstants.haveAccount.tr()),
        TextButton(onPressed: () => Navigator.of(context).pushNamed(Routes.login), child: Text(LocaleConstants.login.tr()))
      ],
    );
  }
}
