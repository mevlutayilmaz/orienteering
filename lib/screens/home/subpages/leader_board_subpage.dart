import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../model/statistic/statistic_model.dart';
import '../../../model/user/user_model.dart';
import '../../../services/statistic/statistic_services.dart';
import '../../../services/user/auth_services.dart';

class LeaderBoardSubpage extends StatefulWidget {
  const LeaderBoardSubpage({super.key});

  @override
  State<LeaderBoardSubpage> createState() => _LeaderBoardSubpageState();
}

class _LeaderBoardSubpageState extends State<LeaderBoardSubpage> {
  UserModel? _user;
  final auth = FirebaseAuth.instance;
  List<StatisticModel> _statisticList = [];

  @override
  void initState() {
    _init();
    super.initState();
  }

  Future<void> _init() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _user = await AuthService().getUserByEmail(auth.currentUser!.email.toString());
      _statisticList = await StatisticServices().getStatisticByUserName(_user!.name!);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: _statisticList.length,
      itemBuilder: (context, index) => _buildListTile(_statisticList[index], index),
    );
  }

  Widget _buildListTile(StatisticModel model, int index){
    String indexx = index < 9 ? '0${index+1}' : '${index+1}';  
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        leading: Text(indexx, style: Theme.of(context).textTheme.headlineSmall),
        title: Text(model.userName!),
        subtitle: Text('${model.gameTitle} (${model.gameType})', maxLines: 1, overflow: TextOverflow.ellipsis),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(model.elapsedTime!),
            Text(model.date!),
          ],
        ),

      ),
    );
  }
}
