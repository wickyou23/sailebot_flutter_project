import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sailebot_app/enum/text_field_enum.dart';
import 'package:sailebot_app/screens/sailebot_setup/sailebot_setup_confirm_screen.dart';
import 'package:sailebot_app/services/local_store_service.dart';
import 'package:sailebot_app/utils/extension.dart';
import 'package:sailebot_app/widgets/custom_navigation_bar.dart';
import 'package:sailebot_app/widgets/custom_textformfield.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateProfileScreen extends StatefulWidget {
  static final routeName = '/UpdateProfileScreen';

  @override
  _UpdateProfileScreenState createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _genderController = TextEditingController();
  final _industryController = TextEditingController();
  final _productController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  final _firstNameFC = FocusNode();
  final _lastNameFC = FocusNode();
  final _productFC = FocusNode();
  final _emailFC = FocusNode();
  final _phoneFC = FocusNode();
  final _genderFC = FocusNode();

  final _maxImage = 140.0;
  final _ratioTopImage = 0.4453703704;
  final _imagePicker = ImagePicker();
  final _listGender = const ['Male', 'Female'];
  final _listIndustry = const ['Industry_1', 'Industry_2', 'Industry_3'];

  double _heighTopImage;
  File _image;
  bool _isShowNaviBar = false;

  @override
  void didChangeDependencies() {
    _heighTopImage = context.media.size.width * _ratioTopImage;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    _isShowNaviBar = context.routeArg as bool ?? false;

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Stack(
          children: [
            SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                children: <Widget>[
                  Container(
                    height: _heighTopImage + 70,
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          top: 0,
                          width: context.media.size.width,
                          height: _heighTopImage,
                          child: Image.asset(
                            'assets/images/top_bg.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: _heighTopImage / 2 + 10,
                          left: (context.media.size.width / 2) - 70,
                          child: Container(
                            height: 140,
                            width: 140,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(_maxImage / 2),
                              boxShadow: [
                                BoxShadow(color: Colors.grey, blurRadius: 8.0)
                              ],
                            ),
                            child: GestureDetector(
                              child: (_image == null)
                                  ? ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(_maxImage / 2),
                                      child: Image.asset(
                                        'assets/images/default_avatar.png',
                                        fit: BoxFit.cover,
                                        width: _maxImage,
                                        height: _maxImage,
                                      ),
                                    )
                                  : ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(_maxImage / 2),
                                      child: Image.file(
                                        _image,
                                        fit: BoxFit.cover,
                                        width: _maxImage,
                                        height: _maxImage,
                                      ),
                                    ),
                              onTap: () async {
                                _getImage();
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                    ),
                    child: Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          SizedBox(height: 30),
                          CustomTextFormField(
                            key: ValueKey('_fistNameKey'),
                            controller: _firstNameController,
                            focusNode: _firstNameFC,
                            title: 'First Name',
                            placeHolder: 'First name',
                            textFieldStyle: CustomTextFormFieldType.normalStyle,
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (vl) {
                              context.focus.unfocus();
                              context.focus.requestFocus(_lastNameFC);
                            },
                          ),
                          SizedBox(height: 25),
                          CustomTextFormField(
                            key: ValueKey('_lastNameKey'),
                            controller: _lastNameController,
                            focusNode: _lastNameFC,
                            title: 'Last Name',
                            placeHolder: 'Last name',
                            textFieldStyle: CustomTextFormFieldType.normalStyle,
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (vl) {
                              context.focus.unfocus();
                              context.focus.requestFocus(_genderFC);
                              _showListGender();
                            },
                          ),
                          SizedBox(height: 25),
                          CustomTextFormField(
                            key: ValueKey('_genderKey'),
                            controller: _genderController,
                            focusNode: _genderFC,
                            title: 'Gender',
                            placeHolder: 'Select one',
                            readOnly: true,
                            textFieldStyle: CustomTextFormFieldType.normalStyle,
                            suffixIcon: Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.black,
                            ),
                            onTap: () {
                              _showListGender();
                            },
                          ),
                          SizedBox(height: 25),
                          CustomTextFormField(
                            key: ValueKey('_industryKey'),
                            controller: _industryController,
                            title: 'Industry',
                            placeHolder: 'Select one',
                            readOnly: true,
                            textFieldStyle: CustomTextFormFieldType.normalStyle,
                            suffixIcon: Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.black,
                            ),
                            onTap: () {
                              _showListIndustry();
                            },
                          ),
                          SizedBox(height: 25),
                          CustomTextFormField(
                            key: ValueKey('_productsKey'),
                            controller: _productController,
                            focusNode: _productFC,
                            title: 'Products/Service offering',
                            placeHolder: 'Products/Service offering',
                            textFieldStyle: CustomTextFormFieldType.normalStyle,
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (vl) {
                              context.focus.unfocus();
                              context.focus.requestFocus(_emailFC);
                            },
                          ),
                          SizedBox(height: 25),
                          CustomTextFormField(
                            key: ValueKey('_emailKey'),
                            controller: _emailController,
                            focusNode: _emailFC,
                            title: 'Email Address',
                            placeHolder: 'e.g. abc@gmail.com',
                            keyboardType: TextInputType.emailAddress,
                            textFieldStyle: CustomTextFormFieldType.normalStyle,
                            textInputAction: TextInputAction.next,
                            onFieldSubmitted: (vl) {
                              context.focus.unfocus();
                              context.focus.requestFocus(_phoneFC);
                            },
                          ),
                          SizedBox(height: 25),
                          CustomTextFormField(
                            key: ValueKey('_phoneKey'),
                            controller: _phoneController,
                            focusNode: _phoneFC,
                            title: 'Phone Number',
                            placeHolder: 'e.g. 0123456789',
                            keyboardType: TextInputType.phone,
                            textFieldStyle: CustomTextFormFieldType.normalStyle,
                            textInputAction: TextInputAction.done,
                            onFieldSubmitted: (vl) {
                              _handleSubmitButton();
                            },
                          ),
                          SizedBox(height: 30),
                          Container(
                            height: 50,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: RaisedButton(
                                child: Text(
                                  'CONFIRM',
                                  style:
                                      context.theme.textTheme.button.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                                color: ColorExt.colorWithHex(0x098EF5),
                                onPressed: () {
                                  _handleSubmitButton();
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: 40),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            if (_isShowNaviBar) CustomNavigationBar(navTitle: ''),
          ],
        ),
      ),
    );
  }

  Future _getImage() async {
    final pickerFile = await _imagePicker.getImage(
      source: ImageSource.gallery,
      maxHeight: _maxImage,
      maxWidth: _maxImage,
    );

    if (pickerFile != null) {
      _image = File(pickerFile.path);
    }

    setState(() {});
  }

  void _handleSubmitButton() {
    context.focus.unfocus();
    if (_isShowNaviBar) {
      context.navigator.pop();
    } else {
      LocalStoreService().isSaveProfile = true;
      context.navigator.pushNamedAndRemoveUntil(
        SaileBotSetupConfirmScreen.routeName,
        (route) => false,
      );
    }
  }

  void _showListGender() {
    context.showBottomSheet(
      _listGender,
      _genderController.text ?? '',
      (value) {
        _genderController.text = value;
      },
    );
  }

  void _showListIndustry() {
    context.showBottomSheet(
      _listIndustry,
      _industryController.text ?? '',
      (value) {
        _industryController.text = value;
      },
    );
  }
}
