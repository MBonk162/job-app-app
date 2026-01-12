import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import '../../../../core/constants/app_constants.dart';
import '../../data/repositories/application_repository_provider.dart';
import '../../domain/entities/application_entity.dart';
import '../../../../core/utils/date_utils.dart';

/// Edit application screen with pre-filled data
class EditApplicationScreen extends ConsumerStatefulWidget {
  final ApplicationEntity application;

  const EditApplicationScreen({
    super.key,
    required this.application,
  });

  @override
  ConsumerState<EditApplicationScreen> createState() => _EditApplicationScreenState();
}

class _EditApplicationScreenState extends ConsumerState<EditApplicationScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool _isSubmitting = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Application'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => _showDeleteConfirmation(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Section 1: Basic Information
              _buildSectionTitle('Basic Information'),
              FormBuilderDateTimePicker(
                name: 'dateApplied',
                initialValue: widget.application.dateApplied,
                inputType: InputType.date,
                decoration: const InputDecoration(
                  labelText: 'Date Applied *',
                  prefixIcon: Icon(Icons.calendar_today),
                ),
                validator: FormBuilderValidators.required(),
              ),
              const SizedBox(height: 16),
              FormBuilderTextField(
                name: 'company',
                initialValue: widget.application.company,
                decoration: const InputDecoration(
                  labelText: 'Company *',
                  prefixIcon: Icon(Icons.business),
                ),
                validator: FormBuilderValidators.required(),
              ),
              const SizedBox(height: 16),
              FormBuilderTextField(
                name: 'roleTitle',
                initialValue: widget.application.roleTitle,
                decoration: const InputDecoration(
                  labelText: 'Role Title *',
                  prefixIcon: Icon(Icons.work),
                ),
                validator: FormBuilderValidators.required(),
              ),
              const SizedBox(height: 16),
              FormBuilderDropdown<String>(
                name: 'status',
                initialValue: widget.application.status.displayName,
                decoration: const InputDecoration(
                  labelText: 'Status',
                  prefixIcon: Icon(Icons.flag),
                ),
                items: AppConstants.applicationStatuses
                    .map((status) => DropdownMenuItem(
                          value: status,
                          child: Text(status),
                        ))
                    .toList(),
              ),
              const SizedBox(height: 24),

              // Section 2: Application Details
              _buildSectionTitle('Application Details'),
              FormBuilderDropdown<String>(
                name: 'source',
                initialValue: widget.application.source,
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
                name: 'applicationMethod',
                initialValue: widget.application.applicationMethod,
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
                initialValue: widget.application.location,
                decoration: const InputDecoration(
                  labelText: 'Location',
                  prefixIcon: Icon(Icons.location_on),
                ),
              ),
              const SizedBox(height: 16),
              FormBuilderDropdown<String>(
                name: 'companySize',
                initialValue: widget.application.companySize,
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
                name: 'roleType',
                initialValue: widget.application.roleType,
                decoration: const InputDecoration(
                  labelText: 'Role Type',
                  prefixIcon: Icon(Icons.category),
                ),
              ),
              const SizedBox(height: 16),
              FormBuilderTextField(
                name: 'techStack',
                initialValue: widget.application.techStack,
                decoration: const InputDecoration(
                  labelText: 'Tech Stack',
                  prefixIcon: Icon(Icons.code),
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 24),

              // Section 3: Compensation
              _buildSectionTitle('Compensation'),
              FormBuilderTextField(
                name: 'salaryMin',
                initialValue: widget.application.salaryMin?.toString(),
                decoration: const InputDecoration(
                  labelText: 'Minimum Salary',
                  prefixIcon: Icon(Icons.attach_money),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              FormBuilderTextField(
                name: 'salaryMax',
                initialValue: widget.application.salaryMax?.toString(),
                decoration: const InputDecoration(
                  labelText: 'Maximum Salary',
                  prefixIcon: Icon(Icons.attach_money),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 24),

              // Section 4: Metadata
              _buildSectionTitle('Additional Information'),
              FormBuilderSwitch(
                name: 'customized',
                initialValue: widget.application.customized,
                title: const Text('Customized Application'),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              ),
              FormBuilderSwitch(
                name: 'referral',
                initialValue: widget.application.referral,
                title: const Text('Had Referral'),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              ),
              const SizedBox(height: 16),
              FormBuilderSlider(
                name: 'confidenceMatch',
                initialValue: widget.application.confidenceMatch?.toDouble() ?? 3.0,
                min: 1,
                max: 5,
                divisions: 4,
                decoration: const InputDecoration(
                  labelText: 'Confidence Match (1-5)',
                  prefixIcon: Icon(Icons.star),
                ),
                displayValues: DisplayValues.all,
              ),
              const SizedBox(height: 24),

              // Section 5: Response Tracking
              _buildSectionTitle('Response Tracking'),
              FormBuilderDateTimePicker(
                name: 'responseDate',
                initialValue: widget.application.responseDate,
                inputType: InputType.date,
                decoration: const InputDecoration(
                  labelText: 'Response Date',
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              const SizedBox(height: 16),
              FormBuilderDropdown<String>(
                name: 'responseType',
                initialValue: widget.application.responseType,
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
                name: 'interviewDate',
                initialValue: widget.application.interviewDate,
                inputType: InputType.date,
                decoration: const InputDecoration(
                  labelText: 'Interview Date',
                  prefixIcon: Icon(Icons.event),
                ),
              ),
              const SizedBox(height: 24),

              // Section 6: Notes
              _buildSectionTitle('Notes'),
              FormBuilderTextField(
                name: 'notes',
                initialValue: widget.application.notes,
                decoration: const InputDecoration(
                  labelText: 'Notes',
                  prefixIcon: Icon(Icons.note),
                  alignLabelWithHint: true,
                ),
                maxLines: 5,
              ),
              const SizedBox(height: 32),

              // Submit Button
              ElevatedButton(
                onPressed: _isSubmitting ? null : _submitForm,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: _isSubmitting
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Update Application'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      setState(() => _isSubmitting = true);

      final values = _formKey.currentState!.value;

      // Create updated application
      final updatedApp = widget.application.copyWith(
        dateApplied: values['dateApplied'] as DateTime,
        company: values['company'] as String,
        roleTitle: values['roleTitle'] as String,
        status: ApplicationStatus.fromString(values['status'] as String),
        source: values['source'] as String,
        applicationMethod: values['applicationMethod'] as String,
        location: values['location'] as String? ?? '',
        companySize: values['companySize'] as String? ?? '',
        roleType: values['roleType'] as String? ?? '',
        techStack: values['techStack'] as String? ?? '',
        salaryMin: values['salaryMin'] != null && values['salaryMin'].toString().isNotEmpty
            ? int.tryParse(values['salaryMin'].toString())
            : null,
        salaryMax: values['salaryMax'] != null && values['salaryMax'].toString().isNotEmpty
            ? int.tryParse(values['salaryMax'].toString())
            : null,
        customized: values['customized'] as bool,
        referral: values['referral'] as bool,
        confidenceMatch: (values['confidenceMatch'] as double).toInt(),
        responseDate: values['responseDate'] as DateTime?,
        responseType: values['responseType'] as String?,
        interviewDate: values['interviewDate'] as DateTime?,
        notes: values['notes'] as String? ?? '',
      );

      try {
        // Update in repository
        final repository = ref.read(applicationRepositoryProvider);
        await repository.update(updatedApp);

        setState(() => _isSubmitting = false);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Application updated successfully!'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pop(context);
        }
      } catch (e) {
        setState(() => _isSubmitting = false);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error updating application: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  Future<void> _showDeleteConfirmation(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Application'),
        content: Text('Are you sure you want to delete the application to ${widget.application.company}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      try {
        final repository = ref.read(applicationRepositoryProvider);
        await repository.delete(widget.application.id);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Application deleted successfully!'),
              backgroundColor: Colors.orange,
            ),
          );
          Navigator.pop(context);
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error deleting application: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }
}
