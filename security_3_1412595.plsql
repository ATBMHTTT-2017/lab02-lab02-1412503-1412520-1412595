--tao Database Session Context cho cac loai nhan vien
CREATE CONTEXT emp_ctx USING set_title_ctx_pkg;
CREATE OR REPLACE PACKAGE set_title_ctx_pkg IS 
   PROCEDURE set_title; 
 END; 
 /
 CREATE OR REPLACE PACKAGE BODY set_title_ctx_pkg IS
   PROCEDURE set_title
   AS 
      title varchar2(20);
      countt INTEGER;
   BEGIN
      SELECT SYS_CONTEXT('USERENV', 'SESSION_USER') INTO title FROM DUAL;
      SELECT COUNT(TRUONGPHONG) INTO countt FROM PHONGBAN WHERE TRUONGPHONG = title;
      IF countt > 0
      THEN
        title := 'TruongPhong';
        DBMS_SESSION.SET_CONTEXT('emp_ctx', 'title', title);
      ELSE
      
        SELECT COUNT(TRUONGCHINHANH) INTO countt FROM CHINHANH WHERE TRUONGCHINHANH = title;
        IF (countt > 0) THEN
           title := 'TruongChiNhanh';
          DBMS_SESSION.SET_CONTEXT('emp_ctx', 'title', title);
        ELSE
          
          SELECT COUNT(TRUONGDA) INTO countt FROM DUAN WHERE TRUONGDA = title;
          IF (countt >0) THEN
            title := 'TruongDuAn';
            DBMS_SESSION.SET_CONTEXT('emp_ctx', 'title', title);
          ELSE
            title := 'NhanVien';
            DBMS_SESSION.SET_CONTEXT('emp_ctx', 'title', title);
          END IF;
        END IF;
      END IF;
   EXCEPTION  
    WHEN NO_DATA_FOUND THEN NULL;
  END;
END;
  /
  show errors
  
 --tao trigger de moi lan logon 1 user nao do, oracle tu dong chay app context de gan title cho user do 
CREATE OR REPLACE TRIGGER set_title_ctx_trig AFTER LOGON ON DATABASE
 BEGIN
  QTV.set_title_ctx_pkg.set_title;
 END;
 /
 show errors

---Trưởng dự án chỉ được xem và cập nhật thông tin chi tiêu dự án của mình
GRANT SELECT, INSERT, UPDATE ON CHITIEU TO TruongDuAn;
GRANT SELECT ON DUAN TO TruongDuAn;
 --tạo policy function
 CREATE OR REPLACE FUNCTION auth_chitieu_select( 
  schema_var IN VARCHAR2,
  table_var  IN VARCHAR2
 )
 RETURN VARCHAR2
 IS
  return_val VARCHAR2 (500);
  userName VARCHAR2(6);
  title varchar2(20);
  countt integer;
 BEGIN
  SELECT SYS_CONTEXT('emp_ctx', 'title') INTO title FROM DUAL;
  SELECT SYS_CONTEXT('userenv', 'SESSION_USER') INTO userName FROM DUAL;
  IF (title = 'TruongDuAn') THEN
      return_val := 'EXISTS  (SELECT MADA FROM DUAN WHERE MADA = DUAN  AND TRUONGDA = '''  ||  userName || ''' )';
      RETURN return_val;
  END IF;
   RETURN return_val;
 END auth_chitieu_select;
/
 show errors
 
 --tạo policy
 ---Trưởng dự án chỉ được xem và cập nhật thông tin chi tiêu dự án của mình
 BEGIN
  DBMS_RLS.ADD_POLICY (
    object_schema    => 'QTV',
    object_name      => 'CHITIEU',
    policy_name      => 'chitieu_policy',
    function_schema  => 'QTV',
    policy_function  => 'auth_chitieu_select',
    statement_types  => 'select, update'
   );
 END;
/
