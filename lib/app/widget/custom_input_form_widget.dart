import 'package:blog_post_flutter/app/constant/app_colors.dart';
import 'package:blog_post_flutter/app/constant/app_dimens.dart';
import 'package:blog_post_flutter/app/widget/text_view_widget.dart';
import 'package:flutter/material.dart';


class CustomInputFormWidget extends StatelessWidget {
  final TextEditingController textEditingController;
  final String discountText;

  const CustomInputFormWidget(this.textEditingController,{this.discountText = "% OFF"});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.formFieldBorderColor,
          borderRadius: BorderRadius.circular(AppDimens.MARGIN_MEDIUM)),
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Row(
          children: [
            Expanded(
                child: TextFormField(
              cursorColor: AppColors.primaryColor,
              inputFormatters: null,
              controller: textEditingController,
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.done,
              toolbarOptions: const ToolbarOptions(
                  paste: true, cut: true, selectAll: true, copy: true),
              maxLines: 1,
              autofocus: false,
              decoration: const InputDecoration(
                fillColor: AppColors.whiteColor,
                isDense: true,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(0),
                    topLeft: Radius.circular(AppDimens.MARGIN_MEDIUM),
                    bottomLeft: Radius.circular(AppDimens.MARGIN_MEDIUM),
                    bottomRight: Radius.circular(0),
                  ),
                  borderSide: BorderSide(
                    color: AppColors.whiteColor,
                  ),
                ),
                errorStyle: TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                  fontStyle: FontStyle.normal,
                  letterSpacing: 1.2,
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(AppDimens.MARGIN_MEDIUM),
                    bottomLeft: Radius.circular(AppDimens.MARGIN_MEDIUM),
                  ),
                  borderSide: BorderSide(color: AppColors.whiteColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(AppDimens.MARGIN_MEDIUM),
                    bottomLeft: Radius.circular(AppDimens.MARGIN_MEDIUM),
                  ),
                  borderSide: BorderSide(color: AppColors.whiteColor),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(AppDimens.MARGIN_MEDIUM),
                    bottomLeft: Radius.circular(AppDimens.MARGIN_MEDIUM),
                  ),
                  borderSide: BorderSide(color: AppColors.whiteColor),
                ),
                filled: true,
                hintText: "0",
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
                contentPadding: EdgeInsets.all(AppDimens.MARGIN_CARD_MEDIUM),
              ),
            )),
            Container(
                decoration: const BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(AppDimens.MARGIN_MEDIUM),
                      bottomRight: Radius.circular(AppDimens.MARGIN_MEDIUM),
                    )),
                child: Padding(
                    padding: const EdgeInsets.all(AppDimens.MARGIN_CARD_MEDIUM),
                    child: TextViewWidget(
                      discountText,
                      textSize: AppDimens.TEXT_REGULAR,
                      textColor: AppColors.whiteColor,
                      fontWeight: FontWeight.w700,
                    )))
          ],
        ),
      ),
    );
  }
}
