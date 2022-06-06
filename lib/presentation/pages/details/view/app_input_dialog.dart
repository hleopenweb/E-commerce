// Dart imports:
import 'dart:math';

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:sajilo_dokan/presentation/pages/details/view/svg_icon.dart';

import 'circle_icon.dart';
import 'custom_button.dart';

class AppInputDialogController {
  _AppInputDialogState? state;

  void bindState(_AppInputDialogState state) {
    this.state = state;
  }

  void setText(String text) {
    state?._controller.text = text;
  }

  void setIsLoading(bool isLoading) {
    FocusManager.instance.primaryFocus?.unfocus();
    state?._isLoading.value = isLoading;
  }

  void close() {
    Get.back();
  }

  void dispose() {
    state = null;
  }
}

class AppInputDialog extends StatefulWidget {
  final AppInputDialogController? controller;

  final String title;
  final String? subTitle;
  final String? placeHolder;
  final String? content;
  final int? maxLength;
  final ValueChanged<String?>? onChange;
  final bool Function(String text)? submitButtonValidator;
  final String submitButtonTitle;
  final ValueChanged<String> onSubmit;
  final String? cancelButtonTitle;
  final ValueChanged<String>? onCancel;
  final VoidCallback? onClose;

  static void showInputDialog({
    AppInputDialogController? controller,
    required String title,
    String? subTitle,
    String? placeHolder,
    String? content,
    int? maxLength,
    ValueChanged<String?>? onChange,
    bool Function(String text)? confirmButtonValidator,
    required String submitButtonTitle,
    required ValueChanged<String> onSubmit,
    String? cancelButtonTitle,
    ValueChanged<String>? onCancel,
    VoidCallback? onClose,
  }) {
    final inputDialog = AppInputDialog._(
      controller: controller,
      title: title,
      subTitle: subTitle,
      placeHolder: placeHolder,
      content: content,
      maxLength: maxLength,
      onChange: onChange,
      submitButtonValidator: confirmButtonValidator,
      submitButtonTitle: submitButtonTitle,
      onSubmit: onSubmit,
      cancelButtonTitle: cancelButtonTitle,
      onCancel: onCancel,
      onClose: onClose,
    );

    const alertStyle = AlertStyle(
      alertElevation: 0,
      isCloseButton: false,
      backgroundColor: Colors.transparent,
      overlayColor: Colors.black54,
      alertBorder: Border(),
      alertPadding: EdgeInsets.zero,
      buttonAreaPadding: EdgeInsets.zero,
    );

    Alert(
      context: Get.overlayContext!,
      buttons: [],
      style: alertStyle,
      content: inputDialog,
    ).show();
  }

  const AppInputDialog._({
    this.controller,
    required this.title,
    this.subTitle,
    this.placeHolder,
    this.content,
    this.maxLength,
    this.onChange,
    this.submitButtonValidator,
    required this.submitButtonTitle,
    required this.onSubmit,
    this.cancelButtonTitle,
    this.onCancel,
    this.onClose,
  });

  @override
  State<AppInputDialog> createState() => _AppInputDialogState();
}

class _AppInputDialogState extends State<AppInputDialog> {
  static const double _horizontalPadding = 30;
  static const double _minimumDialogWidth = 300;
  static const double _inputFieldHeight = 130;
  static const double _dialogPadding = 16;

  final ValueNotifier<bool> _isLoading = ValueNotifier<bool>(false);
  final ValueNotifier<bool> _submitButtonEnabled = ValueNotifier<bool>(true);
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    widget.controller?.bindState(this);
    _controller.text = widget.content ?? '';
    _submitButtonEnabled.value =
        widget.submitButtonValidator?.call(_controller.text) ?? true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: min(_minimumDialogWidth, Get.width - 2 * _horizontalPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Close button
            Row(
              children: [
                const Spacer(),
                CircleIcon(
                  padding: EdgeInsets.zero,
                  icon: const SvgIcon(
                    icon: 'assets/icon_delete.svg',
                    color: Colors.black,
                    size: 18,
                  ),
                  backgroundColor: Colors.black,
                  onPressed: () {
                    widget.onClose?.call();
                    Get.back();
                  },
                ),
              ],
            ),
            const SizedBox(height: _dialogPadding),
            Container(
              padding: const EdgeInsets.all(_dialogPadding),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: kElevationToShadow[4],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Title label
                  Text(
                    widget.title,
                    style: GoogleFonts.beVietnam(
                      color: Color(0xff222D39),
                      fontSize: 23,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: _dialogPadding),

                  // Subtitle label
                  if (widget.subTitle != null &&
                      widget.subTitle!.isNotEmpty) ...[
                    Text(
                      widget.subTitle!,
                      style: GoogleFonts.beVietnam(color: Color(0x0ffa8a8a)),
                      maxLines: 2,
                    ),
                    const SizedBox(height: _dialogPadding),
                  ],

                  // Input
                  SizedBox(
                    height: _inputFieldHeight,
                    child: Form(
                      key: _formKey,
                      child: ValueListenableBuilder<bool>(
                          valueListenable: _isLoading,
                          builder: (context, isLoading, child) {
                            return _buildInputField();
                          }),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Buttons
                  ValueListenableBuilder<bool>(
                    valueListenable: _submitButtonEnabled,
                    builder: (context, valid, child) {
                      return ValueListenableBuilder<bool>(
                          valueListenable: _isLoading,
                          builder: (context, isLoading, child) {
                            return _buildButtons();
                          });
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildButtons() {
    final List<Widget> buttons = [];

    if (widget.cancelButtonTitle != null) {
      buttons.addAll([
        Expanded(
          child: CustomButton(
            title: widget.cancelButtonTitle,
            style: CustomButtonStyle.empty,
            showBorder: true,
            onPressed: () {
              widget.onCancel?.call(_controller.text);
            },
          ),
        ),
        const SizedBox(width: _dialogPadding),
      ]);
    }

    final submitButton = CustomButton(
      isLoading: _isLoading.value,
      minWidth: 130,
      title: widget.submitButtonTitle,
      onPressed: _submitButtonEnabled.value
          ? () {
              widget.onSubmit(_controller.text);
            }
          : null,
    );

    buttons.add(
      buttons.length > 1 ? Expanded(child: submitButton) : submitButton,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: buttons,
    );
  }

  Widget _buildInputField() {
    return Material(
      child: TextFormField(
        readOnly: _isLoading.value,
        enableInteractiveSelection: !_isLoading.value,
        maxLength: widget.maxLength,
        maxLengthEnforcement: MaxLengthEnforcement.enforced,
        controller: _controller,
        keyboardType: TextInputType.multiline,
        maxLines: 10000,
        autofocus: true,
        toolbarOptions: const ToolbarOptions(
          copy: true,
          cut: true,
          paste: true,
          selectAll: true,
        ),
        onChanged: (text) {
          _submitButtonEnabled.value =
              widget.submitButtonValidator?.call(text) ?? true;
        },
        style: GoogleFonts.beVietnam(
          fontSize: 15,
          color: Color(0xff222d398),
          fontWeight: FontWeight.w400,
        ),
        cursorColor: Color(0xff222d39),
        decoration: InputDecoration(
          isDense: true,
          filled: true,
          enabledBorder: _inputBorder(),
          focusedBorder: _inputBorder(),
          errorBorder: _inputBorder(),
          border: _inputBorder(),
          fillColor: Color(0xffE1E1E1),
          disabledBorder: _inputBorder(),
          focusedErrorBorder: _inputBorder(),
          hintText: widget.placeHolder,
          hintStyle: GoogleFonts.beVietnam(
            fontSize: 15,
            color: Color(0x0ffa8a8a),
          ),
          contentPadding: const EdgeInsets.all(10),
          // counter: Container(),
        ),
      ),
    );
  }

  OutlineInputBorder _inputBorder() => OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(color: Color(0xffE1E1E1)),
      );
}
