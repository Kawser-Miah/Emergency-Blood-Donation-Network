/// Whole-blood donation compatibility.
/// Key = donor blood group, value = set of recipient groups they can donate to.
const Map<String, Set<String>> _donorCanGiveTo = {
  'O-':  {'O-', 'O+', 'A-', 'A+', 'B-', 'B+', 'AB-', 'AB+'},
  'O+':  {'O+', 'A+', 'B+', 'AB+'},
  'A-':  {'A-', 'A+', 'AB-', 'AB+'},
  'A+':  {'A+', 'AB+'},
  'B-':  {'B-', 'B+', 'AB-', 'AB+'},
  'B+':  {'B+', 'AB+'},
  'AB-': {'AB-', 'AB+'},
  'AB+': {'AB+'},
};

/// Returns true if [donorGroup] can donate whole blood to [recipientGroup].
/// Returns false for unknown or empty groups.
bool isBloodGroupCompatible(String donorGroup, String recipientGroup) {
  if (donorGroup.isEmpty || recipientGroup.isEmpty) return false;
  return _donorCanGiveTo[donorGroup]?.contains(recipientGroup) ?? false;
}
