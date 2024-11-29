import 'dienthoai.dart';


class HoaDon{
  String _maHD;
  String _tenKhachHang;
  String _soDT;
  int _soLuongMua;
  DateTime _ngayBan;
  DienThoai _dienThoaiDuocBan;
  double _giaBanThucTe;
  List<HoaDon> _danhSachHoaDon = [];
 

  HoaDon(this._tenKhachHang, this._soDT, this._soLuongMua, this._maHD, this._giaBanThucTe, this._dienThoaiDuocBan, this._ngayBan);


  String get maHD => _maHD;
  String get tenKhachHang => _tenKhachHang;
  String get soDT => _soDT;
  double get giaBanThucTe => _giaBanThucTe;
  DateTime get ngayBan => _ngayBan;
  int get soLuongMua => _soLuongMua;
  DienThoai get dienThoaiDuocBan => _dienThoaiDuocBan;

  List<HoaDon> get danhSachHoaDon => _danhSachHoaDon;


  set maHD(String maHD) {
    if (maHD.isEmpty || !RegExp(r"HD-\d{3}").hasMatch(maHD)) {
      throw Exception("Mã hóa đơn không hợp lệ");
    }
    _maHD = maHD;
  }
  set tenKhachHang(String tenKhachHang)
  {
    if(tenKhachHang.isNotEmpty)
    _tenKhachHang=tenKhachHang;
  }
  set soDT(String soDT)
  {
    if(soDT.isNotEmpty)
    _soDT=soDT;
  }
 set soLuongMua(int soLuongMua) {
  if (soLuongMua <= 0) {
    throw Exception("Số lượng mua phải lớn hơn 0");
  } else if (soLuongMua > dienThoaiDuocBan.soLuongTonKho) {
    throw Exception("Số lượng mua không được vượt quá số lượng tồn kho");
  }
  _soLuongMua = soLuongMua;
}
  set ngayBan(DateTime ngayBan) {
    if (ngayBan.isAfter(DateTime.now())) {
      throw Exception("Ngày bán không hợp lệ");
    }
    _ngayBan = ngayBan;
  }


  double tinhTongTien() {
    return soLuongMua * giaBanThucTe;
  }



  // Phương thức tính lợi nhuận thực tế
  double tinhLoiNhuanThucTe() {
    return tinhTongTien() - (soLuongMua * dienThoaiDuocBan.giaNhap);
  }

  // Phương thức hiển thị thông tin hóa đơn
  void hienThiThongTin() {
    print("Mã hóa đơn: $maHD");
    print("Ngày bán: $_ngayBan");
    print("Điện thoại: ${dienThoaiDuocBan.tenDT}");
    print("Số lượng: $_soLuongMua");
    print("Giá bán thực tế: $giaBanThucTe");
    print("Tổng tiền: ${tinhTongTien()}");
    print("Lợi nhuận: ${tinhLoiNhuanThucTe()}");
    print("Khách hàng: $tenKhachHang");
    print("SĐT: $soDT");
  }



}