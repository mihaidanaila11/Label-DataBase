CREATE TYPE cr_del_log_imb IS TABLE OF VARCHAR2(30);
/

CREATE TABLE cr_del_log(
    data_log                TIMESTAMP(3),
    user_logat              VARCHAR2(30),
    nume_tabele             cr_del_log_imb
)
NESTED TABLE nume_tabele STORE AS cr_del_log_store;

INSERT INTO cr_del_log
VALUES (SYSTIMESTAMP(3), USER, cr_del_log_imb('cr_del_log'));

CREATE OR REPLACE TRIGGER trig_ex12Create
AFTER CREATE
ON SCHEMA
DECLARE
    v_tabele    cr_del_log_imb := cr_del_log_imb();
BEGIN
    SELECT nume_tabele INTO v_tabele
    FROM (
         SELECT nume_tabele
        FROM cr_del_log
        ORDER BY data_log DESC
    )
    WHERE ROWNUM = 1;

    v_tabele.extend();
    v_tabele(v_tabele.COUNT) := SYS.DICTIONARY_OBJ_NAME;

    INSERT INTO cr_del_log
    VALUES (SYSTIMESTAMP(3), USER, v_tabele);

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        INSERT INTO cr_del_log
        VALUES (SYSTIMESTAMP(3), USER, cr_del_log_imb(SYS.DICTIONARY_OBJ_NAME));
END;
/

CREATE OR REPLACE TRIGGER trig_ex12Delete
AFTER DROP
ON SCHEMA
DECLARE
    v_tabele            cr_del_log_imb := cr_del_log_imb();
    v_tabeleActual      cr_del_log_imb := cr_del_log_imb();
BEGIN
    SELECT nume_tabele INTO v_tabele
    FROM (
         SELECT nume_tabele
        FROM cr_del_log
        ORDER BY data_log DESC
    )
    WHERE ROWNUM = 1;

    FOR i IN v_tabele.FIRST .. v_tabele.LAST LOOP
        IF UPPER(v_tabele(i)) <> UPPER(SYS.DICTIONARY_OBJ_NAME) THEN
            v_tabeleActual.extend();
            v_tabeleActual(v_tabeleActual.COUNT) := v_tabele(i);
        END IF;
    END LOOP;

    INSERT INTO cr_del_log
    VALUES (SYSTIMESTAMP(3), USER, v_tabeleActual);

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        INSERT INTO cr_del_log
        VALUES (SYSTIMESTAMP(3), USER, cr_del_log_imb());
END;
/

CREATE OR REPLACE PROCEDURE print_tableRegs
IS 
    v_tabele    cr_del_log_imb := cr_del_log_imb();
    NO_REGS     EXCEPTION;
BEGIN
    SELECT nume_tabele INTO v_tabele
    FROM (
         SELECT nume_tabele
        FROM cr_del_log
        ORDER BY data_log DESC
    )
    WHERE ROWNUM = 1;

    IF v_tabele.COUNT = 0 THEN
        RAISE NO_REGS;
    END IF;

    DBMS_OUTPUT.PUT_LINE('--------');
    FOR i IN v_tabele.FIRST .. v_tabele.LAST LOOP
        DBMS_OUTPUT.PUT_LINE(v_tabele(i));
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('--------');

EXCEPTION
    WHEN NO_DATA_FOUND OR NO_REGS THEN
            DBMS_OUTPUT.PUT_LINE('Niciun tabel inregistrat in log.');
END;
/

EXECUTE PRINT_TABLEREGS;

CREATE TABLE Table1(id NUMBER);
EXECUTE PRINT_TABLEREGS;

CREATE TABLE Table2(id NUMBER);
EXECUTE PRINT_TABLEREGS;

DROP TABLE Table1;
EXECUTE PRINT_TABLEREGS;

DROP TABLE Table2;
EXECUTE PRINT_TABLEREGS;