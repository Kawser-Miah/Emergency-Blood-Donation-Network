import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/colors.dart';
import '../bloc/create_request_bloc.dart';
import '../bloc/create_request_event.dart';
import '../bloc/create_request_state.dart';
import 'create_request_card.dart';

class CreateRequestCardAdditional extends StatelessWidget {
  const CreateRequestCardAdditional({super.key, required this.state});

  final CreateRequestState state;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CreateRequestBloc>();
    return CreateRequestCard(
      title: '📝 Additional Information',
      children: [
        const Text(
          'Notes (Optional)',
          style: TextStyle(fontSize: 11, color: AppColors.textMuted),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.dividerLightest,
            borderRadius: BorderRadius.circular(12),
            border:
                Border.all(color: AppColors.dividerLight, width: 1.5),
          ),
          child: TextFormField(
            initialValue: state.notes,
            onChanged: (v) =>
                bloc.add(CreateRequestEvent.notesChanged(v)),
            maxLines: 3,
            decoration: const InputDecoration(
              isDense: true,
              border: InputBorder.none,
              hintText:
                  'e.g. Patient on 3rd floor, ICU, Room 305. Please bring ID.',
            ),
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.textPrimary,
              height: 1.6,
            ),
          ),
        ),
      ],
    );
  }
}
