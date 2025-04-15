import 'package:estudazz_main_code/components/custom/customAppBar.dart';
import 'package:estudazz_main_code/routes/appRoutes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyDataPage extends StatelessWidget {
  const MyDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(titleAppBar: 'Meus Dados'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Center(
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage:
                      NetworkImage('https://i.pinimg.com/736x/9f/16/72/9f1672710cba6bcb0dfd93201c6d4c00.jpg'),
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                'Informações Pessoais',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Divider(thickness: 1),
              _buildInfoRow('Nome', 'Pedro Sawczuk'),
              const SizedBox(height: 10),
              _buildInfoRow('Username', 'pedrosawczuk'),
              const SizedBox(height: 10),
              _buildInfoRow('Email', 'pedrosawczuk53@gmail.com'),
              const SizedBox(height: 10),
              _buildInfoRow('Data de Nascimento', '07/06/2004'),
              const SizedBox(height: 30),
              const Text(
                'Informações Acadêmicas',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Divider(thickness: 1),
              _buildInfoRow('Instituição', 'IFRO Ariquemes'),
              const SizedBox(height: 10),
              _buildInfoRow('Curso', 'Análise e Desenvolvimento de Sistemas'),
              const SizedBox(height: 10),
              _buildInfoRow('Conclusão Prevista', 'Agosto de 2025'),
              const SizedBox(height: 30),
              Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Get.toNamed(
                      AppRoutes.editDataPage,
                    );
                  },
                  icon: const Icon(Icons.edit, size: 20, color: Colors.white),
                  label: const Text(
                    'Editar Dados',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 12),
                    backgroundColor: const Color(0xFFED820E),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ],
    );
  }
}
