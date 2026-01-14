import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/product_cubit.dart';
import '../cubit/product_state.dart';

class CategorySelector extends StatelessWidget {
  const CategorySelector({super.key});

  @override
  Widget build(BuildContext context) {
    // Added "All" to the list
    final categories = ["All", "Headphone", "Laptop", "Mobile", "Wearable"];

    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        final selectedCategory = state.maybeMap(
          loaded: (s) => s.selectedCategory,
          orElse: () => "All",
        );

        return SizedBox(
          height: 40,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final category = categories[index];
              return GestureDetector(
                onTap: () {
                  context.read<ProductCubit>().filterByCategory(category);
                },
                child: _CategoryChip(
                  label: category,
                  isSelected: selectedCategory == category,
                ),
              );
            },
            separatorBuilder: (_, i) => const SizedBox(width: 12),
            itemCount: categories.length,
          ),
        );
      },
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  const _CategoryChip({required this.label, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF003D29) : const Color(0xFFF3F3F3),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
