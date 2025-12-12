import 'package:referral_app/app/view/app_imports.dart';

class QuickAmountSelector extends StatelessWidget {
  const QuickAmountSelector({
    super.key,
    required this.onAmountSelected,
    required this.onMaxSelected,
    this.selectedAmount,
  });

  final Function(String) onAmountSelected;
  final VoidCallback onMaxSelected;
  final String? selectedAmount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Row(
        children: [
          _buildAmountChip(context, '10'),
          12.horizontalSpace,
          _buildAmountChip(context, '20'),
          12.horizontalSpace,
          _buildAmountChip(context, '50'),
          12.horizontalSpace,
          _buildAmountChip(context, '100'),
          12.horizontalSpace,
          _buildMaxChip(context),
        ],
      ),
    );
  }

  Widget _buildAmountChip(
    BuildContext context,
    String amount, {
    bool isHighlighted = false,
  }) {
    final isSelected = selectedAmount == amount;

    return Expanded(
      child: GestureDetector(
        onTap: () => onAmountSelected(amount),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          decoration: BoxDecoration(
            color: isHighlighted
                ? context.appColors.success
                : isSelected
                ? context.appColors.primary.withValues(alpha: 0.15)
                : context.appColors.surfaceVariant,
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(
              color: isHighlighted
                  ? context.appColors.success
                  : isSelected
                  ? context.appColors.primary
                  : context.appColors.border,
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Center(
            child: BuildText(
              text: '\$$amount',
              fontSize: 15.sp,
              fontWeight: FontWeight.w700,
              color: isHighlighted
                  ? Colors.white
                  : isSelected
                  ? context.appColors.primary
                  : context.appColors.text,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMaxChip(BuildContext context) {
    final isSelected = selectedAmount == 'max';

    return Expanded(
      child: GestureDetector(
        onTap: onMaxSelected,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          decoration: BoxDecoration(
            color: isSelected
                ? context.appColors.primary.withValues(alpha: 0.15)
                : context.appColors.surfaceVariant,
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(
              color: isSelected
                  ? context.appColors.primary
                  : context.appColors.border,
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Center(
            child: BuildText(
              text: 'Max',
              fontSize: 15.sp,
              fontWeight: FontWeight.w700,
              color: isSelected
                  ? context.appColors.primary
                  : context.appColors.text,
            ),
          ),
        ),
      ),
    );
  }
}
