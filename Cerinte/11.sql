-- De fiecare data cand o lansare este adaugata
-- sa se creeze un nou produs care sa reprezinte un album fizic
-- pentru noua lansare.

-- Produsul o sa aiba urmatoarele date:
--      - ID_PRODUS -       urmatorul id valabil
--      - ID_PRODUCATOR -   3
--      - PRET              70
--      - MARIME            NULL

-- De fiecare data cand o lansare este asociata unui artist
-- sa se introduca cate 10 produse in fiecare
-- inventar al fiecarui depozit asociat magazinelor artistului.

-- Daca artistul nu are un magazin asociat
-- sa se ridice exceptia FARA_MAGAZIN.

CREATE OR REPLACE TRIGGER trig_ex11Aux
AFTER INSERT ON lansari
FOR EACH ROW
DECLARE
    v_idProdus      produse.id_produs%TYPE;
    v_numeProdus    produse.nume_produs%TYPE;

    FARA_MAGAZIN    EXCEPTION;
BEGIN
    IF :NEW.id_tip_lansare <> 1 THEN
        RETURN;
    END IF;

    SELECT MAX(id_produs)+1 INTO v_idProdus
    FROM produse;

    v_numeProdus := :NEW.nume || ' (CD)';

    INSERT INTO produse
    VALUES (v_idProdus, v_numeProdus, 3, 70, NULL);
END;
/

CREATE OR REPLACE TRIGGER trig_ex11
AFTER INSERT ON asoc_lansari
FOR EACH ROW

DECLARE
    TYPE    tablou_imbricat IS TABLE OF NUMBER;
    
    FARA_MAGAZIN    EXCEPTION;

    v_magazine      tablou_imbricat := tablou_imbricat();
    v_idInventar    inventare.id_inventar%TYPE;
    v_idProdus      produse.id_produs%TYPE;

    v_tipLansare    lansari.id_tip_lansare%TYPE;

    CURSOR c_inventare (arg_idMagazin magazine_online.id_magazin_online%TYPE) IS
        SELECT id_inventar
        FROM asoc_depozite
        JOIN inventare USING (id_depozit)
        WHERE id_magazin_online = arg_idMagazin;
BEGIN
    SELECT id_tip_lansare INTO v_tipLansare
    FROM lansari
    WHERE id_lansare = :NEW.id_lansare;

    IF v_tipLansare <> 1 THEN
        RETURN;
    END IF;

    SELECT id_produs INTO v_idProdus
    FROM produse
    WHERE UPPER(nume_produs) = (SELECT UPPER(nume) || ' (CD)'
                                FROM lansari
                                WHERE id_lansare = :NEW.id_lansare);


    SELECT id_magazin_online BULK COLLECT INTO v_magazine
    FROM magazine_online
    WHERE id_artist = :NEW.id_artist;

    IF v_magazine.COUNT = 0 THEN
        RAISE FARA_MAGAZIN;
    END IF;

    FOR i IN v_magazine.FIRST .. v_magazine.LAST LOOP
        OPEN c_inventare(v_magazine(i));

        FETCH c_inventare INTO v_idInventar;

        WHILE c_inventare%FOUND LOOP
            INSERT INTO asoc_produs
            VALUES (v_idInventar, v_idProdus, 10);

            FETCH c_inventare INTO v_idInventar;
        END LOOP;

        CLOSE c_inventare;
    END LOOP;

EXCEPTION
    WHEN FARA_MAGAZIN THEN
        DBMS_OUTPUT.PUT_LINE('Artistul nu are niciun magazin.');
END;
/

INSERT INTO lansari
VALUES(26, 'My Day', SYSDATE, 1, 3, 1);

INSERT INTO asoc_lansari VALUES (1, 26);


SELECT nume_produs, cantitate
FROM MAGAZINE_ONLINE JOIN asoc_depozite USING (id_magazin_online)
JOIN INVENTARE USING (id_depozit)
JOIN ASOC_PRODUS USING (id_inventar)
JOIN PRODUSE USING (id_produs)

WHERE id_artist = 1;

INSERT INTO lansari
VALUES(27, 'Now what?', SYSDATE, 1, 3, 1);

INSERT INTO asoc_lansari VALUES (6, 27);

SELECT * FROM produse;