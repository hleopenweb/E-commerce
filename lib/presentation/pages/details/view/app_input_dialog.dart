// Dart imports:
import 'dart:math';

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

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
  final String submitButtonTitle;
  final Function(double rating)? onSubmit;
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
    bool Function(double rating)? confirmButtonValidator,
    required String submitButtonTitle,
    required Function(double rating)? onSubmit,
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
  static const double _dialogPadding = 16;

  int index = 0;
  double rating = 3;

  final ValueNotifier<bool> _isLoading = ValueNotifier<bool>(false);
  final ValueNotifier<bool> _submitButtonEnabled = ValueNotifier<bool>(true);
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    widget.controller?.bindState(this);
    _controller.text = widget.content ?? '';
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
                  icon: IconButton(
                    iconSize: 32,
                    padding: EdgeInsets.zero,
                    icon: Icon(Icons.cancel),
                    color: Colors.black,
                    onPressed: () {
                      widget.onClose?.call();
                      Get.back();
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: _dialogPadding / 2),
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
                  const SizedBox(height: _dialogPadding / 2),
                  // Subtitle label
                  if (widget.subTitle != null &&
                      widget.subTitle!.isNotEmpty) ...[
                    Text(
                      widget.subTitle!,
                      style: GoogleFonts.beVietnam(
                        color: Colors.black.withOpacity(0.5),
                        fontSize: 14,
                      ),
                      maxLines: 2,
                    ),
                    const SizedBox(height: _dialogPadding),
                  ],
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RatingBar.builder(
                        itemSize: 32,
                        allowHalfRating: true,
                        initialRating: 3,
                        itemBuilder: (context, index) {
                          switch (index) {
                            case 0:
                              return Icon(
                                Icons.sentiment_very_dissatisfied,
                                color: Colors.red,
                              );
                            case 1:
                              return Icon(
                                Icons.sentiment_dissatisfied,
                                color: Colors.redAccent,
                              );
                            case 2:
                              return Icon(
                                Icons.sentiment_neutral,
                                color: Colors.amber,
                              );
                            case 3:
                              return Icon(
                                Icons.sentiment_satisfied,
                                color: Colors.lightGreen,
                              );
                            case 4:
                              return Icon(
                                Icons.sentiment_very_satisfied,
                                color: Colors.green,
                              );
                            default:
                              return Icon(
                                Icons.sentiment_very_dissatisfied,
                                color: Colors.red,
                              );
                          }
                        },
                        onRatingUpdate: (rating) {
                          setState(() {
                            this.rating = rating;
                          });
                        },
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '$rating',
                              style: GoogleFonts.beVietnam(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: getColor(rating),
                              ),
                            ),
                            TextSpan(
                              text: ' /5',
                              style: GoogleFonts.beVietnam(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
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

  Color getColor(double rating) {
    switch (rating.toInt()) {
      case 1:
        return Colors.red;
      case 2:
        return Colors.redAccent;
      case 3:
        return Colors.amber;
      case 4:
        return Colors.lightGreen;
      case 5:
        return Colors.green;
      default:
        return Colors.red;
    }
  }

  Widget _buildButtons() {
    final List<Widget> buttons = [];

    if (widget.cancelButtonTitle != null) {
      buttons.addAll([
        Expanded(
          child: CustomButton(
            isLoading: true,
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
      fontWeight: FontWeight.w700,
      title: widget.submitButtonTitle,
      onPressed: _submitButtonEnabled.value
          ? () {
              widget.onSubmit!(rating);
              Get.back();
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
}
