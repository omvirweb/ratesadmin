import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jewelbook_calculator/controllers/autofill_data_controller.dart';
import 'package:jewelbook_calculator/controllers/issue_item_controller.dart';
import 'package:jewelbook_calculator/widget/ItemAutocompleteWidget.dart';
import 'package:jewelbook_calculator/widget/NotesAutocompleteWidget.dart';
import 'package:jewelbook_calculator/widget/PartyAutocompleteWidget.dart';
import 'package:jewelbook_calculator/widget/TouchAutocompleteWidget.dart';

import '../../widget/DefaultButton.dart';
import '../../widget/DefaultTextField.dart';

class IssueItemScreen extends StatelessWidget {
  String t_id = "";
  bool isEdit = true;
  final TextEditingController weightTxtController = TextEditingController();
  final TextEditingController lessTxtController = TextEditingController();
  final TextEditingController addTxtController = TextEditingController();
  final TextEditingController touchTxtController = TextEditingController();
  final TextEditingController wastageTxtController = TextEditingController();
  final TextEditingController dateTxtController = TextEditingController();
  final TextEditingController notesTxtController = TextEditingController();

  final IssueItemController _issueItemController = Get.find();
  final AutofillDataController _autofillDataController = Get.find();

  IssueItemScreen({super.key}) {
    if (Get.arguments != null) {
      final issueItem = Get.arguments;
      t_id = (issueItem['id']?.toString()) ?? '';
      isEdit = false;
      weightTxtController.text = (issueItem['weight']?.toString()) ?? '';
      lessTxtController.text = (issueItem['less']?.toString()) ?? '';
      addTxtController.text = (issueItem['add']?.toString()) ?? '';
      touchTxtController.text = (issueItem['touch']?.toString()) ?? '';
      wastageTxtController.text = (issueItem['wastage']?.toString()) ?? '';
      dateTxtController.text =
          (issueItem['date'] ?? _getCurrentDate()); // Use current date if null
      notesTxtController.text = issueItem['notes'] ?? '';

      _autofillDataController.selectedPartyId.value =
          (issueItem['party_id']?.toString()) ?? '';
      _autofillDataController.selectedPartyName.value =
          issueItem['party'] ?? '';
      _autofillDataController.selectedItemId.value =
          (issueItem['item_id']?.toString()) ?? '';
      _autofillDataController.selectedItemName.value = issueItem['item'] ?? '';

      _issueItemController.net_weight.value =
          double.tryParse(issueItem['net_weight']?.toString() ?? '0.0')!;
      _issueItemController.final_fine.value =
          double.tryParse(issueItem['fine']?.toString() ?? '0.0')!;
    } else {
      dateTxtController.text = _getCurrentDate();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _autofillDataController.selectedPartyName.value = '';
        _autofillDataController.selectedItemName.value = '';
        return true;
      },
      child: Scaffold(
        appBar: _appBar(context),
        body: _body(context),
      ),
    );
  }

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      elevation: 10.0,
      backgroundColor: Colors.white,
      titleSpacing: 0,
      leading: Builder(
        builder: (context) {
          return InkWell(
            onTap: () {
              _autofillDataController.selectedPartyName.value = '';
              _autofillDataController.selectedItemName.value = '';
              Get.back(); // Navigate back
            },
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 25,
            ),
          );
        },
      ),
      title: const Text(
        'Issue Item',
        style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
      ),
    );
  }

  Widget _body(BuildContext context) {
    weightTxtController.addListener(() {
      _updateNetWeight();
    });

    lessTxtController.addListener(() {
      _updateNetWeight();
    });

    addTxtController.addListener(() {
      _updateNetWeight();
    });

    touchTxtController.addListener(() {
      _updateFine();
    });

    wastageTxtController.addListener(() {
      _updateFine();
    });

    return SingleChildScrollView(
      child: Column(
        children: [
          PartyAutocompleteWidget(
            name_txt: _autofillDataController.selectedPartyName.value,
            isEdit: isEdit,
          ),
          ItemAutocompleteWidget(
            name_txt: _autofillDataController.selectedItemName.value,
            isEdit: isEdit,
          ),
          DefaultTextField(
              hint_txt: "Enter Weight",
              label_txt: "Weight",
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,3}'))
              ],
              keyboard_type: TextInputType.number,
              txtController: weightTxtController,
              textInputAction: TextInputAction.next),
          DefaultTextField(
              hint_txt: "Enter Less",
              label_txt: "Less",
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,3}'))
              ],
              keyboard_type: TextInputType.number,
              txtController: lessTxtController,
              textInputAction: TextInputAction.next),
          DefaultTextField(
              hint_txt: "Enter Add",
              label_txt: "Add",
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,3}'))
              ],
              keyboard_type: TextInputType.number,
              txtController: addTxtController,
              textInputAction: TextInputAction.next),
          Obx(() => DefaultTextField(
              hint_txt: "Net Wt.",
              label_txt: "Net Wt.",
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,3}'))
              ],
              keyboard_type: TextInputType.number,
              txtController: TextEditingController(
                text: _issueItemController.net_weight.value.toStringAsFixed(3),
              ),
              enabled: false,
              textInputAction: TextInputAction.next)),
          TouchAutocompleteWidget(
            name_txt: touchTxtController.text,
            txtController: touchTxtController,
          ),
          DefaultTextField(
              hint_txt: "Enter Wastage",
              label_txt: "Wastage",
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))
              ],
              keyboard_type: TextInputType.number,
              txtController: wastageTxtController,
              textInputAction: TextInputAction.next),
          Obx(() => DefaultTextField(
              hint_txt: "Fine",
              label_txt: "Fine",
              keyboard_type: TextInputType.number,
              txtController: TextEditingController(
                text: _issueItemController.final_fine.value.toStringAsFixed(3),
              ),
              enabled: false,
              textInputAction: TextInputAction.next)),
          InkWell(
            onTap: () => _selectDate(context),
            child: IgnorePointer(
              child: DefaultTextField(
                hint_txt: "Date",
                label_txt: "Date",
                keyboard_type: TextInputType.number,
                txtController: dateTxtController,
              ),
            ),
          ),

          Notesautocompletewidget(
            name_txt: notesTxtController.text,
            txtController: notesTxtController,
          ),
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: DefaultButton(
              text: "Save",
              press: () => _saveData(context),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }

  void _updateNetWeight() {
    double weight = double.tryParse(weightTxtController.text) ?? 0.0;
    double less = double.tryParse(lessTxtController.text) ?? 0.0;
    double add = double.tryParse(addTxtController.text) ?? 0.0;

    double netWeight = weight - less + add;

    _issueItemController.net_weight.value =
        double.parse(netWeight.toStringAsFixed(3));

    _updateFine();
  }

  void _updateFine() {
    double netWeight = _issueItemController.net_weight.value;
    double touch = double.tryParse(touchTxtController.text) ?? 0.0;
    double wastage = double.tryParse(wastageTxtController.text) ?? 0.0;

    double fine = netWeight * (touch + wastage) / 100;

    _issueItemController.final_fine.value =
        double.parse(fine.toStringAsFixed(3));
  }

  // Method to get the current date in DD-MM-YYYY format
  String _getCurrentDate() {
    DateTime now = DateTime.now();
    return DateFormat('dd-MM-yyyy')
        .format(now); // Format the date as DD-MM-YYYY
  }

  // Method to select a date and display it in DD-MM-YYYY format
  Future<void> _selectDate(BuildContext context) async {
    DateTime now = DateTime.now();
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (selectedDate != null) {
      dateTxtController.text = DateFormat('dd-MM-yyyy').format(selectedDate);
    }
  }

  // Method to save data and convert the date to YYYY-MM-DD format
  Future<void> _saveData(BuildContext context) async {
    String partyName = _autofillDataController.selectedPartyName.value;
    String partyId = _autofillDataController.selectedPartyId.value;
    String item = _autofillDataController.selectedItemName.value;
    String itemId = _autofillDataController.selectedItemId.value;
    String weight = weightTxtController.text;
    String less = lessTxtController.text;
    String add = addTxtController.text;
    String netWeight = _issueItemController.net_weight.value.toString();
    String touch = touchTxtController.text;
    String wastage = wastageTxtController.text;
    String fine = _issueItemController.final_fine.value.toString();

    // Convert the displayed date from DD-MM-YYYY to YYYY-MM-DD for saving
    String date = DateFormat('yyyy-MM-dd')
        .format(DateFormat('dd-MM-yyyy').parse(dateTxtController.text));
    String notes = notesTxtController.text;

    if (partyName.trim() == "" && partyId.trim() == "") {
      Get.snackbar('Warning', "Please enter party");
      return;
    }

    if (item.trim() == "" && itemId.trim() == "") {
      Get.snackbar('Warning', "Please enter item");
      return;
    }

    if (itemId != null && itemId != "") {
      item = "";
    }

    if (partyId != null && partyId != "") {
      partyName = "";
    }

    if (itemId != null && itemId != "") {
      item = "";
    }

    await _issueItemController.submitIssueItemData(
      tId: t_id,
      partyName: partyName,
      partyId: partyId,
      item: item,
      itemId: itemId,
      weight: weight,
      less: less,
      add: add,
      netWeight: netWeight,
      touch: touch,
      wastage: wastage,
      fine: fine,
      date: date,
      notes: notes,
      onSuccess: () {
        final issueItem = {
          'id': t_id,
          'party': _autofillDataController.selectedPartyName.value,
          'party_id': partyId,
          'item': _autofillDataController.selectedItemName.value,
          'item_id': itemId,
          'weight': double.tryParse(weight)?.toStringAsFixed(3) ?? '0.000',
          // 3 decimal places
          'less': double.tryParse(less)?.toStringAsFixed(3) ?? '0.000',
          // 3 decimal places
          'add': double.tryParse(add)?.toStringAsFixed(3) ?? '0.000',
          // 3 decimal places
          'net_weight':
              double.tryParse(netWeight)?.toStringAsFixed(3) ?? '0.000',
          // 3 decimal places
          'touch': double.tryParse(touch)?.toStringAsFixed(2) ?? '0.00',
          // 2 decimal places
          'wastage': double.tryParse(wastage)?.toStringAsFixed(2) ?? '0.00',
          // 2 decimal places
          'fine': double.tryParse(fine)?.toStringAsFixed(3) ?? '0.000',
          // 3 decimal places
          'date': dateTxtController.text,
          'notes': notes,
          'type': 'issue',
        };

        if (t_id.isEmpty) {
          Navigator.of(context).pop();
        } else {
          Get.back(result: issueItem);
        }

        Future.delayed(Duration(milliseconds: 200), () {
          _clearAllFields();
          Get.snackbar('Success', "" + _issueItemController.msg.toString());
          _autofillDataController.fetchAutofillData();
        });
      },
    );
  }

  void _clearAllFields() {
    _autofillDataController.selectedPartyId.value = '';
    _autofillDataController.selectedPartyName.value = '';
    _autofillDataController.selectedItemId.value = '';
    _autofillDataController.selectedItemName.value = '';

    [
      weightTxtController,
      lessTxtController,
      addTxtController,
      touchTxtController,
      wastageTxtController,
      notesTxtController
    ].forEach((controller) => controller.clear());

    dateTxtController.text =
        _getCurrentDate(); // Reset date to the current date
    _issueItemController.net_weight.value = 0.0; // Reset net weight
    _issueItemController.final_fine.value = 0.0; // Reset fine
  }
}
