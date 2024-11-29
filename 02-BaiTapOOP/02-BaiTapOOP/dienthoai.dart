

class DienThoai{
  String _maDT;
  String _tenDT;
  String _hangSanXuat;
  double _giaNhap;
  double _giaBan;
  int _soLuongTonKho;
  bool _trangThaiKinhDoanh;

  DienThoai(this._maDT,this._tenDT,this._hangSanXuat,this._giaNhap,this._giaBan,this._soLuongTonKho,this._trangThaiKinhDoanh);
  String get maDT=>_maDT;
  String get tenDT=>_tenDT;
  String get hangSanXuat=>_hangSanXuat;
  double get giaNhap=>_giaNhap;
  double get giaBan=>_giaBan;
  int get soLuongTonKho=>_soLuongTonKho;
  bool get trangThaiKinhDoanh=>_trangThaiKinhDoanh;


  set maDT(String value) {
    if (value.isEmpty || !RegExp(r"DT-\d{3}").hasMatch(maDT)) {
      throw Exception("Mã điện thoại không hợp lệ");
    }
    _maDT = maDT;
  }

  set tenDT(String tenDT)
  {
    if(tenDT.isNotEmpty)
    _tenDT=tenDT;
  }
  set hangSanXuat(String hangSanXuat)
  {
    if(hangSanXuat.isNotEmpty)
    _hangSanXuat=hangSanXuat;
  }
  set giaNhap(double giaNhap)
  {
    if(giaNhap>0)
    _giaNhap=giaNhap;
  }
  set giaBan(double giaBan)
  {
    if(giaBan>0)
    _giaBan=giaBan;
  }
  set soLuongTonKho(int soLuongTonKho)
  {
    if(soLuongTonKho>0)
    _soLuongTonKho=soLuongTonKho;
  }
  
  set trangThaiKinhDoanh(bool value) {
    _trangThaiKinhDoanh = value;
    if (!value) {
      // Nếu sản phẩm ngừng kinh doanh, cập nhật số lượng tồn kho về 0
      _soLuongTonKho = 0;
    }
  }

  double tinhLoiNhuanDuKien() {
    if (soLuongTonKho <= 0) {
      return 0;
    }
    return (giaBan - giaNhap) * soLuongTonKho;
  }

  // Phương thức hiển thị thông tin
  void hienThiThongTin() {
    print("Mã điện thoại: $maDT");
    print("Tên điện thoại: $tenDT");
    print("Lợi nhuận dự kiến: ${tinhLoiNhuanDuKien()}");
  }

  // Phương thức kiểm tra có thể bán không
  bool coTheBan() {
    return soLuongTonKho > 0 && trangThaiKinhDoanh;
  }
}


