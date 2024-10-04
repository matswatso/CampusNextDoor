import 'package:campuscomfort/main.dart';
import 'package:flutter/material.dart';

class _AddReviewFormState extends State<AddReviewForm> {
  final _formKey = GlobalKey<FormState>();
  String _areaName = '';
  String _reviewType = 'Bathroom';
  double _starRating = 0;
  String _description = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Area Name'),
              onSaved: (value) {
                _areaName = value!;
              },
            ),
            DropdownButtonFormField<String>(
              value: _reviewType,
              items: ['Building', 'Bathroom', 'Cafe', 'Miscellaneous', 'Study Area', 'Water Fountain']
                  .map((type) => DropdownMenuItem(
                        value: type,
                        child: Text(type),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _reviewType = value!;
                });
              },
              decoration: InputDecoration(labelText: 'Review Type'),
            ),
            const SizedBox(height: 16),
            const Text('* Star Rating *'),
            Slider(
              value: _starRating,
              onChanged: (value) {
                setState(() {
                  _starRating = value;
                });
              },
              min: 0,
              max: 5,
              divisions: 5,
              label: _starRating.round().toString(),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Description'),
              maxLines: 3,
              onSaved: (value) {
                _description = value!;
              },
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  widget.onSubmit({
                    'areaName': _areaName,
                    'reviewType': _reviewType,
                    'starRating': _starRating,
                    'description': _description,
                    'image': null, // just for now
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

class AddReviewForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onSubmit;

  AddReviewForm({required this.onSubmit});

  @override
  _AddReviewFormState createState() => _AddReviewFormState();
}
