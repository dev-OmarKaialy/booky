import 'dart:typed_data';

import 'package:book_catalog/core/configs/image_helper.dart';
import 'package:book_catalog/core/extensions/context_extensions.dart';
import 'package:book_catalog/core/widgets/main_text_field.dart';
import 'package:book_catalog/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../bloc/home_bloc.dart';

class AddBookDialog extends StatefulWidget {
  const AddBookDialog({super.key});

  @override
  State<AddBookDialog> createState() => _AddBookDialogState();
}

class _AddBookDialogState extends State<AddBookDialog> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final authorController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final ValueNotifier<DateTime?> dateTime = ValueNotifier(null);
  final ValueNotifier<Uint8List?> image = ValueNotifier(null);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Dialog(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: context.scaffoldBackgroundColor,
          ),
          padding: const EdgeInsets.all(15),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: .72.sh,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Center(
                          child: Text(
                            LocaleKeys.addBookDialog_addNewBook.tr(),
                            style: context.textTheme.titleLarge,
                          ),
                        ),
                        20.verticalSpace,
                        MainTextField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: titleController,
                            text: LocaleKeys.addBookDialog_title.tr(),
                            hint: 'The Hobbit',
                            textInputAction: TextInputAction.next,
                            validator: (text) {
                              if (text != null && text.length > 4) {
                                return null;
                              } else {
                                return LocaleKeys.addBookDialog_titleValidation
                                    .tr();
                              }
                            }),
                        20.verticalSpace,
                        MainTextField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            textInputAction: TextInputAction.next,
                            controller: authorController,
                            text: LocaleKeys.addBookDialog_author.tr(),
                            hint: 'George R R Martin',
                            validator: (text) {
                              if (text != null && text.length > 4) {
                                return null;
                              } else {
                                return LocaleKeys.addBookDialog_authorValidation
                                    .tr();
                              }
                            }),
                        20.verticalSpace,
                        ValueListenableBuilder(
                            valueListenable: dateTime,
                            builder: (context, value, _) {
                              return GestureDetector(
                                onTap: () {
                                  showDatePicker(
                                          context: context,
                                          initialDate: DateTime.utc(2001),
                                          firstDate: DateTime.utc(1970),
                                          lastDate: DateTime.now())
                                      .then((value) {
                                    dateTime.value = value;
                                  });
                                },
                                child: MainTextField(
                                  autovalidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  text: LocaleKeys.addBookDialog_publicationDate
                                      .tr(),
                                  validator: (text) {
                                    if (text != null && text.length > 5) {
                                      return null;
                                    } else {
                                      return LocaleKeys
                                          .addBookDialog_publicationValidation
                                          .tr();
                                    }
                                  },
                                  controller: TextEditingController(
                                      text: value != null
                                          ? DateFormat('yyyy - MM - dd')
                                              .format(value)
                                          : ''),
                                  hint: '2001 - 01 - 01',
                                  enabled: false,
                                ),
                              );
                            }),
                        20.verticalSpace,
                        MainTextField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          textInputAction: TextInputAction.done,
                          controller: descriptionController,
                          text: LocaleKeys.addBookDialog_description.tr(),
                          hint: 'Lorem Ipsum ....',
                          maxLines: 3,
                          validator: (text) {
                            if (text != null && text.length > 12) {
                              return null;
                            } else {
                              return LocaleKeys
                                  .addBookDialog_descriptionValidation
                                  .tr();
                            }
                          },
                        ),
                        20.verticalSpace,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(LocaleKeys.addBookDialog_bookCover.tr(),
                                style: context.textTheme.bodyLarge
                                    ?.copyWith(fontSize: 16)),
                            10.verticalSpace,
                            ValueListenableBuilder(
                                valueListenable: image,
                                builder: (context, value, _) {
                                  return Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          ImageHelper.pickImage().then((value) {
                                            if (value != null) {
                                              image.value = value;
                                            }
                                          });
                                        },
                                        child: Container(
                                          height: 100.sp,
                                          width: 80.sp,
                                          decoration: BoxDecoration(
                                            border: Border.all(),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          clipBehavior: Clip.hardEdge,
                                          child: value != null
                                              ? Image.memory(
                                                  value,
                                                  fit: BoxFit.cover,
                                                )
                                              : const Icon(Icons.image),
                                        ),
                                      ),
                                      value == null
                                          ? const SizedBox()
                                          : PositionedDirectional(
                                              top: -6,
                                              end: -6,
                                              child: GestureDetector(
                                                onTap: () {
                                                  image.value = null;
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color:
                                                          context.primaryColor),
                                                  child: Icon(
                                                    Icons.close_rounded,
                                                    color: context
                                                        .scaffoldBackgroundColor,
                                                  ),
                                                ),
                                              ),
                                            )
                                    ],
                                  );
                                })
                          ],
                        ),
                        10.verticalSpace,
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: context.primaryColor),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          context.read<HomeBloc>().add(
                                AddBookEvent(
                                  title: titleController.text,
                                  description: descriptionController.text,
                                  author: authorController.text,
                                  publication: dateTime.value!,
                                  image: image.value,
                                ),
                              );
                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        LocaleKeys.general_add.tr(),
                        style: context.textTheme.titleMedium?.copyWith(
                            color: context.theme.colorScheme.onPrimary),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: context.primaryColor.withOpacity(.2),
                          elevation: 00),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        LocaleKeys.general_cancel.tr(),
                        style: context.textTheme.titleMedium?.copyWith(
                          color: context.theme.colorScheme.onSurface,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
