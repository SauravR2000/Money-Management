import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:money_management_app/core/storage/secure_local_storage.dart';
import 'package:money_management_app/features/dashboard/presentation/Dashboard%20Screens/Budget%20Screen/bloc/budget_bloc.dart';
import 'package:money_management_app/features/transaction/cubit/drop_down/drop_down_cubit_cubit.dart';
import 'package:money_management_app/injection/injection_container.dart';
import 'package:money_management_app/shared_widgets/amount_textfield.dart';
import 'package:money_management_app/shared_widgets/dropdown_category.dart';
import 'package:money_management_app/shared_widgets/gap_widget.dart';
import 'package:money_management_app/shared_widgets/unfocus_screen_widget.dart';
import 'package:money_management_app/utils/constants/strings.dart';

// List<Map<String, dynamic>> budgetList = <Map<String, dynamic>>[];

@RoutePage()
class BudgetScreen extends StatefulWidget {
  final String month;
  const BudgetScreen({
    super.key,
    required this.month,
  });

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  bool _lights = false;

  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  late List<String> _budgetcategory;
  late BudgetBloc _budgetBloc;
  late DropDownCubit _budgetCategoryDropDownCubit;

  initializeBudgetCategories() {
    _budgetcategory = [
      "Food & Dining",
      "Transportation",
      "Housing",
      "Utilities",
      "Insurance",
      "Healthcare",
      "Debt Payments",
      "Entertainment",
      "Education",
      "Groceries",
      "Clothing",
      "Personal Care",
      "Savings",
      "Gifts & Donations",
      "Travel",
      "Fitness",
      "Subscriptions",
      "Childcare",
      "Miscellaneous"
    ];
  }

  @override
  void initState() {
    _budgetCategoryDropDownCubit = getIt<DropDownCubit>();
    _budgetBloc = BudgetBloc();
    initializeBudgetCategories();
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Budget",
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                color: Colors.white,
              ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: UnfocusScreenWidget(
        child: Column(
          children: [
            gap(value: 300),
            enterAmount(context, _amountController),
            // enterAmount(context),
            gap(value: 16),
            budgetDetail(),
          ],
        ),
      ),
    );
  }

  Widget budgetDetail() {
    return BlocConsumer<BudgetBloc, BudgetState>(
      bloc: _budgetBloc,
      listener: (context, state) {
        _amountController.text = "";
        _budgetCategoryDropDownCubit.value = null;
      },
      builder: (context, state) {
        return Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(35),
                topRight: Radius.circular(35),
              ),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
                child: Column(
                  children: [
                    categoryDropdown(
                      bloc: _budgetCategoryDropDownCubit,
                      dropdownValues: _budgetcategory,
                      hintText: AppStrings.category,
                    ),
                    gap(value: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Receive Alert',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(fontWeight: FontWeight.w600),
                            ),
                            gap(value: 7),
                            Text(
                              'Receive alert when it reaches \nto 80%',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: Colors.grey,
                                  ),
                            ),
                          ],
                        ),
                        // gap(value: 20),
                        CupertinoSwitch(
                          value: _lights,
                          activeColor: Theme.of(context).primaryColor,
                          onChanged: (value) {
                            setState(() {
                              _lights = value;
                            });
                          },
                        )
                      ],
                    ),
                    gap(value: 80),
                    SizedBox(
                      height: 56,
                      width: 343,
                      child: BlocConsumer<BudgetBloc, BudgetState>(
                        bloc: _budgetBloc,
                        listener: (context, state) {
                          if (state is PostDataState) {
                            Fluttertoast.showToast(
                              msg: 'Budget Added',
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );
                          }
                          if (state is ErrorState) {
                            if (state is PostDataState) {
                              Fluttertoast.showToast(
                                msg: 'Error',
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                fontSize: 16.0,
                              );
                            }
                          }
                        },
                        builder: (context, state) {
                          return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {
                              _budgetBloc.add(
                                PostDataEvent(
                                  month: widget.month,
                                  amount: int.parse(_amountController.text),
                                  category:
                                      _budgetCategoryDropDownCubit.value ?? '',
                                  userId: _budgetBloc.getUserId(),
                                  notification: _lights,
                                ),
                              );
                            },
                            child: Text('Continue'),
                          );
                        },
                      ),
                    ),
                    // gap(value: 50)
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
