-- Sa se obtina producatorii produselor detinute in depozitele
-- magazinelor destinate artistilor cu un numar
-- minim de redari.
-- Numarul minim de redari va fi citit de la tastatura

CREATE OR REPLACE PROCEDURE proc_ex7 AS
    TYPE    refcursor   IS REF CURSOR;
    
    CURSOR c_artisti(min_redari NUMBER) IS
        SELECT a.id_artist,
            CURSOR (
                SELECT DISTINCT nume_producator
                FROM artisti JOIN magazine_online USING (id_artist)
                JOIN asoc_depozite USING (id_magazin_online)
                JOIN depozite USING (id_depozit)
                JOIN inventare USING (id_depozit)
                JOIN asoc_produs USING (id_inventar)
                JOIN produse USING (id_produs)
                JOIN producatori USING (id_producator)
                WHERE id_artist = a.id_artist
            )
        FROM artisti a JOIN asoc_lansari al ON (a.id_artist = al.id_artist)
        JOIN lansari l ON (al.id_lansare = l.id_lansare)
        JOIN melodii m ON (m.ID_LANSARE = l.id_lansare)
        GROUP BY a.id_artist
        HAVING SUM(redari) > min_redari;

    v_cursor            refcursor;
    v_numeScena         artisti.NUME_SCENA%TYPE;
    v_numeProducator    producatori.NUME_PRODUCATOR%TYPE;
    v_idArtist          artisti.ID_ARTIST%TYPE;

    v_minRedari melodii.REDARI%TYPE := &p_minRedari;
BEGIN
    OPEN c_artisti(v_minRedari);

    LOOP
        FETCH c_artisti INTO v_idArtist, v_cursor;
        EXIT WHEN c_artisti%NOTFOUND;

        SELECT nume_scena INTO v_numeScena
        FROM artisti
        WHERE id_artist = v_idArtist;

        DBMS_OUTPUT.PUT_LINE('Artistul ' || v_numeScena || ' colaboreaza cu urmatorii producatori de produse:');

        LOOP
            FETCH v_cursor INTO v_numeProducator;
            EXIT WHEN v_cursor%NOTFOUND;

            DBMS_OUTPUT.PUT_LINE(v_numeProducator);
        END LOOP;
        
        IF v_cursor%ROWCOUNT = 0 THEN
            DBMS_OUTPUT.PUT_LINE('Nu colaboreaza cu niciun producator de produse');
        ELSE 
            DBMS_OUTPUT.PUT_LINE('');
        END IF;
    END LOOP;

    CLOSE c_artisti;
END;
/

EXECUTE proc_ex7;