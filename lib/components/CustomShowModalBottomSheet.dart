import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:regive_v3/components/CustomElevatedButton.dart';

void CustomShowModalBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(50),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom + 45,
                  left: 16,
                  right: 16,
                  top: 20,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "New Product",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: 150,
                      height: 150,
                      child: FloatingActionButton(
                        onPressed: () {},
                        backgroundColor: Colors.grey.withAlpha(150),
                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 60,
                        ),
                        shape: const CircleBorder(),
                        elevation: 6,
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Name',
                        hintText: 'Product name',
                        labelStyle: const TextStyle(color: Colors.white),
                        hintStyle: const TextStyle(color: Colors.white70),
                        prefixIcon: const Icon(
                          Icons.drive_file_rename_outline,
                          color: Colors.white,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.white.withAlpha(50),
                      ),
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      minLines: 3,
                      maxLines: 5,
                      decoration: InputDecoration(
                        labelText: 'Description',
                        hintText: 'Product description',
                        labelStyle: const TextStyle(color: Colors.white),
                        hintStyle: const TextStyle(color: Colors.white70),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: const Icon(
                          Icons.description,
                          color: Colors.white,
                        ),
                        fillColor: Colors.white.withAlpha(50),
                        filled: true,
                      ),
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 10),
                    CustomElevatedButton(
                      text: 'Submit',
                      onPressed: () async {},
                      backgroundColor: Colors.grey.withAlpha(150),
                      foregroundColor: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}