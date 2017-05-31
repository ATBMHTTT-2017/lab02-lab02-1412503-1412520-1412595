GRANT SELECT ON KHOA_NHANVIEN TO TruongPhong;
GRANT SELECT ON KHOA_NHANVIEN TO TruongDuAn;
GRANT SELECT ON KHOA_NHANVIEN TO GiamDoc;
GRANT SELECT ON KHOA_NHANVIEN TO TruongChiNhanh;
GRANT SELECT ON KHOA_NHANVIEN TO NhanVien;

CREATE OR REPLACE PROCEDURE INS_EMPLOYEE(empID char, empName nchar, empAdd nchar, empTell char, empMail varchar, empRoom char, branch char, empSal int)
AS
    keyRaw raw(32);
    encryptedSal raw(2000);
BEGIN
    keyRaw := DBMS_CRYPTO.RANDOMBYTES (32);
    encryptedSal := ENCRYPT(TO_CHAR(empSal), keyRaw);
    INSERT INTO KHOA_NHANVIEN VALUES(empID, UTL_RAW.BIT_XOR(keyRaw, UTL_I18N.STRING_TO_RAW(empID)));
    INSERT INTO NHANVIEN VALUES(empID, empName, empAdd, empTell, empMail, empRoom, branch, encryptedSal);
END  INS_EMPLOYEE;

CREATE OR REPLACE FUNCTION ENCRYPT(plainText in varchar2, keyRaw in raw )
RETURN raw
IS
     encryption_type    PLS_INTEGER :=  DBMS_CRYPTO.ENCRYPT_AES256 + DBMS_CRYPTO.CHAIN_CBC + DBMS_CRYPTO.PAD_PKCS5;
       iv_raw             RAW (16);
     cipherText raw(2000);
BEGIN
   iv_raw        := DBMS_CRYPTO.RANDOMBYTES (16);
   cipherText := DBMS_CRYPTO.ENCRYPT
      (
         src => UTL_I18N.STRING_TO_RAW (plainText,  'AL32UTF8'),
         typ => encryption_type,
         key => keyRaw,
         iv  => iv_raw
      );
    cipherText := UTL_RAW.CONCAT(iv_raw, cipherText);
    RETURN cipherText;
END ENCRYPT;
/
show errors

---nhan vien chi duoc nhin thay khoa cua minh
--ham policy
CREATE OR REPLACE FUNCTION auth_khoa( 
  schema_var IN VARCHAR2,
  table_var  IN VARCHAR2
 )
 RETURN VARCHAR2
 IS
  return_val VARCHAR2 (500);
  userName VARCHAR2(6);
 BEGIN
  IF (SYS_CONTEXT('userenv', 'ISDBA') = 'TRUE') THEN
     RETURN '';
  ELSE
      SELECT SYS_CONTEXT('userenv', 'SESSION_USER') INTO userName FROM DUAL;
        IF (userName = 'QTV') THEN
          RETURN '';
        ELSE
          return_val := 'MANV = '  || '''' || userName ||'''';
          
          RETURN return_val;
        END IF;
  END IF;
   RETURN return_val;
 END auth_khoa;
/
 show errors
 
  BEGIN
  DBMS_RLS.ADD_POLICY (
    object_schema    => 'QTV',
    object_name      => 'KHOA_NHANVIEN',
    policy_name      => 'khoa_policy',
    function_schema  => 'QTV',
    policy_function  => 'auth_khoa',
    statement_types  => 'select'
   );
 END;
/
 show errors


CREATE OR REPLACE FUNCTION DECRYPT(cipherText in raw, keyRaw in raw)
RETURN varchar2
IS
     encryption_type    PLS_INTEGER :=  DBMS_CRYPTO.ENCRYPT_AES256 + DBMS_CRYPTO.CHAIN_CBC + DBMS_CRYPTO.PAD_PKCS5;
    plainText varchar2(200);
     decrypted_raw raw(2000);
     iv_raw             RAW (16);
     cipher             RAW(2000);
BEGIN
       iv_raw := UTL_RAW.SUBSTR(cipherText, 0,  16);
       cipher:= UTL_RAW.SUBSTR(cipherText, 17,  UTL_RAW.LENGTH( cipherText) - 16);
       decrypted_raw := DBMS_CRYPTO.DECRYPT
      (
         src => cipher,
         typ => encryption_type,
         key => keyRaw,
         iv  => iv_raw
      );
  plainText  := UTL_I18N.RAW_TO_CHAR (decrypted_raw, 'AL32UTF8');
  RETURN  plainText;
END;
/
show errors

CREATE OR REPLACE FUNCTION ENCRYPT_SAL(salary in raw)
RETURN varchar2
AS
    uName char(6);
    countt int;
    keyRaw raw(2000);
BEGIN
    SELECT COUNT(MANV) INTO countt FROM NHANVIEN N, KHOA_NHANVIEN K WHERE N.MANV = K.MANV;
    SELECT 
    IF (countt > 0) THEN
        SELECT MANV INTO uName FROM KHOA_NHANVIEN;
        RETURN(QTV.DECRYPT(salary, UTL_RAW.BIT_XOR(keyRaw, UTL_I18N.STRING_TO_RAW(uName)));
    ELSE
        RETURN UTL_I18N.RAW_TO_CHAR (salary);
    END IF;
END
/
show errors

CREATE OR REPLACE PROCEDURE SEL_EMPLOYEE
BEGIN
   SELECT MANV, HOTEN, DIACHI, DIENTHOAI, EMAIL, MAPHONG, CHINHANH, ENCRYPT_SAL(LUONG) FROM NHANVIEN;
END SEL_EMPLOYEE;

