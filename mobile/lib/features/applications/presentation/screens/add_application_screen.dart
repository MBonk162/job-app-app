import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/date_utils.dart';
import '../../data/models/application_model.dart';
import '../../data/repositories/application_repository_provider.dart';
import '../../domain/entities/application_entity.dart';

/// Screen for adding a new job application
/// Organized into 6 sections matching the web app structure
class AddApplicationScreen extends ConsumerStatefulWidget {
  const AddApplicationScreen({super.key});

  @override
  ConsumerState<AddApplicationScreen> createState() => _AddApplicationScreenState();
}

class _AddApplicationScreenState extends ConsumerState<AddApplicationScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool _isSubmitting = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Application'),
        actions: [
          TextButton(
            onPressed: _isSubmitting ? null : _submitForm,
            child: _isSubmitting
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('SAVE'),
          ),
        ],
      ),
      body: FormBuilder(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Section 1: Basic Information
            _buildSectionHeader('Basic Information', Icons.business),
            const SizedBox(height: 16),
            FormBuilderDateTimePicker(
              name: 'date_applied',
              initialValue: DateTime.now(),
              inputType: InputType.date,
              decoration: const InputDecoration(
                labelText: 'Date Applied *',
                hintText: 'Select date',
                prefixIcon: Icon(Icons.calendar_today),
              ),
              validator: FormBuilderValidators.required(),
            ),
            const SizedBox(height: 16),
            FormBuilderTextField(
              name: 'company',
              decoration: const InputDecoration(
                labelText: 'Company *',
                hintText: 'Enter company name',
                prefixIcon: Icon(Icons.business),
              ),
              validator: FormBuilderValidators.required(),
            ),
            const SizedBox(height: 16),
            FormBuilderTextField(
              name: 'role_title',
              decoration: const InputDecoration(
                labelText: 'Role Title *',
                hintText: 'Enter job title',
                prefixIcon: Icon(Icons.work),
              ),
              validator: FormBuilderValidators.required(),
            ),
            const SizedBox(height: 16),
            FormBuilderDropdown<String>(
              name: 'status',
              initialValue: 'Applied',
              decoration: const InputDecoration(
                labelText: 'Status',
                prefixIcon: Icon(Icons.check_circle),
              ),
              items: AppConstants.applicationStatuses
                  .map((status) => DropdownMenuItem(
                        value: status,
                        child: Text(status),
                      ))
                  .toList(),
            ),

            // Section 2: Application Details
            const SizedBox(height: 32),
            _buildSectionHeader('Application Details', Icons.description),
            const SizedBox(height: 16),
            FormBuilderDropdown<String>(
              name: 'source',
              initialValue: AppConstants.defaultSource,
              decoration: const InputDecoration(
                labelText: 'Source',
                prefixIcon: Icon(Icons.source),
              ),
              items: AppConstants.sources
                  .map((source) => DropdownMenuItem(
                        value: source,
                        child: Text(source),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 16),
            FormBuilderDropdown<String>(
              name: 'application_method',
              initialValue: AppConstants.defaultApplicationMethod,
              decoration: const InputDecoration(
                labelText: 'Application Method',
                prefixIcon: Icon(Icons.send),
              ),
              items: AppConstants.applicationMethods
                  .map((method) => DropdownMenuItem(
                        value: method,
                        child: Text(method),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 16),
            FormBuilderTextField(
              name: 'location',
              decoration: const InputDecoration(
                labelText: 'Location',
                hintText: 'Remote, City, etc.',
                prefixIcon: Icon(Icons.location_on),
              ),
            ),
            const SizedBox(height: 16),
            FormBuilderDropdown<String>(
              name: 'company_size',
              decoration: const InputDecoration(
                labelText: 'Company Size',
                prefixIcon: Icon(Icons.people),
              ),
              items: AppConstants.companySizes
                  .map((size) => DropdownMenuItem(
                        value: size,
                        child: Text(size),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 16),
            FormBuilderTextField(
              name: 'role_type',
              decoration: const InputDecoration(
                labelText: 'Role Type',
                hintText: 'Full-Stack, Backend, etc.',
                prefixIcon: Icon(Icons.category),
              ),
            ),
            const SizedBox(height: 16),
            FormBuilderTextField(
              name: 'tech_stack',
              decoration: const InputDecoration(
                labelText: 'Tech Stack',
                hintText: 'React, Node.js, etc.',
                prefixIcon: Icon(Icons.code),
              ),
              maxLines: 2,
            ),

            // Section 3: Compensation
            const SizedBox(height: 32),
            _buildSectionHeader('Compensation', Icons.attach_money),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: FormBuilderTextField(
                    name: 'salary_min',
                    decoration: const InputDecoration(
                      labelText: 'Min Salary',
                      hintText: '100000',
                      prefixIcon: Icon(Icons.money),
                    ),
                    keyboardType: TextInputType.number,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.integer(),
                      FormBuilderValidators.min(0),
                    ]),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: FormBuilderTextField(
                    name: 'salary_max',
                    decoration: const InputDecoration(
                      labelText: 'Max Salary',
                      hintText: '150000',
                      prefixIcon: Icon(Icons.money),
                    ),
                    keyboardType: TextInputType.number,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.integer(),
                      FormBuilderValidators.min(0),
                    ]),
                  ),
                ),
              ],
            ),

            // Section 4: Metadata
            const SizedBox(height: 32),
            _buildSectionHeader('Application Metadata', Icons.info),
            const SizedBox(height: 16),
            FormBuilderSwitch(
              name: 'customized',
              title: const Text('Customized Cover Letter'),
              initialValue: false,
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
            ),
            FormBuilderSwitch(
              name: 'referral',
              title: const Text('Had Referral'),
              initialValue: false,
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
            ),
            const SizedBox(height: 16),
            FormBuilderSlider(
              name: 'confidence_match',
              initialValue: AppConstants.defaultConfidenceMatch.toDouble(),
              min: 1,
              max: 5,
              divisions: 4,
              decoration: const InputDecoration(
                labelText: 'Confidence Match (1-5)',
                prefixIcon: Icon(Icons.star),
              ),
              displayValues: DisplayValues.current,
            ),

            // Section 5: Response Tracking
            const SizedBox(height: 32),
            _buildSectionHeader('Response Tracking', Icons.reply),
            const SizedBox(height: 16),
            FormBuilderDateTimePicker(
              name: 'response_date',
              inputType: InputType.date,
              decoration: const InputDecoration(
                labelText: 'Response Date',
                hintText: 'Select date',
                prefixIcon: Icon(Icons.calendar_today),
              ),
            ),
            const SizedBox(height: 16),
            FormBuilderDropdown<String>(
              name: 'response_type',
              decoration: const InputDecoration(
                labelText: 'Response Type',
                prefixIcon: Icon(Icons.message),
              ),
              items: AppConstants.responseTypes
                  .map((type) => DropdownMenuItem(
                        value: type,
                        child: Text(type),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 16),
            FormBuilderDateTimePicker(
              name: 'interview_date',
              inputType: InputType.date,
              decoration: const InputDecoration(
                labelText: 'Interview Date',
                hintText: 'Select date',
                prefixIcon: Icon(Icons.calendar_today),
              ),
            ),

            // Section 6: Notes
            const SizedBox(height: 32),
            _buildSectionHeader('Notes', Icons.note),
            const SizedBox(height: 16),
            FormBuilderTextField(
              name: 'notes',
              decoration: const InputDecoration(
                labelText: 'Additional Notes',
                hintText: 'Any other details...',
                prefixIcon: Icon(Icons.notes),
                alignLabelWithHint: true,
              ),
              maxLines: 5,
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: Theme.of(context).colorScheme.primary),
        const SizedBox(width: 8),
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      setState(() => _isSubmitting = true);

      try {
        final formData = _formKey.currentState!.value;

        // Create application entity
        final application = ApplicationEntityFactory.create(
          company: formData['company'] as String,
          roleTitle: formData['role_title'] as String,
          dateApplied: formData['date_applied'] as DateTime?,
          status: ApplicationStatus.fromString(formData['status'] as String),
          source: formData['source'] as String?,
          applicationMethod: formData['application_method'] as String?,
          location: formData['location'] as String? ?? '',
          companySize: formData['company_size'] as String? ?? '',
          roleType: formData['role_type'] as String? ?? '',
          techStack: formData['tech_stack'] as String? ?? '',
          salaryMin: formData['salary_min'] != null
              ? int.tryParse(formData['salary_min'].toString())
              : null,
          salaryMax: formData['salary_max'] != null
              ? int.tryParse(formData['salary_max'].toString())
              : null,
          customized: formData['customized'] as bool? ?? false,
          referral: formData['referral'] as bool? ?? false,
          confidenceMatch: (formData['confidence_match'] as double?)?.toInt(),
          responseDate: formData['response_date'] as DateTime?,
          responseType: formData['response_type'] as String?,
          interviewDate: formData['interview_date'] as DateTime?,
          notes: formData['notes'] as String? ?? '',
        );

        // Save to database
        final repository = ref.read(applicationRepositoryProvider);
        await repository.create(application);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Application to ${application.company} added!'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pop(context);
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } finally {
        if (mounted) {
          setState(() => _isSubmitting = false);
        }
      }
    }
  }
}
