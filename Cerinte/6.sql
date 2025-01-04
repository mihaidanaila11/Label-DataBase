-- Stocati intr-un tabel indexat vechimea fiecarui angajat

-- Intr-un tablou imbricat stocati angajatii cu o vechime mai mare de 8 ani jumatate
-- Si acordati-le tuturor o marire de 5%

-- Intr-un vector stocati toate locatiile sortate in 
-- ordinea medie vechimii, descrescator si afisati-le in ordine alaturi de
-- media salariilor dupa mariri

-- Restaurați apoi modificările făcute.


CREATE OR REPLACE PROCEDURE proc_ex6 AS
    TYPE    tablou_indexat  IS TABLE        OF NUMBER INDEX BY PLS_INTEGER;
    TYPE    tablou_imbricat IS TABLE        OF angajati%ROWTYPE;
    TYPE    vector          IS VARRAY(5)    OF locatii%ROWTYPE;

    CURSOR      c_vechimi IS
                SELECT id_angajat, MONTHS_BETWEEN(SYSDATE, data_start)/12
                FROM angajati JOIN contracte_angajati USING (id_angajat)
                JOIN contracte USING (id_contract);

    CURSOR      c_vechimiLocatii IS
                SELECT id_locatie
                FROM angajati JOIN departamente USING (id_departament)
                JOIN contracte_angajati USING (id_angajat)
                JOIN contracte USING (id_contract)
                JOIN sedii USING (id_sediu)
                JOIN locatii USING (id_locatie)
                GROUP BY id_locatie
                ORDER BY AVG(MONTHS_BETWEEN(SYSDATE, data_start)/12) DESC;
    
    
    vechime_angajati    tablou_indexat;
    v_idAngajat         angajati.ID_ANGAJAT%TYPE;
    v_vechime           NUMBER;

    angajati_vechi      tablou_imbricat := tablou_imbricat();
    v_contor            NUMBER;

    locatii_ordonate    vector := vector();
    v_idLocatie         locatii.ID_LOCATIE%TYPE;
    v_medieSalariu      angajati.SALARIU%TYPE;

BEGIN
    OPEN c_vechimi;

    FETCH c_vechimi INTO v_idAngajat, v_vechime;

    WHILE c_vechimi%FOUND LOOP
        vechime_angajati(v_idAngajat) := v_vechime;

        FETCH c_vechimi INTO v_idAngajat, v_vechime;
    END LOOP;

    CLOSE c_vechimi;

    v_contor := 1;
    FOR i IN vechime_angajati.FIRST .. vechime_angajati.LAST LOOP
        IF vechime_angajati(i) > 8.5 THEN
            angajati_vechi.EXTEND();

            SELECT * INTO angajati_vechi(v_contor)
            FROM angajati
            WHERE id_angajat = i;

            v_contor := v_contor + 1;
        END IF;
    END LOOP;

    FOR i IN angajati_vechi.FIRST .. angajati_vechi.LAST LOOP
        UPDATE angajati
        SET salariu = salariu + salariu * 0.05
        WHERE id_angajat = angajati_vechi(i).id_angajat;
    END LOOP;

    -- Array locatii

    v_contor := 1;
    FOR locatie IN c_vechimiLocatii LOOP
        locatii_ordonate.EXTEND();

        SELECT * INTO locatii_ordonate(v_contor)
        FROM locatii
        WHERE id_locatie = locatie.id_locatie;

        v_contor := v_contor + 1;
    END LOOP;

    FOR i IN locatii_ordonate.FIRST .. locatii_ordonate.LAST LOOP

        SELECT AVG(salariu)
        INTO v_medieSalariu
        FROM locatii JOIN sedii USING (id_locatie)
        JOIN departamente USING (id_sediu)
        JOIN angajati USING (id_departament)
        WHERE id_locatie = locatii_ordonate(i).id_locatie
        GROUP BY id_locatie;

        DBMS_OUTPUT.PUT_LINE(locatii_ordonate(i).id_locatie || ' ' || v_medieSalariu);
    END LOOP;

    ROLLBACK;
END;
/

EXECUTE PROC_EX6;