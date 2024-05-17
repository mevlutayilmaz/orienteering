import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../router/routes.dart';
import '../../utils/constants/constants.dart';
import '../../services/user/auth_services.dart';
import '../../utils/size/custom_size.dart';
import '../../utils/validators/custom_validators.dart';
import '../../widgets/custom_text_field.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _tEmail = TextEditingController();
  final _tPassword = TextEditingController();

  @override
  void dispose() {
    _tEmail.dispose();
    _tPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Padding _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: _buildColumn(context),
          ),
        ),
      ),
    );
  }

  Column _buildColumn(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _builtextWelcome(),
        CustomTextField(controller: _tEmail, hint: LocaleConstants.email.tr(), iconData: Icons.email_outlined, validator: (value) => CustomValidators.emailValidator(value)),
        CustomTextField(controller: _tPassword, hint: LocaleConstants.password.tr(), iconData: Icons.lock_outline, visibleSuffixIcon: true, validator: (value) => CustomValidators.passwordValidator(value)),
        Align(alignment: Alignment.topRight, child: Text(LocaleConstants.recoverPassword.tr(), style: Theme.of(context).textTheme.bodySmall)),
        const SizedBox(height: 20),
        ElevatedButton(onPressed: () => _formKey.currentState!.validate() ? AuthService().signIn(context, email: _tEmail.text, password: _tPassword.text) : null, style: ElevatedButton.styleFrom(fixedSize: CustomSize.maxButtonSize), child: Text(LocaleConstants.login.tr())),
        _buildtextContinue(),
        _buildImageRow(),
        _buildTextButton(context)
      ],
    );
  }

  Widget _builtextWelcome() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Text(LocaleConstants.welcomeAgain.tr(), style: Theme.of(context).textTheme.headlineLarge)
    );
  }

  Widget _buildtextContinue() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Row(
        children: [
          const Expanded(child: Divider()),
          Expanded(child: Center(child: Text(LocaleConstants.orContinue.tr(), style: Theme.of(context).textTheme.bodySmall))),
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
         Text(LocaleConstants.doNotAccount.tr()),
         TextButton(onPressed: () => Navigator.of(context).pushNamed(Routes.signup), child: Text(LocaleConstants.signUp.tr()))
       ],
     );
  }
}
