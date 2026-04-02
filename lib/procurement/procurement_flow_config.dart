class ProcurementFlowConfig {
  const ProcurementFlowConfig({
    required this.flowType,
    required this.requiresBuyer,
    required this.requiresPublicationApproval,
    required this.publicationActor,
  });

  final String flowType;
  final bool requiresBuyer;
  final bool requiresPublicationApproval;
  final String publicationActor; // initiator | buyer | auto

  static const List<String> allFlowTypes = <String>[
    'STRAIGHT',
    'WITH_BUYER',
    'WITH_BUYER_THROUGH_APPROVAL',
    'STRAIGHT_THROUGH_APPROVAL',
  ];

  static ProcurementFlowConfig fromFlowType(String flowType) {
    switch (flowType) {
      case 'STRAIGHT':
        return const ProcurementFlowConfig(
          flowType: 'STRAIGHT',
          requiresBuyer: false,
          requiresPublicationApproval: false,
          publicationActor: 'initiator',
        );
      case 'WITH_BUYER':
        return const ProcurementFlowConfig(
          flowType: 'WITH_BUYER',
          requiresBuyer: true,
          requiresPublicationApproval: false,
          publicationActor: 'buyer',
        );
      case 'WITH_BUYER_THROUGH_APPROVAL':
        return const ProcurementFlowConfig(
          flowType: 'WITH_BUYER_THROUGH_APPROVAL',
          requiresBuyer: true,
          requiresPublicationApproval: true,
          publicationActor: 'buyer',
        );
      case 'STRAIGHT_THROUGH_APPROVAL':
        return const ProcurementFlowConfig(
          flowType: 'STRAIGHT_THROUGH_APPROVAL',
          requiresBuyer: false,
          requiresPublicationApproval: true,
          publicationActor: 'auto',
        );
      default:
        return const ProcurementFlowConfig(
          flowType: 'WITH_BUYER',
          requiresBuyer: true,
          requiresPublicationApproval: false,
          publicationActor: 'buyer',
        );
    }
  }
}
