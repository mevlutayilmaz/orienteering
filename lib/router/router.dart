import 'package:flutter/material.dart';

import '../model/game/base_game_model.dart';
import '../model/game/indoor_game_model.dart';
import '../model/game/outdoor_game_model.dart';
import '../model/user/user_model.dart';
import '../screens/about_orienteering/about_orienteering_screen.dart';
import '../screens/game/create/create_game_home_screen.dart';
import '../screens/game/create/create_indoor_game_screen.dart';
import '../screens/game/create/create_outdoor_game_screen.dart';
import '../screens/game/create/create_qr_code_screen.dart';
import '../screens/game/indoor/indoor_game_screen.dart';
import '../screens/game/my_games/my_games_screen.dart';
import '../screens/game/outdoor/outdoor_game.dart';
import '../screens/home/main_home_screen.dart';
import '../screens/information/information_screen.dart';
import '../screens/login/login_screen.dart';
import '../screens/edit_profile/edit_profile_screen.dart';
import '../screens/settings/settings_screen.dart';
import '../screens/sign_up/sign_up_screen.dart';
import '../screens/welcome/welcome_screen.dart';
import 'routes.dart';


class RouteGenerate {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case Routes.mainHome:
        return MaterialPageRoute(builder: (_) => const MainHomeScreen());
      case Routes.welcome:
        return MaterialPageRoute(builder: (_) => const WelcomeScreen());
      case Routes.login:
        return MaterialPageRoute(builder: (_) => const LogInScreen());
      case Routes.signup:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case Routes.editProfile:
        if(args is UserModel){
          return MaterialPageRoute(builder: (_) => EditProfileScreen(user: args));
        }
        return _errorRoute();
      case Routes.indoorGame:
        if(args is IndoorGameModel){
          return MaterialPageRoute(builder: (_) => IndoorGameScreen(gameModel: args));
        }
        return _errorRoute();
      case Routes.outdoorGame:
        if(args is OutdoorGameModel){
          return MaterialPageRoute(builder: (_) => OutdoorGameScreen(gameModel: args));
        }
        return _errorRoute();
      case Routes.createGameHome:
        if(args is String){
          return MaterialPageRoute(builder: (_) => CreateGameHomeScreen(organizerName: args));
        }
        return _errorRoute();
      case Routes.createOutdoorGame:
        if(args is BaseGameModel){
          return MaterialPageRoute(builder: (_) => CreateOutdoorGameScreen(baseGameModel: args));
        }
        return _errorRoute();
      case Routes.createIndoorGame:
        if(args is BaseGameModel){
          return MaterialPageRoute(builder: (_) => CreateIndoorGameScreen(baseGameModel: args));
        }
        return _errorRoute();
      case Routes.createQRCode:
        if(args is String){
          return MaterialPageRoute(builder: (_) => CreateQRCodeScreen(data: args));
        }
        return _errorRoute();
      case Routes.myGames:
        if(args is UserModel){
          return MaterialPageRoute(builder: (_) => MyGamesScreen(user: args));
        }
        return _errorRoute();
      case Routes.aboutOrienteering:
        return MaterialPageRoute(builder: (_) => const AboutOrienteeringScreen());
      case Routes.information:
        return MaterialPageRoute(builder: (_) => const InformationScreen());
      case Routes.settings:
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute(){
    return MaterialPageRoute(builder: (_){
      return Scaffold(
        appBar: AppBar(title: const Text('ERROR')),
        body: const Center(child: Text('ERROR')),
      );
    });
  }
}
