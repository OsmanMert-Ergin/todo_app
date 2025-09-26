import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/widgets/todo_title.dart';
import 'package:todo_app/widgets/add-todo-sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Todo> _todos = [
// Başlangıç örnek verileri — öğretici olması için
    Todo(id: const Uuid().v4(), title: 'Hoşgeldin! Yeni todo ekle'),
    Todo(id: const Uuid().v4(), title: 'Örnek görev 1', isDone: true),
  ];

// Yeni görev ekleme fonksiyonu
  void _addTodo(String title) {
    if (title.trim().isEmpty) return;
    final todo = Todo(id: const Uuid().v4(), title: title.trim());
    setState(() {
      _todos.insert(0, todo); // en üstte görünmesi için insert
    });
  }

// Görevi tamamlandı / tamamlanmadı yap
  void _toggleTodo(String id) {
    setState(() {
      final index = _todos.indexWhere((t) => t.id == id);
      if (index != -1) _todos[index].isDone = !_todos[index].isDone;
    });
  }

// Silme
  void _removeTodo(String id) {
    setState(() {
      _todos.removeWhere((t) => t.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Responsive örneği: ekran genişliğine göre padding ayarla
    final width = MediaQuery.of(context).size.width;
    final horizontalPadding =
        width > 600 ? 32.0 : 16.0; // tablet/telefon ayrımı

    return Scaffold(
      appBar: AppBar(
        title: const Text("To - Do Local"),
        centerTitle: false,
      ),
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 12),
        child: Column(
          children: [
            // Bilgilendirici küçük bir header
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Görevler',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: _todos.isEmpty
                  ? Center(
                      child: Text(
                        'Henüz görev yok. Sağ alt + ile ekleyebilirsin.',
                        style: Theme.of(context).textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                    )
                  : ListView.builder(
                      itemCount: _todos.length,
                      itemBuilder: (context, index) {
                        final todo = _todos[index];
                        return TodoTile(
                          key: ValueKey(todo.id),
                          todo: todo,
                          onToggle: () => _toggleTodo(todo.id),
                          onDelete: () => _removeTodo(todo.id),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          builder: (_) => AddTodoSheet(onAdd: _addTodo),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
