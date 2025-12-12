import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:referral_app/app/cubit/theme_cubit.dart';
import 'package:referral_app/app/view/app_imports.dart';

class AppTopSectionWidget extends StatelessWidget {
  const AppTopSectionWidget({
    super.key,
    this.showBackButton = true,
    this.prefix,
    this.title,
  });
  final bool showBackButton;
  final Widget? prefix;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        showBackButton
            ? GestureDetector(
                onTap: () {
                  context.pop();
                },
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: EdgeInsets.all(12.r),
                    decoration: BoxDecoration(
                      color: context.appColors.surfaceVariant,
                      borderRadius: BorderRadius.circular(360.r),
                    ),
                    child: Icon(Icons.arrow_back),
                  ),
                ),
              )
            : prefix ?? SizedBox.shrink(),
        title != null
            ? BuildText(
                text: title!,
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                color: context.appColors.text,
              )
            : SizedBox.shrink(),
        BlocBuilder<ThemeCubit, ThemeMode>(
          builder: (context, themeMode) {
            IconData icon;
            String tooltip;

            switch (themeMode) {
              case ThemeMode.light:
                icon = Icons.light_mode;
                tooltip = 'Light Mode';
              case ThemeMode.dark:
                icon = Icons.dark_mode;
                tooltip = 'Dark Mode';
              case ThemeMode.system:
                icon = Icons.brightness_auto;
                tooltip = 'System Mode';
            }

            return IconButton(
              icon: Icon(icon),
              tooltip: tooltip,
              onPressed: () => context.read<ThemeCubit>().toggleTheme(),
            );
          },
        ),
      ],
    );
  }
}
