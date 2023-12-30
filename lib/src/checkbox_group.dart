// Copyright 2020 Joan Pablo Jimenez Milian. All rights reserved.
// Use of this source code is governed by the MIT license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

typedef CheckboxWidgetBuilder<V> = Widget Function(
    BuildContext context, V value);

typedef ListBuilder = Widget Function(
    BuildContext context, Iterable<CheckboxListTile> values);

/// This is a convenience widget that wraps a [CheckboxListTile] widget in a
/// [ReactiveCheckboxGroupListTile].
class ReactiveCheckboxGroupListTile<T, V>
    extends ReactiveFocusableFormField<List<T>, List<V>> {
  /// Create an instance of a [ReactiveCheckboxGroupListTile].
  ///
  /// Can optionally provide a [formControl] to bind this widget to a control.
  ///
  /// Can optionally provide a [formControlName] to bind this ReactiveFormField
  /// to a [FormControl].
  ///
  /// Must provide one of the arguments [formControl] or a [formControlName],
  /// but not both at the same time.
  ///
  /// For documentation about the various parameters, see the [CheckboxListTile]
  /// class and the [CheckboxListTile] constructor.
  ///
  /// [minimumOptions] represents the minimum number of options that must be selected.
  ///
  /// [listBuilder] is a function that allows you to customize the list of options.
  ReactiveCheckboxGroupListTile({
    Key? key,
    String? formControlName,
    FormControl<List<T>>? formControl,
    required List<V> options,
    Color? activeColor,
    Color? checkColor,
    required CheckboxWidgetBuilder<V> titleBuilder,
    CheckboxWidgetBuilder<V>? subtitleBuilder,
    bool isThreeLine = false,
    bool selected = false,
    bool? dense,
    Widget? secondary,
    ListTileControlAffinity controlAffinity = ListTileControlAffinity.platform,
    bool autofocus = false,
    EdgeInsetsGeometry? contentPadding,
    bool tristate = false,
    Color? selectedTileColor,
    Color? tileColor,
    ShapeBorder? shape,
    VisualDensity? visualDensity,
    FocusNode? focusNode,
    bool? enableFeedback,
    OutlinedBorder? checkboxShape,
    BorderSide? side,
    ReactiveFormFieldCallback<List<T>>? onChanged,
    MouseCursor? mouseCursor,
    MaterialStateProperty<Color?>? fillColor,
    Color? hoverColor,
    MaterialStateProperty<Color?>? overlayColor,
    double? splashRadius,
    MaterialTapTargetSize? materialTapTargetSize,
    ValueChanged<bool>? onFocusChange,
    ShowErrorsFunction<List<T>>? showErrors,
    int minimumOptions = 0,
    ListBuilder? listBuilder,
    ControlValueAccessor<List<T>, List<V>>? valueAccessor,
  }) : super(
          valueAccessor: valueAccessor,
          key: key,
          formControl: formControl,
          formControlName: formControlName,
          focusNode: focusNode,
          showErrors: showErrors ??
              (control) =>
                  control.invalid && (control.dirty || control.touched),
          builder: (field) {
            return Builder(builder: (context) {
              if (listBuilder != null) {
                return listBuilder(
                  context,
                  options.map((option) {
                    return CheckboxListTile(
                      value: (field.value ?? []).contains(option),
                      mouseCursor: mouseCursor,
                      fillColor: fillColor,
                      hoverColor: hoverColor,
                      overlayColor: overlayColor,
                      materialTapTargetSize: materialTapTargetSize,
                      splashRadius: splashRadius,
                      activeColor: activeColor,
                      checkColor: checkColor,
                      onFocusChange: onFocusChange,
                      isError: field.errorText != null,
                      title: titleBuilder.call(context, option),
                      subtitle: subtitleBuilder?.call(context, option),
                      isThreeLine: isThreeLine,
                      dense: dense,
                      secondary: secondary,
                      controlAffinity: controlAffinity,
                      autofocus: autofocus,
                      contentPadding: contentPadding,
                      tristate: tristate,
                      selectedTileColor: selectedTileColor,
                      tileColor: tileColor,
                      shape: shape,
                      selected: selected,
                      visualDensity: visualDensity,
                      focusNode: field.focusNode,
                      enableFeedback: enableFeedback,
                      checkboxShape: checkboxShape,
                      side: side,
                      enabled: field.control.enabled,
                      onChanged: field.control.enabled
                          ? (value) {
                              _onChanged(
                                value ?? false,
                                field,
                                option,
                                minimumOptions,
                                valueAccessor,
                              );
                              onChanged?.call(field.control);
                            }
                          : null,
                    );
                  }),
                );
              }
              return ListView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  ...options.map((option) {
                    return CheckboxListTile(
                      value: (field.value ?? []).contains(option),
                      mouseCursor: mouseCursor,
                      fillColor: fillColor,
                      hoverColor: hoverColor,
                      overlayColor: overlayColor,
                      materialTapTargetSize: materialTapTargetSize,
                      splashRadius: splashRadius,
                      activeColor: activeColor,
                      checkColor: checkColor,
                      onFocusChange: onFocusChange,
                      isError: field.errorText != null,
                      title: titleBuilder.call(context, option),
                      subtitle: subtitleBuilder?.call(context, option),
                      isThreeLine: isThreeLine,
                      dense: dense,
                      secondary: secondary,
                      controlAffinity: controlAffinity,
                      autofocus: autofocus,
                      contentPadding: contentPadding,
                      tristate: tristate,
                      selectedTileColor: selectedTileColor,
                      tileColor: tileColor,
                      shape: shape,
                      selected: selected,
                      visualDensity: visualDensity,
                      focusNode: field.focusNode,
                      enableFeedback: enableFeedback,
                      checkboxShape: checkboxShape,
                      side: side,
                      enabled: field.control.enabled,
                      onChanged: field.control.enabled
                          ? (value) {
                              _onChanged(
                                value ?? false,
                                field,
                                option,
                                minimumOptions,
                                valueAccessor,
                              );
                              onChanged?.call(field.control);
                            }
                          : null,
                    );
                  }),
                ],
              );
            });
          },
        );

  static void _onChanged<T, V>(
    bool value,
    ReactiveFormFieldState<List<T>, List<V>> field,
    V option,
    int minimumOptions,
    ControlValueAccessor<List<T>, List<V>>? valueAccessor,
  ) {
    // make sure at least one value is selected
    if (field.value?.length == minimumOptions && value == false) {
      return;
    }
    if (value == true) {
      // add the value to the list
      field.didChange([...?field.value, option]);
    } else {
      // remove the value from the list
      field.didChange([...?field.value]..remove(option));
    }
  }
}
