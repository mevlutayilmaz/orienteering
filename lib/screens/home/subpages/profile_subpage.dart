import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:image_picker/image_picker.dart';

import '../../../router/routes.dart';
import '../../../utils/constants/constants.dart';
import '../../../model/user/user_model.dart';
import '../../../services/user/auth_services.dart';
import '../../../utils/colors/custom_colors.dart';
import '../../../widgets/custom_circular.dart';
import '../../../widgets/custom_log_out_dialog.dart';
import '../../../widgets/custom_profile_label.dart';

class ProfileSubpage extends StatefulWidget {
  const ProfileSubpage({super.key});

  @override
  State<ProfileSubpage> createState() => _ProfileSubpageState();
}

class _ProfileSubpageState extends State<ProfileSubpage> {
  UserModel? _user;
  final auth = FirebaseAuth.instance;

  @override
  void initState() {
    _init();
    super.initState();
  }

  Future<void> _init() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _user = await AuthService().getUserByEmail(auth.currentUser!.email.toString());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return _user == null
        ? customCircular
        : _buildBody(context);
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildProfilePhoto(context),
        Text(_user!.name.toString(), style: Theme.of(context).textTheme.bodyLarge),
        Text(_user!.email.toString(), style: Theme.of(context).textTheme.bodySmall),
        const SizedBox(height: 20),
        _buildEditProfileButton(context),
        const SizedBox(height: 40),
        CustomProfileLabel(
            text: LocaleConstants.createGame.tr(),
            icon: Icons.add_circle_outline,
            onPress: () => Navigator.of(context).pushNamed(Routes.createGameHome, arguments: _user?.name)),
        CustomProfileLabel(
            text: LocaleConstants.myGames.tr(),
            icon: Icons.games_outlined,
            onPress: () => Navigator.of(context).pushNamed(Routes.myGames, arguments: _user)),
        CustomProfileLabel(
            text: LocaleConstants.settings.tr(),
            icon: Icons.settings_outlined,
            onPress: () => Navigator.of(context).pushNamed(Routes.settings)),
        CustomProfileLabel(
            text: LocaleConstants.information.tr(),
            icon: Icons.info_outline_rounded,
            onPress: () => Navigator.of(context).pushNamed(Routes.information)),
        CustomProfileLabel(
            text: LocaleConstants.logOut.tr(),
            icon: Icons.logout_rounded,
            textColor: Colors.red,
            isArrow: false,
            onPress: () => logOutDialog(context, () => AuthService().signOut(context))),
      ],
    );
  }

  Widget _buildProfilePhoto(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
            height: 150,
            width: 150,
            child: (_user != null && _user!.image!.isNotEmpty)
                ? CircleAvatar(backgroundImage: NetworkImage(_user!.image.toString()))
                : const CircleAvatar(child: customCircular)),
        Padding(
          padding: const EdgeInsets.only(top: 96, left: 96),
          child: IconButton(
            onPressed: () => showImagePickerOption(context),
            icon: CircleAvatar(
              backgroundColor: CustomColors.buttonColor,
              child: Icon(Icons.camera_alt_outlined, size: 25, color: Theme.of(context).primaryColor)),
          ),
        ),
      ],
    );
  }

  void showImagePickerOption(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (builder) {
        return Padding(
          padding: const EdgeInsets.all(18.0),
          child: SizedBox(
            height: 100,
            child: Row(
              children: [
                _imagePickerOptionButtons(LocaleConstants.gallery.tr(),  Icons.image, ImageSource.gallery),
                _imagePickerOptionButtons(LocaleConstants.camera.tr(), Icons.camera_alt, ImageSource.camera),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _imagePickerOptionButtons(String text, IconData icon, ImageSource source) {
    return Expanded(
      child: InkWell(
        onTap: () => _pickImage(source),
        child: SizedBox(
          child: Column(
            children: [Icon(icon, size: 70), Text(text)],
          ),
        ),
      ),
    );

  }

  Future<void> _pickImage(ImageSource source) async {
    final returnImage = await ImagePicker().pickImage(source: source);
    if (returnImage == null) return;
    String oldImage = _user!.image!;
    setState(() {
      _user!.image = '';
    });
    File? selectedImage = File(returnImage.path);
    AuthService().deleteImageFromFirebase(oldImage);
    String imageUrl = await AuthService().uploadImageToFirebase(selectedImage);
    if (imageUrl.isNotEmpty) {
      await AuthService().updateUser(documentId: _user!.documentId.toString(), image: imageUrl);
      if (mounted) { 
        setState(() {
          _user!.image = imageUrl;
        });
      }
    }
  }

  Widget _buildEditProfileButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => Navigator.of(context).pushNamed(Routes.editProfile, arguments: _user),
      child: Text(LocaleConstants.editProfile.tr()),
    );
  }

}
