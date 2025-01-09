-- Creati un tabel melodii_log in care sa se pastreze
-- informatii despre fiecare operatie LMD efectuata
-- pe tabelul melodii plus evolutia redarilor totale.
-- Actualizarea tabelului sa fie facuta printr-un trigger

CREATE TABLE melodii_log(
    data_operatie   DATE,
    operatie        VARCHAR2(6),
    login_user      VARCHAR2(30),
    total_redari    NUMBER,
    progres_redari  NUMBER
);


CREATE OR REPLACE TRIGGER trig_ex10
AFTER INSERT OR UPDATE OR DELETE ON melodii
DECLARE
    v_operatie      VARCHAR2(6);
    v_redari        NUMBER;
    v_redariOld     NUMBER;
BEGIN
    IF INSERTING THEN
        v_operatie := 'INSERT';
    ELSIF DELETING THEN
        v_operatie := 'DELETE';
    ELSE
        v_operatie := 'UPDATE';

    END IF;

    SELECT SUM(redari) into v_redari
    FROM melodii;

    SELECT total_redari INTO v_redariOld
    FROM (
        SELECT total_redari
        FROM melodii_LOG
        ORDER BY data_operatie DESC
    )
    WHERE ROWNUM = 1;

    IF v_redariOld IS NULL THEN
        v_redariOld := v_redari;
    END IF;

    INSERT INTO melodii_log
    VALUES (SYSDATE, v_operatie, SYS.LOGIN_USER, v_redari, v_redariOld/v_redari);

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        INSERT INTO melodii_log
        VALUES (SYSDATE, v_operatie, SYS.LOGIN_USER, v_redari, 1);
END;
/

UPDATE melodii
SET redari = redari
WHERE ID_MELODIE = 1;

SELECT * FROM melodii_log;

