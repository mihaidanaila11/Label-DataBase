CREATE OR REPLACE TRIGGER trig_tema12
AFTER INSERT OR UPDATE ON produse
FOR EACH ROW
DECLARE
    v_pretMaxim     produse.pret%TYPE;
BEGIN
    SELECT MAX(pret) INTO v_pretMaxim
    FROM produse;

    IF v_pretMaxim * 2 < :NEW.pret THEN
        UPDATE produse
        SET pret = :NEW.pret / 2
        WHERE id_produs = :NEW.id_produs;

        RETURN;
    END IF;
END;
/

INSERT INTO PRODUSE
VALUES (100, 'Breloc', 1, 300, NULL);