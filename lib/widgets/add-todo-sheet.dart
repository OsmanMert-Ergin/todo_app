import 'package:flutter/material.dart';

class AddTodoSheet extends StatefulWidget {
  final void Function(String title) onAdd;
  const AddTodoSheet({super.key, required this.onAdd});

  @override
  State<AddTodoSheet> createState() => _AddTodoSheetState();
}

class _AddTodoSheetState extends State<AddTodoSheet> {
  final _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _submit() {
    if (_formKey.currentState!.validate()) {
      widget.onAdd(_controller.text);
      Navigator.of(context).pop(); // kapat
    }
  }

  @override
  Widget build(BuildContext context) {
// Klavye açıldığında sheet'in yukarı çıkması için padding ekleyelim
    final bottom = MediaQuery.of(context).viewInsets.bottom;

    return Padding(
      padding: EdgeInsets.only(bottom: bottom),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Yeni Görev Ekle',
                  style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 8),
              TextFormField(
                controller: _controller,
                decoration:
                    const InputDecoration(hintText: 'Görev başlığını girin'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty)
                    return 'Lütfen görev girin';
                  return null;
                },
                onFieldSubmitted: (_) => _submit(),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _submit,
                      child: const Text('Ekle'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
