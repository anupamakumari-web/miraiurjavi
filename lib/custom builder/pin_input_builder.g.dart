// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pin_input_builder.dart';

// **************************************************************************
// Generator: JsonWidgetLibraryBuilder
// **************************************************************************

// ignore_for_file: avoid_init_to_null
// ignore_for_file: deprecated_member_use
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_constructors_in_immutables
// ignore_for_file: prefer_final_locals
// ignore_for_file: prefer_if_null_operators
// ignore_for_file: prefer_single_quotes
// ignore_for_file: unused_local_variable

class PinInputBuilder extends _PinInputBuilder {
  const PinInputBuilder({required super.args});

  static const kType = 'pin_input';

  /// Constant that can be referenced for the builder's type.
  @override
  String get type => kType;

  /// Static function that is capable of decoding the widget from a dynamic JSON
  /// or YAML set of values.
  static PinInputBuilder fromDynamic(
    dynamic map, {
    JsonWidgetRegistry? registry,
  }) => PinInputBuilder(args: map);

  @override
  PinInputBuilderModel createModel({
    ChildWidgetBuilder? childBuilder,
    required JsonWidgetData data,
  }) {
    final model = PinInputBuilderModel.fromDynamic(
      args,
      registry: data.jsonWidgetRegistry,
    );

    return model;
  }

  @override
  _PinInput buildCustom({
    ChildWidgetBuilder? childBuilder,
    required BuildContext context,
    required JsonWidgetData data,
    Key? key,
  }) {
    final model = createModel(childBuilder: childBuilder, data: data);

    return _PinInput(
      controller: model.controller,
      cursor: model.cursor?.build(childBuilder: childBuilder, context: context),
      key: key,
      length: model.length,
      onChanged: model.onChanged,
    );
  }
}

class JsonPinInput extends JsonWidgetData {
  JsonPinInput({
    Map<String, dynamic> args = const {},
    JsonWidgetRegistry? registry,
    this.controller,
    this.cursor,
    this.length,
    this.onChanged,
  }) : super(
         jsonWidgetArgs: PinInputBuilderModel.fromDynamic(
           {
             'controller': controller,
             'cursor': cursor,
             'length': length,
             'onChanged': onChanged,

             ...args,
           },
           args: args,
           registry: registry,
         ),
         jsonWidgetBuilder: () => PinInputBuilder(
           args: PinInputBuilderModel.fromDynamic(
             {
               'controller': controller,
               'cursor': cursor,
               'length': length,
               'onChanged': onChanged,

               ...args,
             },
             args: args,
             registry: registry,
           ),
         ),
         jsonWidgetType: PinInputBuilder.kType,
       );

  final TextEditingController? controller;

  final JsonWidgetData? cursor;

  final int? length;

  final dynamic Function(String)? onChanged;
}

class PinInputBuilderModel extends JsonWidgetBuilderModel {
  const PinInputBuilderModel(
    super.args, {
    this.controller,
    this.cursor,
    this.length,
    this.onChanged,
  });

  final TextEditingController? controller;

  final JsonWidgetData? cursor;

  final int? length;

  final dynamic Function(String)? onChanged;

  static PinInputBuilderModel fromDynamic(
    dynamic map, {
    Map<String, dynamic> args = const {},
    JsonWidgetRegistry? registry,
  }) {
    final result = maybeFromDynamic(map, args: args, registry: registry);

    if (result == null) {
      throw Exception(
        '[PinInputBuilder]: requested to parse from dynamic, but the input is null.',
      );
    }

    return result;
  }

  static PinInputBuilderModel? maybeFromDynamic(
    dynamic map, {
    Map<String, dynamic> args = const {},
    JsonWidgetRegistry? registry,
  }) {
    PinInputBuilderModel? result;

    if (map != null) {
      if (map is String) {
        map = yaon.parse(map, normalize: true);
      }

      if (map is PinInputBuilderModel) {
        result = map;
      } else {
        registry ??= JsonWidgetRegistry.instance;
        map = registry.processArgs(map, <String>{}).value;
        result = PinInputBuilderModel(
          args,
          controller: map['controller'],
          cursor: () {
            dynamic parsed = JsonWidgetData.maybeFromDynamic(
              map['cursor'],
              registry: registry,
            );

            return parsed;
          }(),
          length: () {
            dynamic parsed = JsonClass.maybeParseInt(map['length']);

            return parsed;
          }(),
          onChanged: map['onChanged'],
        );
      }
    }

    return result;
  }

  @override
  Map<String, dynamic> toJson() {
    return JsonClass.removeNull({
      'controller': controller,
      'cursor': cursor?.toJson(),
      'length': length,
      'onChanged': onChanged,

      ...args,
    });
  }
}

class PinInputSchema {
  static const id =
      'https://peiffer-innovations.github.io/flutter_json_schemas/schemas/miraiurjavi_app/pin_input.json';

  static final schema = <String, Object>{
    r'$schema': 'http://json-schema.org/draft-07/schema#',
    r'$id': id,
    'title': '_PinInput',
    'type': 'object',
    'additionalProperties': false,
    'properties': {
      'controller': SchemaHelper.anySchema,
      'cursor': SchemaHelper.objectSchema(JsonWidgetDataSchema.id),
      'length': SchemaHelper.numberSchema,
      'onChanged': SchemaHelper.anySchema,
    },
    'required': [],
  };
}
