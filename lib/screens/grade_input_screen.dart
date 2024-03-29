import 'package:flutter/material.dart';
import 'package:gp_calculator/gp_view_model.dart';
import 'package:gp_calculator/model/course.dart';
import 'package:gp_calculator/utilities/constants.dart';
import 'package:gp_calculator/utilities/navigation_utils.dart';
import 'package:gp_calculator/utilities/validators.dart';
import 'package:gp_calculator/widgets/dropdown_card.dart';
import 'package:gp_calculator/widgets/dropdown_card_no_edit.dart';
import 'package:provider/provider.dart';

enum CalculationOption {
  oneSemester,
  cumulative,
  editSemester,
}

class GradeInputScreen extends StatefulWidget {
  final CalculationOption calculationOption;

  const GradeInputScreen({
    super.key,
    required this.calculationOption,
  });

  @override
  State<GradeInputScreen> createState() => _GradeInputScreenState();
}

class _GradeInputScreenState extends State<GradeInputScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (widget.calculationOption != CalculationOption.editSemester) {
      Provider.of<GpViewModel>(context, listen: false).reset();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GpViewModel>(context, listen: false);
    final courses = provider.courses;

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Enter Course Details',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: widget.calculationOption ==
                            CalculationOption.editSemester
                        ? DropdownCardNoEdit(
                            title: 'Session',
                            selectedOption: provider.session!,
                          )
                        : DropdownCard(
                            title: 'Session',
                            dropdownList: List.generate(
                              40,
                              (index) => '${index + 2010}/${index + 2011}',
                            ),
                            onSelect: (value) {
                              Provider.of<GpViewModel>(
                                context,
                                listen: false,
                              ).session = value;
                            },
                            selectedOption: provider.session,
                          ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: widget.calculationOption ==
                            CalculationOption.editSemester
                        ? DropdownCardNoEdit(
                            title: 'Semester',
                            selectedOption: provider.semester!,
                          )
                        : DropdownCard(
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
              const SizedBox(height: 16),
              const Row(
                children: [
                  Expanded(
                    child: Text(
                      'Course',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Units',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Grade',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
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
                    icon: const Icon(
                      Icons.remove,
                      size: 32,
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => validateInputs(context, provider),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimaryColor,
                        foregroundColor: Colors.white,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text('Calculate GP'),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        courses.add(Course());
                      });
                    },
                    icon: const Icon(
                      Icons.add,
                      size: 32,
                    ),
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
        if (widget.calculationOption == CalculationOption.oneSemester) {
          final gpReport = provider.getGpReport();

          NavigationUtils.goToGpReport(context, gpReport);
        } else {
          final fullReport = provider.getFullReport();

          NavigationUtils.goToFullReport(context, fullReport);
        }
      }
    } else {
      final snackBar = SnackBar(
        content: Text(headerValidatorMessage),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
