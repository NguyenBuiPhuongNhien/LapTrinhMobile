import 'cuahang.dart';
import 'dienthoai.dart';
//import 'hoadon.dart';

void main(){
  CuaHang cuaHang1 = CuaHang('Cellphone S', '369 Vo Van Ngan');

 DienThoai iphoneXs = DienThoai('DT-001', 'iPhone XS max', 'Apple', 5000000, 5500000, 20, true);
 DienThoai iphone12 = DienThoai('DT-002', 'iPhone 12 ', 'Apple', 15000000, 6500000, 20, true);
 DienThoai samsunggalaxy = DienThoai('DT-003', 'SamsungJ7', 'SamSung', 3000000, 3500000, 20, true);

 cuaHang1.themDienThoai(iphoneXs);
 cuaHang1.themDienThoai(iphone12);
 cuaHang1.themDienThoai(samsunggalaxy);

 cuaHang1.hienThiDanhSachDienThoai();
 cuaHang1.capNhatThongTinDienThoai(iphone12.maDT,tenDT:'iphone12pro');
 print('DS Sau Khi Update la:');
 cuaHang1.hienThiDanhSachDienThoai();

var hoadonA = cuaHang1.taoHoaDon(iphoneXs, 2, 'Nguyễn Văn Chiến', '0123456789');
print('Tổng tiền hóa đơn 1: ${hoadonA.tinhTongTien()}');
print('Lợi nhuận hóa đơn 1: ${hoadonA.tinhLoiNhuanThucTe()}');


//Taọ thêm các hóa đơn
var hoadonB = cuaHang1.taoHoaDon(iphone12, 3, 'Nguyễn Văn Thắng', '0123456789');
var hoadonC = cuaHang1.taoHoaDon(samsunggalaxy, 4, 'Nguyễn Văn Trung', '0123456789');
cuaHang1.hienThiDanhSachHoaDon();
print('Doanh thu từ 10/2024 đến bây giờ: ${cuaHang1.tongDoanhThu(DateTime.parse("2024-10-01"), DateTime.now())}');

print('Lợi nhuận từ 10/2024 đến giờ: ${cuaHang1.tongLoiNhuan(DateTime.parse("2024-10-01"), DateTime.now())}');

print('\n-------------------');
print('Thống kê hàng bán chạy: ');
cuaHang1.thongKeBanChay();




print('\n-------------------');
print('Thống kê tồn kho: ');
cuaHang1.thongKeTonKho();
 
}

