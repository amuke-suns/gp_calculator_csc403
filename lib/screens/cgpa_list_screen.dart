import 'package:flutter/material.dart';
import 'package:gp_calculator/cgpa_view_model.dart';
import 'package:gp_calculator/gp_view_model.dart';
import 'package:gp_calculator/model/full_report.dart';
import 'package:gp_calculator/screens/calc_options_screen.dart';
import 'package:gp_calculator/utilities/constants.dart';
import 'package:gp_calculator/utilities/navigation_utils.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class CGPAListScreen extends StatelessWidget {
  const CGPAListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final box = Hive.box(kAppBoxName);

    List<FullReport> reports =
        box.values.map((json) => FullReport.fromJson(json)).toList();

    if (reports.isEmpty) {
      return const Scaffold(
        body: Center(
          child: Text('No records yet!'),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Existing Records'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.separated(
            itemCount: reports.length,
            separatorBuilder: (context, index) {
              return const SizedBox(height: 10);
            },
            itemBuilder: (context, index) {
              FullReport report = reports[index];

              return ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                title: Text(
                  '${report.session} ${report.semester} Semester',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                subtitle: Text(
                  '${report.level} Level\nTotal Units: ${report.totalUnits}',
                ),
                leading: CircleAvatar(
                  backgroundColor: kPrimaryColor,
                  child: Text(
                    report.gpa,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 1),
                  borderRadius: BorderRadius.circular(20),
                ),
                trailing: PopupMenuButton(
                  child: const Icon(Icons.more_vert),
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        child: const Text('Edit'),
                        onTap: () async {
                          Provider.of<GpViewModel>(context, listen: false).setForEdit(report);

                          // this ensures that the menu is popped
                          // before pushing new route
                          await Future.delayed(Duration.zero);
                          if (context.mounted) {
                            NavigationUtils.goToNamed(context, NavigationUtils.editSemester);
                          }
                        },
                      ),
                      PopupMenuItem(
                        child: const Text('Delete'),
                        onTap: () async {
                          Provider.of<CGPAViewModel>(context, listen: false).delete(report);

                          // this ensures that the menu is popped
                          // before pushing new route
                          await Future.delayed(Duration.zero);
                          if (context.mounted) {
                            NavigationUtils.goBackToCGPAHome(context);
                          }
                        },
                      )
                    ];
                  },
                ),
              );
            },
          ),
        ),
      );
    }
  }
}
