import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freiightflow/classes/vehicle_class.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class VehicleCard extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final Vehicle vehicle;
  final VoidCallback onChanged; // To call setState in parent
  final bool isVin;
  final bool imageError;
  final Function(bool) onToggleVinChanged;
  final Map<String, List<Map<String, dynamic>>> manufacturersData;
  const VehicleCard({
    super.key,
    required this.formKey,
    required this.vehicle,
    required this.onChanged,
    required this.isVin,
    required this.imageError,
    required this.onToggleVinChanged,
    required this.manufacturersData,
  });

  @override
  State<VehicleCard> createState() => _VehicleCardState();
}

class _VehicleCardState extends State<VehicleCard> {
  List<String>? manufacturers;
  List<String>? models;

  final ImagePicker picker = ImagePicker();

  final hyphenController = HyphenTextController();

  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source, imageQuality: 75);
    if (pickedFile != null) {
      setState(() {
        widget.vehicle.image = File(pickedFile.path);
      });
      widget.onChanged(); // notify parent
    }
  }

  @override
  Widget build(BuildContext context) {
    manufacturers = widget.manufacturersData.keys.toList();
    List<Map<String, dynamic>> selectedModels =
        widget.manufacturersData[widget.vehicle.make] ?? [];
    models = selectedModels.map((e) => e['model'].toString()).toList();

    return Form(
      key: widget.formKey,
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: Column(
          spacing: 10,
          children: [
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    hint: Text(AppLocalizations.of(context)!.select_make),
                    value: widget.vehicle.make,
                    items:
                        (manufacturers ?? []).map((String make) {
                          return DropdownMenuItem<String>(
                            value: make,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.circle_rounded, color: Colors.indigo),
                                const SizedBox(width: 10),
                                Text(make),
                              ],
                            ),
                          );
                        }).toList(),
                    onChanged: (String? value) {
                      widget.vehicle.make = value;
                      widget.vehicle.model = null;
                      widget.onChanged();
                    },
                    decoration: InputDecoration(
                      label: Text(AppLocalizations.of(context)!.make),
                      errorStyle: TextStyle(fontSize: 0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    style: GoogleFonts.rubik(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    dropdownColor: Colors.lightGreen[100],
                    menuMaxHeight: MediaQuery.sizeOf(context).height/3,
                    validator: (value) => value == null ? '' : null,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child:
                      widget.vehicle.make == "Other"
                          ? TextFormField(
                            onChanged: (value) {
                              widget.vehicle.model = value;
                              widget.onChanged();
                            },
                            decoration: InputDecoration(
                              label: Text(AppLocalizations.of(context)!.model),
                              errorStyle: TextStyle(fontSize: 0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            validator:
                                (value) =>
                                    value == null || value.isEmpty ? '' : null,
                          )
                          : DropdownButtonFormField<String>(
                            hint: Text(AppLocalizations.of(context)!.select_model),
                            value: widget.vehicle.model,
                            items:
                                (models ?? []).map((String model) {
                                  return DropdownMenuItem<String>(
                                    value: model,
                                    child: Text(model, overflow: TextOverflow.ellipsis),
                                  );
                                }).toList(),
                            onChanged: (String? value) {
                              widget.vehicle.model = value;
                              widget.onChanged();
                            },
                            decoration: InputDecoration(
                              label: Text(AppLocalizations.of(context)!.model),
                              errorStyle: TextStyle(fontSize: 0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            style: GoogleFonts.rubik(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                            borderRadius: BorderRadius.circular(12),
                            dropdownColor: Colors.lightGreen[100],
                            menuMaxHeight: MediaQuery.sizeOf(context).height/3,
                            validator: (value) => value == null ? '' : null,
                          ),
                ),
              ],
            ),
            Row(
              spacing: 10,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ToggleButtons(
                  isSelected: [widget.isVin, !widget.isVin],
                  onPressed: (index) {
                    if (index == 0) {
                      if (hyphenController.text.length > 6) {
                        hyphenController.text = hyphenController.rawText
                            .substring(0, 6);
                      }
                      widget.vehicle.vin = hyphenController.rawText;
                      widget.vehicle.plateNumber = null;
                    } else {
                      widget.vehicle.plateNumber = hyphenController.rawText;
                      widget.vehicle.vin = null;
                    }
                    widget.onToggleVinChanged(index == 0);
                  },
                  borderRadius: BorderRadius.circular(12),
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(AppLocalizations.of(context)!.vin),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(AppLocalizations.of(context)!.plate),
                    ),
                  ],
                ),
                Flexible(
                  child: TextFormField(
                    controller: hyphenController,
                    inputFormatters:
                        widget.isVin
                            ? [VinNumInputFormatter()]
                            : [PlateNumInputFormatter()],
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      counterText: "",
                      label:
                          widget.isVin
                              ? Text(AppLocalizations.of(context)!.vin_num)
                              : Text(AppLocalizations.of(context)!.plate_num),
                      errorStyle: TextStyle(fontSize: 0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    maxLength: widget.isVin ? 6 : 10,
                    onChanged: (value) {
                      if (widget.isVin) {
                        widget.vehicle.vin = hyphenController.rawText;
                      } else {
                        widget.vehicle.plateNumber = hyphenController.rawText;
                      }
                    },
                    validator: (value) {
                      if (widget.isVin) {
                        return value == null ||
                                hyphenController.rawText.length < 4
                            ? ''
                            : null;
                      }
                      return value == null ||
                              hyphenController.rawText.length < 7
                          ? ''
                          : null;
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                ),
              ],
            ),
            if (widget.vehicle.image != null)
              GestureDetector(
                onTap:
                    () => showDialog(
                      context: context,
                      builder:
                          (context) => Dialog(
                            child: InteractiveViewer(
                              child: Image.file(
                                widget.vehicle.image!,
                                width: double.infinity,
                              ),
                            ),
                          ),
                    ),
                child: Image.file(widget.vehicle.image!, height: 120),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.photo_camera),
                  onPressed: () => pickImage(ImageSource.camera),
                ),
                IconButton(
                  icon: const Icon(Icons.photo_library),
                  onPressed: () => pickImage(ImageSource.gallery),
                ),
              ],
            ),
            Visibility(
              visible: widget.imageError && widget.vehicle.image == null,
              child: Center(
                child: Text(
                  "Please upload image",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PlateNumInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String digitsOnly = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    StringBuffer formatted = StringBuffer();

    if (digitsOnly.length <= 7) {
      for (int i = 0; i < digitsOnly.length; i++) {
        if (i == 2 || i == 5) {
          formatted.write('-');
        }
        formatted.write(digitsOnly[i]);
      }
    } else {
      for (int i = 0; i < digitsOnly.length; i++) {
        if (i == 3 || i == 5) {
          formatted.write('-');
        }
        formatted.write(digitsOnly[i]);
      }
    }

    // Correct cursor position
    int offset = formatted.length;
    return TextEditingValue(
      text: formatted.toString(),
      selection: TextSelection.collapsed(offset: offset),
    );
  }
}

class VinNumInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String digitsOnly = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    StringBuffer formatted = StringBuffer(digitsOnly);

    // Correct cursor position
    int offset = formatted.length;
    return TextEditingValue(
      text: formatted.toString(),
      selection: TextSelection.collapsed(offset: offset),
    );
  }
}

class HyphenTextController extends TextEditingController {
  HyphenTextController({super.text});

  String get rawText => text.replaceAll('-', '');
}
