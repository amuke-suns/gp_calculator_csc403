import 'package:flutter/material.dart';
import 'package:gp_calculator/gp_report_screen.dart';
import 'package:gp_calculator/gp_view_model.dart';
import 'package:gp_calculator/model/course.dart';
import 'package:gp_calculator/utilities/constants.dart';
import 'package:gp_calculator/utilities/validators.dart';
import 'package:gp_calculator/widgets/dropdown_card.dart';
import 'package:provider/provider.dart';

class OneSemesterScreen extends StatefulWidget {
  const OneSemesterScreen({super.key});

  @override
  State<OneSemesterScreen> createState() => _OneSemesterScreenState();
}

class _OneSemesterScreenState extends State<OneSemesterScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    Provider.of<GpViewModel>(context, listen: false).init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GpViewModel>(context, listen: false);
    final courses = provider.courses;

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: DropdownCard(
                      title: 'Session',
                      dropdownList: List.generate(
                        40,
                        (index) => '${index + 2010}/${index + 2011}',
                      ),
                      onSelect: (value) {
                        Provider.of<GpViewModel>(context, listen: false)
                            .session = value;
                      },
                      selectedOption: provider.session,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: DropdownCard(
                      title: 'Semester',
                      dropdownList: const ['Harmattan', 'Rain'],
                      onSelect: (value) {
                        Provider.of<GpViewModel>(context, listen: false)
                            .semester = value;
                      },
                      selectedOption: provider.semester,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: DropdownCard(
                      title: 'Total Units',
                      dropdownList: List.generate(
                        24,
                        (index) => '${index + 1}',
                      ),
                      onSelect: (value) {
                        Provider.of<GpViewModel>(context, listen: false)
                            .totalUnits = value;
                      },
                      selectedOption: provider.totalUnits,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: DropdownCard(
                      title: 'Level',
                      dropdownList: List.generate(
                        8,
                        (index) => '${(index + 1) * 100}',
                      ),
                      onSelect: (value) {
                        Provider.of<GpViewModel>(context, listen: false).level =
                            value;
                      },
                      selectedOption: provider.level,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Row(
                children: [
                  Expanded(child: Text('Course')),
                  Expanded(child: Text('Units')),
                  Expanded(child: Text('Grade')),
                ],
              ),
              Expanded(
                child: Form(
                  key: _formKey,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: courses.length,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              initialValue: courses[index].name,
                              validator: Validators.validateCourseName,
                              onChanged: (value) {
                                courses[index].name = value;
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: DropdownButtonFormField<int>(
                              hint: const Text('None'),
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.zero,
                              ),
                              validator: Validators.validateUnit,
                              value: courses[index].units,
                              onChanged: (int? newValue) {
                                courses[index].units = newValue;
                              },
                              items: [
                                for (var i = 1; i <= 15; i++) ...[
                                  DropdownMenuItem<int>(
                                    value: i,
                                    child: Text(i.toString()),
                                  )
                                ]
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              hint: const Text('None'),
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.zero,
                              ),
                              validator: Validators.validateGrade,
                              value: courses[index].grade,
                              onChanged: (String? newValue) {
                                courses[index].grade = newValue!;
                              },
                              items: ['A', 'B', 'C', 'D', 'E', 'F']
                                  .map(
                                    (grade) => DropdownMenuItem<String>(
                                      value: grade,
                                      child: Text(grade),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        courses.removeLast();
                      });
                    },
                    icon: const Icon(Icons.remove),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => validateInputs(context, provider),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimaryColor,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Calculate GP'),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        courses.add(Course());
                      });
                    },
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void validateInputs(BuildContext context, GpViewModel provider) {
    String? headerValidatorMessage = provider.validateHeaders();

    if (headerValidatorMessage == null) {
      final form = _formKey.currentState!;

      if (form.validate()) {
        final gpReport = provider.calculateGP();

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => GpReportScreen(report: gpReport),
          ),
        );
      }
    } else {
      final snackBar = SnackBar(
        content: Text(headerValidatorMessage),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
