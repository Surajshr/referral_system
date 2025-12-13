import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:referral_app/app/view/app_imports.dart';
import 'package:referral_app/core/mixins/auth_mixin.dart';
import 'package:referral_app/feature/transaction/domain/entities/transaction_entity.dart';
import 'package:referral_app/feature/transaction/presentation/bloc/transaction_bloc.dart';
import 'package:referral_app/feature/transaction/presentation/bloc/transaction_bloc_state.dart';
import 'package:referral_app/feature/transaction/presentation/bloc/transaction_event.dart';
import 'package:referral_app/feature/transaction/presentation/cubit/transaction_cubit.dart';
import 'package:referral_app/feature/transaction/presentation/widgets/quick_amount_selector.dart';
import 'package:referral_app/core/formz/formz_exports.dart';
import 'package:referral_app/shared/data/models/transaction_model.dart';

class TransactinFormWidget extends StatelessWidget with AuthMixin {
  const TransactinFormWidget({
    super.key,
    required TextEditingController recipientController,
    required FocusNode recipientFocusNode,
    required FocusNode amountFocusNode,
    required TextEditingController amountController,
    required TextEditingController noteController,
    required FocusNode noteFocusNode,
    required TransactionState state,
    required BoxConstraints constraints,
  }) : _recipientController = recipientController,
       _recipientFocusNode = recipientFocusNode,
       _amountFocusNode = amountFocusNode,
       _amountController = amountController,
       _noteController = noteController,
       _noteFocusNode = noteFocusNode,
       state = state,
       constraints = constraints;

  final TextEditingController _recipientController;
  final FocusNode _recipientFocusNode;
  final FocusNode _amountFocusNode;
  final TextEditingController _amountController;
  final TextEditingController _noteController;
  final FocusNode _noteFocusNode;
  final TransactionState state;
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      constraints: BoxConstraints(minHeight: constraints.maxHeight - 200.h),
      decoration: BoxDecoration(
        color: context.appColors.background,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32.r),
          topRight: Radius.circular(32.r),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: BlocBuilder<TransactionCubit, TransactionState>(
        builder: (context, cubitState) {
          return BlocBuilder<TransactionBloc, TransactionBlocState>(
            builder: (context, blocState) {
              final isLoading =
                  blocState is TransactionLoading || cubitState.isLoading;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  24.verticalSpace,

                  // Recipient Field
                  AppTextField(
                    controller: _recipientController,
                    focusNode: _recipientFocusNode,
                    titleText: 'Recipient',
                    hintText: 'Recipient Email',
                    onChanged: (value) {
                      context.read<TransactionCubit>().updateRecipient(value);
                      context.read<TransactionCubit>().onEmailChanged(value);
                    },
                    keyBoardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    onSubmitted: (_) => _amountFocusNode.requestFocus(),
                    fillColor: context.appColors.surfaceVariant,
                    errorText:
                        !cubitState.email.isPure && cubitState.email.isNotValid
                        ? cubitState.email.error?.explain
                        : null,
                    suffixIcon: Icon(
                      Icons.person_outline_rounded,
                      color: context.appColors.textMuted,
                      size: 22.sp,
                    ),
                  ),

                  16.verticalSpace,

                  // Amount Field
                  AppTextField(
                    controller: _amountController,
                    focusNode: _amountFocusNode,
                    titleText: 'Amount',
                    hintText: '0.00',
                    onChanged: (value) =>
                        context.read<TransactionCubit>().updateAmount(value),
                    keyBoardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    textInputAction: TextInputAction.done,
                    fillColor: context.appColors.surfaceVariant,
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(left: 12.w),
                      child: Icon(
                        Icons.attach_money_rounded,
                        color: context.appColors.textMuted,
                        size: 22.sp,
                      ),
                    ),
                  ),

                  16.verticalSpace,

                  // Quick Amount Selector
                  QuickAmountSelector(
                    selectedAmount: cubitState.selectedQuickAmount,
                    onAmountSelected: (amount) => context
                        .read<TransactionCubit>()
                        .selectQuickAmount(amount),
                    onMaxSelected: () => context
                        .read<TransactionCubit>()
                        .setMaxAmount('1000.00'),
                  ),

                  24.verticalSpace,

                  // Add Note Button
                  if (!cubitState.showNoteField)
                    Padding(
                      padding: EdgeInsets.only(left: 12.w),
                      child: GestureDetector(
                        onTap: () =>
                            context.read<TransactionCubit>().toggleNoteField(),
                        child: Row(
                          children: [
                            Icon(
                              Icons.note_add_outlined,
                              color: context.appColors.textSecondary,
                              size: 20.sp,
                            ),
                            8.horizontalSpace,
                            BuildText(
                              text: 'Add a note',
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                              color: context.appColors.textSecondary,
                            ),
                          ],
                        ),
                      ),
                    ),

                  // Note Field
                  if (cubitState.showNoteField) ...[
                    AppTextField(
                      controller: _noteController,
                      focusNode: _noteFocusNode,
                      titleText: 'Note (Optional)',
                      hintText: 'Add a message...',
                      onChanged: (value) =>
                          context.read<TransactionCubit>().updateNote(value),
                      keyBoardType: TextInputType.multiline,
                      textInputAction: TextInputAction.done,
                      maxLines: 3,
                      fillColor: context.appColors.surfaceVariant,
                    ),
                  ],

                  32.verticalSpace,

                  // Send Button
                  _transactionSendButton(isLoading, cubitState),

                  16.verticalSpace,

                  // Security Message
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.lock_outline_rounded,
                        color: context.appColors.textMuted,
                        size: 14.sp,
                      ),
                      6.horizontalSpace,
                      BuildText(
                        text: 'Secure encrypted transaction',
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: context.appColors.textMuted,
                      ),
                    ],
                  ),

                  32.verticalSpace,
                ],
              );
            },
          );
        },
      ),
    );
  }

  Builder _transactionSendButton(bool isLoading, TransactionState cubitState) {
    return Builder(
      builder: (context) {
        final isDisabled = isLoading || !cubitState.canSubmit;
        return Container(
          width: 1.sw,
          height: 56.h,
          decoration: BoxDecoration(
            gradient: isDisabled
                ? null
                : LinearGradient(
                    colors: [
                      context.appColors.primary,
                      context.appColors.primary.withValues(alpha: 0.8),
                    ],
                  ),
            color: isDisabled ? context.appColors.surfaceVariant : null,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: isDisabled
                ? null
                : [
                    BoxShadow(
                      color: context.appColors.primary.withValues(alpha: 0.4),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
          ),
          child: ElevatedButton(
            onPressed: isDisabled
                ? null
                : () => _handleSendTransaction(context, cubitState),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              disabledBackgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
            ),
            child: isLoading
                ? CircularProgressIndicator(color: context.appColors.text)
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BuildText(
                        text: 'Send & Claim Reward',
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: isDisabled
                            ? context.appColors.textMuted
                            : Colors.white,
                      ),
                      12.horizontalSpace,
                      Icon(
                        Icons.arrow_forward_rounded,
                        color: isDisabled
                            ? context.appColors.textMuted
                            : Colors.white,
                        size: 20.sp,
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }

  Future<void> _handleSendTransaction(
    BuildContext context,
    TransactionState cubitState,
  ) async {
    final cubit = context.read<TransactionCubit>();

    // Validation
    if (cubitState.recipient.isEmpty) {
      cubit.updateRecipient('');

      return;
    }

    final amount = double.tryParse(cubitState.amount);
    if (amount == null || amount <= 0) {
      return;
    }

    // Get current user
    final currentUser = await getCurrentAuthUser();
    if (currentUser == null) {
      return;
    }

    // Create transaction entity
    final transactionEntity = TransactionEntity(
      userId: currentUser.id,
      amount: amount,
      type: TransactionType.withdrawal,
      referralId: null,
      description: cubitState.note.isEmpty ? null : cubitState.note,
      transactionToUserEmail: cubitState.recipient.trim(),
    );

    // Dispatch event
    context.read<TransactionBloc>().add(
      TransactionSendRequested(transactionEntity: transactionEntity),
    );
  }
}
