import 'package:super_do/presentation/widgets/base_screen.dart';
import 'package:flutter/cupertino.dart';

class ShowErrorScreen extends StatelessWidget {
  const ShowErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      body: const Center(
        child: Text("There was an error"),
      ),
    );
  }
}
