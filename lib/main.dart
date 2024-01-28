import 'package:flutter/material.dart';
import 'package:gp_calculator/gp_view_model.dart';
import 'package:gp_calculator/model/full_report.dart';
import 'package:gp_calculator/model/gp_report.dart';
import 'package:gp_calculator/screens/calc_options_screen.dart';
import 'package:gp_calculator/screens/cgpa_home_screen.dart';
import 'package:gp_calculator/screens/cgpa_list_screen.dart';
import 'package:gp_calculator/screens/full_report_screen.dart';
import 'package:gp_calculator/screens/get_started_screen.dart';
import 'package:gp_calculator/screens/gp_report_screen.dart';
import 'package:gp_calculator/screens/grade_input_screen.dart';
import 'package:gp_calculator/utilities/constants.dart';
import 'package:gp_calculator/utilities/navigation_utils.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'cgpa_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox(kAppBoxName);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GpViewModel()),
        ChangeNotifierProvider(create: (_) => CGPAViewModel()),
      ],
      child: MaterialApp(
        title: 'GP Calculator',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
          useMaterial3: true,
        ),
        initialRoute: NavigationUtils.initial,
        routes: {
          NavigationUtils.initial: (context) => const GetStartedScreen(),
          NavigationUtils.options: (context) => const CalcOptionsScreen(),
          NavigationUtils.cgpaList: (context) => const CGPAListScreen(),
          NavigationUtils.oneSemesterInput: (context) => const GradeInputScreen(
                calculationOption: CalculationOption.oneSemester,
              ),
          NavigationUtils.cgpaInput: (context) => const GradeInputScreen(
                calculationOption: CalculationOption.cumulative,
              ),
          NavigationUtils.editSemester: (context) => const GradeInputScreen(
            calculationOption: CalculationOption.editSemester,
          ),
          NavigationUtils.cgpaHome: (context) => const CGPAHomeScreen(),
          NavigationUtils.gpReport: (context) => GpReportScreen(
                report: ModalRoute.of(context)?.settings.arguments as GpReport,
              ),
          NavigationUtils.fullReport: (context) => FullReportScreen(
            fullReport: ModalRoute.of(context)?.settings.arguments as FullReport,
          ),

        },
      ),
    );
  }
}
