import 'dart:io';

import 'package:flutter/material.dart';
import 'package:freiightflow/classes/vehicle_class.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class VehicleCard extends StatefulWidget {
  final Vehicle vehicle;
  final VoidCallback onChanged; // To call setState in parent
  final bool isVin;
  final Function(bool) onToggleVinChanged;
  const VehicleCard({super.key, required this.vehicle, required this.onChanged, required this.isVin, required this.onToggleVinChanged});

  @override
  State<VehicleCard> createState() => _VehicleCardState();
}

class _VehicleCardState extends State<VehicleCard> {
  final Map<String, List<String>> models = {
    "Kia": ["Picanto", "Sporatge", "Stonic", "Ceed"],
    "KGM": ["Rexton", "Torres", "Musso"],
    "Seres": ["M5", "5", "3"],
    "Other": ["Other"],
  };

  final ImagePicker picker = ImagePicker();

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
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 20,
            children: [
              DropdownButton<String>(
                hint: Text(AppLocalizations.of(context)!.select_make),
                value: widget.vehicle.make,
                items:
                    models.keys.map((String make) {
                      return DropdownMenuItem<String>(
                        value: make,
                        child: Text(make),
                      );
                    }).toList(),
                onChanged: (String? value) {
                  widget.vehicle.make = value;
                  widget.vehicle.model = null;
                  widget.onChanged();
                },
              ),
              DropdownButton<String>(
                hint: Text(AppLocalizations.of(context)!.select_model),
                value: widget.vehicle.model,
                items:
                    (models[widget.vehicle.make] ?? []).map((String model) {
                      return DropdownMenuItem<String>(
                        value: model,
                        child: Text(model),
                      );
                    }).toList(),
                onChanged: (String? value) {
                  widget.vehicle.model = value;
                  widget.onChanged();
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ToggleButtons(
                isSelected: [widget.isVin, !widget.isVin],
                onPressed: (index) {
                  widget.onToggleVinChanged(index == 0);
                },
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(AppLocalizations.of(context)!.vin),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(AppLocalizations.of(context)!.plate_num),
                  ),
                ],
              ),
              Flexible(child: TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  if (widget.isVin) {
                    widget.vehicle.vin = value;
                  }else{
                    widget.vehicle.plateNumber = value;
                  }
                },
              )),
            ],
          ),
          if (widget.vehicle.image != null)
            GestureDetector(
              onTap: () => showDialog(context: context, builder: (context) => Dialog(
                child: Image.file(widget.vehicle.image!, width: double.infinity,),
              ),),
              child: Image.file(widget.vehicle.image!, height: 120)),
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
        ],
      ),
    );
  }
}
