import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_app/core/routing/app_routes.dart';
import 'package:flutter_firebase_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:flutter_firebase_app/features/home/presentation/ui/widgets/custom_drawer.dart';
import 'package:flutter_firebase_app/features/home/presentation/ui/widgets/custom_note_item.dart';

class HomeScreen extends StatelessWidget {
  final String email;
  final String displayName;

  const HomeScreen({super.key, required this.email, required this.displayName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      drawer: CustomDrawer(displayName: displayName, email: email),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(
            context,
            AppRoutes.addNoteScreenRoute,
            arguments: context.read<HomeCubit>(),
          ).then((_) {
            context.read<HomeCubit>().fetchNotes();
          });
        },
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is HomeError) {
            return Center(
              child: Text(
                state.erorrMassage,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          if (state is HomeSuccess) {
            final notes = state.notes;

            if (notes.isEmpty) {
              return const Center(
                child: Text('No notes found, add your first note!'),
              );
            }

            return ListView.separated(
              padding: const EdgeInsets.all(12.0),
              itemCount: notes.length,
              separatorBuilder: (context, index) =>
                  const SizedBox(height: 12.0),
              itemBuilder: (context, index) {
                final note = notes[index];

                return CustomNoteItem(
                  title: note.title,
                  description: note.subTitle,
                  backgroundColor: Color(note.color),
                );
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
