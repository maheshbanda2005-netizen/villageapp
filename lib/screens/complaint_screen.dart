import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../main.dart';

class ComplaintScreen extends StatefulWidget {
  const ComplaintScreen({super.key});

  @override
  State<ComplaintScreen> createState() => _ComplaintScreenState();
}

class _ComplaintScreenState extends State<ComplaintScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _subjectController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _subjectController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.reset();
    _nameController.clear();
    _phoneController.clear();
    _subjectController.clear();
    _descriptionController.clear();
    FocusScope.of(context).unfocus();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Complaint submitted successfully!'),
        backgroundColor: kDarkBg,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register Complaint')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Voice your concerns",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: kDarkBg),
              ).animate().fadeIn(duration: 400.ms, curve: Curves.easeOutCubic),
              const SizedBox(height: 8),
              const Text(
                "Submit your complaint directly to the Gram Panchayat.",
                style: TextStyle(color: Colors.grey),
              ).animate().fadeIn(delay: 150.ms, curve: Curves.easeOutCubic),
              const SizedBox(height: 28),
              TextFormField(
                controller: _nameController,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  labelText: 'Your Name',
                  prefixIcon: Icon(Icons.person_outline),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ).animate().fadeIn(delay: 200.ms, curve: Curves.easeOutCubic).slideY(begin: 0.03),
              const SizedBox(height: 16),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  prefixIcon: Icon(Icons.phone_outlined),
                ),
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your phone number';
                  }
                  if (value.trim().length != 10) {
                    return 'Please enter a valid 10-digit phone number';
                  }
                  return null;
                },
              ).animate().fadeIn(delay: 300.ms, curve: Curves.easeOutCubic).slideY(begin: 0.03),
              const SizedBox(height: 16),
              TextFormField(
                controller: _subjectController,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(
                  labelText: 'Subject',
                  prefixIcon: Icon(Icons.subject),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a subject';
                  }
                  return null;
                },
              ).animate().fadeIn(delay: 400.ms, curve: Curves.easeOutCubic).slideY(begin: 0.03),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                textCapitalization: TextCapitalization.sentences,
                decoration: const InputDecoration(
                  labelText: 'Detailed Description',
                  alignLabelWithHint: true,
                ),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please describe your complaint';
                  }
                  return null;
                },
              ).animate().fadeIn(delay: 500.ms, curve: Curves.easeOutCubic).slideY(begin: 0.03),
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _submit,
                  child: const Text("Submit Complaint", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                ),
              ).animate().fadeIn(delay: 600.ms, curve: Curves.easeOutCubic).scale(begin: const Offset(0.97, 0.97)),
            ],
          ),
        ),
      ),
    );
  }
}
