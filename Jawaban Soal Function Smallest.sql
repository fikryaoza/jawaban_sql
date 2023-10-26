-- ----------------------------
-- Function structure for FIND_SMALLEST
-- ----------------------------
DROP FUNCTION IF EXISTS `FIND_SMALLEST`;
delimiter ;;
CREATE FUNCTION `FIND_SMALLEST`(tanggal VARCHAR(255))
 RETURNS varchar(255) CHARSET latin1 COLLATE latin1_swedish_ci
BEGIN
		DECLARE smallest VARCHAR(255);
		DECLARE flag INT;
		SET @var1 = tanggal ;
		SET @var2 := LENGTH(@tgl) - LENGTH(REPLACE(@tgl, ',', '')) + 1;
		SET @var3 := SUBSTRING_INDEX(@var1, ',', 1);
		SET flag = 1;
-- 		init smallest value
		SET smallest = SUBSTRING_INDEX(@var1, ',', 1);
		label: LOOP
			SET flag = flag + 1;
			IF(flag <= @var2) THEN
				IF(SUBSTRING_INDEX(SUBSTRING_INDEX(@var1,',',flag),',',-1) < smallest) THEN
					SET smallest = SUBSTRING_INDEX(SUBSTRING_INDEX(@var1,',',flag),',',-1);
				END IF; 
					ITERATE label;
			END IF;
			LEAVE label;
		END LOOP label;
    RETURN smallest;
END
;;
delimiter ;
