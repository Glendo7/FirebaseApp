import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WelcomeMessage extends StatelessWidget {
  const WelcomeMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance.collection('config').get(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text(
            'ERRO: ${snapshot.error}',
            textAlign: TextAlign.center,
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        final docs = snapshot.data?.docs ?? [];

        if (docs.isEmpty) {
          return const Text(
            'A coleção config está vazia',
            textAlign: TextAlign.center,
          );
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: docs.map((doc) {
            final data = doc.data() as Map<String, dynamic>;

            return Text(
              'Documento: ${doc.id}\n'
              'Texto: ${data['text'] ?? 'sem campo text'}',
              textAlign: TextAlign.center,
            );
          }).toList(),
        );
      },
    );
  }
}