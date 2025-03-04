-- QUẢN LÝ ĐỀ TÀI.
 -- câu 36: Cho biết những giáo viên có lương lớn nhất
 SELECT *
 FROM GIAOVIEN GV
 WHERE GV.LUONG = (SELECT MAX(LUONG)
       FROM GIAOVIEN)
 -- Câu 38: Cho biết tên của giáo viên lớn tuổi nhất của bộ môn hệ thống thông tin
 SELECT HOTEN
 FROM GIAOVIEN GV, BOMON BM
 WHERE BM.TENBM = N'Hệ thống thông tin' AND GV.MABM = BM.MABM
   AND YEAR(GV.NGSINH) = (SELECT MIN(YEAR(GV1.NGSINH))
        FROM GIAOVIEN GV1, BOMON BM1
        WHERE BM1.TENBM = N'Hệ thống thông tin' AND GV1.MABM = BM1.MABM
        )
 -- Câu 40: Cho biết tên giáo viên và tên khoa giáo viên có lương cao nhất
 SELECT GV.HOTEN, K.TENKHOA
 FROM GIAOVIEN GV, KHOA K, BOMON BM
 WHERE GV.MABM = BM.MABM AND BM.MAKHOA = K.MAKHOA AND (GV.LUONG = (SELECT MAX(LUONG) 
         FROM GIAOVIEN))
 -- Câu 42: Cho biết tên những đề tài mà giáo viên Nguyễn Hoài An chưa tham gia
 SELECT TENDT
 FROM DETAI DT
 WHERE DT.MADT NOT IN (SELECT DT.MADT
      FROM GIAOVIEN GV,THAMGIADT TG
      WHERE GV.HOTEN = N'Nguyễn Hoài An'AND GV.MAGV = TG.MAGV
      )
 -- 44: Cho biết tên của những giáo viên khoa Công nghệ thông tin chưa tham gia đề tài
 SELECT HOTEN
 FROM GIAOVIEN GV, DETAI DT, BOMON BM, KHOA K
 WHERE (K.TENKHOA = N'Công nghệ thông tin' AND K.MAKHOA = BM.MAKHOA AND GV.MABM = BM.MABM AND GV.MAGV NOT IN (SELECT MAGV FROM THAMGIADT))
 -- 46: Cho biết giáo viên có lương lớn hơn lương của giáo viên Nguyễn Hoài An 
 SELECT GV1.MAGV , GV1.HOTEN
 FROM GIAOVIEN GV1, GIAOVIEN GV2
 WHERE GV1.LUONG > GV2.LUONG AND GV2.HOTEN = N'Nguyễn Hoài An' AND GV1.MAGV != GV2.MAGV  
 -- 48: tìm những giáo viên cùng tên, cùng giới tính với các giáo viên trong cùng bộ môn
 SELECT *
 FROM GIAOVIEN GV1, GIAOVIEN GV2
 WHERE GV1.HOTEN = GV2.HOTEN AND GV2.PHAI = GV1.PHAI  AND GV1.MAGV != GV2.MAGV AND GV1.MABM = GV2.MABM
 -- 50: tìm những giáo viên có lương lớn hơn tất cả các giáo viên thuộc bộ môn hệ thống thôn tin
 SELECT *
 FROM GIAOVIEN GV
 WHERE GV.LUONG >= ALL (SELECT GV1.LUONG
       FROM GIAOVIEN GV1, BOMON BM
       WHERE GV1.MABM = BM.MABM AND BM.TENBM = 'Hệ thống thông tin'
       )
 -- 52: Cho biết tên của giáo viên chủ nhiệm nhiều đề tài nhất.
 SELECT HOTEN
 FROM GIAOVIEN GV
 WHERE GV.MAGV IN (SELECT MAGV
       FROM GIAOVIEN GV1, DETAI DT1
       WHERE GV1.MAGV = DT1.GVCNDT 
       GROUP BY GV1.MAGV
       HAVING COUNT(*) >= ALL (SELECT GV2.MAGV
             FROM GIAOVIEN GV2, DETAI DT2
             WHERE GV2.MAGV = DT2.GVCNDT 
             GROUP BY GV2.MAGV)
       )
 -- 54: Cho biết tên giáo viên và tên bộ môn của giáo viên tham gia nhiều đề tài nhất
 SELECT HOTEN, TENBM
 FROM GIAOVIEN GV, BOMON BM
 WHERE GV.MABM = BM.MABM AND EXISTS      (SELECT GV2.MAGV
           FROM GIAOVIEN GV2, THAMGIADT TG
           WHERE GV2.MAGV = TG.MAGV  AND GV.MAGV = GV2.MAGV
           GROUP BY GV2.MAGV
           HAVING COUNT(*) >=ALL (SELECT (COUNT(*))
                 FROM GIAOVIEN GV3, THAMGIADT TG3
                 WHERE GV3.MAGV = TG3.MAGV
                 GROUP BY GV3.MAGV)
                )
 -- 56: Cho biết tên giáo viên và tên của giáo viên có nhiều người thân nhất
 SELECT HOTEN, TENBM
 FROM GIAOVIEN GV, BOMON BM
 WHERE GV.MABM = BM.MABM AND GV.MAGV IN (SELECT GV.MAGV
           FROM GIAOVIEN GV, NGUOITHAN NT
           WHERE GV.MAGV = NT.MAGV
           GROUP BY GV.MAGV
           HAVING COUNT(*) >=ALL (SELECT COUNT(*)
                 FROM GIAOVIEN GV, NGUOITHAN NT
                 WHERE GV.MAGV = NT.MAGV
                 GROUP BY GV.MAGV)
                 )
-- Câu 59: Cho biết tên đề tài nào mà được tất cả các giáo viên của bộ môn hệ thống thông tin tham gia
SELECT TENDT
FROM DETAI DT
WHERE DT.MADT IN(SELECT DT.MADT
    FROM DETAI DT
    WHERE NOT EXISTS (SELECT GV.MAGV
          FROM GIAOVIEN GV
          WHERE GV.MABM = 'HTTT'
          EXCEPT
          SELECT TG.MAGV
          FROM THAMGIADT TG
          WHERE DT.MADT = TG.MADT 
          )
          )
-- Câu 61: Cho biết giáo viên nào đã tham gia tất cả các đề tài có mã chủ đề là QLGD
SELECT *
FROM GIAOVIEN GV
WHERE NOT EXISTS (SELECT DT.MADT
      FROM DETAI DT
      WHERE DT.MACD = 'QLGD'
      EXCEPT 
      SELECT TG.MADT
      FROM THAMGIADT TG
      WHERE GV.MAGV = TG.MAGV )
        
-- Câu 63: Cho biết tên đề tài nào mà được tất cả giáo viên của bộ môn hóa hữu cơ tham gia
SELECT TENDT
FROM DETAI DT
WHERE DT.MADT IN(SELECT DT.MADT
    FROM DETAI DT
    WHERE NOT EXISTS (SELECT GV.MAGV
          FROM GIAOVIEN GV, BOMON BM
          WHERE GV.MABM = BM.MABM AND BM.TENBM = N'Hóa hữu cơ'
          EXCEPT
          SELECT TG.MAGV
          FROM THAMGIADT TG
          WHERE DT.MADT = TG.MADT
           )
         )
       
-- Câu 65: Cho biết giáo viên nào đã tham gia tất cả các đề tài của chủ đề ứng dụng công nghệ
SELECT *
FROM GIAOVIEN GV
WHERE NOT EXISTS (SELECT DT.MADT
      FROM DETAI DT, CHUDE CD
      WHERE DT.MACD = CD.MACD AND CD.TENCD = N'Ứng dụng công nghệ'
      EXCEPT 
      SELECT TG.MADT
      FROM THAMGIADT TG
      WHERE GV.MAGV = TG.MAGV )
-- Câu 67: Cho biết tên đề tài nào được tất cả giáo viên của khoa CNTT tham gia
SELECT TENDT
FROM DETAI DT
WHERE DT.MADT IN(SELECT DT.MADT
    FROM DETAI DT
    WHERE NOT EXISTS (SELECT GV.MAGV
          FROM GIAOVIEN GV, BOMON BM
          WHERE GV.MABM = BM.MABM AND BM.MAKHOA = 'CNTT'
          EXCEPT
          SELECT TG.MAGV
          FROM THAMGIADT TG
          WHERE DT.MADT = TG.MADT
           )
         )
-- 69: Tìm tên các giáo viên được phân công làm tất cả các công việc của đề tài có kinh phí trên 100tr
SELECT GV.HOTEN
FROM GIAOVIEN GV
WHERE GV.MAGV IN (SELECT GV.MAGV
      FROM GIAOVIEN GV
      WHERE NOT EXISTS (SELECT DT.MADT
         FROM DETAI DT
         WHERE DT.KINHPHI >100000000
      
         EXCEPT
         SELECT TG.MADT
         FROM THAMGIADT TG
         WHERE GV.MAGV = TG.MAGV
         ) 
         )
-- 71: Cho biết mã số, họ tên, ngày sinh của giáo viên của giáo viên tham gia tất cả các công việc của đề tài ứng dụng xanh 
SELECT GV.HOTEN, GV.MAGV, GV.NGSINH
FROM GIAOVIEN GV
WHERE GV.MAGV IN (SELECT GV.MAGV
      FROM GIAOVIEN GV
      WHERE NOT EXISTS (SELECT DT.MADT, CV.SOTT
         FROM DETAI DT, CONGVIEC CV
         WHERE DT.MADT = CV.MADT AND DT.TENDT = N'Ứng dụng xanh'
      
         EXCEPT
         SELECT TG.MADT
         FROM THAMGIADT TG
         WHERE GV.MAGV = TG.MAGV
         )
         )
Nguồn URL: shareprogramming.net.vn

 