import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_randomnizer/randomnize.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  void takeValues() {
    if (_formKey.currentState!.saveAndValidate()) {
      final data = _formKey.currentState!.value;
      int? min = int.tryParse(data['min']);
      int? max = int.tryParse(data['max']);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Randomnize(minn: min, maxx: max),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        title: const Text(
          'RandomNizer',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(10),
            width: double.infinity,
            height: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
            ),
            child: FormBuilder(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FormBuilderTextField(
                    name: 'min',
                    decoration: InputDecoration(
                      label: const Text('min'),
                      labelStyle: const TextStyle(color: Colors.black),
                      filled: true,
                      fillColor: const Color.fromARGB(255, 211, 209, 209),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required<String>(
                          errorText: 'The min value is required'),
                      FormBuilderValidators.numeric(
                          errorText: 'The min value must be a number'),
                      (val) {
                        final max = _formKey.currentState?.fields['max']?.value;
                        if (max != null && !RegExp(r'^\d+$').hasMatch(max)) {
                          return 'The value must be an integer';
                        }
                        return null;
                      }
                    ]),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FormBuilderTextField(
                    name: 'max',
                    decoration: InputDecoration(
                      label: const Text('max'),
                      filled: true,
                      fillColor: const Color.fromARGB(255, 211, 209, 209),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: FormBuilderValidators.compose(
                      [
                        FormBuilderValidators.required(
                            errorText: 'The max value is required'),
                        FormBuilderValidators.numeric(
                            errorText: 'Max value must be a number'),
                        (val) {
                          final min =
                              _formKey.currentState?.fields['min']?.value;
                          if (min != null && val != null) {
                            final minValue = double.tryParse(min);
                            final maxValue = double.tryParse(val);
                            if (minValue != null &&
                                maxValue != null &&
                                minValue >= maxValue) {
                              return 'The max value must be greater than the min value';
                            }
                          }
                          return null;
                        },
                        (val) {
                          final min =
                              _formKey.currentState?.fields['min']?.value;
                          if (min != null && !RegExp(r'^\d+$').hasMatch(min)) {
                            return 'The value must be an integer';
                          }
                          return null;
                        }
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextButton(
                    onPressed: takeValues,
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: const Text(
                      'Randomnize',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
