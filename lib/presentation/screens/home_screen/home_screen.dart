import 'package:accountant_pro/presentation/widgets/base_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(body: buildBody(context));
  }

  Widget buildBody(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverList(
            delegate: SliverChildListDelegate([
          Text("ToDos"),
        ]))
      ],
    );
  }
}
