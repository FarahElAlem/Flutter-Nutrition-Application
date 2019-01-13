
class FoodItem {
  FoodItem(var value) {
    this.carbohydrate = value['Carbohydrt_(g)'].toString();
    this.cholestrol = value['Cholestrl_(mg)'].toString();
    this.energy = value['Energ_Kcal'].toString();
    this.FAMono = value['FA_Mono_(g)'].toString();
    this.FAPoly = value['FA_Poly_(g)'].toString();
    this.FASat = value['FA_Sat_(g)'].toString();
    this.fdGrp = value['Fd_Grp'].toString();
    this.fiberTD = value['Fiber_TD_(g)'].toString();
    this.folateTot = value['Folate_Tot_(µg)'].toString();
    this.GMWt1 = value['GmWt_1'].toString();
    this.GmWtDesc1 = value['GmWt_Desc1'].toString();
    this.iron = value['Iron_(mg)'].toString();
    this.lipidTot = value['Lipid_Tot_(g)'].toString();
    this.magnesium = value['Magnesium_(mg)'].toString();
    this.NDBNo = value['NDB_No'].toString();
    this.niacrin = value['Niacin_(mg)'].toString();
    this.phosphorus = value['Phosphorus_(mg)'].toString();
    this.potassium = value['Potassium_(mg)'].toString();
    this.protein = value['Protein_(g)'].toString();
    this.refusePct = value['Refuse_Pct'].toString();
    this.riboflavin = value['Riboflavin_(mg)'].toString();
    this.shrtDesc = value['Shrt_Desc'].toString();
    this.sodium = value['Sodium_(mg)'].toString();
    this.sugarTot = value['Sugar_Tot_(g)'].toString();
    this.thiamin = value['Thiamin_(mg)'].toString();
    this.vitB12 = value['Vit_B12_(µg)'].toString();
    this.vitB6 = value['Vit_B6_(mg)'].toString();
    this.vitD = value['Vit_D_IU'].toString();
    this.vitDug = value['Vit_D_µg'].toString();
    this.water = value['Water_(g)'].toString();
    this.zinc = value['Zinc_(mg)'].toString();
  }

  String carbohydrate;
  String cholestrol;
  String energy;
  String FAMono;
  String FAPoly;
  String FASat;
  String fdGrp;
  String fiberTD;
  String folateTot;
  String GMWt1;
  String GmWtDesc1;
  String iron;
  String lipidTot;
  String magnesium;
  String NDBNo;
  String niacrin;
  String phosphorus;
  String potassium;
  String protein;
  String refusePct;
  String riboflavin;
  String shrtDesc;
  String sodium;
  String sugarTot;
  String thiamin;
  String vitB12;
  String vitB6;
  String vitD;
  String vitDug;
  String water;
  String zinc;
}
