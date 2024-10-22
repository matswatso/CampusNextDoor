import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddReviewForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onSubmit;

  const AddReviewForm({super.key, required this.onSubmit});

  @override
  State<AddReviewForm> createState() => _AddReviewFormState();
}

class _AddReviewFormState extends State<AddReviewForm> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  static const List<String> reviewTypes = [
    'Building',
    'Bathroom',
    'Cafe',
    'Miscellaneous',
    'Study Area'
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _reviewTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildUniversalFields(),
            if (_reviewType ==  'Bathroom') _buildBathroomSpecificFields(),
            if (_reviewType == 'Building') _buildBuildingSpecificFields(),
            if (_reviewType == 'Cafe') _buildCafeSpecificFields(),
            if (_reviewType == 'Miscellaneous') _buildMiscellaneousSpecificFields(),
            if (_reviewType == 'Study Area') _buildStudyAreaSpecificFields(),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _submitForm,
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }



  // For the image picker in universal

  Future<void> _pickImage(ImageSource source) async { // Essentially a shell around pickImage() to handle errors and assign the image
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 3500,
        maxHeight: 3500,
        imageQuality: 85,
      );
      if (pickedFile != null) {
        setState(() {
          _imageFile = pickedFile;
        });
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
  }

  Widget _buildImagePicker() {
    return Column(
      children: [
        const SizedBox(height: 16),
        const Text('Add Image (Optional)'),
        const SizedBox(height: 8),
        if (_imageFile != null) ...[
          Stack(
            alignment: Alignment.topRight,
            children: [
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(
                    File(_imageFile!.path), // to display the image once its selected
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close, color: Colors.red),
                onPressed: () {
                  setState(() {
                    _imageFile = null;
                  });
                },
              ),
            ],
          ),
        ],
        const SizedBox(height: 8),
        ElevatedButton.icon(
          onPressed: () => _pickImage(ImageSource.gallery),
          icon: const Icon(Icons.photo_library),
          label: const Text('Gallery'),
        ),
      ],
    );
  }

  /////////////////////
  ///// Universal /////
  /////////////////////
  final _titleController = TextEditingController();
  final _reviewTextController = TextEditingController();
  String _reviewType = reviewTypes[0];
  double _starRating = 0;
  XFile? _imageFile;
  Widget _buildUniversalFields() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        DropdownButtonFormField<String>(
          value: _reviewType,
          items: reviewTypes
              .map((type) => DropdownMenuItem(
                    value: type,
                    child: Text(type),
                  ))
              .toList(),
          onChanged: (value) {
            if (value != null) {
              setState(() {
                _reviewType = value;
              });
            }
          },
          decoration: const InputDecoration(labelText: 'Review Type'),
        ),
        TextFormField(
          controller: _titleController,
          decoration: const InputDecoration(labelText: 'Title'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a title';
            }
            if (value.length >= 64) {
              return 'Title must be less than 64 characters';
            }
            return null;
          },
        ),
        TextFormField(
          controller: _reviewTextController,
          decoration: const InputDecoration(labelText: 'Review'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a review';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        const Text('* Overall Rating *'),
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
        _buildImagePicker(), // Image picker has a lot of stuff in it, so for readability it is seperate
      ],
    );
  }

  ////////////////////
  ///// Bathroom /////
  ////////////////////
  double _cleanlinessStars = 0;
  double _wellStockedStars = 0;
  Widget _buildBathroomSpecificFields() {
    return Column(
      children: [
        const SizedBox(height: 16),
        const Text('* Cleanliness Rating *'),
        Slider(
          value: _cleanlinessStars,
          onChanged: (double value) {
            setState(() {
              _cleanlinessStars = value;
            });
          },
          min: 0,
          max: 5,
          divisions: 5,
          label: _cleanlinessStars.round().toString(),
        ),
        const Text('* Well Stocked Rating *'),
        Slider(
          value: _wellStockedStars,
          onChanged: (double value) {
            setState(() {
              _wellStockedStars = value;
            });
          },
          min: 0,
          max: 5,
          divisions: 5,
          label: _wellStockedStars.round().toString(),
        ),
      ],
    );
  }

  ///////////////////////
  ///// Cafe Review /////
  ///////////////////////
  // double _cleanlinessStars = 0; <-- only here for consistency. Reused from bathroom
  double _customerServiceStars = 0;
  double _foodQualityStars = 0;
  final _cafeNameController = TextEditingController();
  Widget _buildCafeSpecificFields() {
    return Column(
      children: [
        TextFormField(
          controller: _cafeNameController,
          decoration: const InputDecoration(labelText: 'Cafe Name'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a name';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        const Text('* Cleanliness Rating *'),
        Slider(
          value: _cleanlinessStars,
          onChanged: (double value) {
            setState(() {
              _cleanlinessStars = value;
            });
          },
          min: 0,
          max: 5,
          divisions: 5,
          label: _cleanlinessStars.round().toString(),
        ),
        const Text('* Customer Service Rating *'),
        Slider(
          value: _customerServiceStars,
          onChanged: (double value) {
            setState(() {
              _customerServiceStars = value;
            });
          },
          min: 0,
          max: 5,
          divisions: 5,
          label: _customerServiceStars.round().toString(),
        ),
        const Text('* Food Quality Rating *'),
        Slider(
          value: _foodQualityStars,
          onChanged: (double value) {
            setState(() {
              _foodQualityStars = value;
            });
          },
          min: 0,
          max: 5,
          divisions: 5,
          label: _foodQualityStars.round().toString(),
        ),
      ],
    );
  }

  ////////////////////////////////
  ///// Miscellaneous Review /////
  ////////////////////////////////
  final _objectReviewedController = TextEditingController();
  Widget _buildMiscellaneousSpecificFields() {
    return Column(
      children: [
        TextFormField(
          controller: _objectReviewedController,
          decoration: const InputDecoration(labelText: 'Type of Object Reviewed'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a name';
            }
            return null;
          },
        ),
      ],
    );
  }

  ///////////////////////////
  ///// Building Review /////
  ///////////////////////////
  double _accessibilityStars = 0;
  double _navigabilityStars = 0;
  Widget _buildBuildingSpecificFields() {
    return Column(
      children: [
        const SizedBox(height: 16),
        const Text('* Accessibility Rating *'),
        Slider(
          value: _accessibilityStars,
          onChanged: (double value) {
            setState(() {
              _accessibilityStars = value;
            });
          },
          min: 0,
          max: 5,
          divisions: 5,
          label: _accessibilityStars.round().toString(),
        ),
        const Text('* Navigability Rating *'),
        Slider(
          value: _navigabilityStars,
          onChanged: (double value) {
            setState(() {
              _navigabilityStars = value;
            });
          },
          min: 0,
          max: 5,
          divisions: 5,
          label: _navigabilityStars.round().toString(),
        ),
      ],
    );
  }

  /////////////////////////////
  ///// Study Area Review /////
  /////////////////////////////
  double _noiseLevelStars = 0;
  double _comfortStars = 0;
  double _popularityStars = 0;
  final _studyAreaNameController = TextEditingController();
  Widget _buildStudyAreaSpecificFields() {
    return Column(
      children: [
        TextFormField(
          controller: _studyAreaNameController,
          decoration: const InputDecoration(labelText: 'Cafe Name'),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a name';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        const Text('* Noise Rating *'),
        Slider(
          value: _noiseLevelStars,
          onChanged: (double value) {
            setState(() {
              _noiseLevelStars = value;
            });
          },
          min: 0,
          max: 5,
          divisions: 5,
          label: _noiseLevelStars.round().toString(),
        ),
        const Text('* Comfort Rating *'),
        Slider(
          value: _comfortStars,
          onChanged: (double value) {
            setState(() {
              _comfortStars = value;
            });
          },
          min: 0,
          max: 5,
          divisions: 5,
          label: _comfortStars.round().toString(),
        ),
        const Text('* Popularity Rating *'),
        Slider(
          value: _popularityStars,
          onChanged: (double value) {
            setState(() {
              _popularityStars = value;
            });
          },
          min: 0,
          max: 5,
          divisions: 5,
          label: _popularityStars.round().toString(),
        ),
      ],
    );
  }


  // Creates a map for the onSubmit function
  // ['Building', 'Bathroom', 'Cafe', 'Miscellaneous', 'Study Area']
  Map<String, dynamic> _createReview() {
    Map<String, dynamic> reviewData = {
      'title': _titleController.text,
      'reviewText': _reviewTextController.text,
      'type': _reviewType,
      'starRating': _starRating,
      'image': _imageFile != null ? File(_imageFile!.path) : null, // incase they didn't attach an image
    };
    switch (_reviewType) { // I think build map and call function given
      case 'Bathroom':
        reviewData['cleanlinessStars'] = _cleanlinessStars;
        reviewData['wellStockedStars'] = _wellStockedStars;
        return reviewData;
      case 'Building':
        reviewData['accessibilityStars'] = _accessibilityStars;
        reviewData['navigabilityStars'] = _navigabilityStars;
        reviewData['buildingName'] = 'placeholder name'; // TODO: fill in (milestone3)
        return reviewData;
      case 'Cafe':
        reviewData['cleanlinessStars'] = _cleanlinessStars;
        reviewData['customerServiceStars'] = _customerServiceStars;
        reviewData['foodQualityStars'] = _foodQualityStars;
        reviewData['cafeName'] = _cafeNameController.text;
        return reviewData;
      case 'Miscellaneous':
        reviewData['objectReviewed'] = _objectReviewedController.text;
        return reviewData;
      case 'Study Area':
        reviewData['noiseLevelStars'] = _noiseLevelStars;
        reviewData['comfortStars'] = _comfortStars;
        reviewData['popularityStars'] = _popularityStars;
        reviewData['studyAreaName'] = _studyAreaNameController.text;
        return reviewData;
      default:
        return reviewData;
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      widget.onSubmit(_createReview()); // Pass the information map back to the onSubmit function
      Navigator.pop(context); // close form
    }
  }
}