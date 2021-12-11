enum BirdsName { Merpati, Pipit, Perkutut, Cenderawasih }

class Birds {
  final String imgAsset;
  final BirdsName name;

  Birds({
    required this.name,
    required this.imgAsset,
  });
}

final allBirds = [
  Birds(
    name: BirdsName.Merpati,
    imgAsset: 'assets/images/merpati.jpg',
  ),
  Birds(
    name: BirdsName.Pipit,
    imgAsset: 'assets/images/pipit.jpg',
  ),
  Birds(
    name: BirdsName.Perkutut,
    imgAsset: 'assets/images/perkutut.jpg',
  ),
  Birds(
    name: BirdsName.Cenderawasih,
    imgAsset: 'assets/images/cenderawasih.jpg',
  ),
];
