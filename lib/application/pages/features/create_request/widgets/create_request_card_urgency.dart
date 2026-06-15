import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/colors.dart';
import '../bloc/create_request_bloc.dart';
import '../bloc/create_request_event.dart';
import '../bloc/create_request_state.dart';
import 'create_request_card.dart';
import 'create_request_date_picker.dart';
import 'create_request_input_field.dart';
import 'create_request_options.dart';

class CreateRequestCardUrgency extends StatelessWidget {
  const CreateRequestCardUrgency({super.key, required this.state});

  final CreateRequestState state;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CreateRequestBloc>();
    return CreateRequestCard(
      title: '⚡ Urgency & Timing',
      children: [
        const Text(
          'Urgency Level *',
          style: TextStyle(fontSize: 11, color: AppColors.textMuted),
        ),
        const SizedBox(height: 10),
        Column(
          children: kUrgencyOptions.map((opt) {
            final selected = state.urgency == opt.id;
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: GestureDetector(
                onTap: () =>
                    bloc.add(CreateRequestEvent.urgencyChanged(opt.id)),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: selected
                        ? (opt.gradient == null
                            ? Colors.transparent
                            : null)
                        : AppColors.dividerLightest,
                    gradient: selected && opt.gradient != null
                        ? LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: opt.gradient!,
                          )
                        : null,
                    borderRadius: BorderRadius.circular(16),
                    border: !selected
                        ? Border.all(
                            color: opt.color.withValues(alpha: 0.13),
                            width: 2,
                          )
                        : null,
                    boxShadow: selected
                        ? [
                            BoxShadow(
                              color: opt.color.withValues(alpha: 0.25),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ]
                        : null,
                  ),
                  child: Row(
                    children: [
                      Text(opt.emoji,
                          style: const TextStyle(fontSize: 20)),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              opt.title,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: selected
                                    ? opt.textColor
                                    : opt.color,
                              ),
                            ),
                            Text(
                              opt.subtitle,
                              style: TextStyle(
                                fontSize: 11,
                                color: selected
                                    ? opt.textColor.withValues(alpha: 0.8)
                                    : AppColors.textMuted,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (selected)
                        Icon(Icons.check,
                            size: 18, color: opt.textColor),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 8),
        CreateRequestDatePicker(
          value: state.needBy,
          onPicked: (dt) =>
              bloc.add(CreateRequestEvent.needByChanged(dt)),
        ),
        CreateRequestInputField(
          icon: Icons.phone_outlined,
          label: 'Contact Number *',
          hint: '01X-XXXXXXXX',
          value: state.contact,
          keyboardType: TextInputType.phone,
          onChanged: (v) =>
              bloc.add(CreateRequestEvent.contactChanged(v)),
        ),
      ],
    );
  }
}
