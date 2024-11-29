import 'dienthoai.dart';
import 'hoadon.dart';

class CuaHang{

  String _tenCuaHang;
  String _diaChi;
  List<DienThoai> _danhSachDienThoai=[];
  List<HoaDon> _danhSachHoaDon=[];


  CuaHang(this._tenCuaHang, this._diaChi);
  
  String get tenCuaHang => _tenCuaHang;
   
  set tenCuaHang(String tenCuaHang) {
    if(tenCuaHang.isNotEmpty)
    _tenCuaHang=tenCuaHang;
  }

  // Getter và setter cho địa chỉ
  String get diaChi => _diaChi;
  set diaChi(String diaChi) {
    if(diaChi.isNotEmpty)
    _diaChi=diaChi;
  }

   void themDienThoai(DienThoai dienThoai) {
    _danhSachDienThoai.add(dienThoai);
  }

  void capNhatThongTinDienThoai(String maDT, {String? tenDT, double? giaNhap,
  double? giaBan, int? soLuongTonKho , bool? trangThaiKinhDoanh }){
    for(var dt in _danhSachDienThoai){
      if(dt.maDT == maDT){
        if(tenDT!=null) dt.tenDT = tenDT;
        if(giaNhap!=null) dt.giaNhap = giaNhap;
        if(giaBan!=null) dt.giaBan = giaBan;
        if(soLuongTonKho!=null)  dt.soLuongTonKho = soLuongTonKho;
        if(trangThaiKinhDoanh!=null) dt.trangThaiKinhDoanh = trangThaiKinhDoanh;
        return;
      }
    }
    print('Không thấy điện thoại.');
  }

  // Ngừng kinh doanh điện thoại
  void ngungKinhDoanhDienThoai(String maDienThoai) {
    var dienThoai = _danhSachDienThoai.firstWhere((dt) => dt.maDT == maDienThoai);
    dienThoai.trangThaiKinhDoanh = false;
  }

  // Tìm kiếm điện thoại
  List<DienThoai> timKiemDienThoai(String keyword) {
    // Tìm kiếm theo mã, tên, hãng
    return _danhSachDienThoai.where((dt) =>
        dt.maDT.contains(keyword) ||
        dt.tenDT.toLowerCase().contains(keyword.toLowerCase()) ||
        dt.hangSanXuat.toLowerCase().contains(keyword.toLowerCase())
    ).toList();
  }

  // Tạo hóa đơn mới
  HoaDon taoHoaDon(DienThoai dienThoai, int soLuong, String tenKhachHang, String soDT) {
    // Kiểm tra số lượng tồn kho
    if (soLuong > dienThoai.soLuongTonKho) {
      throw Exception("Số lượng mua vượt quá số lượng tồn kho");
    }
    // Tạo hóa đơn mới và cập nhật số lượng tồn kho
    var hoaDon = HoaDon(tenKhachHang, soDT, soLuong, "HD-${_danhSachHoaDon.length + 1}", dienThoai.giaBan, dienThoai, DateTime.now());
    _danhSachHoaDon.add(hoaDon);
    dienThoai.soLuongTonKho -= soLuong;
    return hoaDon;
  }


  // Hiển thị danh sách điện thoại
  void hienThiDanhSachDienThoai() {
    for (var dt in _danhSachDienThoai) {
      print('${dt.maDT} - ${dt.tenDT}  - ${dt.giaBan} - Tồn kho: ${dt.soLuongTonKho}');
    }
  }

  

  // Tìm kiếm hóa đơn
  List<HoaDon> timKiemHoaDon({String? maHD, DateTime? ngayBan, String? tenKhachHang}) {
    return _danhSachHoaDon.where((hd) {
      bool match = true;
      if (maHD != null) match &= hd.maHD.contains(maHD);
      if (ngayBan != null) match &= hd.ngayBan == ngayBan;
      if (tenKhachHang != null) match &= hd.tenKhachHang.contains(tenKhachHang);
      return match;
    }).toList();
  }

  // Hiển thị danh sách hóa đơn
  void hienThiDanhSachHoaDon() {
    for (var hd in _danhSachHoaDon) {
      print('Mã hóa đơn: ${hd.maHD}, Ngày: ${hd.ngayBan}, Khách hàng: ${hd.tenKhachHang}, Tổng tiền: ${hd.tinhTongTien()}');
    }
  }

  // Tính tổng doanh thu theo khoảng thời gian
  double tongDoanhThu(DateTime from, DateTime to) {
    return _danhSachHoaDon
        .where((hd) => hd.ngayBan.isAfter(from) && hd.ngayBan.isBefore(to))
        .fold(0.0, (sum, hd) => sum + hd.tinhTongTien());
  }

  // Tính tổng lợi nhuận theo khoảng thời gian
  double tongLoiNhuan(DateTime from, DateTime to) {
    double doanhThu = tongDoanhThu(from, to);
    double chiPhi = _danhSachDienThoai.fold(0.0, (sum, dt) => sum + (dt.giaBan * dt.soLuongTonKho));
    return doanhThu - chiPhi;
  }

 void thongKeBanChay(){
    var danhSach = <(String, int)>[];
    for(var dt in _danhSachDienThoai){
      int dem = 0;
      for(var hd in _danhSachHoaDon){
        if(hd.dienThoaiDuocBan.maDT == dt.maDT){
          dem+= hd.soLuongMua;
        }
      }
      if(dem>0){
        danhSach.add((dt.tenDT , dem));
      }
    }
    danhSach.sort((a,b) => b.$2.compareTo(a.$2));
    var topSeller = danhSach.take(3);
    for(var (dt, sl) in topSeller){
      print('Điện thoại: $dt, số lượng bán: $sl');
    }

  }

  // Thống kê tồn kho
  void thongKeTonKho() {
    for (var dt in _danhSachDienThoai) {
      print('Điện thoại: ${dt.tenDT}, Tồn kho: ${dt.soLuongTonKho}');
    }
  }

  }






