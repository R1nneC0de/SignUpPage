import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Signup Page',
      localizationsDelegates: const [FormBuilderLocalizations.delegate],
      theme: ThemeData(useMaterial3: true),
      home: const SignupPage(),
    );
  }
}

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Signup Form')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FormBuilder(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  children: [
                    buildElevatedField(
                      key: const ValueKey('first_name'),
                      name: 'first_name',
                      label: 'First',
                      validator: FormBuilderValidators.required(),
                    ),
                    buildElevatedField(
                      key: const ValueKey('last_name'),
                      name: 'last_name',
                      label: 'Last',
                      validator: FormBuilderValidators.required(),
                    ),
                    buildElevatedField(
                      key: const ValueKey('email'),
                      name: 'email',
                      label: 'Email',
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.email(),
                      ]),
                    ),
                    buildElevatedField(
                      key: const ValueKey('contact'),
                      name: 'contact',
                      label: 'Contact No.',
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.numeric(),
                        FormBuilderValidators.equalLength(10),
                      ]),
                    ),
                    buildElevatedDateField(
                      key: const ValueKey('dob'),
                      name: 'dob',
                      label: 'Date of Birth',
                    ),
                    buildElevatedField(
                      key: const ValueKey('aadhar'),
                      name: 'aadhar',
                      label: 'Aadhar No.',
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(),
                        FormBuilderValidators.numeric(),
                        FormBuilderValidators.equalLength(12),
                      ]),
                    ),
                    buildElevatedField(
                      key: const ValueKey('address'),
                      name: 'address',
                      label: 'Address',
                      isFullWidth: true,
                      validator: FormBuilderValidators.required(),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.saveAndValidate() ?? false) {
                      final formData = _formKey.currentState!.value;
                      print('Form Data: $formData');
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Form submitted successfully!'),
                        ),
                      );
                    } else {
                      print("Validation failed");
                    }
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildElevatedField({
    required Key key,
    required String name,
    required String label,
    required String? Function(String?) validator,
    bool isFullWidth = false,
  }) {
    return SizedBox(
      width:
          isFullWidth
              ? MediaQuery.of(context).size.width - 32
              : MediaQuery.of(context).size.width * 0.42,
      child: Material(
        elevation: 3,
        shadowColor: Colors.black26,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: FormBuilderTextField(
            key: key,
            name: name,
            decoration: InputDecoration(
              labelText: label,
              border: InputBorder.none,
            ),
            validator: validator,
          ),
        ),
      ),
    );
  }

  Widget buildElevatedDateField({
    required Key key,
    required String name,
    required String label,
  }) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.42,
      child: Material(
        elevation: 3,
        shadowColor: Colors.black26,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: FormBuilderDateTimePicker(
            key: key,
            name: name,
            inputType: InputType.date,
            decoration: InputDecoration(
              labelText: label,
              border: InputBorder.none,
            ),
            validator: FormBuilderValidators.required(),
          ),
        ),
      ),
    );
  }
}
