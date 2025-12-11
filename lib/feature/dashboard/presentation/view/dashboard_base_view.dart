import 'package:referral_app/app/view/app_imports.dart';

class DashboardBaseScreen extends StatefulWidget {
  const DashboardBaseScreen({super.key});

  @override
  State<DashboardBaseScreen> createState() => _DashboardBaseScreenState();
}

class _DashboardBaseScreenState extends State<DashboardBaseScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Text('Dashboard'));
  }
}
