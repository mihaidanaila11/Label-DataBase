-- JUDETE --
INSERT INTO judete (id_judet, nume) VALUES (1, 'București');
INSERT INTO judete (id_judet, nume) VALUES (2, 'Cluj');
INSERT INTO judete (id_judet, nume) VALUES (3, 'Timiș');
INSERT INTO judete (id_judet, nume) VALUES (4, 'Iași');
INSERT INTO judete (id_judet, nume) VALUES (5, 'Constanța');
--

-- ORASE --
INSERT INTO orase (id_oras, nume, id_judet) VALUES (1, 'Sector 1', 1);
INSERT INTO orase (id_oras, nume, id_judet) VALUES (2, 'Cluj-Napoca', 2);
INSERT INTO orase (id_oras, nume, id_judet) VALUES (3, 'Timișoara', 3);
INSERT INTO orase (id_oras, nume, id_judet) VALUES (4, 'Iași', 4);
INSERT INTO orase (id_oras, nume, id_judet) VALUES (5, 'Constanța', 5);
--

-- LOCATII --
INSERT INTO locatii (id_locatie, strada, cod_postal, id_oras) VALUES (1, 'Calea Victoriei', '010001', 1);
INSERT INTO locatii (id_locatie, strada, cod_postal, id_oras) VALUES (2, 'Bulevardul Eroilor', '400394', 2);
INSERT INTO locatii (id_locatie, strada, cod_postal, id_oras) VALUES (3, 'Calea Aradului', '300234', 3);
INSERT INTO locatii (id_locatie, strada, cod_postal, id_oras) VALUES (4, 'Cuza Vodă', '700200', 4);
INSERT INTO locatii (id_locatie, strada, cod_postal, id_oras) VALUES (5, 'Mircea cel Bătrân', '900001', 5);
--

-- PRODUCATORI --
INSERT INTO producatori (id_producator, nume_producator) VALUES (1, 'VinylCraft');
INSERT INTO producatori (id_producator, nume_producator) VALUES (2, 'MerchHub');
INSERT INTO producatori (id_producator, nume_producator) VALUES (3, 'SoundGear');
INSERT INTO producatori (id_producator, nume_producator) VALUES (4, 'TuneThreads');
INSERT INTO producatori (id_producator, nume_producator) VALUES (5, 'GrooveStyle');
--

-- PRODUSE --
INSERT INTO produse (id_produs, nume_produs, id_producator, pret, marime) VALUES (1, 'Tricou Tour', 4, 99.99, 'M');
INSERT INTO produse (id_produs, nume_produs, id_producator, pret, marime) VALUES (2, 'Vinil Album X', 1, 129.50, NULL);
INSERT INTO produse (id_produs, nume_produs, id_producator, pret, marime) VALUES (3, 'Hanorac Logo', 3, 149.99, 'L');
INSERT INTO produse (id_produs, nume_produs, id_producator, pret, marime) VALUES (4, 'Poster Limited', 2, 49.90, NULL);
INSERT INTO produse (id_produs, nume_produs, id_producator, pret, marime) VALUES (5, 'Sapca Band', 5, 79.99, 'U');
--

-- DEPOZITE -- 
INSERT INTO depozite (id_depozit, id_locatie) VALUES (1, 1);
INSERT INTO depozite (id_depozit, id_locatie) VALUES (2, 2);
INSERT INTO depozite (id_depozit, id_locatie) VALUES (3, 3);
INSERT INTO depozite (id_depozit, id_locatie) VALUES (4, 4);
INSERT INTO depozite (id_depozit, id_locatie) VALUES (5, 5);
--

-- INVENTARE --
INSERT INTO inventare (id_inventar, sector_depozit, id_depozit) VALUES (1, 'A1', 1);
INSERT INTO inventare (id_inventar, sector_depozit, id_depozit) VALUES (2, 'B2', 2);
INSERT INTO inventare (id_inventar, sector_depozit, id_depozit) VALUES (3, 'C3', 3);
INSERT INTO inventare (id_inventar, sector_depozit, id_depozit) VALUES (4, 'D4', 4);
INSERT INTO inventare (id_inventar, sector_depozit, id_depozit) VALUES (5, 'E5', 5);
--

-- ASOC_PRODUS --
INSERT INTO asoc_produs (id_inventar, id_produs, cantitate) VALUES (1, 1, 100);
INSERT INTO asoc_produs (id_inventar, id_produs, cantitate) VALUES (1, 2, 50);
INSERT INTO asoc_produs (id_inventar, id_produs, cantitate) VALUES (1, 3, 75);
INSERT INTO asoc_produs (id_inventar, id_produs, cantitate) VALUES (1, 4, 200);
INSERT INTO asoc_produs (id_inventar, id_produs, cantitate) VALUES (1, 5, 150);
INSERT INTO asoc_produs (id_inventar, id_produs, cantitate) VALUES (2, 1, 120);
INSERT INTO asoc_produs (id_inventar, id_produs, cantitate) VALUES (2, 2, 60);
INSERT INTO asoc_produs (id_inventar, id_produs, cantitate) VALUES (2, 3, 85);
INSERT INTO asoc_produs (id_inventar, id_produs, cantitate) VALUES (2, 4, 220);
INSERT INTO asoc_produs (id_inventar, id_produs, cantitate) VALUES (2, 5, 160);
INSERT INTO asoc_produs (id_inventar, id_produs, cantitate) VALUES (3, 1, 90);
INSERT INTO asoc_produs (id_inventar, id_produs, cantitate) VALUES (3, 2, 55);
INSERT INTO asoc_produs (id_inventar, id_produs, cantitate) VALUES (3, 3, 70);
INSERT INTO asoc_produs (id_inventar, id_produs, cantitate) VALUES (3, 4, 210);
INSERT INTO asoc_produs (id_inventar, id_produs, cantitate) VALUES (3, 5, 140);
INSERT INTO asoc_produs (id_inventar, id_produs, cantitate) VALUES (4, 1, 110);
INSERT INTO asoc_produs (id_inventar, id_produs, cantitate) VALUES (4, 2, 65);
INSERT INTO asoc_produs (id_inventar, id_produs, cantitate) VALUES (4, 3, 80);
INSERT INTO asoc_produs (id_inventar, id_produs, cantitate) VALUES (4, 4, 230);
INSERT INTO asoc_produs (id_inventar, id_produs, cantitate) VALUES (4, 5, 170);
--

-- GENURI --
INSERT INTO genuri (id_gen, titlu) VALUES (1, 'Rock');
INSERT INTO genuri (id_gen, titlu) VALUES (2, 'Pop');
INSERT INTO genuri (id_gen, titlu) VALUES (3, 'Hip-Hop');
INSERT INTO genuri (id_gen, titlu) VALUES (4, 'Jazz');
INSERT INTO genuri (id_gen, titlu) VALUES (5, 'Electronic');
--

-- COPERTE --
INSERT INTO coperte (id_coperta, latime, inaltime, tip_format) VALUES (1, 3000, 3000, 'JPG');
INSERT INTO coperte (id_coperta, latime, inaltime, tip_format) VALUES (2, 3000, 3000, 'PNG');
INSERT INTO coperte (id_coperta, latime, inaltime, tip_format) VALUES (3, 3500, 3500, 'JPG');
INSERT INTO coperte (id_coperta, latime, inaltime, tip_format) VALUES (4, 3200, 3200, 'PNG');
INSERT INTO coperte (id_coperta, latime, inaltime, tip_format) VALUES (5, 3000, 3000, 'JPEG');
--

-- TIPURI_LANSARI --
INSERT INTO tipuri_lansari (id_tip_lansare, titlu) VALUES (1, 'Album');
INSERT INTO tipuri_lansari (id_tip_lansare, titlu) VALUES (2, 'Single');
INSERT INTO tipuri_lansari (id_tip_lansare, titlu) VALUES (3, 'EP');
INSERT INTO tipuri_lansari (id_tip_lansare, titlu) VALUES (4, 'Live');
INSERT INTO tipuri_lansari (id_tip_lansare, titlu) VALUES (5, 'Remix');
--

-- LANSARI --
INSERT INTO lansari (id_lansare, nume, data_lansare, id_tip_lansare, id_gen, id_coperta) 
VALUES (1, 'The Dark Side', TO_DATE('2025-01-01', 'YYYY-MM-DD'), 1, 1, 1);

INSERT INTO lansari (id_lansare, nume, data_lansare, id_tip_lansare, id_gen, id_coperta) 
VALUES (2, 'Summer Vibes', TO_DATE('2025-06-15', 'YYYY-MM-DD'), 2, 2, 2);

INSERT INTO lansari (id_lansare, nume, data_lansare, id_tip_lansare, id_gen, id_coperta) 
VALUES (3, 'Beats of the Night', TO_DATE('2025-03-20', 'YYYY-MM-DD'), 3, 3, 3);

INSERT INTO lansari (id_lansare, nume, data_lansare, id_tip_lansare, id_gen, id_coperta) 
VALUES (4, 'Jazz Live Session', TO_DATE('2025-05-10', 'YYYY-MM-DD'), 4, 4, 4);

INSERT INTO lansari (id_lansare, nume, data_lansare, id_tip_lansare, id_gen, id_coperta) 
VALUES (5, 'Electronic Dreams', TO_DATE('2025-07-01', 'YYYY-MM-DD'), 5, 5, 5);
--

-- MELODII --
INSERT INTO melodii (id_melodie, nume, redari, id_lansare, id_gen)
VALUES (1, 'Intro', 150000, 1, 1);

INSERT INTO melodii (id_melodie, nume, redari, id_lansare, id_gen) VALUES
(2, 'Sunrise', 250000, 2, 2);

INSERT INTO melodii (id_melodie, nume, redari, id_lansare, id_gen) VALUES
(3, 'Nightfall', 320000, 3, 3);

INSERT INTO melodii (id_melodie, nume, redari, id_lansare, id_gen) VALUES
(4, 'Smooth Jazz', 180000, 4, 4);

INSERT INTO melodii (id_melodie, nume, redari, id_lansare, id_gen) VALUES
(5, 'Dreamscape', 210000, 5, 5);
--

-- FACILITATI --
INSERT INTO facilitati (id_facilitate, nume_facilitate) VALUES (1, 'Parcare');
INSERT INTO facilitati (id_facilitate, nume_facilitate) VALUES (2, 'Lift');
INSERT INTO facilitati (id_facilitate, nume_facilitate) VALUES (3, 'Sala de relaxare');
INSERT INTO facilitati (id_facilitate, nume_facilitate) VALUES (4, 'Cafenea');
INSERT INTO facilitati (id_facilitate, nume_facilitate) VALUES (5, 'Sala de fitness');
--

-- POSTURI --
INSERT INTO posturi (id_post, nume_post, salariu_minim, salariu_maxim, experienta_minima) 
VALUES (1, 'Manager', 4000, 7000, 3);

INSERT INTO posturi (id_post, nume_post, salariu_minim, salariu_maxim, experienta_minima) 
VALUES (2, 'Tehnician', 2000, 3500, 1);

INSERT INTO posturi (id_post, nume_post, salariu_minim, salariu_maxim, experienta_minima) 
VALUES (3, 'Asistent', 1800, 2500, 0);

INSERT INTO posturi (id_post, nume_post, salariu_minim, salariu_maxim, experienta_minima) 
VALUES (4, 'Coordonator Evenimente', 2500, 4800, 0);

INSERT INTO posturi (id_post, nume_post, salariu_minim, salariu_maxim, experienta_minima) 
VALUES (5, 'Programator', 3000, 6000, 2);

INSERT INTO posturi (id_post, nume_post, salariu_minim, salariu_maxim, experienta_minima) 
VALUES (6, 'Analist Financiar', 2200, 4500, 1);

INSERT INTO posturi (id_post, nume_post, salariu_minim, salariu_maxim, experienta_minima) 
VALUES (7, 'Contabil', 2500, 5000, 2);

INSERT INTO posturi (id_post, nume_post, salariu_minim, salariu_maxim, experienta_minima) 
VALUES (8, 'Manager Proiect', 2700, 4800, 1);

INSERT INTO posturi (id_post, nume_post, salariu_minim, salariu_maxim, experienta_minima) 
VALUES (9, 'Secretar', 1800, 2300, 0);

INSERT INTO posturi (id_post, nume_post, salariu_minim, salariu_maxim, experienta_minima) 
VALUES (10, 'Vanzator', 1500, 2500, 0);

INSERT INTO posturi (id_post, nume_post, salariu_minim, salariu_maxim, experienta_minima) 
VALUES (11, 'Consultant', 2700, 5500, 2);

INSERT INTO posturi (id_post, nume_post, salariu_minim, salariu_maxim, experienta_minima) 
VALUES (12, 'Operator', 1800, 2800, 0);

INSERT INTO posturi (id_post, nume_post, salariu_minim, salariu_maxim, experienta_minima) 
VALUES (13, 'Avocat', 4000, 8000, 3);

INSERT INTO posturi (id_post, nume_post, salariu_minim, salariu_maxim, experienta_minima) 
VALUES (14, 'Director', 5000, 10000, 5);

INSERT INTO posturi (id_post, nume_post, salariu_minim, salariu_maxim, experienta_minima) 
VALUES (15, 'Reprezentant vanzari', 2200, 4500, 1);
--

-- SEDII fara directori --
INSERT INTO sedii (id_sediu, nume_sediu, id_director, id_locatie) 
VALUES (1, 'SkyTower', NULL, 1);

INSERT INTO sedii (id_sediu, nume_sediu, id_director, id_locatie) 
VALUES (2, 'Metropolis Center', NULL, 2);

INSERT INTO sedii (id_sediu, nume_sediu, id_director, id_locatie) 
VALUES (3, 'Grand Central', NULL, 3);

INSERT INTO sedii (id_sediu, nume_sediu, id_director, id_locatie) 
VALUES (4, 'Horizon Plaza', NULL, 4);

INSERT INTO sedii (id_sediu, nume_sediu, id_director, id_locatie) 
VALUES (5, 'The Pinnacle', NULL, 5);
--

-- ASOC_FACILITATI --
INSERT INTO asoc_facilitati (id_sediu, id_facilitate) 
VALUES (1, 1);

INSERT INTO asoc_facilitati (id_sediu, id_facilitate) 
VALUES (1, 2);

INSERT INTO asoc_facilitati (id_sediu, id_facilitate) 
VALUES (1, 3);

INSERT INTO asoc_facilitati (id_sediu, id_facilitate) 
VALUES (2, 4);

INSERT INTO asoc_facilitati (id_sediu, id_facilitate) 
VALUES (2, 5);

INSERT INTO asoc_facilitati (id_sediu, id_facilitate) 
VALUES (3, 1);

INSERT INTO asoc_facilitati (id_sediu, id_facilitate) 
VALUES (3, 2);

INSERT INTO asoc_facilitati (id_sediu, id_facilitate) 
VALUES (3, 4);

INSERT INTO asoc_facilitati (id_sediu, id_facilitate) 
VALUES (4, 3);

INSERT INTO asoc_facilitati (id_sediu, id_facilitate) 
VALUES (4, 5);

INSERT INTO asoc_facilitati (id_sediu, id_facilitate) 
VALUES (5, 1);

INSERT INTO asoc_facilitati (id_sediu, id_facilitate) 
VALUES (5, 2);

INSERT INTO asoc_facilitati (id_sediu, id_facilitate) 
VALUES (5, 3);

INSERT INTO asoc_facilitati (id_sediu, id_facilitate) 
VALUES (5, 4);

INSERT INTO asoc_facilitati (id_sediu, id_facilitate) 
VALUES (5, 5);
--




-- DEPARTAMENTE fara coordonatori --
INSERT INTO departamente (id_departament, nume_departament, id_coordonator, id_sediu) 
VALUES (1, 'Vanzari', NULL, 1);

INSERT INTO departamente (id_departament, nume_departament, id_coordonator, id_sediu) 
VALUES (2, 'Marketing', NULL, 2);

INSERT INTO departamente (id_departament, nume_departament, id_coordonator, id_sediu) 
VALUES (3, 'IT', NULL, 3);

INSERT INTO departamente (id_departament, nume_departament, id_coordonator, id_sediu) 
VALUES (4, 'HR', NULL, 4);

INSERT INTO departamente (id_departament, nume_departament, id_coordonator, id_sediu) 
VALUES (5, 'Financiar', NULL, 5);

INSERT INTO departamente (id_departament, nume_departament, id_coordonator, id_sediu) 
VALUES (6, 'Legal', NULL, 1);

INSERT INTO departamente (id_departament, nume_departament, id_coordonator, id_sediu) 
VALUES (7, 'Productie', NULL, 2);

INSERT INTO departamente (id_departament, nume_departament, id_coordonator, id_sediu) 
VALUES (8, 'Logistica', NULL, 3);

INSERT INTO departamente (id_departament, nume_departament, id_coordonator, id_sediu) 
VALUES (9, 'Customer Service', NULL, 4);

INSERT INTO departamente (id_departament, nume_departament, id_coordonator, id_sediu) 
VALUES (10, 'Design', NULL, 5);
--

-- ANGAJATI --
INSERT INTO angajati (id_angajat, nume, prenume, id_post, id_departament, telefon, email, data_nastere, salariu) 
VALUES (1, 'Popescu', 'Andrei', 1, 1, '0745123456', 'andrei.popescu@example.com', TO_DATE('1985-03-15', 'YYYY-MM-DD'), 5000);

INSERT INTO angajati (id_angajat, nume, prenume, id_post, id_departament, telefon, email, data_nastere, salariu) 
VALUES (2, 'Ionescu', 'Maria', 2, 2, '0745234567', 'maria.ionescu@example.com', TO_DATE('1990-07-20', 'YYYY-MM-DD'), 4500);

INSERT INTO angajati (id_angajat, nume, prenume, id_post, id_departament, telefon, email, data_nastere, salariu) 
VALUES (3, 'Vasile', 'Ion', 3, 3, '0745345678', 'ion.vasile@example.com', TO_DATE('1983-02-10', 'YYYY-MM-DD'), 5200);

INSERT INTO angajati (id_angajat, nume, prenume, id_post, id_departament, telefon, email, data_nastere, salariu) 
VALUES (4, 'Radu', 'Diana', 4, 4, '0745456789', 'diana.radu@example.com', TO_DATE('1992-11-05', 'YYYY-MM-DD'), 3800);

INSERT INTO angajati (id_angajat, nume, prenume, id_post, id_departament, telefon, email, data_nastere, salariu) 
VALUES (5, 'Neagu', 'Alexandru', 5, 5, '0745567890', 'alexandru.neagu@example.com', TO_DATE('1988-04-30', 'YYYY-MM-DD'), 4800);

INSERT INTO angajati (id_angajat, nume, prenume, id_post, id_departament, telefon, email, data_nastere, salariu) 
VALUES (6, 'Georgescu', 'Ionut', 6, 6, '0745678901', 'ionut.georgescu@example.com', TO_DATE('1994-09-25', 'YYYY-MM-DD'), 3500);

INSERT INTO angajati (id_angajat, nume, prenume, id_post, id_departament, telefon, email, data_nastere, salariu) 
VALUES (7, 'Popa', 'Elena', 7, 7, '0745789012', 'elena.popa@example.com', TO_DATE('1991-01-12', 'YYYY-MM-DD'), 4000);

INSERT INTO angajati (id_angajat, nume, prenume, id_post, id_departament, telefon, email, data_nastere, salariu) 
VALUES (8, 'Mihail', 'Gabriela', 8, 8, '0745890123', 'gabriela.mihail@example.com', TO_DATE('1986-06-22', 'YYYY-MM-DD'), 4700);

INSERT INTO angajati (id_angajat, nume, prenume, id_post, id_departament, telefon, email, data_nastere, salariu) 
VALUES (9, 'Bălan', 'Victor', 9, 9, '0745901234', 'victor.balan@example.com', TO_DATE('1984-08-17', 'YYYY-MM-DD'), 3500);

INSERT INTO angajati (id_angajat, nume, prenume, id_post, id_departament, telefon, email, data_nastere, salariu) 
VALUES (10, 'Marin', 'Ioana', 10, 10, '0746012345', 'ioana.marin@example.com', TO_DATE('1995-05-03', 'YYYY-MM-DD'), 4300);

INSERT INTO angajati (id_angajat, nume, prenume, id_post, id_departament, telefon, email, data_nastere, salariu) 
VALUES (11, 'Dumitru', 'Stefan', 1, 6, '0746123456', 'stefan.dumitru@example.com', TO_DATE('1980-12-18', 'YYYY-MM-DD'), 8000);

INSERT INTO angajati (id_angajat, nume, prenume, id_post, id_departament, telefon, email, data_nastere, salariu) 
VALUES (12, 'Petrescu', 'Cristina', 1, 6, '0746234567', 'cristina.petrescu@example.com', TO_DATE('1993-03-25', 'YYYY-MM-DD'), 7500);

INSERT INTO angajati (id_angajat, nume, prenume, id_post, id_departament, telefon, email, data_nastere, salariu) 
VALUES (13, 'Barbu', 'Andreea', 1, 6, '0746345678', 'andreea.barbu@example.com', TO_DATE('1987-09-06', 'YYYY-MM-DD'), 7800);

INSERT INTO angajati (id_angajat, nume, prenume, id_post, id_departament, telefon, email, data_nastere, salariu) 
VALUES (14, 'Munteanu', 'Florin', 2, 6, '0746456789', 'florin.munteanu@example.com', TO_DATE('1982-05-14', 'YYYY-MM-DD'), 7000);

INSERT INTO angajati (id_angajat, nume, prenume, id_post, id_departament, telefon, email, data_nastere, salariu) 
VALUES (15, 'Ion', 'Adrian', 2, 6, '0746567890', 'adrian.ion@example.com', TO_DATE('1989-11-21', 'YYYY-MM-DD'), 7200);

INSERT INTO angajati (id_angajat, nume, prenume, id_post, id_departament, telefon, email, data_nastere, salariu) 
VALUES (16, 'Stan', 'Ramona', 3, 1, '0746678901', 'ramona.stan@example.com', TO_DATE('1990-10-12', 'YYYY-MM-DD'), 3800);

INSERT INTO angajati (id_angajat, nume, prenume, id_post, id_departament, telefon, email, data_nastere, salariu) 
VALUES (17, 'Neagu', 'Alina', 4, 2, '0746789012', 'alina.neagu@example.com', TO_DATE('1992-07-29', 'YYYY-MM-DD'), 4200);

INSERT INTO angajati (id_angajat, nume, prenume, id_post, id_departament, telefon, email, data_nastere, salariu) 
VALUES (18, 'Cristescu', 'Mihai', 5, 3, '0746890123', 'mihai.cristescu@example.com', TO_DATE('1983-01-03', 'YYYY-MM-DD'), 4500);

INSERT INTO angajati (id_angajat, nume, prenume, id_post, id_departament, telefon, email, data_nastere, salariu) 
VALUES (19, 'Sava', 'Larisa', 6, 4, '0746901234', 'larisa.sava@example.com', TO_DATE('1994-02-19', 'YYYY-MM-DD'), 3300);

INSERT INTO angajati (id_angajat, nume, prenume, id_post, id_departament, telefon, email, data_nastere, salariu) 
VALUES (20, 'Vlaicu', 'Doru', 7, 5, '0747012345', 'doru.vlaicu@example.com', TO_DATE('1990-12-05', 'YYYY-MM-DD'), 4600);

INSERT INTO angajati (id_angajat, nume, prenume, id_post, id_departament, telefon, email, data_nastere, salariu) 
VALUES (21, 'Dima', 'Stefan', 3, 1, '0747123456', 'stefan.dima@example.com', TO_DATE('1984-08-23', 'YYYY-MM-DD'), 5900);

INSERT INTO angajati (id_angajat, nume, prenume, id_post, id_departament, telefon, email, data_nastere, salariu) 
VALUES (22, 'Pavel', 'Florin', 4, 2, '0747234567', 'florin.pavel@example.com', TO_DATE('1986-11-10', 'YYYY-MM-DD'), 5200);

INSERT INTO angajati (id_angajat, nume, prenume, id_post, id_departament, telefon, email, data_nastere, salariu) 
VALUES (23, 'Tudor', 'Elena', 5, 3, '0747345678', 'elena.tudor@example.com', TO_DATE('1987-07-15', 'YYYY-MM-DD'), 5500);

INSERT INTO angajati (id_angajat, nume, prenume, id_post, id_departament, telefon, email, data_nastere, salariu) 
VALUES (24, 'Bălan', 'Radu', 8, 4, '0747456789', 'radu.balan@example.com', TO_DATE('1985-02-25', 'YYYY-MM-DD'), 5000);

INSERT INTO angajati (id_angajat, nume, prenume, id_post, id_departament, telefon, email, data_nastere, salariu) 
VALUES (25, 'Popa', 'Mihail', 9, 5, '0747567890', 'mihail.popa@example.com', TO_DATE('1991-09-19', 'YYYY-MM-DD'), 5200);

--

-- COORDONATORI DEPARTAMENTE --

DECLARE
    v_nrDepartamente NUMBER;
    v_contor NUMBER := 1;
    v_idCoordonator departamente.ID_COORDONATOR%TYPE;
BEGIN
    SELECT COUNT(*) INTO v_nrDepartamente
    FROM departamente;

    WHILE v_contor <= v_nrDepartamente LOOP

    SELECT id_angajat INTO v_idCoordonator
    FROM (
        WITH salarii AS(
        SELECT MAX(salariu) sal, id_departament
        FROM angajati
        GROUP BY id_departament
        )
        SELECT a.id_angajat, a.salariu, s.id_departament, (s.sal)
        FROM ANGAJATI a JOIN salarii s ON (a.id_departament = s.id_departament
                                            AND a.salariu = s.sal)
    )

    WHERE id_departament = v_contor AND ROWNUM = 1;

    UPDATE departamente
    SET id_coordonator = v_idCoordonator
    WHERE id_departament = v_contor;

    v_contor := v_contor + 1;
    END LOOP;
END;
/
--

-- COORDONATORI SEDII --
DECLARE
    v_nrSedii NUMBER;
    v_contor NUMBER := 1;
    v_idDirector sedii.ID_DIRECTOR%TYPE;
BEGIN
    SELECT COUNT(*) INTO v_nrSedii
    FROM sedii;

    WHILE v_contor <= v_nrSedii LOOP

    SELECT id_angajat INTO v_idDirector
    FROM angajati a JOIN departamente d USING (id_departament)
    JOIN (SELECT MAX(salariu) sal, id_sediu
        FROM angajati JOIN departamente USING (id_departament)
        GROUP BY id_sediu) max_sal
            ON (d.id_sediu = max_sal.id_sediu AND max_sal.sal = a.salariu)

    WHERE d.id_sediu = v_contor AND ROWNUM = 1;

    UPDATE sedii
    SET id_director = v_idDirector
    WHERE id_sediu = v_contor;

    v_contor := v_contor + 1;
    END LOOP;
END;
/
--


-- ARTISTI --
INSERT INTO artisti (id_artist, nume, prenume, nume_scena, data_nastere, telefon, id_gen, id_manager) 
VALUES (1, 'Ion', 'Popescu', 'Pop', TO_DATE('1990-04-12', 'YYYY-MM-DD'), '0712345678', 1, 1);

INSERT INTO artisti (id_artist, nume, prenume, nume_scena, data_nastere, telefon, id_gen, id_manager) 
VALUES (2, 'Maria', 'Ionescu', 'Maya', TO_DATE('1985-06-22', 'YYYY-MM-DD'), '0723456789', 2, 11);

INSERT INTO artisti (id_artist, nume, prenume, nume_scena, data_nastere, telefon, id_gen, id_manager) 
VALUES (3, 'Andrei', 'Vasilescu', 'DJ Andrei', TO_DATE('1988-09-15', 'YYYY-MM-DD'), '0734567890', 3, 12);

INSERT INTO artisti (id_artist, nume, prenume, nume_scena, data_nastere, telefon, id_gen, id_manager) 
VALUES (4, 'Elena', 'Munteanu', 'Lena', TO_DATE('1992-02-10', 'YYYY-MM-DD'), '0745678901', 4, 13);

INSERT INTO artisti (id_artist, nume, prenume, nume_scena, data_nastere, telefon, id_gen, id_manager) 
VALUES (5, 'Vasile', 'Georgescu', 'Vasi', TO_DATE('1994-11-30', 'YYYY-MM-DD'), '0756789012', 5, 13);

INSERT INTO artisti
VALUES (6, 'Danaila', 'Mihai', 'Imp0rt', TO_DATE('2005-22-01', 'YYYY-MM-DD'), '0771118281', 1, 1);
--

-- ASOC_LANSARI --
INSERT INTO asoc_lansari (id_artist, id_lansare) VALUES (1, 1);
INSERT INTO asoc_lansari (id_artist, id_lansare) VALUES (1, 2);
INSERT INTO asoc_lansari (id_artist, id_lansare) VALUES (2, 1);
INSERT INTO asoc_lansari (id_artist, id_lansare) VALUES (2, 3);
INSERT INTO asoc_lansari (id_artist, id_lansare) VALUES (3, 2);
INSERT INTO asoc_lansari (id_artist, id_lansare) VALUES (3, 4);
INSERT INTO asoc_lansari (id_artist, id_lansare) VALUES (4, 3);
INSERT INTO asoc_lansari (id_artist, id_lansare) VALUES (4, 5);
INSERT INTO asoc_lansari (id_artist, id_lansare) VALUES (5, 4);
INSERT INTO asoc_lansari (id_artist, id_lansare) VALUES (5, 5);
INSERT INTO ASOC_LANSARI (id_artist, id_lansare) VALUES (6, 2);
INSERT INTO ASOC_LANSARI (id_artist, id_lansare) VALUES (6, 1);
INSERT INTO ASOC_LANSARI (id_artist, id_lansare) VALUES (6, 3);
INSERT INTO ASOC_LANSARI (id_artist, id_lansare) VALUES (6, 4);
INSERT INTO ASOC_LANSARI (id_artist, id_lansare) VALUES (6, 5);
--

-- MAGAZINE_ONLINE --
INSERT INTO magazine_online (id_magazin_online, nume, id_artist) VALUES (1, 'RockByMayaStore', 1);
INSERT INTO magazine_online (id_magazin_online, nume, id_artist) VALUES (2, 'MayaPopShop', 2);
INSERT INTO magazine_online (id_magazin_online, nume, id_artist) VALUES (3, 'AndreiBeatsStore', 3);
INSERT INTO magazine_online (id_magazin_online, nume, id_artist) VALUES (4, 'LenaJazzVibes', 4);
INSERT INTO magazine_online (id_magazin_online, nume, id_artist) VALUES (5, 'VasiElectronicShop', 5);
--

-- ASOC_DEPOZITE --
INSERT INTO asoc_depozite (id_magazin_online, id_depozit) VALUES (1, 1);
INSERT INTO asoc_depozite (id_magazin_online, id_depozit) VALUES (1, 2);
INSERT INTO asoc_depozite (id_magazin_online, id_depozit) VALUES (2, 2);
INSERT INTO asoc_depozite (id_magazin_online, id_depozit) VALUES (2, 3);
INSERT INTO asoc_depozite (id_magazin_online, id_depozit) VALUES (3, 3);
INSERT INTO asoc_depozite (id_magazin_online, id_depozit) VALUES (3, 4);
INSERT INTO asoc_depozite (id_magazin_online, id_depozit) VALUES (4, 4);
INSERT INTO asoc_depozite (id_magazin_online, id_depozit) VALUES (4, 5);
INSERT INTO asoc_depozite (id_magazin_online, id_depozit) VALUES (5, 5);
INSERT INTO asoc_depozite (id_magazin_online, id_depozit) VALUES (5, 1);
--

-- CONTRACTE --

DECLARE
    CURSOR c_angajati IS
        SELECT id_angajat
        FROM angajati;
    v_idAngajat angajati.id_angajat%TYPE;
    v_idContract contracte.id_contract%TYPE := 100;
    v_dataStart contracte.data_start%TYPE;
    v_dataIncheiere contracte.data_incheiere%TYPE := NULL;
    v_durataContract NUMBER;
BEGIN
    OPEN c_angajati;

    FETCH c_angajati INTO v_idAngajat;
    WHILE c_angajati%FOUND LOOP

        v_dataStart :=  TO_DATE(
                            TRUNC(
                                DBMS_RANDOM.VALUE(
                                    TO_CHAR(DATE '2014-01-22', 'J'),
                                    TO_CHAR(SYSDATE, 'J')
                                )
                            ),
                        'J');

        IF DBMS_RANDOM.VALUE(0,1) > 0.5 THEN
            v_durataContract := TRUNC(DBMS_RANDOM.VALUE(1,10)) * 12;
            v_dataIncheiere := ADD_MONTHS(SYSDATE, v_durataContract);
        ELSE 
            v_dataIncheiere := NULL;
        END IF;
            

        INSERT INTO contracte (id_contract, data_start, data_incheiere)
        VALUES (v_idContract, v_dataStart, v_dataIncheiere);

        v_idContract := v_idContract + 1;
        FETCH c_angajati INTO v_idAngajat;
    END LOOP;

    CLOSE c_angajati;
END;
/

DECLARE
    CURSOR c_artisti IS
        SELECT id_artist
        FROM artisti;
    v_idArtist artisti.id_artist%TYPE;
    v_idContract contracte.id_contract%TYPE := 125;
    v_dataStart contracte.data_start%TYPE;
    v_dataIncheiere contracte.data_incheiere%TYPE := NULL;
    v_durataContract NUMBER;
BEGIN
    OPEN c_artisti;

    FETCH c_artisti INTO v_idArtist;
    WHILE c_artisti%FOUND LOOP

        v_dataStart :=  TO_DATE(
                            TRUNC(
                                DBMS_RANDOM.VALUE(
                                    TO_CHAR(DATE '2014-01-22', 'J'),
                                    TO_CHAR(SYSDATE, 'J')
                                )
                            ),
                        'J');

        IF DBMS_RANDOM.VALUE(0,1) > 0.5 THEN
            v_durataContract := TRUNC(DBMS_RANDOM.VALUE(1,10)) * 12;
            v_dataIncheiere := ADD_MONTHS(SYSDATE, v_durataContract);
        ELSE 
            v_dataIncheiere := NULL;
        END IF;
            

        INSERT INTO contracte (id_contract, data_start, data_incheiere)
        VALUES (v_idContract, v_dataStart, v_dataIncheiere);

        v_idContract := v_idContract + 1;
        FETCH c_artisti INTO v_idArtist;
    END LOOP;

    CLOSE c_artisti;
END;
/
--

-- CONTRACTE ANGAJATI --
DECLARE
    CURSOR c_angajati IS
        SELECT id_angajat, salariu, id_post, id_departament
        FROM angajati;
    v_idAngajat angajati.id_angajat%TYPE;
    v_salariu angajati.salariu%TYPE;
    v_idPost angajati.id_post%TYPE;
    v_oreMunca contracte_angajati.ore_Munca%TYPE;
    v_oreProba contracte_angajati.ORE_PERIOADA_PROBA%TYPE;
    v_idDepartament angajati.id_departament%TYPE;
    v_idContract contracte.id_contract%TYPE := 100;
    v_randomValue NUMBER;
BEGIN
    OPEN c_angajati;
    
    FETCH c_angajati INTO v_idAngajat, v_salariu, v_idPost, v_idDepartament;

    WHILE c_angajati%FOUND LOOP

        IF DBMS_RANDOM.VALUE(0,1) < 0.25 THEN
            v_oreMunca := 4;
        ELSE
            v_oreMunca:= 8;
        END IF;

        /*
        # TRUNC(DBMS_RANDOM.VALUE(0,4)) - SAPTAMANI DE PROBA
        # * 5 - 5 ZILE LUCRATOARE PE SAPTAMANA
        */
        v_oreProba := TRUNC(DBMS_RANDOM.VALUE(0,4)) * 5 * v_oreMunca;

        INSERT INTO contracte_angajati (id_contract, id_angajat, ore_munca, 
                salariu_start, ore_perioada_proba, id_post, id_departament)
        VALUES (v_idContract, v_idAngajat, v_oreMunca, v_salariu, 
                v_oreProba, v_idPost, v_idDepartament);

        v_idContract := v_idContract + 1;
        FETCH c_angajati INTO v_idAngajat, v_salariu, v_idPost, v_idDepartament;
    END LOOP;
END;
/
--

-- TIPURI_CONTRACTE_ARTISTI --
INSERT INTO tipuri_contracte_artisti (id_tip_contract_artist, titlu)
VALUES(1, 'Full Label Deal');

INSERT INTO tipuri_contracte_artisti (id_tip_contract_artist, titlu)
VALUES(2, 'Label Services Deal');

INSERT INTO tipuri_contracte_artisti (id_tip_contract_artist, titlu)
VALUES(3, 'Distribution Deal');

INSERT INTO tipuri_contracte_artisti (id_tip_contract_artist, titlu)
VALUES(4, '360 Deal');

INSERT INTO tipuri_contracte_artisti (id_tip_contract_artist, titlu)
VALUES(5, 'Catalogue Acquisition');
--

-- CONTRACTE ARTISTI --
INSERT INTO contracte_artisti (id_contract, id_locatie, procent_casa, avans, id_tip_contract_artist, id_artist) 
VALUES (125, 1, 0.3, 10000, 1, 1);

INSERT INTO contracte_artisti (id_contract, id_locatie, procent_casa, avans, id_tip_contract_artist, id_artist)
VALUES (126, 2, 0.25, 8000, 2, 2);

INSERT INTO contracte_artisti (id_contract, id_locatie, procent_casa, avans, id_tip_contract_artist, id_artist)
VALUES (127, 3, 0.2, 5000, 3, 3);

INSERT INTO contracte_artisti (id_contract, id_locatie, procent_casa, avans, id_tip_contract_artist, id_artist)
VALUES (128, 4, 0.35, 15000, 4, 4);

INSERT INTO contracte_artisti (id_contract, id_locatie, procent_casa, avans, id_tip_contract_artist, id_artist)
VALUES (129, 5, 0.40, 20000, 5, 5);
--