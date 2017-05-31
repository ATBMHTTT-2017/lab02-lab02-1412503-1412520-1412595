--tạo cấu trúc dữ liệu
--ma nhan vien co dang NV0000
CREATE TABLE NHANVIEN(
  maNV char(6),
  hoTen nchar(100),
  diaChi nchar(100),
  dienThoai char(20),
  email varchar(100),
  maPhong char(5) not null,
  chiNhanh char(5) not null,
  luong raw(2000)
);

--ma chi nhanh co dang CN000, bat buoc phai co 3 chi nhanh Tp.Ho Chi Minh, Ha Noi. Da Nang
CREATE TABLE CHINHANH(
  maCN char(5),
  tenCN nvarchar2(100),
  truongChiNhanh char(6),
  PRIMARY KEY(maCN)	
);

--ma phong ban co dang la PB000, bat buoc phai co phong ban: “Nhân sự”, “Kế toán”, “Kế hoạch”.

CREATE TABLE PHONGBAN(
  maPhong char(5),
  tenPhong nvarchar2(30),
  truongPhong char(6),
  ngayNhanChuc date,
  soNhanVien int,
  chiNhanh char(5) not null,
  CONSTRAINT check_soNV
  CHECK (soNhanVien > 0),
  PRIMARY KEY(maPhong)
);

CREATE TABLE PHANCONG(
  maNV char(6),
  duAn char(5),
  vaiTro nvarchar2(30),
  phuCap int,
  CONSTRAINT check_phuCap
  CHECK (phuCap > 0),
  PRIMARY KEY(maNV, duAn)
);

--ma chi tieu co dang la CT000
CREATE TABLE CHITIEU(
  maChiTieu varchar(9),
  tenChiTieu nvarchar2(50),
  soTien raw(2000),
  duAn char(5) not null
);

--ma du an co dang DA000
CREATE TABLE DUAN(
  maDA char(5),
  tenDA nvarchar2(50),
  kinhPhi int,
  phongChuTri char(5) not null,
  truongDA char(6) not null,
  CONSTRAINT check_kinhPhi
  CHECK (kinhPhi > 0),
  PRIMARY KEY(maDA)
);

ALTER TABLE NHANVIEN
ADD CONSTRAINT FK_NHANVIEN_PHONGBAN
FOREIGN KEY (maPhong)
REFERENCES PHONGBAN(maPhong);

ALTER TABLE NHANVIEN
ADD CONSTRAINT FK_NHANVIEN_CHINHANH
FOREIGN KEY (chiNhanh)
REFERENCES CHINHANH(maCN);

ALTER TABLE CHINHANH
ADD CONSTRAINT FK_CHINHANH_NHANVIEN
FOREIGN KEY (truongChiNhanh)
REFERENCES NHANVIEN(maNV);

ALTER TABLE PHONGBAN
ADD CONSTRAINT FK_PHONGBAN_NHANVIEN
FOREIGN KEY (truongPhong)
REFERENCES NHANVIEN(maNV);

ALTER TABLE PHONGBAN
ADD CONSTRAINT FK_PHONGBAN_CHINHANH
FOREIGN KEY (chiNhanh)
REFERENCES CHINHANH(maCN);

ALTER TABLE  PHANCONG
ADD CONSTRAINT FK_PHANCONG_NHANVIEN
FOREIGN KEY (maNV)
REFERENCES NHANVIEN(maNV);

ALTER TABLE PHANCONG
ADD CONSTRAINT FK_PHANCONG_DUAN
FOREIGN KEY (duAn)
REFERENCES  DUAN(maDA);

ALTER TABLE DUAN
ADD CONSTRAINT FK_DUAN_PHONGBAN
FOREIGN KEY (phongChuTri)
REFERENCES PHONGBAN(maPhong);

ALTER TABLE DUAN
ADD CONSTRAINT FK_DUAN_NHANVIEN
FOREIGN KEY (truongDA)
REFERENCES  NHANVIEN(maNV);

ALTER TABLE CHITIEU
ADD CONSTRAINT FK_CHITIEU_DUAN
FOREIGN KEY (duAn)
REFERENCES DUAN(maDA);

--tạo dữ liệu
--chi nhánh
insert into CHINHANH values ('CN001', 'TP Hà Nội', null);
insert into CHINHANH values ('CN002', 'TP Hải Phòng', null);
insert into CHINHANH values ('CN003', 'TP Đà Nẵng', null);
insert into CHINHANH values ('CN004', 'TP Hồ Chí Minh', null);
insert into CHINHANH values ('CN005', 'TP Cần Thơ', null);

--phong ban
---chi nhánh 1
INSERT INTO PHONGBAN VALUES('PB001', 'Nhân sự', null, TO_DATE( '2009-06-23', 'yyyy-mm-dd'), '7', 'CN001');
INSERT INTO PHONGBAN VALUES('PB002', 'Kế toán', null, TO_DATE( '2009-07-25', 'yyyy-mm-dd'), '6', 'CN001');
INSERT INTO PHONGBAN VALUES('PB003', 'Kế hoạch', null, TO_DATE( '2010-03-11', 'yyyy-mm-dd'), '5', 'CN001');
--chi nhánh 2
INSERT INTO PHONGBAN VALUES('PB004', 'Nhân sự', null, TO_DATE('2010-09-12', 'yyyy-mm-dd'), '3', 'CN002');
INSERT INTO PHONGBAN VALUES('PB005', 'Kế toán', null, TO_DATE('2011-10-27', 'yyyy-mm-dd'), '3', 'CN002');
INSERT INTO PHONGBAN VALUES('PB006', 'Kế hoạch', null, TO_DATE('2012-03-29', 'yyyy-mm-dd'), '5', 'CN002');
--chi nhánh 3
INSERT INTO PHONGBAN VALUES('PB007', 'Nhân sự', null, TO_DATE('2009-04-23', 'yyyy-mm-dd'), '3', 'CN003');
INSERT INTO PHONGBAN VALUES('PB008', 'Kế toán', null, TO_DATE( '2009-04-25', 'yyyy-mm-dd'), '4', 'CN003');
INSERT INTO PHONGBAN VALUES('PB009', 'Kế hoạch', null, TO_DATE('2010-11-30', 'yyyy-mm-dd'), '3', 'CN003');
--chi nhánh 4
INSERT INTO PHONGBAN VALUES('PB010', 'Nhân sự', null, TO_DATE( '2009-10-31', 'yyyy-mm-dd'), '4', 'CN004');
INSERT INTO PHONGBAN VALUES('PB011', 'Kế toán', null, TO_DATE( '2012-07-19' , 'yyyy-mm-dd'), '4', 'CN004');
INSERT INTO PHONGBAN VALUES('PB012', 'Kế hoạch', null, TO_DATE( '2008-04-21', 'yyyy-mm-dd'), '3', 'CN004');
--chi nhánh 5
INSERT INTO PHONGBAN VALUES('PB013', 'Nhân sự', null, TO_DATE( '2007-04-11', 'yyyy-mm-dd'), '3', 'CN005');
INSERT INTO PHONGBAN VALUES('PB014', 'Kế toán', null, TO_DATE( '2008-05-29', 'yyyy-mm-dd'), '3', 'CN005');
INSERT INTO PHONGBAN VALUES('PB015', 'Kế hoạch', null, TO_DATE( '2008-04-21', 'yyyy-mm-dd'), '4',  'CN005');



--trưởng chi nhánh
insert into NHANVIEN values ('NV0011', 'Ngô Hồng Bảo Ngọc', '115, Nguyễn Huệ, phường Bến Nghé, Quận 1, TP.HCM', '01671671677', 'nhbngoc@gmail.com', 'PB001', 'CN001',8000000);
insert into NHANVIEN values ('NV0012', 'Ngô Huỳnh Phúc Nguyên', '364 Cộng Hòa, phường 13, Quận Tân Bình, TPHCM', '0911119111', 'nhpnguyen@gmail.com', 'PB006', 'CN002',800000);
insert into NHANVIEN values ('NV0013', 'Huỳnh Thị Tuyết Hạnh', '71 Hai Bà Trưng, phường Tân Định, Quận 1, TPHCM', '0989898098', 'htthanh@gmail.com', 'PB008', 'CN003',8500000);
insert into NHANVIEN values ('NV0014', 'Lê Thị Mai', '14 Đinh Tiên Hoàng, phường Bến Nghé, Quận 1, TPHCM', '0912346565', 'ltmai@gmail.com', 'PB010', 'CN004',8000000);
insert into NHANVIEN values ('NV0015', 'Võ Thanh Tùng', '202 Pasteur, phường 6, Quận 3, TPHCM', '0977865123', 'vttung@gmail.com', 'PB015', 'CN005',9000000);

--truong phong
INSERT INTO NHANVIEN VALUES('NV0006', 'Trần Ngọc Thùy Tiên', '242 Trần Hưng Đạo quận 5', '0284731461', 'tnttien@gmail.com', 'PB004', 'CN002', '9000000');
INSERT INTO NHANVIEN VALUES('NV0007', 'Nguyễn Thị Khánh Ngân', '124 Nguyễn Trãi phường 7 quận 5', '091387241', 'ntkngan@gmail.com', 'PB015', 'CN005', '9000000');
INSERT INTO NHANVIEN VALUES('NV0008', 'Hoàng Thị Chọc Sào', '136 Nguyễn Đình Chiểu phường 13 quận 1', '090237141', 'htcsao@yahoo.com', 'PB001', 'CN001', '8000000');
INSERT INTO NHANVIEN VALUES('NV0009', 'Nguyễn Ngọc Phân Thơm', '956 Lò Gốm phường 8 quận 6', '098247264', 'nnpthom@gmail.com', 'PB002', 'CN001', '8500000');
INSERT INTO NHANVIEN VALUES('NV0010', 'Thòng Hoàng Yến', '56 Mạc Đĩnh Chi phường 6 quận 1', '0935732872', 'thyen@yahoo.com', 'PB003', 'CN001', '8000000');

INSERT INTO NHANVIEN VALUES('NV0034', 'Bùi Kim Quyên', '269 Trần Hưng Đạo quận 5', '0284731461', 'bkquyen@gmail.com', 'PB005', 'CN002', '9000000');
INSERT INTO NHANVIEN VALUES('NV0035', 'Võ An Phước Thiện', '121 Nguyễn Trãi phường 7 quận 5', '091387241', 'vapthien@gmail.com', 'PB007', 'CN003', '9000000');
INSERT INTO NHANVIEN VALUES('NV0036', 'Phạm Nguyễn Quỳnh Trân', '34 Nguyễn Đình Chiểu phường 13 quận 1', '090237141', 'pnqtran@yahoo.com', 'PB010', 'CN004', '8000000');
INSERT INTO NHANVIEN VALUES('NV0037', 'Dương Hoài Phương', '950 Lò Gốm phường 8 quận 6', '098247264', 'dhphuong@gmail.com', 'PB013', 'CN005', '8500000');
INSERT INTO NHANVIEN VALUES('NV0038', 'Phan Vinh Bính', '18 Mạc Đĩnh Chi phường 6 quận 1', '0935732872', 'pvbinh@yahoo.com', 'PB006', 'CN002', '8000000');

INSERT INTO NHANVIEN VALUES('NV0039', 'Võ Minh Thư', '271 Trần Hưng Đạo quận 5', '0284731461', 'vmthu@gmail.com', 'PB008', 'CN003', '9000000');
INSERT INTO NHANVIEN VALUES('NV0040', 'Phan Huỳnh Ngọc Dung', '42 Nguyễn Trãi phường 7 quận 5', '091387241', 'phndung@gmail.com', 'PB011', 'CN004', '9000000');
INSERT INTO NHANVIEN VALUES('NV0041', 'Nguyễn Vân Anh', '198 Nguyễn Đình Chiểu phường 13 quận 1', '090237141', 'nvanh@yahoo.com', 'PB014', 'CN005', '8000000');
INSERT INTO NHANVIEN VALUES('NV0050', 'Nguyễn Thế Vinh', '768 Lò Gốm phường 8 quận 6', '098247264', 'ntvinh@gmail.com', 'PB009', 'CN003', '8500000');
INSERT INTO NHANVIEN VALUES('NV0051', 'Nguyễnn Thi Thanh Bích', '19 Mạc Đĩnh Chi phường 6 quận 1', '0935732872', 'nttbich@yahoo.com', 'PB012', 'CN004', '8000000');

--Trưởng dự án
insert into NHANVIEN values ('NV0001', 'Nguyễn Hoàng Anh', '130/25 Trần Hưng Ðạo, phuờng Phạm Ngũ Lão, Quận 1, TPHCM', '0935123456', 'hoanganh589@gmail.com', 'PB001', 'CN001',6000000);
insert into NHANVIEN values ('NV0002', 'Trần Ngọc Phươnng', '80 Trần Phú, phường 4, Quận 5, TPHCM', '0125896347', 'ngocphuong@gmail.com', 'PB011', 'CN004',6500000);
insert into NHANVIEN values ('NV0003', 'Võ Thanh Ngọc', '227 Nguyễn Văn Cừ, phường 4, Quận 5, TPHCM', '01666359782', 'thanhngoc@gmail.com', 'PB006', 'CN002',6000000);
insert into NHANVIEN values ('NV0004', 'Nguyễn Văn Minh', '176 Nguyễn Thị Thập, phường Bình Thuận, Quận 7, TPHCM', '01265897433', 'vanminh@gmail.com', 'PB002', 'CN001',6000000);
insert into NHANVIEN values ('NV0005', 'Bùi Minh Quang', '938 Lò Gốm, phường 8, Quận 6, TPHCM', '09365874265', 'minhquang@gmail.com', 'PB003', 'CN001',7000000);

insert into NHANVIEN values ('NV0052', 'Lương Thế Vinh', '12 Cộng Hòa, phuờng 4, Quận Tân Bình, TPHCM', '0935148256', 'thevinh@gmail.com', 'PB007', 'CN003',6000000);
insert into NHANVIEN values ('NV0053', 'Trần Ngọc Vân', '80 Hồ Thị Kỷ, phường 5, Quận 5, TPHCM', '0125896347', 'ngocvan@gmail.com', 'PB005', 'CN002',6500000);
insert into NHANVIEN values ('NV0054', 'Võ Vân Ngọc', '22 Trần Đình Xu, phường Cầu Kho, Quận 1, TPHCM', '01666359782', 'vanngoc@gmail.com', 'PB008', 'CN003',6000000);
insert into NHANVIEN values ('NV0055', 'Nguyễn Văn Hùng', '90 Hồ Hảo Hớn, phường Phạm Ngũ Lão, Quận 1, TPHCM', '01265890143', 'vanhung@gmail.com', 'PB013', 'CN005',6000000);
insert into NHANVIEN values ('NV0056', 'Bùi Thu Trang', '30 Nguyễn Khắc Nhu, phường Phạm Ngũ Lão, Quận 1, TPHCM', '09365874265', 'thutrang@gmail.com', 'PB004', 'CN002',7000000);
insert into NHANVIEN values ('NV0057', 'Nguyễn Hoài Tú', '30 Lê Văn Sỹ, phuờng 5, Quận Phú Nhuận, TPHCM', '0901223456', 'hoaitu@gmail.com', 'PB009', 'CN003',6000000);
insert into NHANVIEN values ('NV0058', 'Trần Thảo Nguyên', '124 Trường Sa, phường 4, Quận Phú Nhuận, TPHCM', '0168996347', 'thaonguyen@gmail.com', 'PB014', 'CN005',6500000);
insert into NHANVIEN values ('NV0059', 'Võ Thảo Vy', '250 Cao Đạt, phường 4, Quận 5, TPHCM', '03657359782', 'thaovy@gmail.com', 'PB010', 'CN004',6000000);
insert into NHANVIEN values ('NV0060', 'Nguyễn Minh Thành', '52 Phạm Viết Chánh, phường Nguyễn Cư Trinh, Quận 1, TPHCM', '01210257433', 'minhthanh@gmail.com', 'PB012', 'CN004',6000000);
insert into NHANVIEN values ('NV0061', 'Bùi Ngọc Hân', '32 Nguyễn Biểu, phường 8, Quận 5, TPHCM', '09369870265', 'ngochan@gmail.com', 'PB015', 'CN005',7000000);

--giams doc
INSERT INTO NHANVIEN VALUES('NV0016', 'Nguyễn Hoàng Bành Trướng', '98 Hoàng Trân Công Chúa phường 12 quận 3', '0124824217', 'nhbtruong@gmail.com', 'PB001', 'CN001', '40000000');
INSERT INTO NHANVIEN VALUES('NV0017', 'Nguyễn Phạm Đăng Khoa', '156 Nguyễn Văn Luông phường 9 quận 6', '0127146178', 'npdkhoa@yahoo.com', 'PB002', 'CN001', '42000000');
INSERT INTO NHANVIEN VALUES('NV0018', 'Phạm Kiều Bình Nguyên', '45 Bãi Sậy phường 8 quận 6', '0123846371', 'pkbnguyen@gmail.com', 'PB001', 'CN001', '40000000');
INSERT INTO NHANVIEN VALUES('NV0019', 'Ngọc Hoàng Thiên Lôi', '123 Nguyễn Tri Phương quận 5', '0284727847', 'nhtloi@yahoo.com', 'PB002', 'CN001', '35000000');
INSERT INTO NHANVIEN VALUES('NV0020', 'Nguyễn Huỳnh Mỹ Ái', '23 Bùi Viện quận 3', '092848642', 'nhmai@gmail.com', 'PB003', 'CN001', '45000000');

--Nhân viên quèn
insert into NHANVIEN values ('NV0021', 'Nguyễn Phượng Hoàng', '676 Võ Văn Kiệt, phường 2, Quận 5, TPHCM', '01247563209', 'phuonghoang@gmail.com', 'PB001', 'CN001',3000000);
insert into NHANVIEN values ('NV0022', 'Trần Sơn Lâm', '200 Bạch Đằng, phường 9, Quận Tân Bình, TPHCM', '0996874265', 'sonlam@gmail.com', 'PB006', 'CN002',3500000);
insert into NHANVIEN values ('NV0023', 'Tạ Văn Tấn', '30 Nguyễn Minh Hoàng, phường 12, Quận Tân Bình, TPHCM', '0902596321', 'vantan@gmail.com', 'PB011', 'CN004',4000000);
insert into NHANVIEN values ('NV0024', 'Lý Thị Bông', '2/14 Trần Quốc Tuấn, phường 1, Quận Gò Vấp, TPHCM', '0901254265', 'thibong@gmail.com', 'PB002', 'CN001',3700000);
insert into NHANVIEN values ('NV0025', 'Đỗ Minh Khánh', '126/8 Dương Bá Trạc, phường 2, Quận 8, TPHCM', '01225874265', 'minhkhanh@gmail.com', 'PB007', 'CN003',5000000);
insert into NHANVIEN values ('NV0026', 'Nguyễn Thanh Phong', '676 Võ Văn Ngân, phường 2, Quận Thủ Đức, TPHCM', '01247563252', 'thanhphong@gmail.com', 'PB005', 'CN002',3600000);
insert into NHANVIEN values ('NV0027', 'Trần Ngọc Vũ', '226 Cống Quỳnh, phường Nguyễn Cư Trinh, Quận 1, TPHCM', '0996874265', 'ngocvu@gmail.com', 'PB003', 'CN001',4500000);
insert into NHANVIEN values ('NV0028', 'Đỗ Triều', '241 Nguyễn Trãi, phường Nguyễn Cư Trinh, Quận 1, TPHCM', '0925696321', 'dotrieu@gmail.com', 'PB008', 'CN003', 4000000);
insert into NHANVIEN values ('NV0029', 'Hoàng Kim Lan', '245 Đề Thám, phường Phạm Ngũ Lão, Quận 1, TPHCM', '0632254265', 'kimlan@gmail.com', 'PB013', 'CN005',3900000);
insert into NHANVIEN values ('NV0030', 'Đỗ Tuyết Nhung', '63 Lý Thái Tổ, phường 2, Quận 10, TPHCM', '01298474265', 'tuyetnhung@gmail.com', 'PB004', 'CN002',5000000);
insert into NHANVIEN values ('NV0031', 'Trần Phát Tài', '30 Nguyễn Thị Minh Khai, phường 12, Quận Bình Thạnh, TPHCM', '0902502121', 'phattai@gmail.com', 'PB009', 'CN003',4000000);
insert into NHANVIEN values ('NV0032', 'Lý Kiều Oanh', '2/14 Nguyễn Tri Phương, phường 10, Quận 5, TPHCM', '0901012265', 'kieuoanh@gmail.com', 'PB014', 'CN005',4700000);
insert into NHANVIEN values ('NV0033', 'Đỗ Phan Anh', '126 Nguyễn Biểu, phường 2, Quận 5, TPHCM', '01365874265', 'phananh@gmail.com', 'PB010', 'CN004',3000000);
insert into NHANVIEN values ('NV0042', 'Nguyễn Thành Lợi', '101, Nguyễn Huệ, phường Bến Nghé, Quận 1, TP.HCM', '01663428865', 'ntloi@gmail.com', 'PB012', 'CN004', 6000000);
insert into NHANVIEN values ('NV0043', 'Võ Quốc Duy', '338 Cộng Hòa, phường 13, Quận Tân Bình, TPHCM', '0953774400', 'vqduy@gmail.com', 'PB015', 'CN005',600000);

insert into NHANVIEN values ('NV0044', 'Lê Mai Phương Uyên', '89 Hai Bà Trưng, phường Tân Định, Quận 1, TPHCM', '0979896012', 'lmpuyen@gmail.com', 'PB001', 'CN001',6500000);
insert into NHANVIEN values ('NV0045', 'Trương Ngọc Kim Ngân', '20 Đinh Tiên Hoàng, phường Bến Nghé, Quận 1, TPHCM', '01235599324', 'tnkngan@gmail.com', 'PB006', 'CN002',7000000);
insert into NHANVIEN values ('NV0046', 'Võ Hoàng Phúc', '196 Pasteur, phường 6, Quận 3, TPHCM', '0933654889', 'vhphuc@gmail.com', 'PB011', 'CN004',7000000);
insert into NHANVIEN values ('NV0047', 'Ngô Hồng Phúc', '32 Nguyễn Du, phường Bến Nghé, Quận 1, TPHCM', '01691154768', 'nhphuc@gmail.com', 'PB002', 'CN001',6000000);
insert into NHANVIEN values ('NV0048', 'Ngô Huỳnh Phúc Khang', '42 Cộng Hòa, phường 4, Quận Tân Bình, TPHCM', '0948745434', 'nhpkhang@gmail.com', 'PB005', 'CN002',600000);
insert into NHANVIEN values ('NV0049', 'Nguyễn Hoàng Thành', '95 Võ Thị Sáu, phường Tân Định, Quận 1, TPHCM', '01677234985', 'nhthanh@gmail.com', 'PB003', 'CN001',6500000);

--Cập nhật trưởng chi nhánh
update CHINHANH set truongChiNhanh = 'NV0011' where maCN='CN001';
update CHINHANH set truongChiNhanh = 'NV0012' where maCN='CN002';
update CHINHANH set truongChiNhanh = 'NV0013' where maCN='CN003';
update CHINHANH set truongChiNhanh = 'NV0014' where maCN='CN004';
update CHINHANH set truongChiNhanh = 'NV0015' where maCN='CN005';

--cập nhật phòng ban
UPDATE PHONGBAN SET truongPhong = 'NV0008' WHERE maPhong = 'PB001';
UPDATE PHONGBAN SET truongPhong = 'NV0009' WHERE maPhong = 'PB002';
UPDATE PHONGBAN SET truongPhong = 'NV0010' WHERE maPhong = 'PB003';

UPDATE PHONGBAN SET truongPhong = 'NV0006' WHERE maPhong = 'PB004';
UPDATE PHONGBAN SET truongPhong = 'NV0034' WHERE maPhong = 'PB005';
UPDATE PHONGBAN SET truongPhong = 'NV0038' WHERE maPhong = 'PB006';

UPDATE PHONGBAN SET truongPhong = 'NV0035' WHERE maPhong = 'PB007';
UPDATE PHONGBAN SET truongPhong = 'NV0039' WHERE maPhong = 'PB008';
UPDATE PHONGBAN SET truongPhong = 'NV0050' WHERE maPhong = 'PB009';

UPDATE PHONGBAN SET truongPhong = 'NV0036' WHERE maPhong = 'PB010';
UPDATE PHONGBAN SET truongPhong = 'NV0040' WHERE maPhong = 'PB011';
UPDATE PHONGBAN SET truongPhong = 'NV0051' WHERE maPhong = 'PB012';

UPDATE PHONGBAN SET truongPhong = 'NV0037' WHERE maPhong = 'PB013';
UPDATE PHONGBAN SET truongPhong = 'NV0041' WHERE maPhong = 'PB014';
UPDATE PHONGBAN SET truongPhong = 'NV0007' WHERE maPhong = 'PB015';

--Dự án
insert into DUAN values ('DA001', 'Chung cư Riverside', 150000000000, 'PB001', 'NV0001');
insert into DUAN values ('DA002', 'Khu vui chơi Baby Place', 100000000000, 'PB006', 'NV0003');
insert into DUAN values ('DA003', 'Trung tâm thương mại New Center ', 200000000000, 'PB011', 'NV0002');
insert into DUAN values ('DA004', 'Lake Bank', 120000000000, 'PB002', 'NV0004');
insert into DUAN values ('DA005', 'Trường Tiểu học Nguyễn Minh',100000000000, 'PB007', 'NV0052');
insert into DUAN values ('DA006', 'Chung cư mới', 150000000000, 'PB005', 'NV0053');
insert into DUAN values ('DA007', 'Khu du lịch sinh thái Cỏ', 100000000000, 'PB003', 'NV0005');
insert into DUAN values ('DA008', 'Trung tâm thương mại Nắng', 200000000000, 'PB008', 'NV0054');
insert into DUAN values ('DA009', 'Lake Bank', 120000000000, 'PB013', 'NV0055');
insert into DUAN values ('DA010', 'Trường THPT Trần Quang',100000000000, 'PB004', 'NV0056');
insert into DUAN values ('DA011', 'Chung cư Saiko', 150000000000, 'PB009', 'NV0057');
insert into DUAN values ('DA012', 'Rạp chiếu phim Akako', 100000000000, 'PB014', 'NV0058');
insert into DUAN values ('DA013', 'Ngân hàng ABD ', 200000000000, 'PB010', 'NV0059');
insert into DUAN values ('DA014', 'Beach Bank', 120000000000, 'PB012', 'NV0060');
insert into DUAN values ('DA015', 'Cửa hàng ABC',100000000000, 'PB015', 'NV0061');

--Phân công
insert into PHANCONG values ('NV0001', 'DA001', 'Trưởng dự án',6000000);
insert into PHANCONG values ('NV0002', 'DA003', 'Trưởng dự án',6500000);
insert into PHANCONG values ('NV0003', 'DA002', 'Trưởng dự án',6000000);
insert into PHANCONG values ('NV0004', 'DA004', 'Trưởng dự án',6000000);
insert into PHANCONG values ('NV0005', 'DA007', 'Trưởng dự án',7000000);

insert into PHANCONG values ('NV0052', 'DA005', 'Trưởng dự án', 6000000);
insert into PHANCONG values ('NV0053', 'DA006', 'Trưởng dự án', 6000000);
insert into PHANCONG values ('NV0054', 'DA008', 'Trưởng dự án', 6000000);
insert into PHANCONG values ('NV0055', 'DA009', 'Trưởng dự án', 6000000);
insert into PHANCONG values ('NV0056', 'DA010', 'Trưởng dự án', 6000000);
insert into PHANCONG values ('NV0057', 'DA011', 'Trưởng dự án', 6000000);
insert into PHANCONG values ('NV0058', 'DA012', 'Trưởng dự án', 6000000);
insert into PHANCONG values ('NV0059', 'DA013', 'Trưởng dự án', 6000000);
insert into PHANCONG values ('NV0060', 'DA014', 'Trưởng dự án', 6000000);
insert into PHANCONG values ('NV0061', 'DA015', 'Trưởng dự án', 6000000);

insert into PHANCONG values ('NV0021', 'DA001', 'Phó dự án', 3000000); 
insert into PHANCONG values ('NV0022', 'DA002', 'Phó dự án', 3500000);
insert into PHANCONG values ('NV0023', 'DA003', 'Phó dự án', 4000000);
insert into PHANCONG values ('NV0024', 'DA004', 'Phó dự án', 3700000);
insert into PHANCONG values ('NV0025', 'DA005', 'Phó dự án', 5000000);
insert into PHANCONG values ('NV0026', 'DA006', 'Phó dự án', 3600000);
insert into PHANCONG values ('NV0027', 'DA007', 'Phó dự án', 4500000);
insert into PHANCONG values ('NV0028', 'DA008', 'Phó dự án', 4000000);
insert into PHANCONG values ('NV0029', 'DA009', 'Phó dự án', 3900000);
insert into PHANCONG values ('NV0030', 'DA010', 'Phó dự án', 5000000);
insert into PHANCONG values ('NV0031', 'DA011', 'Phó dự án', 4000000);
insert into PHANCONG values ('NV0032', 'DA012', 'Phó dự án', 4700000);
insert into PHANCONG values ('NV0033', 'DA013', 'Phó dự án', 3000000);
insert into PHANCONG values ('NV0042', 'DA014', 'Phó dự án', 6000000);
insert into PHANCONG values ('NV0043', 'DA015', 'Phó dự án', 600000);

insert into PHANCONG values ('NV0044', 'DA001', 'Kỹ sư',3500000);
insert into PHANCONG values ('NV0045', 'DA002', 'Kỹ sư',3000000);
insert into PHANCONG values ('NV0046', 'DA003', 'Kỹ sư',3000000);
insert into PHANCONG values ('NV0047', 'DA004', 'Kỹ sư',3000000);
insert into PHANCONG values ('NV0048', 'DA006', 'Kỹ sư',3000000);
insert into PHANCONG values ('NV0049', 'DA007', 'Kỹ sư',3500000);

--chi tiêu
insert into CHITIEU values ('CT001', 'Mặt bằng', 40000000000, 'DA001');
insert into CHITIEU values ('CT002', 'Nguyên vật liệu', 40000000000, 'DA001');
insert into CHITIEU values ('CT003', 'Nhân viên', 50000000000, 'DA001');
insert into CHITIEU values ('CT004', 'Quảng Cáo', 1000000000, 'DA001');
insert into CHITIEU values ('CT005', 'Dịch vụ (internet, điện thoại,...)', 5000000000, 'DA001');
insert into CHITIEU values ('CT006', 'Mặt bằng', 45000000000, 'DA004');
insert into CHITIEU values ('CT007', 'Nguyên vật liệu', 30000000000, 'DA004');
insert into CHITIEU values ('CT008', 'Nguyên vật liệu', 40000000000, 'DA005');
insert into CHITIEU values ('CT009', 'Nguyên vật liệu', 35000000000, 'DA006');
insert into CHITIEU values ('CT010', 'Nhân công', 45000000000, 'DA007');
insert into CHITIEU values ('CT011', 'Nhân công', 40000000000, 'DA008');
insert into CHITIEU values ('CT012', 'Mặt bằng', 40000000000, 'DA009');
insert into CHITIEU values ('CT013', 'Mặt bằng', 50000000000, 'DA010');
insert into CHITIEU values ('CT014', 'Nguyên vật liệu', 20000000000, 'DA011');
insert into CHITIEU values ('CT015', 'Nguyên vật liệu', 35000000000, 'DA012');
insert into CHITIEU values ('CT016', 'Mặt bằng', 45000000000, 'DA013');
insert into CHITIEU values ('CT017', 'Nguyên vật liệu', 30000000000, 'DA014');
insert into CHITIEU values ('CT018', 'Nhân công', 40000000000, 'DA014');
insert into CHITIEU values ('CT019', 'Mặt bằng', 40000000000, 'DA015');
insert into CHITIEU values ('CT020', 'Nhân công', 35000000000, 'DA015');

--tạo người dùng
--tài khoản quản trị viên
CREATE USER QTV IDENTIFIED BY quantrivien;
GRANT DBA TO QTV;
GRANT CREATE SESSION TO QTV;
GRANT CREATE ANY CONTEXT, CREATE PROCEDURE TO QTV;
GRANT EXECUTE ON DBMS_SESSION TO QTV;

---tài khoản trưởng phòng
CREATE USER NV0006 IDENTIFIED BY NV0006;
GRANT CREATE SESSION TO NV0006;
CREATE USER NV0007 IDENTIFIED BY NV0007;
GRANT CREATE SESSION TO NV0007;
CREATE USER NV0008 IDENTIFIED BY NV0008;
GRANT CREATE SESSION TO NV0008;
CREATE USER NV0009 IDENTIFIED BY NV0009;
GRANT CREATE SESSION TO NV0009;
CREATE USER NV0010 IDENTIFIED BY NV0010;
GRANT CREATE SESSION TO NV0010;

CREATE USER NV0034 IDENTIFIED BY NV0034;
GRANT CREATE SESSION TO NV0034;
CREATE USER NV0035 IDENTIFIED BY NV0035;
GRANT CREATE SESSION TO NV0035;
CREATE USER NV0036 IDENTIFIED BY NV0036;
GRANT CREATE SESSION TO NV0036;
CREATE USER NV0037 IDENTIFIED BY NV0037;
GRANT CREATE SESSION TO NV0037;
CREATE USER NV0038 IDENTIFIED BY NV0038;
GRANT CREATE SESSION TO NV0038;

CREATE USER NV0039 IDENTIFIED BY NV0039;
GRANT CREATE SESSION TO NV0039;
CREATE USER NV0040 IDENTIFIED BY NV0040;
GRANT CREATE SESSION TO NV0040;
CREATE USER NV0041 IDENTIFIED BY NV0041;
GRANT CREATE SESSION TO NV0041;
CREATE USER NV0050 IDENTIFIED BY NV0050;
GRANT CREATE SESSION TO NV0050;
CREATE USER NV0051 IDENTIFIED BY NV0051;

--tài khoản trưởng chi nhánh
CREATE USER NV0011 IDENTIFIED BY NV0011;
GRANT CREATE SESSION TO NV0011;
CREATE USER NV0012 IDENTIFIED BY NV0012;
GRANT CREATE SESSION TO NV0012;
CREATE USER NV0013 IDENTIFIED BY NV0013;
GRANT CREATE SESSION TO NV0013;
CREATE USER NV0014 IDENTIFIED BY NV0014;
GRANT CREATE SESSION TO NV0014;
CREATE USER NV0015 IDENTIFIED BY NV0015;
GRANT CREATE SESSION TO NV0015;

--tài khoản giám đốc
CREATE USER NV0016 IDENTIFIED BY NV0016;
GRANT CREATE SESSION TO NV0016;
CREATE USER NV0017 IDENTIFIED BY NV0017;
GRANT CREATE SESSION TO NV0017;
CREATE USER NV0018 IDENTIFIED BY NV0018;
GRANT CREATE SESSION TO NV0018;
CREATE USER NV0019 IDENTIFIED BY NV0019;
GRANT CREATE SESSION TO NV0019;
CREATE USER NV0020 IDENTIFIED BY NV0020;
GRANT CREATE SESSION TO NV0020;

--tài khoản trưởng dự án
CREATE USER NV0001 IDENTIFIED BY NV0001 ;
GRANT CREATE SESSION TO NV0001;
CREATE USER NV0002 IDENTIFIED BY NV0002 ;
GRANT CREATE SESSION TO NV0002;
CREATE USER NV0003 IDENTIFIED BY NV0003 ;
GRANT CREATE SESSION TO NV0003;
CREATE USER NV0004 IDENTIFIED BY NV0004 ;
GRANT CREATE SESSION TO NV0004;
CREATE USER NV0005 IDENTIFIED BY NV0005 ;
GRANT CREATE SESSION TO NV0005;
CREATE USER NV0052 IDENTIFIED BY NV0052;
GRANT CREATE SESSION TO NV0052;
CREATE USER NV0053 IDENTIFIED BY NV0053;
GRANT CREATE SESSION TO NV0053;
CREATE USER NV0054 IDENTIFIED BY NV0054;
GRANT CREATE SESSION TO NV0054;
CREATE USER NV0055 IDENTIFIED BY NV0055 ;
GRANT CREATE SESSION TO NV0055;
CREATE USER NV0056 IDENTIFIED BY NV0056 ;
GRANT CREATE SESSION TO NV0056;
CREATE USER NV0057 IDENTIFIED BY NV0057;
GRANT CREATE SESSION TO NV0057;
CREATE USER NV0058 IDENTIFIED BY NV0058;
GRANT CREATE SESSION TO NV0058;
CREATE USER NV0059 IDENTIFIED BY NV0059;
GRANT CREATE SESSION TO NV0059;
CREATE USER NV0060 IDENTIFIED BY NV0060;
GRANT CREATE SESSION TO NV0060;
CREATE USER NV0061 IDENTIFIED BY NV0061;
GRANT CREATE SESSION TO NV0061;

--tài khoản nhân viên quèn
CREATE USER NV0021 IDENTIFIED BY NV0021 ;
GRANT CREATE SESSION TO NV0021;
CREATE USER NV0022 IDENTIFIED BY NV0022 ;
GRANT CREATE SESSION TO NV0022;
CREATE USER NV0023 IDENTIFIED BY NV0023 ;
GRANT CREATE SESSION TO NV0023;
CREATE USER NV0024 IDENTIFIED BY NV0024 ;
GRANT CREATE SESSION TO NV0024;
CREATE USER NV0025 IDENTIFIED BY NV0025 ;
GRANT CREATE SESSION TO NV0025;

CREATE USER NV0026 IDENTIFIED BY NV0026 ;
GRANT CREATE SESSION TO NV0026;
CREATE USER NV0027 IDENTIFIED BY NV0027 ;
GRANT CREATE SESSION TO NV0027;
CREATE USER NV0028 IDENTIFIED BY NV0028 ;
GRANT CREATE SESSION TO NV0028;
CREATE USER NV0029 IDENTIFIED BY NV0029 ;
GRANT CREATE SESSION TO NV0029;
CREATE USER NV0030 IDENTIFIED BY NV0030 ;
GRANT CREATE SESSION TO NV0030;
CREATE USER NV0031 IDENTIFIED BY NV0031 ;
GRANT CREATE SESSION TO NV0031;
CREATE USER NV0032 IDENTIFIED BY NV0032 ;
GRANT CREATE SESSION TO NV0032;
CREATE USER NV0033 IDENTIFIED BY NV0033 ;

CREATE USER NV0042 IDENTIFIED BY NV042;
GRANT CREATE SESSION TO NV0042;
CREATE USER NV0043 IDENTIFIED BY NV043;
GRANT CREATE SESSION TO NV0043;
CREATE USER NV0044 IDENTIFIED BY NV044;
GRANT CREATE SESSION TO NV0044;
CREATE USER NV0045 IDENTIFIED BY NV045;
GRANT CREATE SESSION TO NV0045;
CREATE USER NV0046 IDENTIFIED BY NV046;
GRANT CREATE SESSION TO NV0046;
CREATE USER NV0047 IDENTIFIED BY NV047;
GRANT CREATE SESSION TO NV0047;
CREATE USER NV0048 IDENTIFIED BY NV048;
GRANT CREATE SESSION TO NV0048;
CREATE USER NV0049 IDENTIFIED BY NV049;
GRANT CREATE SESSION TO NV0049;
