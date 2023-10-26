// Soal Stored Procedure
Call SP_KURS_PAJAK();

// Soal Stored Function
SET @tgl := '2016-04-22, 2016-07-20, 2015-03-29, 2023-07-03';
SELECT FIND_SMALLEST(@tgl);