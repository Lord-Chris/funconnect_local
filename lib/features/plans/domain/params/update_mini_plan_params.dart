class UpdateMiniPlanParams {
  final String selectedPLaceId;
  final String miniPlanId;
  final int date;
  final String planPlaceIdentifier;

  UpdateMiniPlanParams(
      {required this.selectedPLaceId,
      required this.miniPlanId,
      required this.date,
      required this.planPlaceIdentifier});
}
