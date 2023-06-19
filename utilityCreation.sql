DROP FUNCTION IF EXISTS NeedPointChange;
DELIMITER //
CREATE FUNCTION NeedPointChange(stageNameInput VARCHAR(20), currentPoints INT, newScore FLOAT, ascending BOOL)
RETURNS BOOL DETERMINISTIC
BEGIN
	DECLARE result BOOL;
    SET result = CASE WHEN 
		(SELECT COUNT(points) FROM submissions 
            WHERE stagename = stageNameInput 
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
CREATE PROCEDURE UpdateScore (IN newScore FLOAT, IN userNameInput VARCHAR(50), IN stageNameInput VARCHAR(50)) 
BEGIN
	DECLARE currentPoints INT;
    DECLARE ascending BOOL;
	SET currentPoints = (SELECT points FROM submissions WHERE username = userNameInput AND stagename = stageNameInput);
    SET ascending = (SELECT descending FROM stages WHERE stagename = stageNameInput);

	UPDATE submissions SET score = newScore WHERE username = userNameInput AND stagename = stageNameInput;

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
			(SELECT stagename, username, ROW_NUMBER() OVER (ORDER BY score ASC, submissionDate DESC) as newPoints 
            FROM submissions WHERE stagename = stageNameInput) AS s2 
        ON s1.stagename = s2.stagename AND s1.username = s2.username 
	SET s1.points = s2.newPoints;
    
    ELSE
    UPDATE submissions AS 
		s1 JOIN 
			(SELECT stagename, username, ROW_NUMBER() OVER (ORDER BY score DESC, submissionDate DESC) as newPoints 
            FROM submissions WHERE stagename = stageNameInput) AS s2 
        ON s1.stagename = s2.stagename AND s1.username = s2.username 
	SET s1.points = s2.newPoints;
    END IF;
END; //
