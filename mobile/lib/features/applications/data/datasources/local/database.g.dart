// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $ApplicationsTable extends Applications
    with TableInfo<$ApplicationsTable, Application> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ApplicationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sheetRowIdMeta = const VerificationMeta(
    'sheetRowId',
  );
  @override
  late final GeneratedColumn<int> sheetRowId = GeneratedColumn<int>(
    'sheet_row_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dateAppliedMeta = const VerificationMeta(
    'dateApplied',
  );
  @override
  late final GeneratedColumn<String> dateApplied = GeneratedColumn<String>(
    'date_applied',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _companyMeta = const VerificationMeta(
    'company',
  );
  @override
  late final GeneratedColumn<String> company = GeneratedColumn<String>(
    'company',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _roleTitleMeta = const VerificationMeta(
    'roleTitle',
  );
  @override
  late final GeneratedColumn<String> roleTitle = GeneratedColumn<String>(
    'role_title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
    'source',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _applicationMethodMeta = const VerificationMeta(
    'applicationMethod',
  );
  @override
  late final GeneratedColumn<String> applicationMethod =
      GeneratedColumn<String>(
        'application_method',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _locationMeta = const VerificationMeta(
    'location',
  );
  @override
  late final GeneratedColumn<String> location = GeneratedColumn<String>(
    'location',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _companySizeMeta = const VerificationMeta(
    'companySize',
  );
  @override
  late final GeneratedColumn<String> companySize = GeneratedColumn<String>(
    'company_size',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _roleTypeMeta = const VerificationMeta(
    'roleType',
  );
  @override
  late final GeneratedColumn<String> roleType = GeneratedColumn<String>(
    'role_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _techStackMeta = const VerificationMeta(
    'techStack',
  );
  @override
  late final GeneratedColumn<String> techStack = GeneratedColumn<String>(
    'tech_stack',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _salaryMinMeta = const VerificationMeta(
    'salaryMin',
  );
  @override
  late final GeneratedColumn<int> salaryMin = GeneratedColumn<int>(
    'salary_min',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _salaryMaxMeta = const VerificationMeta(
    'salaryMax',
  );
  @override
  late final GeneratedColumn<int> salaryMax = GeneratedColumn<int>(
    'salary_max',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _customizedMeta = const VerificationMeta(
    'customized',
  );
  @override
  late final GeneratedColumn<String> customized = GeneratedColumn<String>(
    'customized',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _referralMeta = const VerificationMeta(
    'referral',
  );
  @override
  late final GeneratedColumn<String> referral = GeneratedColumn<String>(
    'referral',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _confidenceMatchMeta = const VerificationMeta(
    'confidenceMatch',
  );
  @override
  late final GeneratedColumn<int> confidenceMatch = GeneratedColumn<int>(
    'confidence_match',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _responseDateMeta = const VerificationMeta(
    'responseDate',
  );
  @override
  late final GeneratedColumn<String> responseDate = GeneratedColumn<String>(
    'response_date',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _responseTypeMeta = const VerificationMeta(
    'responseType',
  );
  @override
  late final GeneratedColumn<String> responseType = GeneratedColumn<String>(
    'response_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _interviewDateMeta = const VerificationMeta(
    'interviewDate',
  );
  @override
  late final GeneratedColumn<String> interviewDate = GeneratedColumn<String>(
    'interview_date',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isDirtyMeta = const VerificationMeta(
    'isDirty',
  );
  @override
  late final GeneratedColumn<bool> isDirty = GeneratedColumn<bool>(
    'is_dirty',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_dirty" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _lastModifiedMeta = const VerificationMeta(
    'lastModified',
  );
  @override
  late final GeneratedColumn<String> lastModified = GeneratedColumn<String>(
    'last_modified',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastSyncedMeta = const VerificationMeta(
    'lastSynced',
  );
  @override
  late final GeneratedColumn<String> lastSynced = GeneratedColumn<String>(
    'last_synced',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    sheetRowId,
    dateApplied,
    company,
    roleTitle,
    status,
    source,
    applicationMethod,
    location,
    companySize,
    roleType,
    techStack,
    salaryMin,
    salaryMax,
    customized,
    referral,
    confidenceMatch,
    responseDate,
    responseType,
    interviewDate,
    notes,
    isDirty,
    lastModified,
    lastSynced,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'applications';
  @override
  VerificationContext validateIntegrity(
    Insertable<Application> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('sheet_row_id')) {
      context.handle(
        _sheetRowIdMeta,
        sheetRowId.isAcceptableOrUnknown(
          data['sheet_row_id']!,
          _sheetRowIdMeta,
        ),
      );
    }
    if (data.containsKey('date_applied')) {
      context.handle(
        _dateAppliedMeta,
        dateApplied.isAcceptableOrUnknown(
          data['date_applied']!,
          _dateAppliedMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_dateAppliedMeta);
    }
    if (data.containsKey('company')) {
      context.handle(
        _companyMeta,
        company.isAcceptableOrUnknown(data['company']!, _companyMeta),
      );
    } else if (isInserting) {
      context.missing(_companyMeta);
    }
    if (data.containsKey('role_title')) {
      context.handle(
        _roleTitleMeta,
        roleTitle.isAcceptableOrUnknown(data['role_title']!, _roleTitleMeta),
      );
    } else if (isInserting) {
      context.missing(_roleTitleMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('source')) {
      context.handle(
        _sourceMeta,
        source.isAcceptableOrUnknown(data['source']!, _sourceMeta),
      );
    } else if (isInserting) {
      context.missing(_sourceMeta);
    }
    if (data.containsKey('application_method')) {
      context.handle(
        _applicationMethodMeta,
        applicationMethod.isAcceptableOrUnknown(
          data['application_method']!,
          _applicationMethodMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_applicationMethodMeta);
    }
    if (data.containsKey('location')) {
      context.handle(
        _locationMeta,
        location.isAcceptableOrUnknown(data['location']!, _locationMeta),
      );
    } else if (isInserting) {
      context.missing(_locationMeta);
    }
    if (data.containsKey('company_size')) {
      context.handle(
        _companySizeMeta,
        companySize.isAcceptableOrUnknown(
          data['company_size']!,
          _companySizeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_companySizeMeta);
    }
    if (data.containsKey('role_type')) {
      context.handle(
        _roleTypeMeta,
        roleType.isAcceptableOrUnknown(data['role_type']!, _roleTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_roleTypeMeta);
    }
    if (data.containsKey('tech_stack')) {
      context.handle(
        _techStackMeta,
        techStack.isAcceptableOrUnknown(data['tech_stack']!, _techStackMeta),
      );
    } else if (isInserting) {
      context.missing(_techStackMeta);
    }
    if (data.containsKey('salary_min')) {
      context.handle(
        _salaryMinMeta,
        salaryMin.isAcceptableOrUnknown(data['salary_min']!, _salaryMinMeta),
      );
    }
    if (data.containsKey('salary_max')) {
      context.handle(
        _salaryMaxMeta,
        salaryMax.isAcceptableOrUnknown(data['salary_max']!, _salaryMaxMeta),
      );
    }
    if (data.containsKey('customized')) {
      context.handle(
        _customizedMeta,
        customized.isAcceptableOrUnknown(data['customized']!, _customizedMeta),
      );
    } else if (isInserting) {
      context.missing(_customizedMeta);
    }
    if (data.containsKey('referral')) {
      context.handle(
        _referralMeta,
        referral.isAcceptableOrUnknown(data['referral']!, _referralMeta),
      );
    } else if (isInserting) {
      context.missing(_referralMeta);
    }
    if (data.containsKey('confidence_match')) {
      context.handle(
        _confidenceMatchMeta,
        confidenceMatch.isAcceptableOrUnknown(
          data['confidence_match']!,
          _confidenceMatchMeta,
        ),
      );
    }
    if (data.containsKey('response_date')) {
      context.handle(
        _responseDateMeta,
        responseDate.isAcceptableOrUnknown(
          data['response_date']!,
          _responseDateMeta,
        ),
      );
    }
    if (data.containsKey('response_type')) {
      context.handle(
        _responseTypeMeta,
        responseType.isAcceptableOrUnknown(
          data['response_type']!,
          _responseTypeMeta,
        ),
      );
    }
    if (data.containsKey('interview_date')) {
      context.handle(
        _interviewDateMeta,
        interviewDate.isAcceptableOrUnknown(
          data['interview_date']!,
          _interviewDateMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    } else if (isInserting) {
      context.missing(_notesMeta);
    }
    if (data.containsKey('is_dirty')) {
      context.handle(
        _isDirtyMeta,
        isDirty.isAcceptableOrUnknown(data['is_dirty']!, _isDirtyMeta),
      );
    }
    if (data.containsKey('last_modified')) {
      context.handle(
        _lastModifiedMeta,
        lastModified.isAcceptableOrUnknown(
          data['last_modified']!,
          _lastModifiedMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lastModifiedMeta);
    }
    if (data.containsKey('last_synced')) {
      context.handle(
        _lastSyncedMeta,
        lastSynced.isAcceptableOrUnknown(data['last_synced']!, _lastSyncedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Application map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Application(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      sheetRowId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sheet_row_id'],
      ),
      dateApplied: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}date_applied'],
      )!,
      company: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}company'],
      )!,
      roleTitle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role_title'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      source: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source'],
      )!,
      applicationMethod: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}application_method'],
      )!,
      location: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location'],
      )!,
      companySize: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}company_size'],
      )!,
      roleType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role_type'],
      )!,
      techStack: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tech_stack'],
      )!,
      salaryMin: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}salary_min'],
      ),
      salaryMax: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}salary_max'],
      ),
      customized: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}customized'],
      )!,
      referral: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}referral'],
      )!,
      confidenceMatch: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}confidence_match'],
      ),
      responseDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}response_date'],
      ),
      responseType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}response_type'],
      ),
      interviewDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}interview_date'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      )!,
      isDirty: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_dirty'],
      )!,
      lastModified: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_modified'],
      )!,
      lastSynced: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_synced'],
      ),
    );
  }

  @override
  $ApplicationsTable createAlias(String alias) {
    return $ApplicationsTable(attachedDatabase, alias);
  }
}

class Application extends DataClass implements Insertable<Application> {
  final String id;
  final int? sheetRowId;
  final String dateApplied;
  final String company;
  final String roleTitle;
  final String status;
  final String source;
  final String applicationMethod;
  final String location;
  final String companySize;
  final String roleType;
  final String techStack;
  final int? salaryMin;
  final int? salaryMax;
  final String customized;
  final String referral;
  final int? confidenceMatch;
  final String? responseDate;
  final String? responseType;
  final String? interviewDate;
  final String notes;
  final bool isDirty;
  final String lastModified;
  final String? lastSynced;
  const Application({
    required this.id,
    this.sheetRowId,
    required this.dateApplied,
    required this.company,
    required this.roleTitle,
    required this.status,
    required this.source,
    required this.applicationMethod,
    required this.location,
    required this.companySize,
    required this.roleType,
    required this.techStack,
    this.salaryMin,
    this.salaryMax,
    required this.customized,
    required this.referral,
    this.confidenceMatch,
    this.responseDate,
    this.responseType,
    this.interviewDate,
    required this.notes,
    required this.isDirty,
    required this.lastModified,
    this.lastSynced,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || sheetRowId != null) {
      map['sheet_row_id'] = Variable<int>(sheetRowId);
    }
    map['date_applied'] = Variable<String>(dateApplied);
    map['company'] = Variable<String>(company);
    map['role_title'] = Variable<String>(roleTitle);
    map['status'] = Variable<String>(status);
    map['source'] = Variable<String>(source);
    map['application_method'] = Variable<String>(applicationMethod);
    map['location'] = Variable<String>(location);
    map['company_size'] = Variable<String>(companySize);
    map['role_type'] = Variable<String>(roleType);
    map['tech_stack'] = Variable<String>(techStack);
    if (!nullToAbsent || salaryMin != null) {
      map['salary_min'] = Variable<int>(salaryMin);
    }
    if (!nullToAbsent || salaryMax != null) {
      map['salary_max'] = Variable<int>(salaryMax);
    }
    map['customized'] = Variable<String>(customized);
    map['referral'] = Variable<String>(referral);
    if (!nullToAbsent || confidenceMatch != null) {
      map['confidence_match'] = Variable<int>(confidenceMatch);
    }
    if (!nullToAbsent || responseDate != null) {
      map['response_date'] = Variable<String>(responseDate);
    }
    if (!nullToAbsent || responseType != null) {
      map['response_type'] = Variable<String>(responseType);
    }
    if (!nullToAbsent || interviewDate != null) {
      map['interview_date'] = Variable<String>(interviewDate);
    }
    map['notes'] = Variable<String>(notes);
    map['is_dirty'] = Variable<bool>(isDirty);
    map['last_modified'] = Variable<String>(lastModified);
    if (!nullToAbsent || lastSynced != null) {
      map['last_synced'] = Variable<String>(lastSynced);
    }
    return map;
  }

  ApplicationsCompanion toCompanion(bool nullToAbsent) {
    return ApplicationsCompanion(
      id: Value(id),
      sheetRowId: sheetRowId == null && nullToAbsent
          ? const Value.absent()
          : Value(sheetRowId),
      dateApplied: Value(dateApplied),
      company: Value(company),
      roleTitle: Value(roleTitle),
      status: Value(status),
      source: Value(source),
      applicationMethod: Value(applicationMethod),
      location: Value(location),
      companySize: Value(companySize),
      roleType: Value(roleType),
      techStack: Value(techStack),
      salaryMin: salaryMin == null && nullToAbsent
          ? const Value.absent()
          : Value(salaryMin),
      salaryMax: salaryMax == null && nullToAbsent
          ? const Value.absent()
          : Value(salaryMax),
      customized: Value(customized),
      referral: Value(referral),
      confidenceMatch: confidenceMatch == null && nullToAbsent
          ? const Value.absent()
          : Value(confidenceMatch),
      responseDate: responseDate == null && nullToAbsent
          ? const Value.absent()
          : Value(responseDate),
      responseType: responseType == null && nullToAbsent
          ? const Value.absent()
          : Value(responseType),
      interviewDate: interviewDate == null && nullToAbsent
          ? const Value.absent()
          : Value(interviewDate),
      notes: Value(notes),
      isDirty: Value(isDirty),
      lastModified: Value(lastModified),
      lastSynced: lastSynced == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSynced),
    );
  }

  factory Application.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Application(
      id: serializer.fromJson<String>(json['id']),
      sheetRowId: serializer.fromJson<int?>(json['sheetRowId']),
      dateApplied: serializer.fromJson<String>(json['dateApplied']),
      company: serializer.fromJson<String>(json['company']),
      roleTitle: serializer.fromJson<String>(json['roleTitle']),
      status: serializer.fromJson<String>(json['status']),
      source: serializer.fromJson<String>(json['source']),
      applicationMethod: serializer.fromJson<String>(json['applicationMethod']),
      location: serializer.fromJson<String>(json['location']),
      companySize: serializer.fromJson<String>(json['companySize']),
      roleType: serializer.fromJson<String>(json['roleType']),
      techStack: serializer.fromJson<String>(json['techStack']),
      salaryMin: serializer.fromJson<int?>(json['salaryMin']),
      salaryMax: serializer.fromJson<int?>(json['salaryMax']),
      customized: serializer.fromJson<String>(json['customized']),
      referral: serializer.fromJson<String>(json['referral']),
      confidenceMatch: serializer.fromJson<int?>(json['confidenceMatch']),
      responseDate: serializer.fromJson<String?>(json['responseDate']),
      responseType: serializer.fromJson<String?>(json['responseType']),
      interviewDate: serializer.fromJson<String?>(json['interviewDate']),
      notes: serializer.fromJson<String>(json['notes']),
      isDirty: serializer.fromJson<bool>(json['isDirty']),
      lastModified: serializer.fromJson<String>(json['lastModified']),
      lastSynced: serializer.fromJson<String?>(json['lastSynced']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'sheetRowId': serializer.toJson<int?>(sheetRowId),
      'dateApplied': serializer.toJson<String>(dateApplied),
      'company': serializer.toJson<String>(company),
      'roleTitle': serializer.toJson<String>(roleTitle),
      'status': serializer.toJson<String>(status),
      'source': serializer.toJson<String>(source),
      'applicationMethod': serializer.toJson<String>(applicationMethod),
      'location': serializer.toJson<String>(location),
      'companySize': serializer.toJson<String>(companySize),
      'roleType': serializer.toJson<String>(roleType),
      'techStack': serializer.toJson<String>(techStack),
      'salaryMin': serializer.toJson<int?>(salaryMin),
      'salaryMax': serializer.toJson<int?>(salaryMax),
      'customized': serializer.toJson<String>(customized),
      'referral': serializer.toJson<String>(referral),
      'confidenceMatch': serializer.toJson<int?>(confidenceMatch),
      'responseDate': serializer.toJson<String?>(responseDate),
      'responseType': serializer.toJson<String?>(responseType),
      'interviewDate': serializer.toJson<String?>(interviewDate),
      'notes': serializer.toJson<String>(notes),
      'isDirty': serializer.toJson<bool>(isDirty),
      'lastModified': serializer.toJson<String>(lastModified),
      'lastSynced': serializer.toJson<String?>(lastSynced),
    };
  }

  Application copyWith({
    String? id,
    Value<int?> sheetRowId = const Value.absent(),
    String? dateApplied,
    String? company,
    String? roleTitle,
    String? status,
    String? source,
    String? applicationMethod,
    String? location,
    String? companySize,
    String? roleType,
    String? techStack,
    Value<int?> salaryMin = const Value.absent(),
    Value<int?> salaryMax = const Value.absent(),
    String? customized,
    String? referral,
    Value<int?> confidenceMatch = const Value.absent(),
    Value<String?> responseDate = const Value.absent(),
    Value<String?> responseType = const Value.absent(),
    Value<String?> interviewDate = const Value.absent(),
    String? notes,
    bool? isDirty,
    String? lastModified,
    Value<String?> lastSynced = const Value.absent(),
  }) => Application(
    id: id ?? this.id,
    sheetRowId: sheetRowId.present ? sheetRowId.value : this.sheetRowId,
    dateApplied: dateApplied ?? this.dateApplied,
    company: company ?? this.company,
    roleTitle: roleTitle ?? this.roleTitle,
    status: status ?? this.status,
    source: source ?? this.source,
    applicationMethod: applicationMethod ?? this.applicationMethod,
    location: location ?? this.location,
    companySize: companySize ?? this.companySize,
    roleType: roleType ?? this.roleType,
    techStack: techStack ?? this.techStack,
    salaryMin: salaryMin.present ? salaryMin.value : this.salaryMin,
    salaryMax: salaryMax.present ? salaryMax.value : this.salaryMax,
    customized: customized ?? this.customized,
    referral: referral ?? this.referral,
    confidenceMatch: confidenceMatch.present
        ? confidenceMatch.value
        : this.confidenceMatch,
    responseDate: responseDate.present ? responseDate.value : this.responseDate,
    responseType: responseType.present ? responseType.value : this.responseType,
    interviewDate: interviewDate.present
        ? interviewDate.value
        : this.interviewDate,
    notes: notes ?? this.notes,
    isDirty: isDirty ?? this.isDirty,
    lastModified: lastModified ?? this.lastModified,
    lastSynced: lastSynced.present ? lastSynced.value : this.lastSynced,
  );
  Application copyWithCompanion(ApplicationsCompanion data) {
    return Application(
      id: data.id.present ? data.id.value : this.id,
      sheetRowId: data.sheetRowId.present
          ? data.sheetRowId.value
          : this.sheetRowId,
      dateApplied: data.dateApplied.present
          ? data.dateApplied.value
          : this.dateApplied,
      company: data.company.present ? data.company.value : this.company,
      roleTitle: data.roleTitle.present ? data.roleTitle.value : this.roleTitle,
      status: data.status.present ? data.status.value : this.status,
      source: data.source.present ? data.source.value : this.source,
      applicationMethod: data.applicationMethod.present
          ? data.applicationMethod.value
          : this.applicationMethod,
      location: data.location.present ? data.location.value : this.location,
      companySize: data.companySize.present
          ? data.companySize.value
          : this.companySize,
      roleType: data.roleType.present ? data.roleType.value : this.roleType,
      techStack: data.techStack.present ? data.techStack.value : this.techStack,
      salaryMin: data.salaryMin.present ? data.salaryMin.value : this.salaryMin,
      salaryMax: data.salaryMax.present ? data.salaryMax.value : this.salaryMax,
      customized: data.customized.present
          ? data.customized.value
          : this.customized,
      referral: data.referral.present ? data.referral.value : this.referral,
      confidenceMatch: data.confidenceMatch.present
          ? data.confidenceMatch.value
          : this.confidenceMatch,
      responseDate: data.responseDate.present
          ? data.responseDate.value
          : this.responseDate,
      responseType: data.responseType.present
          ? data.responseType.value
          : this.responseType,
      interviewDate: data.interviewDate.present
          ? data.interviewDate.value
          : this.interviewDate,
      notes: data.notes.present ? data.notes.value : this.notes,
      isDirty: data.isDirty.present ? data.isDirty.value : this.isDirty,
      lastModified: data.lastModified.present
          ? data.lastModified.value
          : this.lastModified,
      lastSynced: data.lastSynced.present
          ? data.lastSynced.value
          : this.lastSynced,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Application(')
          ..write('id: $id, ')
          ..write('sheetRowId: $sheetRowId, ')
          ..write('dateApplied: $dateApplied, ')
          ..write('company: $company, ')
          ..write('roleTitle: $roleTitle, ')
          ..write('status: $status, ')
          ..write('source: $source, ')
          ..write('applicationMethod: $applicationMethod, ')
          ..write('location: $location, ')
          ..write('companySize: $companySize, ')
          ..write('roleType: $roleType, ')
          ..write('techStack: $techStack, ')
          ..write('salaryMin: $salaryMin, ')
          ..write('salaryMax: $salaryMax, ')
          ..write('customized: $customized, ')
          ..write('referral: $referral, ')
          ..write('confidenceMatch: $confidenceMatch, ')
          ..write('responseDate: $responseDate, ')
          ..write('responseType: $responseType, ')
          ..write('interviewDate: $interviewDate, ')
          ..write('notes: $notes, ')
          ..write('isDirty: $isDirty, ')
          ..write('lastModified: $lastModified, ')
          ..write('lastSynced: $lastSynced')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    sheetRowId,
    dateApplied,
    company,
    roleTitle,
    status,
    source,
    applicationMethod,
    location,
    companySize,
    roleType,
    techStack,
    salaryMin,
    salaryMax,
    customized,
    referral,
    confidenceMatch,
    responseDate,
    responseType,
    interviewDate,
    notes,
    isDirty,
    lastModified,
    lastSynced,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Application &&
          other.id == this.id &&
          other.sheetRowId == this.sheetRowId &&
          other.dateApplied == this.dateApplied &&
          other.company == this.company &&
          other.roleTitle == this.roleTitle &&
          other.status == this.status &&
          other.source == this.source &&
          other.applicationMethod == this.applicationMethod &&
          other.location == this.location &&
          other.companySize == this.companySize &&
          other.roleType == this.roleType &&
          other.techStack == this.techStack &&
          other.salaryMin == this.salaryMin &&
          other.salaryMax == this.salaryMax &&
          other.customized == this.customized &&
          other.referral == this.referral &&
          other.confidenceMatch == this.confidenceMatch &&
          other.responseDate == this.responseDate &&
          other.responseType == this.responseType &&
          other.interviewDate == this.interviewDate &&
          other.notes == this.notes &&
          other.isDirty == this.isDirty &&
          other.lastModified == this.lastModified &&
          other.lastSynced == this.lastSynced);
}

class ApplicationsCompanion extends UpdateCompanion<Application> {
  final Value<String> id;
  final Value<int?> sheetRowId;
  final Value<String> dateApplied;
  final Value<String> company;
  final Value<String> roleTitle;
  final Value<String> status;
  final Value<String> source;
  final Value<String> applicationMethod;
  final Value<String> location;
  final Value<String> companySize;
  final Value<String> roleType;
  final Value<String> techStack;
  final Value<int?> salaryMin;
  final Value<int?> salaryMax;
  final Value<String> customized;
  final Value<String> referral;
  final Value<int?> confidenceMatch;
  final Value<String?> responseDate;
  final Value<String?> responseType;
  final Value<String?> interviewDate;
  final Value<String> notes;
  final Value<bool> isDirty;
  final Value<String> lastModified;
  final Value<String?> lastSynced;
  final Value<int> rowid;
  const ApplicationsCompanion({
    this.id = const Value.absent(),
    this.sheetRowId = const Value.absent(),
    this.dateApplied = const Value.absent(),
    this.company = const Value.absent(),
    this.roleTitle = const Value.absent(),
    this.status = const Value.absent(),
    this.source = const Value.absent(),
    this.applicationMethod = const Value.absent(),
    this.location = const Value.absent(),
    this.companySize = const Value.absent(),
    this.roleType = const Value.absent(),
    this.techStack = const Value.absent(),
    this.salaryMin = const Value.absent(),
    this.salaryMax = const Value.absent(),
    this.customized = const Value.absent(),
    this.referral = const Value.absent(),
    this.confidenceMatch = const Value.absent(),
    this.responseDate = const Value.absent(),
    this.responseType = const Value.absent(),
    this.interviewDate = const Value.absent(),
    this.notes = const Value.absent(),
    this.isDirty = const Value.absent(),
    this.lastModified = const Value.absent(),
    this.lastSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ApplicationsCompanion.insert({
    required String id,
    this.sheetRowId = const Value.absent(),
    required String dateApplied,
    required String company,
    required String roleTitle,
    required String status,
    required String source,
    required String applicationMethod,
    required String location,
    required String companySize,
    required String roleType,
    required String techStack,
    this.salaryMin = const Value.absent(),
    this.salaryMax = const Value.absent(),
    required String customized,
    required String referral,
    this.confidenceMatch = const Value.absent(),
    this.responseDate = const Value.absent(),
    this.responseType = const Value.absent(),
    this.interviewDate = const Value.absent(),
    required String notes,
    this.isDirty = const Value.absent(),
    required String lastModified,
    this.lastSynced = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       dateApplied = Value(dateApplied),
       company = Value(company),
       roleTitle = Value(roleTitle),
       status = Value(status),
       source = Value(source),
       applicationMethod = Value(applicationMethod),
       location = Value(location),
       companySize = Value(companySize),
       roleType = Value(roleType),
       techStack = Value(techStack),
       customized = Value(customized),
       referral = Value(referral),
       notes = Value(notes),
       lastModified = Value(lastModified);
  static Insertable<Application> custom({
    Expression<String>? id,
    Expression<int>? sheetRowId,
    Expression<String>? dateApplied,
    Expression<String>? company,
    Expression<String>? roleTitle,
    Expression<String>? status,
    Expression<String>? source,
    Expression<String>? applicationMethod,
    Expression<String>? location,
    Expression<String>? companySize,
    Expression<String>? roleType,
    Expression<String>? techStack,
    Expression<int>? salaryMin,
    Expression<int>? salaryMax,
    Expression<String>? customized,
    Expression<String>? referral,
    Expression<int>? confidenceMatch,
    Expression<String>? responseDate,
    Expression<String>? responseType,
    Expression<String>? interviewDate,
    Expression<String>? notes,
    Expression<bool>? isDirty,
    Expression<String>? lastModified,
    Expression<String>? lastSynced,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sheetRowId != null) 'sheet_row_id': sheetRowId,
      if (dateApplied != null) 'date_applied': dateApplied,
      if (company != null) 'company': company,
      if (roleTitle != null) 'role_title': roleTitle,
      if (status != null) 'status': status,
      if (source != null) 'source': source,
      if (applicationMethod != null) 'application_method': applicationMethod,
      if (location != null) 'location': location,
      if (companySize != null) 'company_size': companySize,
      if (roleType != null) 'role_type': roleType,
      if (techStack != null) 'tech_stack': techStack,
      if (salaryMin != null) 'salary_min': salaryMin,
      if (salaryMax != null) 'salary_max': salaryMax,
      if (customized != null) 'customized': customized,
      if (referral != null) 'referral': referral,
      if (confidenceMatch != null) 'confidence_match': confidenceMatch,
      if (responseDate != null) 'response_date': responseDate,
      if (responseType != null) 'response_type': responseType,
      if (interviewDate != null) 'interview_date': interviewDate,
      if (notes != null) 'notes': notes,
      if (isDirty != null) 'is_dirty': isDirty,
      if (lastModified != null) 'last_modified': lastModified,
      if (lastSynced != null) 'last_synced': lastSynced,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ApplicationsCompanion copyWith({
    Value<String>? id,
    Value<int?>? sheetRowId,
    Value<String>? dateApplied,
    Value<String>? company,
    Value<String>? roleTitle,
    Value<String>? status,
    Value<String>? source,
    Value<String>? applicationMethod,
    Value<String>? location,
    Value<String>? companySize,
    Value<String>? roleType,
    Value<String>? techStack,
    Value<int?>? salaryMin,
    Value<int?>? salaryMax,
    Value<String>? customized,
    Value<String>? referral,
    Value<int?>? confidenceMatch,
    Value<String?>? responseDate,
    Value<String?>? responseType,
    Value<String?>? interviewDate,
    Value<String>? notes,
    Value<bool>? isDirty,
    Value<String>? lastModified,
    Value<String?>? lastSynced,
    Value<int>? rowid,
  }) {
    return ApplicationsCompanion(
      id: id ?? this.id,
      sheetRowId: sheetRowId ?? this.sheetRowId,
      dateApplied: dateApplied ?? this.dateApplied,
      company: company ?? this.company,
      roleTitle: roleTitle ?? this.roleTitle,
      status: status ?? this.status,
      source: source ?? this.source,
      applicationMethod: applicationMethod ?? this.applicationMethod,
      location: location ?? this.location,
      companySize: companySize ?? this.companySize,
      roleType: roleType ?? this.roleType,
      techStack: techStack ?? this.techStack,
      salaryMin: salaryMin ?? this.salaryMin,
      salaryMax: salaryMax ?? this.salaryMax,
      customized: customized ?? this.customized,
      referral: referral ?? this.referral,
      confidenceMatch: confidenceMatch ?? this.confidenceMatch,
      responseDate: responseDate ?? this.responseDate,
      responseType: responseType ?? this.responseType,
      interviewDate: interviewDate ?? this.interviewDate,
      notes: notes ?? this.notes,
      isDirty: isDirty ?? this.isDirty,
      lastModified: lastModified ?? this.lastModified,
      lastSynced: lastSynced ?? this.lastSynced,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (sheetRowId.present) {
      map['sheet_row_id'] = Variable<int>(sheetRowId.value);
    }
    if (dateApplied.present) {
      map['date_applied'] = Variable<String>(dateApplied.value);
    }
    if (company.present) {
      map['company'] = Variable<String>(company.value);
    }
    if (roleTitle.present) {
      map['role_title'] = Variable<String>(roleTitle.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (applicationMethod.present) {
      map['application_method'] = Variable<String>(applicationMethod.value);
    }
    if (location.present) {
      map['location'] = Variable<String>(location.value);
    }
    if (companySize.present) {
      map['company_size'] = Variable<String>(companySize.value);
    }
    if (roleType.present) {
      map['role_type'] = Variable<String>(roleType.value);
    }
    if (techStack.present) {
      map['tech_stack'] = Variable<String>(techStack.value);
    }
    if (salaryMin.present) {
      map['salary_min'] = Variable<int>(salaryMin.value);
    }
    if (salaryMax.present) {
      map['salary_max'] = Variable<int>(salaryMax.value);
    }
    if (customized.present) {
      map['customized'] = Variable<String>(customized.value);
    }
    if (referral.present) {
      map['referral'] = Variable<String>(referral.value);
    }
    if (confidenceMatch.present) {
      map['confidence_match'] = Variable<int>(confidenceMatch.value);
    }
    if (responseDate.present) {
      map['response_date'] = Variable<String>(responseDate.value);
    }
    if (responseType.present) {
      map['response_type'] = Variable<String>(responseType.value);
    }
    if (interviewDate.present) {
      map['interview_date'] = Variable<String>(interviewDate.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (isDirty.present) {
      map['is_dirty'] = Variable<bool>(isDirty.value);
    }
    if (lastModified.present) {
      map['last_modified'] = Variable<String>(lastModified.value);
    }
    if (lastSynced.present) {
      map['last_synced'] = Variable<String>(lastSynced.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ApplicationsCompanion(')
          ..write('id: $id, ')
          ..write('sheetRowId: $sheetRowId, ')
          ..write('dateApplied: $dateApplied, ')
          ..write('company: $company, ')
          ..write('roleTitle: $roleTitle, ')
          ..write('status: $status, ')
          ..write('source: $source, ')
          ..write('applicationMethod: $applicationMethod, ')
          ..write('location: $location, ')
          ..write('companySize: $companySize, ')
          ..write('roleType: $roleType, ')
          ..write('techStack: $techStack, ')
          ..write('salaryMin: $salaryMin, ')
          ..write('salaryMax: $salaryMax, ')
          ..write('customized: $customized, ')
          ..write('referral: $referral, ')
          ..write('confidenceMatch: $confidenceMatch, ')
          ..write('responseDate: $responseDate, ')
          ..write('responseType: $responseType, ')
          ..write('interviewDate: $interviewDate, ')
          ..write('notes: $notes, ')
          ..write('isDirty: $isDirty, ')
          ..write('lastModified: $lastModified, ')
          ..write('lastSynced: $lastSynced, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ApplicationsTable applications = $ApplicationsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [applications];
}

typedef $$ApplicationsTableCreateCompanionBuilder =
    ApplicationsCompanion Function({
      required String id,
      Value<int?> sheetRowId,
      required String dateApplied,
      required String company,
      required String roleTitle,
      required String status,
      required String source,
      required String applicationMethod,
      required String location,
      required String companySize,
      required String roleType,
      required String techStack,
      Value<int?> salaryMin,
      Value<int?> salaryMax,
      required String customized,
      required String referral,
      Value<int?> confidenceMatch,
      Value<String?> responseDate,
      Value<String?> responseType,
      Value<String?> interviewDate,
      required String notes,
      Value<bool> isDirty,
      required String lastModified,
      Value<String?> lastSynced,
      Value<int> rowid,
    });
typedef $$ApplicationsTableUpdateCompanionBuilder =
    ApplicationsCompanion Function({
      Value<String> id,
      Value<int?> sheetRowId,
      Value<String> dateApplied,
      Value<String> company,
      Value<String> roleTitle,
      Value<String> status,
      Value<String> source,
      Value<String> applicationMethod,
      Value<String> location,
      Value<String> companySize,
      Value<String> roleType,
      Value<String> techStack,
      Value<int?> salaryMin,
      Value<int?> salaryMax,
      Value<String> customized,
      Value<String> referral,
      Value<int?> confidenceMatch,
      Value<String?> responseDate,
      Value<String?> responseType,
      Value<String?> interviewDate,
      Value<String> notes,
      Value<bool> isDirty,
      Value<String> lastModified,
      Value<String?> lastSynced,
      Value<int> rowid,
    });

class $$ApplicationsTableFilterComposer
    extends Composer<_$AppDatabase, $ApplicationsTable> {
  $$ApplicationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sheetRowId => $composableBuilder(
    column: $table.sheetRowId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dateApplied => $composableBuilder(
    column: $table.dateApplied,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get company => $composableBuilder(
    column: $table.company,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get roleTitle => $composableBuilder(
    column: $table.roleTitle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get applicationMethod => $composableBuilder(
    column: $table.applicationMethod,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get companySize => $composableBuilder(
    column: $table.companySize,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get roleType => $composableBuilder(
    column: $table.roleType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get techStack => $composableBuilder(
    column: $table.techStack,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get salaryMin => $composableBuilder(
    column: $table.salaryMin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get salaryMax => $composableBuilder(
    column: $table.salaryMax,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customized => $composableBuilder(
    column: $table.customized,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get referral => $composableBuilder(
    column: $table.referral,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get confidenceMatch => $composableBuilder(
    column: $table.confidenceMatch,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get responseDate => $composableBuilder(
    column: $table.responseDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get responseType => $composableBuilder(
    column: $table.responseType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get interviewDate => $composableBuilder(
    column: $table.interviewDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDirty => $composableBuilder(
    column: $table.isDirty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastModified => $composableBuilder(
    column: $table.lastModified,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastSynced => $composableBuilder(
    column: $table.lastSynced,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ApplicationsTableOrderingComposer
    extends Composer<_$AppDatabase, $ApplicationsTable> {
  $$ApplicationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sheetRowId => $composableBuilder(
    column: $table.sheetRowId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dateApplied => $composableBuilder(
    column: $table.dateApplied,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get company => $composableBuilder(
    column: $table.company,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get roleTitle => $composableBuilder(
    column: $table.roleTitle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get applicationMethod => $composableBuilder(
    column: $table.applicationMethod,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get companySize => $composableBuilder(
    column: $table.companySize,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get roleType => $composableBuilder(
    column: $table.roleType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get techStack => $composableBuilder(
    column: $table.techStack,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get salaryMin => $composableBuilder(
    column: $table.salaryMin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get salaryMax => $composableBuilder(
    column: $table.salaryMax,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customized => $composableBuilder(
    column: $table.customized,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get referral => $composableBuilder(
    column: $table.referral,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get confidenceMatch => $composableBuilder(
    column: $table.confidenceMatch,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get responseDate => $composableBuilder(
    column: $table.responseDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get responseType => $composableBuilder(
    column: $table.responseType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get interviewDate => $composableBuilder(
    column: $table.interviewDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDirty => $composableBuilder(
    column: $table.isDirty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastModified => $composableBuilder(
    column: $table.lastModified,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastSynced => $composableBuilder(
    column: $table.lastSynced,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ApplicationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ApplicationsTable> {
  $$ApplicationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get sheetRowId => $composableBuilder(
    column: $table.sheetRowId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get dateApplied => $composableBuilder(
    column: $table.dateApplied,
    builder: (column) => column,
  );

  GeneratedColumn<String> get company =>
      $composableBuilder(column: $table.company, builder: (column) => column);

  GeneratedColumn<String> get roleTitle =>
      $composableBuilder(column: $table.roleTitle, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get applicationMethod => $composableBuilder(
    column: $table.applicationMethod,
    builder: (column) => column,
  );

  GeneratedColumn<String> get location =>
      $composableBuilder(column: $table.location, builder: (column) => column);

  GeneratedColumn<String> get companySize => $composableBuilder(
    column: $table.companySize,
    builder: (column) => column,
  );

  GeneratedColumn<String> get roleType =>
      $composableBuilder(column: $table.roleType, builder: (column) => column);

  GeneratedColumn<String> get techStack =>
      $composableBuilder(column: $table.techStack, builder: (column) => column);

  GeneratedColumn<int> get salaryMin =>
      $composableBuilder(column: $table.salaryMin, builder: (column) => column);

  GeneratedColumn<int> get salaryMax =>
      $composableBuilder(column: $table.salaryMax, builder: (column) => column);

  GeneratedColumn<String> get customized => $composableBuilder(
    column: $table.customized,
    builder: (column) => column,
  );

  GeneratedColumn<String> get referral =>
      $composableBuilder(column: $table.referral, builder: (column) => column);

  GeneratedColumn<int> get confidenceMatch => $composableBuilder(
    column: $table.confidenceMatch,
    builder: (column) => column,
  );

  GeneratedColumn<String> get responseDate => $composableBuilder(
    column: $table.responseDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get responseType => $composableBuilder(
    column: $table.responseType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get interviewDate => $composableBuilder(
    column: $table.interviewDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<bool> get isDirty =>
      $composableBuilder(column: $table.isDirty, builder: (column) => column);

  GeneratedColumn<String> get lastModified => $composableBuilder(
    column: $table.lastModified,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastSynced => $composableBuilder(
    column: $table.lastSynced,
    builder: (column) => column,
  );
}

class $$ApplicationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ApplicationsTable,
          Application,
          $$ApplicationsTableFilterComposer,
          $$ApplicationsTableOrderingComposer,
          $$ApplicationsTableAnnotationComposer,
          $$ApplicationsTableCreateCompanionBuilder,
          $$ApplicationsTableUpdateCompanionBuilder,
          (
            Application,
            BaseReferences<_$AppDatabase, $ApplicationsTable, Application>,
          ),
          Application,
          PrefetchHooks Function()
        > {
  $$ApplicationsTableTableManager(_$AppDatabase db, $ApplicationsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ApplicationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ApplicationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ApplicationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<int?> sheetRowId = const Value.absent(),
                Value<String> dateApplied = const Value.absent(),
                Value<String> company = const Value.absent(),
                Value<String> roleTitle = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> source = const Value.absent(),
                Value<String> applicationMethod = const Value.absent(),
                Value<String> location = const Value.absent(),
                Value<String> companySize = const Value.absent(),
                Value<String> roleType = const Value.absent(),
                Value<String> techStack = const Value.absent(),
                Value<int?> salaryMin = const Value.absent(),
                Value<int?> salaryMax = const Value.absent(),
                Value<String> customized = const Value.absent(),
                Value<String> referral = const Value.absent(),
                Value<int?> confidenceMatch = const Value.absent(),
                Value<String?> responseDate = const Value.absent(),
                Value<String?> responseType = const Value.absent(),
                Value<String?> interviewDate = const Value.absent(),
                Value<String> notes = const Value.absent(),
                Value<bool> isDirty = const Value.absent(),
                Value<String> lastModified = const Value.absent(),
                Value<String?> lastSynced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ApplicationsCompanion(
                id: id,
                sheetRowId: sheetRowId,
                dateApplied: dateApplied,
                company: company,
                roleTitle: roleTitle,
                status: status,
                source: source,
                applicationMethod: applicationMethod,
                location: location,
                companySize: companySize,
                roleType: roleType,
                techStack: techStack,
                salaryMin: salaryMin,
                salaryMax: salaryMax,
                customized: customized,
                referral: referral,
                confidenceMatch: confidenceMatch,
                responseDate: responseDate,
                responseType: responseType,
                interviewDate: interviewDate,
                notes: notes,
                isDirty: isDirty,
                lastModified: lastModified,
                lastSynced: lastSynced,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<int?> sheetRowId = const Value.absent(),
                required String dateApplied,
                required String company,
                required String roleTitle,
                required String status,
                required String source,
                required String applicationMethod,
                required String location,
                required String companySize,
                required String roleType,
                required String techStack,
                Value<int?> salaryMin = const Value.absent(),
                Value<int?> salaryMax = const Value.absent(),
                required String customized,
                required String referral,
                Value<int?> confidenceMatch = const Value.absent(),
                Value<String?> responseDate = const Value.absent(),
                Value<String?> responseType = const Value.absent(),
                Value<String?> interviewDate = const Value.absent(),
                required String notes,
                Value<bool> isDirty = const Value.absent(),
                required String lastModified,
                Value<String?> lastSynced = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ApplicationsCompanion.insert(
                id: id,
                sheetRowId: sheetRowId,
                dateApplied: dateApplied,
                company: company,
                roleTitle: roleTitle,
                status: status,
                source: source,
                applicationMethod: applicationMethod,
                location: location,
                companySize: companySize,
                roleType: roleType,
                techStack: techStack,
                salaryMin: salaryMin,
                salaryMax: salaryMax,
                customized: customized,
                referral: referral,
                confidenceMatch: confidenceMatch,
                responseDate: responseDate,
                responseType: responseType,
                interviewDate: interviewDate,
                notes: notes,
                isDirty: isDirty,
                lastModified: lastModified,
                lastSynced: lastSynced,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ApplicationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ApplicationsTable,
      Application,
      $$ApplicationsTableFilterComposer,
      $$ApplicationsTableOrderingComposer,
      $$ApplicationsTableAnnotationComposer,
      $$ApplicationsTableCreateCompanionBuilder,
      $$ApplicationsTableUpdateCompanionBuilder,
      (
        Application,
        BaseReferences<_$AppDatabase, $ApplicationsTable, Application>,
      ),
      Application,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ApplicationsTableTableManager get applications =>
      $$ApplicationsTableTableManager(_db, _db.applications);
}
