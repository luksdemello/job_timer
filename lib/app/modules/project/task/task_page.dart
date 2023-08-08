import 'package:asuka/asuka.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_timer/app/core/ui/button_with_loader.dart';
import 'package:job_timer/app/modules/project/task/controller/task_controller.dart';
import 'package:validatorless/validatorless.dart';

class TaskPage extends StatefulWidget {
  final TaskController controller;
  const TaskPage({super.key, required this.controller});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final _formKey = GlobalKey<FormState>();

  final _nameEC = TextEditingController();
  final _durationEC = TextEditingController();

  @override
  void dispose() {
    _nameEC.dispose();
    _durationEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TaskController, TaskStatus>(
      bloc: widget.controller,
      listener: (context, state) {
        if (state == TaskStatus.failure) {
          AsukaSnackbar.alert('Arro ao salvar task').show();
        } else if (state == TaskStatus.success) {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            'Criar nova Task',
            style: TextStyle(color: Colors.black),
          ),
          elevation: 0,
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
        ),
        body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextFormField(
                  controller: _nameEC,
                  validator: Validatorless.required('Nome obrigatório'),
                  decoration:
                      const InputDecoration(label: Text('Nome da task')),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: _durationEC,
                  validator: Validatorless.multiple([
                    Validatorless.required('Duração obrigatório'),
                    Validatorless.number('Somente número')
                  ]),
                  decoration:
                      const InputDecoration(label: Text('Duração da task')),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  height: 49,
                  child: ButtonWithLoader<TaskController, TaskStatus>(
                    bloc: widget.controller,
                    selector: (state) => state == TaskStatus.loading,
                    onPressed: () {
                      final formValid =
                          _formKey.currentState?.validate() ?? false;

                      if (formValid) {
                        widget.controller.register(
                            _nameEC.text, int.parse(_durationEC.text));
                      }
                    },
                    label: 'Salvar',
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
