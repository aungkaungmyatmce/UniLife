import 'package:blog_post_flutter/app/constant/app_colors.dart';
import 'package:blog_post_flutter/app/constant/app_dimens.dart';
import 'package:blog_post_flutter/app/constant/string.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputFormFieldWidget extends StatelessWidget {
  final TextEditingController textEditingController;
  final String parametersValidate;
  final Color bgColor;
  final Color cursorColor;
  final bool isReadOnly;
  final int maxLine;
  final textInputType;
  final autoFocus;
  final obscureText;
  final bool showTrailingIcon;
  final String hintText;
  final double formRadius;
  final Color formColor;
  final Color formBorderColor;
  final double contentPadding;
  final double formBorderWidth;
  final Widget trailingIconWidget;
  final TextInputAction textInputAction;
  final Function? commonValidation;
  final Function? onTextChange;
  final Widget? suffixIcon;
  final inputFormatters;

  InputFormFieldWidget(this.textEditingController,
      {this.parametersValidate = Constant.textParameterValidate,
      this.isReadOnly = false,
      this.textInputType = TextInputType.text,
      this.maxLine = 1,
      this.bgColor = AppColors.whiteColor,
      this.cursorColor = AppColors.primaryColor,
      this.autoFocus = false,
      this.obscureText = false,
      this.showTrailingIcon = false,
      this.hintText = "",
      this.formRadius = 10,
      this.formColor = AppColors.whiteColor,
      this.formBorderColor = AppColors.spaceGrayColor,
      this.contentPadding = AppDimens.MARGIN_CARD_MEDIUM,
      this.formBorderWidth = 1,
      this.onTextChange,
      this.suffixIcon,
      this.inputFormatters,
      this.trailingIconWidget = const Icon(
        Icons.chevron_right,
      ),
      this.textInputAction = TextInputAction.done,
      this.commonValidation});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: cursorColor,
      inputFormatters: inputFormatters,
      controller: textEditingController,
      readOnly: isReadOnly,
      keyboardType: textInputType,
      obscureText: obscureText,
      textInputAction: textInputAction,
      toolbarOptions: const ToolbarOptions(
          paste: true, cut: true, selectAll: true, copy: true),
      maxLines: maxLine,
      autofocus: autoFocus,
      onTap: () {
        print("I'm here!!!");
      },
      validator: (value) => commonValidation != null
          ? commonValidation!(
              value,
              parametersValidate,
            )
          : null,
      onChanged: (text) => onTextChange == null ? {} : onTextChange!(text),
      decoration: InputDecoration(
        fillColor: formColor,
        suffixIcon: showTrailingIcon ? trailingIconWidget : suffixIcon,
        isDense: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(formRadius),
          ),
          borderSide: BorderSide(
            color: formBorderColor,
            width: formBorderWidth,
          ),
        ),
        errorStyle: const TextStyle(
          color: Colors.red,
          fontSize: 16,
          fontWeight: FontWeight.w300,
          fontStyle: FontStyle.normal,
          letterSpacing: 1.2,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(formRadius),
          ),
          borderSide: BorderSide(color: formBorderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(formRadius),
          ),
          borderSide:
              BorderSide(color: formBorderColor, width: formBorderWidth),
        ),
        focusedErrorBorder: isReadOnly
            ? const OutlineInputBorder(borderSide: BorderSide.none)
            : OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(formRadius),
                ),
                borderSide:
                    BorderSide(color: formBorderColor, width: formBorderWidth),
              ),
        filled: true,
        hintText: hintText,
        hintStyle: const TextStyle(
          color: AppColors.textColor,
          fontSize: 12,
        ),
        //fillColor: Colors.grey.shade400,
        contentPadding: EdgeInsets.all(contentPadding),
      ),
    );
  }
}
