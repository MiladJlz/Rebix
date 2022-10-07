import 'dart:async';
import 'dart:typed_data';
import 'package:easy_localization/easy_localization.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_rebix/controller/product_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class AddOrUpdateProduct extends StatefulWidget {
  final String? productName;
  final String? sellerName;
  final String? price;
  final int? key1;
  final Uint8List? imageUint8List;

  const AddOrUpdateProduct([
    this.productName,
    this.sellerName,
    this.price,
    this.imageUint8List,
    this.key1,
  ]);

  @override
  State<AddOrUpdateProduct> createState() => _AddOrUpdateProductState();
}

class _AddOrUpdateProductState extends State<AddOrUpdateProduct> {
  TextEditingController productNameController = TextEditingController();
  TextEditingController sellerNameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  Uint8List imageUint8ListTemp = Uint8List.fromList([]);
  ImagePicker picker = ImagePicker();
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    productNameController.text = widget.productName ?? "";
    sellerNameController.text = widget.sellerName ?? "";
    priceController.text = widget.price ?? "";
    imageUint8ListTemp = widget.imageUint8List ?? Uint8List.fromList([]);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    productNameController.dispose();
    sellerNameController.dispose();
    priceController.dispose();
  }

  bool returnValue = false;

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<ProductController>(context, listen: false);

    return WillPopScope(
        onWillPop: () async {
          FocusManager.instance.primaryFocus?.unfocus();
          bool willLeave = false;
          if (returnValue == false) {
            willLeave = true;
            Navigator.of(context).pop();
          }
          if (returnValue == true) {
            await showDialog(
                context: context,
                builder: (_) => AlertDialog(
                      title: Text('warning_dialog_body'.tr(),style: TextStyle(fontSize: 15),),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'cancel_button'.tr(),
                            )),
                        TextButton(
                            onPressed: () {
                              willLeave = true;

                              Navigator.of(context).pop();
                            },
                            child: Text('yes_button'.tr(),
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .color!))),
                      ],
                    ));
          }
          return willLeave;
        },
        child: Scaffold(
          appBar: AppBar(
            title: widget.key1 == null
                ? Text('add_product_title'.tr())
                : Text('edit_product_title'.tr()),
          ),
          body: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                              prefixIcon:
                                  const Icon(Icons.drive_file_rename_outline),
                              labelText: 'name_textfield'.tr(),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6))),
                          keyboardType: TextInputType.name,
                          controller: productNameController,
                          onChanged: (_) {
                            returnValue = true;
                          },
                          validator: (value) {
                            try {
                              if (value!.isEmpty) {
                                return 'warning_empty_field'.tr();
                              } else if (!RegExp(
                                      r"[آابپتثجچحخدذرزژسشصضطظعغفقکگلمنهیئؤA-Za-z]+$")
                                  .hasMatch(value)) {
                                return 'warning_invalid_field'.tr();
                              }
                            } catch (e) {
                              print(e.toString());
                            }
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.person),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            labelText: 'seller_name_textfield'.tr(),
                          ),
                          onChanged: (_) {
                            returnValue = true;
                          },
                          keyboardType: TextInputType.name,
                          controller: sellerNameController,
                          validator: (value) {
                            try {
                              if (value!.isEmpty) {
                                return 'warning_empty_field'.tr();
                              } else if (!RegExp(
                                      r"[آابپتثجچحخدذرزژسشصضطظعغفقکگلمنهیئؤA-Za-z]+$")
                                  .hasMatch(value)) {
                                return 'warning_invalid_field'.tr();
                              }
                            } catch (e) {
                              print(e.toString());
                            }
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.attach_money),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            labelText: 'price_textfield'.tr(),
                          ),
                          keyboardType: TextInputType.number,
                          controller: priceController,
                          onChanged: (string) {
                            try {
                              returnValue = true;
                              string = formNum(
                                string.replaceAll(',', ''),
                              );
                              priceController.value = TextEditingValue(
                                text: string,
                                selection: TextSelection.collapsed(
                                  offset: string.length,
                                ),
                              );
                            } catch (e) {
                              print(e.toString());
                            }
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'warning_empty_field'.tr();
                            } else if (!RegExp(r"^[0-9,]+$").hasMatch(value) &&
                                !RegExp(r"^[\u0660-\u0669]").hasMatch(value)) {
                              return 'warning_invalid_field'.tr();
                            }
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        FormField<Uint8List>(
                          validator: (value) {
                            if (imageUint8ListTemp.isEmpty) {
                              return 'select_image'.tr();
                            }
                          },
                          builder: (formFieldState) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    DottedBorder(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .color!,
                                      borderType: BorderType.RRect,
                                      radius: const Radius.circular(12),
                                      padding: const EdgeInsets.all(6),
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(12)),
                                        child: SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              .3,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .6,
                                          child: imageUint8ListTemp.isEmpty
                                              ? SizedBox(
                                                  height: 200,
                                                  width: 120,
                                                  child: Center(
                                                      child: Icon(
                                                    Icons
                                                        .image_not_supported_outlined,
                                                    size: 70,
                                                  )),
                                                )
                                              : Image.memory(
                                                  imageUint8ListTemp,
                                                  fit: BoxFit.contain,
                                                  frameBuilder: ((context,
                                                      child,
                                                      frame,
                                                      wasSynchronouslyLoaded) {
                                                    if (wasSynchronouslyLoaded) {
                                                      return child;
                                                    }
                                                    return AnimatedSwitcher(
                                                      duration: const Duration(
                                                          milliseconds: 200),
                                                      child: frame != null
                                                          ? child
                                                          : const CircularProgressIndicator(
                                                              strokeWidth: 6),
                                                    );
                                                  }),
                                                ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: -15,
                                      right: -15,
                                      child: CircleAvatar(
                                        radius: 30,
                                        child: IconButton(
                                          onPressed: () async {
                                            XFile? image =
                                                await picker.pickImage(
                                                    source:
                                                        ImageSource.gallery);

                                            var imageTemp = await getImage(image);

                                            setState(() {
                                              imageUint8ListTemp = imageTemp;

                                            });
                                            formFieldState.validate();
                                          },
                                          icon: const Icon(Icons.add_photo_alternate),
                                          iconSize: 30,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                if (formFieldState.hasError)
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 40, top: 10),
                                    child: Builder(builder: (context) {
                                      return Text(
                                        formFieldState.errorText!,
                                        style: const TextStyle(
                                            fontStyle: FontStyle.normal,
                                            fontSize: 13,
                                            color: Colors.red,
                                            height: 0.5),
                                      );
                                    }),
                                  ),
                              ],
                            );
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        RoundedLoadingButton(
                          controller: _btnController,
                          onPressed: widget.key1 == null
                              ? () async {
                                  if (formKey.currentState!.validate()) {
                                    await controller
                                        .add(
                                            productNameController.text,
                                            sellerNameController.text,
                                            priceController.text,
                                            imageUint8ListTemp)
                                        .then((value) =>
                                            _btnController.success());

                                    Future.delayed(const Duration(seconds: 2),
                                        () {
                                      setState(() {
                                        productNameController.clear();
                                        sellerNameController.clear();
                                        priceController.clear();
                                        imageUint8ListTemp =
                                            Uint8List.fromList([]);
                                        formKey = GlobalKey<FormState>();
                                      });

                                      returnValue = false;
                                    });
                                  } else {
                                    _btnController.error();
                                  }
                                  Timer(const Duration(seconds: 1), () {
                                    _btnController.reset();
                                  });
                                }
                              : () async {
                                  if (formKey.currentState!.validate() &&
                                      imageUint8ListTemp.isNotEmpty) {
                                    await controller
                                        .editProduct(
                                            productNameController.text,
                                            sellerNameController.text,
                                            priceController.text,
                                            imageUint8ListTemp,
                                            widget.key1!)
                                        .then((value) =>
                                            _btnController.success());

                                    returnValue = false;
                                  } else {
                                    _btnController.error();
                                  }
                                  Timer(const Duration(seconds: 1), () {
                                    _btnController.reset();
                                  });
                                },
                          child: Text(
                              widget.key1 == null
                                  ? 'save_button'.tr()
                                  : 'edit_button'.tr(),
                              style: const TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                  ))),
        ));
  }

  String formNum(String s) {
    return NumberFormat.decimalPattern().format(
      int.parse(s),
    );
  }

  Future<Uint8List> getImage(XFile? image) async {
 if(image?.path!=null){
   returnValue = true;
 }
    return image!.readAsBytes();
  }
}
