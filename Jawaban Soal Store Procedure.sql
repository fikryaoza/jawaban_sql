-- ----------------------------
-- Procedure structure for SP_KURS_PAJAK
-- ----------------------------
DROP PROCEDURE IF EXISTS `SP_KURS_PAJAK`;
delimiter ;;
CREATE PROCEDURE `SP_KURS_PAJAK`()
BEGIN

	DECLARE track_no INT DEFAULT 0;
	DECLARE EXIT HANDLER FOR SQLEXCEPTION, NOT FOUND, SQLWARNING
		BEGIN
				
        ROLLBACK;
        GET DIAGNOSTICS CONDITION 1 @`errno` = MYSQL_ERRNO, @`sqlstate` = RETURNED_SQLSTATE, @`text` = MESSAGE_TEXT;
        SET @full_error = CONCAT('ERROR ', @`errno`, ' (', @`sqlstate`, '): ', @`text`);
        SELECT track_no, @full_error;
    END;
		
		START TRANSACTION;
		
		DROP TABLE IF EXISTS kurs_pajak;
		CREATE TABLE kurs_pajak (
			id_ksm_kurs_pajak int(11) NOT NULL,
			kurs_rate decimal(20,4) NOT NULL,
			tgl date NOT NULL,
			curr_id int(11) NOT NULL
		) ENGINE=InnoDB DEFAULT CHARSET=latin1;
								INSERT INTO kurs_pajak(id_ksm_kurs_pajak, kurs_rate, tgl, curr_id)SELECT id AS id_ksm_kurs_pajak, kurs_rate, DATE_FORMAT(start_date + INTERVAL n.n DAY, '%Y-%m-%d') AS tgl, curr_id
				FROM ksm_kurs_pajak
				JOIN (
					SELECT n10.n * 10 + n1.n * 1 AS n
					FROM (
						SELECT 0 n UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3
						UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6
						UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9
					) n10
					CROSS JOIN (
						SELECT 0 n UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3
						UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6
						UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9
					) n1
				) n ON start_date + INTERVAL n.n DAY <= end_date
				ORDER BY id, start_date + INTERVAL n.n DAY;
        SET track_no = 1;
				
        SET FOREIGN_KEY_CHECKS = 1;
        SET track_no = 3;

        SELECT track_no, 'Congrates!, successfully executed.';

    COMMIT;
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;