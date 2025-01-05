-- Sa se definească o funcție stocată 
-- care întoarce luna (indiferent de an) în care s-au inregistrat
-- cele mai multe încasări din redări pentru un
-- gen de muzică dat ca parametru.
-- Se mai dă ca parametru și platforma de muzică
-- care este analizată.

-- Se stiu următoarele tarife per redare

-- Tidal	        $0.01284
-- Apple Music	    $0.008
-- Amazon Music	    $0.00402
-- Spotify	        $0.00318
-- YouTube Music	$0.002
-- Pandora	        $0.00133
-- Deezer	        $0.0011

CREATE OR REPLACE FUNCTION FUNC_ex8 (arg_platforma VARCHAR2, arg_gen genuri.id_gen%TYPE)
RETURN VARCHAR2
IS
    v_tarif             NUMBER;

    v_luna              VARCHAR(3);
    v_incasareMaxima    NUMBER;

BEGIN
    CASE UPPER(arg_platforma)
        WHEN 'TIDAL'        THEN v_tarif := 0.01284;
        WHEN 'APPLE MUSIC'  THEN v_tarif := 0.008;
        WHEN 'AMAZON MUSIC' THEN v_tarif := 0.00402;
        WHEN 'SPOTIFY'      THEN v_tarif := 0.00318;
        WHEN 'PANDORA'      THEN v_tarif := 0.00133;
        WHEN 'DEEZER'       THEN v_tarif := 0.0011;
    END CASE;

    SELECT profit INTO v_incasareMaxima
    FROM (SELECT TO_CHAR(lansari.DATA_LANSARE, 'MON') luna, SUM(redari) * v_tarif profit
        FROM lansari JOIN melodii USING (id_lansare)
        WHERE lansari.id_gen = arg_gen
        GROUP BY TO_CHAR(lansari.DATA_LANSARE, 'MON')
        ORDER BY SUM(redari) * v_tarif DESC)
    WHERE ROWNUM=1;

    -- DBMS_OUTPUT.PUT_LINE('Incasarea maxima este ' || v_incasareMaxima);

    SELECT luna INTO v_luna
    FROM (SELECT TO_CHAR(lansari.DATA_LANSARE, 'MON') luna, SUM(redari) * v_tarif incasari_luna
        FROM lansari JOIN melodii USING (id_lansare)
        WHERE lansari.id_gen = arg_gen
        GROUP BY TO_CHAR(lansari.DATA_LANSARE, 'MON')
        ) s
    WHERE s.incasari_luna = v_incasareMaxima;

    DBMS_OUTPUT.PUT_LINE('Luna cu cele mai mari incasari este ' || v_luna);

    RETURN v_luna;

EXCEPTION
    WHEN CASE_NOT_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Nu exista aceasta platforma.');
        RETURN NULL;

    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Nu exista incasari pentru acest gen.');
        RETURN NULL;
     
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('Exista mai multe luni cu aceeasi incasare maxima.');
        RETURN NULL;
END;
/


DECLARE
    v_luna VARCHAR2(3);
BEGIN
    v_luna := FUNC_EX8('SPOTIFY', 0);
    v_luna := FUNC_EX8('SPOTIFY', 2);
    v_luna := FUNC_EX8('SPOTIFY', 3);
END;
/