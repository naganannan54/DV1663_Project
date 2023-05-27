DROP FUNCTION IF EXISTS NeedPointChange;
DELIMITER //
CREATE FUNCTION NeedPointChange(stageName VARCHAR(20), currentPoints INT, newScore FLOAT, ascending BOOL)
RETURNS BOOL DETERMINISTIC
BEGIN
	DECLARE result BOOL;
    SET result = CASE WHEN 
		(SELECT COUNT(points) FROM submissions 
            WHERE stage = stageName 
			AND ((points = currentPoints + 1 AND ((ascending AND score < newScore) OR (NOT ascending AND score > newScore))) 
            OR (points = currentPoints - 1 AND ((ascending AND score > newScore) OR (NOT ascending AND score < newScore))))
		> 0) 
		THEN 1 
        ELSE 0 
        END;
	RETURN result;
END; //

DROP PROCEDURE IF EXISTS UpdateScore;
DELIMITER //
CREATE PROCEDURE UpdateScore (IN newScore FLOAT, IN userName VARCHAR(50), IN stageNameInput VARCHAR(50)) 
BEGIN
	DECLARE currentPoints INT;
    DECLARE ascending BOOL;
	SET currentPoints = (SELECT points FROM submissions WHERE user = userName AND stage = stageNameInput);
    SET ascending = (SELECT descending FROM stages WHERE stageName = stageNameInput);

	UPDATE submissions SET score = newScore WHERE user = userName AND stage = stageNameInput;

	IF project.NeedPointChange(stageNameInput, currentPoints, newScore, ascending) THEN
        CALL UpdatePoints(stageNameInput, ascending);
        SELECT "Points updated";
	ELSE
		SELECT "Points not updated";
	END IF;
END; //

DROP PROCEDURE IF EXISTS UpdatePoints;
DELIMITER //
CREATE PROCEDURE UpdatePoints (IN stageNameInput VARCHAR(50), IN ascending BOOL) 
BEGIN
    IF ascending THEN
    UPDATE submissions AS 
		s1 JOIN 
			(SELECT stage, user, ROW_NUMBER() OVER (ORDER BY score ASC, submissionDate DESC) as newPoints 
            FROM submissions WHERE stage = stageNameInput) AS s2 
        ON s1.stage = s2.stage AND s1.user = s2.user 
	SET s1.points = s2.newPoints;
    
    ELSE
    UPDATE submissions AS 
		s1 JOIN 
			(SELECT stage, user, ROW_NUMBER() OVER (ORDER BY score DESC, submissionDate DESC) as newPoints 
            FROM submissions WHERE stage = stageNameInput) AS s2 
        ON s1.stage = s2.stage AND s1.user = s2.user 
	SET s1.points = s2.newPoints;
    END IF;
END; //



