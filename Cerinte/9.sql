-- Pentru fiecare album lansat, fiecare artist
-- are un concert de lansare al acestuia.
-- Pentru a realiza o promovare eficienta,
-- casa de discuri amplaseaza afise promotionale
-- in anumite locatii.

-- Sa se calculeze cat s-a cheltuit pe afise
-- intr-un an dat, in functie de artist.

-- afisele sunt puse in tot judetul
-- mentionat in contractul incheiat de artist.

-- Stim ca un om asculta o melodie in medie de 5 ori

-- Echipa de marketing a venit cu o strategie
-- de a pune nrPersoaneCareAuAscultat / nrPopulatieJudet * 50 afise

-- Pretul unui afis se calculeaza in functie de
-- marimea copertei si de formatul acesteia.

-- Costul de format este:
--  PNG     10 RON
--  JPG     5 RON
--  JPEG    6 RON

-- Costul de marime este:
-- Aria copertei / 100000 RON

-- Pretul total este suma celor doua costuri.

-- Daca numarul afiselor e mai mic de 10 atunci promovarea
-- Nu este profitabila

-- Daca un an contine o promovare neprofitabila
-- Atunci sa se declanseze exceptia AN_NEPROFITABIL

-- Daca pentru o lansare se folosesc mai multi
-- Bani decat s-au produs din ascultari
-- atunci sa se declanseze exceptia DEFICIT_BUGET

-- Sa se creeze un tabel exceptii_afise
-- in care sa se introduca date despre exceptiile declansate.

CREATE TABLE exceptii_afise(
    an              NUMBER,
    id_artist       NUMBER,
    data_declansare DATE,
    exceptie        VARCHAR2(20)
);


CREATE OR REPLACE PROCEDURE proc_ex9 (arg_idArtist artisti.id_artist%TYPE,
                                        arg_an NUMBER) 
IS
    TYPE    lansari_record  IS RECORD(
            nume            lansari.nume%TYPE,
            id_coperta      lansari.id_coperta%TYPE,
            suma_redari     melodii.redari%TYPE,
            incasari        NUMBER
    );

    TYPE    lansari_tablou_indexat  IS TABLE OF lansari_record          INDEX BY PLS_INTEGER;

    v_lansariAlbume      lansari_tablou_indexat;
    v_populatieJudet    orase.populatie%TYPE;
    v_nrAfise           NUMBER;
    v_coperta           coperte%ROWTYPE;
    v_tarif             NUMBER;
    v_cost              NUMBER;
    v_plataPlatforma    NUMBER := 0.00318;

    AN_NEPROFITABIL     EXCEPTION;
    DEFICIT_BUGET       EXCEPTION;
    FARA_LANSARI        EXCEPTION;
BEGIN
    SELECT lansari.nume, lansari.id_coperta, SUM(redari/5), SUM(redari) * v_plataPlatforma BULK COLLECT INTO v_lansariAlbume
    FROM lansari JOIN asoc_lansari USING (id_lansare)
    JOIN melodii USING (id_lansare)
    WHERE TO_CHAR(data_lansare, 'YYYY') = TO_CHAR(arg_an)
    AND id_artist = arg_idArtist
    AND id_tip_lansare = 1
    GROUP BY lansari.nume, lansari.id_coperta;

    IF v_lansariAlbume.COUNT = 0 THEN RAISE FARA_LANSARI;
    END IF;

    SELECT SUM(populatie) INTO v_populatieJudet
    FROM artisti JOIN contracte_artisti USING(id_artist)
    JOIN locatii USING (id_locatie)
    JOIN orase USING (id_oras)
    JOIN judete USING (id_judet)
    WHERE id_artist = arg_idArtist
    GROUP BY id_artist;

    

    FOR i IN v_lansariAlbume.FIRST .. v_lansariAlbume.LAST LOOP
        v_nrAfise :=  CEIL(v_lansariAlbume(i).suma_redari / v_populatieJudet * 50);

        IF v_nrAfise < 7 THEN
            RAISE AN_NEPROFITABIL;
        END IF;
        
        SELECT * INTO v_coperta
        FROM coperte
        WHERE id_coperta = v_lansariAlbume(i).id_coperta;

        CASE UPPER(v_coperta.tip_format)
            WHEN 'PNG'  THEN v_tarif := 10;
            WHEN 'JPG'  THEN v_tarif := 5;
            WHEN 'JPEG' THEN v_tarif := 6;
        END CASE;

        v_cost := v_nrAfise *  v_coperta.latime * v_coperta.inaltime / 100000;

        IF v_lansariAlbume(i).incasari < v_cost
            THEN RAISE DEFICIT_BUGET;
        END IF;

        DBMS_OUTPUT.PUT_LINE( v_lansariAlbume(i).nume || ' - ' || v_nrAfise || ' afise - ' || v_cost || ' RON');
    END LOOP;

EXCEPTION
    WHEN AN_NEPROFITABIL THEN
        INSERT INTO EXCEPTII_AFISE
        VALUES (arg_an, arg_idArtist, SYSDATE, 'AN_NEPROFITABIL');

        DBMS_OUTPUT.PUT_LINE('Anul ' || arg_an || ' este un an neprofitabil.');

    WHEN DEFICIT_BUGET THEN
        INSERT INTO EXCEPTII_AFISE
        VALUES (arg_an, arg_idArtist, SYSDATE, 'DEIFCIT_BUGET');

        DBMS_OUTPUT.PUT_LINE('Anul ' || arg_an || ' creste deficitul bugetar al casei de discuri.');

    WHEN FARA_LANSARI THEN
        INSERT INTO EXCEPTII_AFISE
        VALUES (arg_an, arg_idArtist, SYSDATE, 'FARA_LANSARI');

        DBMS_OUTPUT.PUT_LINE('Artistul nu are albume in anul ' || arg_an);
END;
/

EXECUTE PROC_EX9(1, 2025);
EXECUTE PROC_EX9(2, 2025);
EXECUTE PROC_EX9(7, 2012);

SELECT * FROM exceptii_afise;