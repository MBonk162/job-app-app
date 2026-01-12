/// Form validation utilities
class AppValidators {
  /// Required field validator
  static String? required(dynamic value, [String? fieldName]) {
    if (value == null || value.toString().trim().isEmpty) {
      return '${fieldName ?? "This field"} is required';
    }
    return null;
  }

  /// Company name validator (required field)
  static String? companyName(String? value) {
    return required(value, 'Company name');
  }

  /// Role title validator (required field)
  static String? roleTitle(String? value) {
    return required(value, 'Role title');
  }

  /// Email validator
  static String? email(String? value) {
    if (value == null || value.isEmpty) return null;

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  /// Salary validator (positive number)
  static String? salary(String? value) {
    if (value == null || value.isEmpty) return null;

    final salary = int.tryParse(value);
    if (salary == null) {
      return 'Please enter a valid number';
    }

    if (salary < 0) {
      return 'Salary must be positive';
    }

    return null;
  }

  /// Salary range validator (min must be less than max)
  static String? salaryRange(String? minValue, String? maxValue) {
    if (minValue == null || maxValue == null) return null;
    if (minValue.isEmpty || maxValue.isEmpty) return null;

    final min = int.tryParse(minValue);
    final max = int.tryParse(maxValue);

    if (min == null || max == null) return null;

    if (min > max) {
      return 'Minimum salary must be less than maximum';
    }

    return null;
  }

  /// Confidence match validator (1-5)
  static String? confidenceMatch(int? value) {
    if (value == null) return null;

    if (value < 1 || value > 5) {
      return 'Confidence must be between 1 and 5';
    }

    return null;
  }

  /// URL validator
  static String? url(String? value) {
    if (value == null || value.isEmpty) return null;

    final urlRegex = RegExp(
      r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$',
    );

    if (!urlRegex.hasMatch(value)) {
      return 'Please enter a valid URL';
    }
    return null;
  }
}
