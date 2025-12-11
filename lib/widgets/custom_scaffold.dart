import 'package:referral_app/app/view/app_imports.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({super.key, required this.body, this.appBar});
  final Widget body;
  final AppBar? appBar;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: context.appColors.surface,
        body: body,
        appBar: appBar,
      ),
    );
  }
}
