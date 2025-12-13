import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:referral_app/app/view/app_imports.dart';
import 'package:referral_app/feature/transaction/presentation/bloc/transaction_bloc.dart';
import 'package:referral_app/feature/transaction/presentation/bloc/transaction_bloc_state.dart';
import 'package:referral_app/feature/transaction/presentation/cubit/transaction_cubit.dart';
import 'package:referral_app/feature/transaction/presentation/widgets/transaction_form_widget.dart';
import 'package:referral_app/feature/transaction/presentation/widgets/transaction_header.dart';
import 'package:referral_app/widgets/app_snackbar.dart';

class TransactionBaseView extends StatelessWidget {
  const TransactionBaseView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => TransactionCubit()),
        BlocProvider(create: (context) => TransactionBloc()),
      ],
      child: const _TransactionContent(),
    );
  }
}

class _TransactionContent extends StatefulWidget {
  const _TransactionContent();

  @override
  State<_TransactionContent> createState() => _TransactionContentState();
}

class _TransactionContentState extends State<_TransactionContent> {
  final TextEditingController _recipientEmailController =
      TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final FocusNode _recipientEmailFocusNode = FocusNode();
  final FocusNode _amountFocusNode = FocusNode();
  final FocusNode _noteFocusNode = FocusNode();

  @override
  void dispose() {
    _recipientEmailController.dispose();
    _amountController.dispose();
    _noteController.dispose();
    _recipientEmailFocusNode.dispose();
    _amountFocusNode.dispose();
    _noteFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TransactionBloc, TransactionBlocState>(
      listener: (context, blocState) {
        if (blocState is TransactionFailure) {
          AppSnackbar.showError(context, blocState.exception.message);
        } else if (blocState is TransactionSuccess) {
          AppSnackbar.showSuccess(
            context,
            'Transaction successful! Reward unlocked! 🎉',
          );
          Future.delayed(const Duration(milliseconds: 500), () {
            if (context.mounted) {
              context.pop();
            }
          });
        }
      },
      child: BlocConsumer<TransactionCubit, TransactionState>(
        listener: (context, cubitState) {
          // Show error messages from cubit
          if (cubitState.errorMessage != null) {
            AppSnackbar.showError(context, cubitState.errorMessage!);
            context.read<TransactionCubit>().clearMessages();
          }

          // Show success message from cubit
          if (cubitState.successMessage != null) {
            AppSnackbar.showSuccess(context, cubitState.successMessage!);
            context.read<TransactionCubit>().clearMessages();
          }
        },
        builder: (context, cubitState) {
          // Sync controllers with state when needed
          if (_recipientEmailController.text != cubitState.recipient &&
              _recipientEmailController.text.isEmpty) {
            _recipientEmailController.text = cubitState.recipient;
          }
          if (_amountController.text != cubitState.amount &&
              cubitState.selectedQuickAmount.isNotEmpty) {
            _amountController.text = cubitState.amount;
          }
          if (_noteController.text != cubitState.note &&
              _noteController.text.isEmpty) {
            _noteController.text = cubitState.note;
          }

          return CustomScaffold(
            body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF0D5E3A),
                    const Color(0xFF1A7A4C),
                    context.appColors.primary,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                children: [
                  // Fixed Top Section - Back button and Title
                  SafeArea(
                    bottom: false,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Column(
                        children: [
                          20.verticalSpace,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () => context.pop(),
                                child: Container(
                                  padding: EdgeInsets.all(12.r),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.15),
                                    borderRadius: BorderRadius.circular(360.r),
                                  ),
                                  child: Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                    size: 20.sp,
                                  ),
                                ),
                              ),
                              BuildText(
                                text: 'Make First Transaction',
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                              SizedBox(width: 48.w),
                            ],
                          ),
                          16.verticalSpace,
                        ],
                      ),
                    ),
                  ),

                  // Scrollable Section
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              // Transaction Header with gradient background
                              const TransactionHeader(),
                              24.verticalSpace,

                              // Form Section with app background
                              TransactinFormWidget(
                                recipientController: _recipientEmailController,
                                recipientFocusNode: _recipientEmailFocusNode,
                                amountFocusNode: _amountFocusNode,
                                amountController: _amountController,
                                noteController: _noteController,
                                noteFocusNode: _noteFocusNode,
                                state: cubitState,
                                constraints: constraints,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
