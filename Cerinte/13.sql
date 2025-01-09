CREATE OR REPLACE PACKAGE label_stats
IS
    tarif_redare CONSTANT NUMBER := 0.00318;

    TYPE numArray           IS VARRAY(50) OF NUMBER;
    TYPE stringArray        IS VARRAY(50) OF VARCHAR2(50);

    TYPE stringPair         IS TABLE OF VARCHAR2(50) INDEX BY VARCHAR2(20);
    TYPE anNumPair          IS TABLE OF NUMBER INDEX BY VARCHAR2(4);
    TYPE numStringArrPair   IS TABLE OF stringArray INDEX BY PLS_INTEGER;
    TYPE stringPairArray    IS VARRAY(25) OF stringPair;

    TYPE anNumPairArray     IS VARRAY(40) OF anNumPair;

    TYPE praguriVechimi     IS VARRAY(4) OF numStringArrPair;
    TYPE refcursor          IS REF CURSOR;
    
    -- Returneaza venitul unui artist dat generat melodiille de un gen dat
    FUNCTION venit_artist_gen(
        arg_idArtist    artisti.id_artist%TYPE,
        arg_idGen       genuri.id_gen%TYPE
    )   RETURN NUMBER;

    -- Afiseaza veniturile generate de un artist dat pentru fiecare gen al melodiilor sale
    PROCEDURE venit_artist_genuri(
        arg_idArtist    artisti.id_artist%TYPE
    );

    -- Afiseaza cele mai profitabile decenii ale unui artist dat
    PROCEDURE top_dec(
        arg_idArtist    artisti.id_artist%TYPE
    );

    -- Afiseaza artistii pe categorii de vechime
    PROCEDURE vechimi_artisti;

    -- Afiseaza evolutia veniturilor unui artist dat
    -- Daca argumentul este NULL afiseaza evolutia tuturor artistilor
    PROCEDURE evolutie_venit_artist(
        arg_idArtist    artisti.id_artist%TYPE
    );

    NULL_ARTIST EXCEPTION;
    
END label_stats;
/

CREATE OR REPLACE PACKAGE BODY label_stats
IS

    -- PRIVATE

    FUNCTION redari_an_artist (
        arg_idArtist    artisti.id_artist%TYPE
    ) RETURN stringPairArray
    IS
        v_statistici    stringPairArray := stringPairArray();
        v_stat          stringPair;
        v_redari        melodii.REDARI%TYPE;
        v_an            VARCHAR2(4);
         v_key           VARCHAR2(20);
        v_contor        NUMBER := 1;

        CURSOR stats (
            c_artistId  artisti.id_artist%TYPE) 
        IS 
            SELECT SUM(redari), CONCAT(SUBSTR(TO_CHAR(data_lansare, 'yyyy'), 1,  3), '0')
            FROM lansari JOIN melodii USING (id_lansare)
            JOIN asoc_lansari USING (id_lansare)
            WHERE id_artist = arg_idArtist
            GROUP BY CONCAT(SUBSTR(TO_CHAR(data_lansare, 'yyyy'), 1,  3), '0'), id_artist
            ORDER BY -SUM(redari);
    BEGIN
        OPEN stats(arg_idArtist);
        FETCH stats INTO v_redari, v_an;

        WHILE stats%FOUND LOOP
            v_stat := stringPair();
            v_stat(v_an) := v_redari;

            v_statistici.extend();
            
            v_statistici(v_contor) := v_stat;
            v_contor := v_contor + 1;

            FETCH stats INTO v_redari, v_an;
        END LOOP;
        CLOSE stats;

        RETURN v_statistici;
    END;

    -- Functie privata
    FUNCTION evolutie_venit_artist(
        arg_idArtist    artisti.id_artist%TYPE
    ) RETURN anNumPairArray
    IS

    CURSOR c_venituri IS
            SELECT *
            FROM(
                SELECT SUM(redari) * tarif_redare, TO_CHAR(data_lansare, 'yyyy') an
                FROM lansari JOIN melodii USING (id_lansare)
                JOIN asoc_lansari USING (id_lansare)
                WHERE id_artist = arg_idArtist
                GROUP BY TO_CHAR(data_lansare, 'yyyy'), id_artist
            )

            ORDER BY TO_NUMBER(AN);
            

    v_venit         NUMBER;
    v_an            VARCHAR2(4);
    v_procent       NUMBER;
    v_venitOLD      NUMBER;

    v_anRedari      anNumPair;
    v_evolutie      anNumPairArray := anNumPairArray();

    BEGIN
        OPEN c_venituri;
        FETCH c_venituri INTO v_venit, v_an;

        v_venitOLD := v_venit;

        WHILE c_venituri%FOUND LOOP
            v_procent := (v_venit - v_venitOLD) / ABS(v_venitOLD) * 100;

            v_anRedari := anNumPair();
            v_anRedari(v_an) := v_procent;
            v_evolutie.extend();
            v_evolutie(v_evolutie.COUNT) := v_anRedari;

            v_venitOLD := v_venit;
            FETCH c_venituri INTO v_venit, v_an;
        END LOOP;

        CLOSE c_venituri;

        RETURN v_evolutie;
    END;
    --
    FUNCTION venit_artist_gen(
        arg_idArtist    artisti.id_artist%TYPE,
        arg_idGen       genuri.id_gen%TYPE
    )   RETURN NUMBER
    IS
        v_venit     NUMBER;
        v_idArtist  artisti.id_artist%TYPE;
    BEGIN
        SELECT id_artist INTO v_idArtist
        FROM artisti
        WHERE id_artist = arg_idArtist;

        IF v_idArtist IS NULL THEN RAISE label_stats.NULL_ARTIST;
        END IF;

        SELECT SUM(redari) * LABEL_STATS.tarif_redare INTO v_venit
        FROM artisti JOIN asoc_lansari USING (id_artist)
        JOIN lansari USING (id_lansare)
        JOIN melodii USING (id_lansare)
        WHERE   id_artist = arg_idArtist
                AND melodii.id_gen = arg_idGen;

        RETURN v_venit;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN 0;
    END;

    FUNCTION artist_genuri_melodii(
        arg_idArtist    artisti.id_artist%TYPE
    )   RETURN numArray
    IS
        v_genuri    numArray:= numArray();
    BEGIN
        SELECT DISTINCT melodii.id_gen BULK COLLECT INTO v_genuri
        FROM artisti JOIN asoc_lansari USING (id_artist)
        JOIN lansari USING (id_lansare)
        JOIN melodii USING (id_lansare)
        WHERE id_artist = arg_idArtist;

        RETURN v_genuri;
    END;

    PROCEDURE venit_artist_genuri(
        arg_idArtist    artisti.id_artist%TYPE
    )
    IS
        v_genuri        numArray := LABEL_STATS.ARTIST_GENURI_MELODII(arg_idArtist);
        v_numeArtist    artisti.NUME_SCENA%TYPE;
        v_numeGen       genuri.TITLU%TYPE;
    BEGIN
        SELECT nume_scena INTO v_numeArtist
        FROM artisti
        WHERE ID_ARTIST = arg_idArtist;
        
        DBMS_OUTPUT.PUT_LINE('Artistul ' || v_numeArtist || ' are incasarile:');
        FOR i IN v_genuri.FIRST .. v_genuri.LAST LOOP
            SELECT titlu INTO v_numeGen
            FROM GENURI
            WHERE id_gen = v_genuri(i);

            DBMS_OUTPUT.PUT_LINE(v_numeGen || ': ' || LABEL_STATS.VENIT_ARTIST_GEN(arg_idArtist, v_genuri(i)));
        END LOOP;
    END;

    

    PROCEDURE top_dec(
        arg_idArtist    artisti.id_artist%TYPE
    )
    IS
        v_artistStats   stringPairArray := stringPairArray();
        v_an            VARCHAR2(20);
        v_numeArtist    artisti.NUME_SCENA%TYPE;
    BEGIN
        v_artistStats := redari_an_artist(arg_idArtist);
        
        SELECT nume_scena INTO v_numeArtist
        FROM artisti
        WHERE ID_ARTIST = arg_idArtist;

        DBMS_OUTPUT.PUT_LINE('Incasarile artistului ' || v_numeArtist || ' pe decenii');
        FOR i IN 1 .. v_artistStats.COUNT LOOP
            
            v_an := v_artistStats(i).FIRST;
            DBMS_OUTPUT.PUT_LINE(v_an || '- ' || v_artistStats(i)(v_an));
        END LOOP;
    END;


    PROCEDURE vechimi_artisti
    IS
        v_praguri           praguriVechimi := praguriVechimi();
        v_idArtist          artisti.id_artist%TYPE;
        v_vechime           NUMBER;
        c_lansari           refcursor;
        v_prag              NUMBER;
        v_numeLansare       lansari.nume%TYPE;
        v_lansariArray      stringArray;
        v_contor            NUMBER;
        v_numeArtist        artisti.nume_scena%TYPE;

        CURSOR c_artisti IS
            SELECT artist, vechime, CURSOR(
                    SELECT c_l.nume
                    FROM lansari c_l JOIN asoc_lansari c_ac ON (c_l.id_lansare = c_ac.id_lansare)
                    WHERE c_ac.id_artist = artist
                )
            FROM (SELECT a.id_artist artist, FLOOR(MONTHS_BETWEEN(SYSDATE, MIN(c.DATA_START))/12) vechime
                    FROM contracte c JOIN contracte_artisti ca ON (c.id_contract = ca.id_contract)
                    JOIN artisti a ON (a.id_artist = ca.id_artist)
                    GROUP BY a.id_artist);
                
    BEGIN
        -- Prag 1: 0-5 ani
        -- Prag 2: 6-10 ani
        -- Prag 3: >10 ani

        v_praguri.extend(3);

        OPEN c_artisti;
        FETCH c_artisti INTO v_idArtist, v_vechime, c_lansari;

        WHILE c_artisti%FOUND LOOP
            FETCH c_lansari INTO v_numeLansare;

            v_lansariArray := stringArray();
            v_contor := 1;
            WHILE c_lansari%FOUND LOOP
                v_lansariArray.extend();
                v_lansariArray(v_contor) := v_numeLansare;

                v_contor := v_contor + 1;
                FETCH c_lansari INTO v_numeLansare;
            END LOOP;

            CLOSE c_lansari;

            CASE
                WHEN v_vechime < 5    THEN    v_prag := 1;
                WHEN v_vechime < 10   THEN    v_prag := 2;
                ELSE                v_prag := 3;
            END CASE;
            
            v_praguri(v_prag)(v_idArtist) := v_lansariArray;

            FETCH c_artisti INTO v_idArtist, v_vechime, c_lansari;
        END LOOP;
        CLOSE c_artisti;

        FOR i IN v_praguri.FIRST .. v_praguri.LAST LOOP
            DBMS_OUTPUT.PUT_LINE('****' || 'PRAGUL ' || i || '****');

            v_idArtist := v_praguri(i).FIRST;

            WHILE v_idArtist IS NOT NULL LOOP
                SELECT nume_scena INTO v_numeArtist
                FROM artisti
                WHERE id_artist = v_idArtist;

                DBMS_OUTPUT.PUT_LINE('  Artist #' || v_idArtist || ' ' || v_numeArtist || ':');

                FOR j IN v_praguri(i)(v_idArtist).FIRST .. v_praguri(i)(v_idArtist).LAST LOOP
                    DBMS_OUTPUT.PUT_LINE('      -' || v_praguri(i)(v_idArtist)(j));
                END LOOP;
                v_idArtist := v_praguri(i).NEXT(v_idArtist);
            END LOOP;

            DBMS_OUTPUT.PUT_LINE('****************');

        END LOOP;
    END;

    PROCEDURE evolutie_venit_artist(
        arg_idArtist    artisti.id_artist%TYPE
    )
    IS
        c_artisti       refcursor;
        v_idArtist      artisti.ID_ARTIST%TYPE;
        v_numeArtist    artisti.NUME_SCENA%TYPE;
        v_an            VARCHAR2(4);

        v_evolutie  anNumPairArray;
    BEGIN
        IF arg_idArtist IS NULL THEN
            OPEN c_artisti FOR
                SELECT id_artist, nume_scena
                FROM ARTISTI;
        ELSE
            OPEN c_artisti FOR
                SELECT id_artist, nume_scena
                FROM ARTISTI
                WHERE id_artist = arg_idArtist;
        END IF;

        FETCH c_artisti INTO v_idArtist, v_numeArtist;

        DBMS_OUTPUT.PUT_LINE('AN | PROCENT_EVOLUTIE');
        WHILE c_artisti%FOUND LOOP
            DBMS_OUTPUT.PUT_LINE('Evolutie venit ' || v_numeArtist);
            
            v_evolutie := evolutie_venit_artist(v_idArtist);
            
            FOR i IN v_evolutie.FIRST .. v_evolutie.LAST LOOP
                v_an := v_evolutie(i).FIRST;
                DBMS_OUTPUT.PUT_LINE(v_an || ' ' || TO_CHAR(v_evolutie(i)(v_an), 'FM9999999.90') || '%');
            END LOOP;

            FETCH c_artisti INTO v_idArtist, v_numeArtist;
        END LOOP;

        CLOSE c_artisti;
    END;

END label_stats;
/


SELECT LABEL_STATS.VENIT_ARTIST_GEN(6, 3) venit
FROM dual;

EXECUTE LABEL_STATS.VENIT_ARTIST_GENURI(6);
EXECUTE LABEL_STATS.top_dec(7);
EXECUTE LABEL_STATS.VECHIMI_ARTISTI;

EXECUTE label_stats.evolutie_venit_artist(7);
EXECUTE label_stats.evolutie_venit_artist(NULL);
