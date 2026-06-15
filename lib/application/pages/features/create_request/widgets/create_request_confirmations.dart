import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/colors.dart';
import '../bloc/create_request_bloc.dart';
import '../bloc/create_request_event.dart';
import '../bloc/create_request_state.dart';

class _ConfirmItem {
  const _ConfirmItem({
    required this.text,
    required this.value,
    required this.onTap,
  });

  final String text;
  final bool value;
  final VoidCallback onTap;
}

class CreateRequestConfirmations extends StatelessWidget {
  const CreateRequestConfirmations({super.key, required this.state});

  final CreateRequestState state;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CreateRequestBloc>();
    final items = [
      _ConfirmItem(
        text: 'I confirm this is a genuine blood request',
        value: state.confirmed1,
        onTap: () =>
            bloc.add(const CreateRequestEvent.confirmed1Toggled()),
      ),
      _ConfirmItem(
        text:
            'I have permission to receive blood for this patient',
        value: state.confirmed2,
        onTap: () =>
            bloc.add(const CreateRequestEvent.confirmed2Toggled()),
      ),
    ];

    return Column(
      children: items.map((it) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: InkWell(
            onTap: it.onTap,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    margin: const EdgeInsets.only(top: 2, right: 12),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: it.value ? AppColors.primary : Colors.white,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: it.value
                            ? AppColors.primary
                            : AppColors.textDisabled,
                        width: 2,
                      ),
                    ),
                    child: it.value
                        ? const Icon(Icons.check,
                            size: 12, color: Colors.white)
                        : null,
                  ),
                  Expanded(
                    child: Text(
                      it.text,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                        height: 1.6,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
