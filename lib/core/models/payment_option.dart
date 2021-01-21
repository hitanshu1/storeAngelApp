enum PaymentOptionEnum{ prepayment, payment_on_delivery,withBudgetConstraint}
enum PaymentRestriction {yes, no}

class PaymentOption {
  String title;
  PaymentOptionEnum paymentOptionEnum;
  PaymentRestriction paymentRestriction;
  PaymentOption({this.paymentOptionEnum,this.title, this.paymentRestriction: PaymentRestriction.no});
}