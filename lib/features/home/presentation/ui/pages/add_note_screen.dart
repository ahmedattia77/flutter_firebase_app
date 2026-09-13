import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_app/features/home/data/model/note_model.dart';
import 'package:flutter_firebase_app/features/home/presentation/cubit/add_screen/cubit/add_note_screen_cubit.dart';
import 'package:flutter_firebase_app/features/home/presentation/cubit/home/home_cubit.dart';
import 'package:flutter_firebase_app/features/home/presentation/ui/widgets/color_picker_palette.dart';

class AddNoteScreen extends StatefulWidget {
  final NoteModel? note;

  const AddNoteScreen({super.key, this.note});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _titleController;
  late final TextEditingController _subTitleController;
  late final TextEditingController _detailsController;
  late int _selectedColor;

  bool get isEditMode => widget.note != null;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note?.title ?? '');
    _subTitleController = TextEditingController(
      text: widget.note?.subTitle ?? '',
    );
    _detailsController = TextEditingController(
      text: widget.note?.details ?? '',
    );
    _selectedColor = widget.note?.color ?? 0xFF2196F3;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _subTitleController.dispose();
    _detailsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditMode ? widget.note!.title : 'Add Note',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          if (isEditMode)
            IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _titleController,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  hintText: 'title',
                  filled: true,
                  fillColor: theme.colorScheme.surfaceVariant.withOpacity(0.4),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
                validator: (val) =>
                    val == null || val.trim().isEmpty ? 'PLS Add Title' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _subTitleController,
                decoration: InputDecoration(
                  hintText: 'sub title',
                  prefixIcon: const Icon(Icons.short_text),
                  filled: true,
                  fillColor: theme.colorScheme.surfaceVariant.withOpacity(0.4),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _detailsController,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'description',
                  filled: true,
                  fillColor: theme.colorScheme.surfaceVariant.withOpacity(0.4),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'pick color : ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 12),
              ColorPickerPalette(
                selectedColor: _selectedColor,
                onColorSelected: (color) {
                  setState(() => _selectedColor = color);
                },
              ),
              const SizedBox(height: 36),
              BlocConsumer<AddNoteScreenCubit, AddNoteScreenState>(
                listenWhen: (_, current) =>
                    current is HomeAddNoteSuccess ||
                    current is HomeAddNoteError,
                listener: (context, state) {
                  if (state is HomeAddNoteSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Note added successfully!'),
                        backgroundColor: Colors.green,
                      ),
                    );
                    Navigator.pop(context);
                  } else if (state is HomeAddNoteError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.erorrMassage),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                buildWhen: (_, current) =>
                    current is HomeAddNoteLoading ||
                    current is HomeAddNoteSuccess ||
                    current is HomeAddNoteError,
                builder: (context, state) {
                  final bool isLoading = state is HomeAddNoteLoading;

                  return SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(_selectedColor),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 4,
                      ),
                      onPressed: isLoading
                          ? null
                          : () {
                              if (_formKey.currentState!.validate()) {
                                if (isEditMode) {
                                } else {
                                  context.read<AddNoteScreenCubit>().addNote(
                                    title: _titleController.text.trim(),
                                    subTitle: _subTitleController.text.trim(),
                                    details: _detailsController.text.trim(),
                                    color: _selectedColor,
                                  );
                                }
                              }
                              // Navigator.pop(context);
                            },
                      child: isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : Text(
                              isEditMode ? 'update note' : 'add note',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
