/*
CERINTA 4

Implementați în Oracle diagrama conceptuală realizată: 
definiți toate tabelele, adăugând toate constrângerile de 
integritate necesare (chei primare, cheile externe etc).
*/

-- JUDETE --
CREATE TABLE judete(
    id_judet NUMBER PRIMARY KEY,
    nume VARCHAR2(30)
);
--

-- ORASE --
CREATE TABLE orase(
    id_oras NUMBER PRIMARY KEY,
    nume VARCHAR2(30),
    populatie NUMBER,
    id_judet NUMBER,
    FOREIGN KEY (id_judet) REFERENCES judete(id_judet)
);
--

-- LOCATII --
CREATE TABLE locatii(
    id_locatie NUMBER PRIMARY KEY,
    strada VARCHAR2(30),
    cod_postal VARCHAR2(6),
    id_oras NUMBER,
    FOREIGN KEY (id_oras) REFERENCES orase(id_oras)
);
--

-- PRODUCATORI --
CREATE TABLE producatori(
    id_producator NUMBER PRIMARY KEY,
    nume_producator VARCHAR2(25)
);
--

-- PRODUS --
CREATE TABLE produse(
    id_produs NUMBER PRIMARY KEY,
    nume_produs VARCHAR2(20),
    id_producator NUMBER,
    pret NUMBER,
    marime VARCHAR2(5),
    FOREIGN KEY (id_producator) REFERENCES producatori(id_producator)
);
--

-- DEPOZITE --
CREATE TABLE depozite(
    id_depozit NUMBER PRIMARY KEY,
    id_locatie NUMBER NOT NULL,
    FOREIGN KEY (id_locatie) REFERENCES locatii(id_locatie)
);
-- 

-- INVENTARE --
CREATE TABLE inventare(
    id_inventar NUMBER PRIMARY KEY,
    sector_depozit VARCHAR2(5) NOT NULL,
    id_depozit NUMBER NOT NULL,
    FOREIGN KEY (id_depozit) REFERENCES depozite(id_depozit)
);
--

-- ASOC_PRODUS --
CREATE TABLE asoc_produs(
    id_inventar NUMBER,
    id_produs NUMBER,
    cantitate NUMBER,
    PRIMARY KEY (id_inventar, id_produs),
    FOREIGN KEY (id_inventar) REFERENCES inventare(id_inventar),
    FOREIGN KEY (id_produs) REFERENCES produse(id_produs)
);
--

-- GENURI --
CREATE TABLE genuri(
    id_gen NUMBER PRIMARY KEY,
    titlu VARCHAR2(15)
);
--

-- COPERTE --
CREATE TABLE coperte(
    id_coperta NUMBER PRIMARY KEY,
    latime NUMBER NOT NULL,
    inaltime NUMBER NOT NULL,
    tip_format VARCHAR2(5)
);
--

-- TIPURI_LANSARI
CREATE TABLE tipuri_lansari(
    id_tip_lansare NUMBER PRIMARY KEY,
    titlu VARCHAR2(10)
);
--

-- LANSARI --
CREATE TABLE lansari(
    id_lansare NUMBER PRIMARY KEY,
    nume VARCHAR2(40) NOT NULL,
    data_lansare DATE DEFAULT sysdate,
    id_tip_lansare NUMBER NOT NULL,
    id_gen NUMBER NOT NULL,
    id_coperta NUMBER,
    FOREIGN KEY (id_tip_lansare) REFERENCES tipuri_lansari(id_tip_lansare),
    FOREIGN KEY (id_gen) REFERENCES genuri(id_gen),
    FOREIGN KEY (id_coperta) REFERENCES coperte(id_coperta)
);
--

-- MELODII --
CREATE TABLE melodii(
    id_melodie NUMBER PRIMARY KEY,
    nume VARCHAR2(40) NOT NULL,
    redari NUMBER DEFAULT 0,
    id_lansare NUMBER NOT NULL,
    id_gen NUMBER NOT NULL,
    FOREIGN KEY (id_lansare) REFERENCES lansari(id_lansare),
    FOREIGN KEY (id_gen) REFERENCES genuri(id_gen)
);
--



-- FACILITATI --
CREATE TABLE facilitati(
    id_facilitate NUMBER PRIMARY KEY,
    nume_facilitate VARCHAR(20) NOT NULL
);
--

-- POST --
CREATE TABLE posturi(
    id_post NUMBER PRIMARY KEY,
    nume_post VARCHAR2(25) NOT NULL,
    salariu_minim NUMBER,
    salariu_maxim NUMBER,
    experienta_minima NUMBER
);
--

-- ANGAJATI --
CREATE TABLE angajati(
    id_angajat NUMBER PRIMARY KEY,
    nume VARCHAR2(25) NOT NULL,
    prenume VARCHAR2(25) NOT NULL,
    id_post NUMBER NOT NULL,
    id_departament NUMBER NOT NULL,
    telefon VARCHAR2(12),
    email VARCHAR2(35) NOT NULL,
    data_nastere DATE,
    salariu NUMBER NOT NULL,
    FOREIGN KEY (id_post) REFERENCES posturi(id_post)
);
--

-- ARTISTI --
CREATE TABLE artisti(
    id_artist NUMBER PRIMARY KEY,
    nume VARCHAR2(25) NOT NULL,
    prenume VARCHAR2(25) NOT NULL,
    nume_scena VARCHAR2(25) NOT NULL,
    data_nastere DATE,
    telefon VARCHAR2(12),
    id_gen NUMBER NOT NULL,
    id_manager NUMBER NOT NULL,
    FOREIGN KEY (id_gen) REFERENCES genuri(id_gen),
    FOREIGN KEY (id_manager) REFERENCES angajati(id_angajat)
);
--

-- ASOC_LANSARI --
CREATE TABLE asoc_lansari(
    id_artist NUMBER,
    id_lansare NUMBER,
    PRIMARY KEY(id_artist, id_lansare),
    FOREIGN KEY (id_artist) REFERENCES artisti(id_artist),
    FOREIGN KEY (id_lansare) REFERENCES lansari(id_lansare)
);
--

-- MAGAZINE_ONLINE --
CREATE TABLE magazine_online(
    id_magazin_online NUMBER PRIMARY KEY,
    nume VARCHAR2(25) NOT NULL,
    id_artist NUMBER,
    FOREIGN KEY (id_artist) REFERENCES artisti(id_artist)
);
--

-- ASOC_DEPOZITE --
CREATE TABLE asoc_depozite(
    id_magazin_online NUMBER,
    id_depozit NUMBER,
    PRIMARY KEY (id_magazin_online, id_depozit),
    FOREIGN KEY (id_magazin_online) REFERENCES magazine_online(id_magazin_online),
    FOREIGN KEY (id_depozit) REFERENCES depozite (id_depozit)
);
--

-- SEDII --
CREATE TABLE sedii(
    id_sediu NUMBER PRIMARY KEY,
    nume_sediu VARCHAR(25),
    id_director NUMBER,
    id_locatie NUMBER NOT NULL,
    FOREIGN KEY (id_director) REFERENCES angajati(id_angajat),
    FOREIGN KEY (id_locatie) REFERENCES locatii(id_locatie)
);
--

-- ASOC_FACILITATI --
CREATE TABLE asoc_facilitati(
    id_sediu NUMBER,
    id_facilitate NUMBER,
    PRIMARY KEY (id_sediu, id_facilitate),
    FOREIGN KEY (id_sediu) REFERENCES sedii(id_sediu),
    FOREIGN KEY (id_facilitate) REFERENCES facilitati(id_facilitate)
);
--

-- DEPARTAMENTE --
CREATE TABLE departamente(
    id_departament NUMBER PRIMARY KEY,
    nume_departament VARCHAR2(20) NOT NULL,
    id_coordonator NUMBER,
    id_sediu NUMBER NOT NULL,
    FOREIGN KEY (id_coordonator) REFERENCES angajati(id_angajat),
    FOREIGN KEY (id_sediu) REFERENCES sedii(id_sediu)
);

ALTER TABLE angajati
ADD(
    CONSTRAINT ang_dep_fk
        FOREIGN KEY (id_departament)
        REFERENCES departamente(id_departament)
);
--

-- CONTRACTE --
CREATE TABLE contracte(
    id_contract NUMBER PRIMARY KEY,
    data_start DATE NOT NULL,
    data_incheiere DATE
);
--

-- CONTRACTE_ANGAJATI --
CREATE TABLE contracte_angajati(
    id_contract NUMBER,
    id_angajat NUMBER,
    ore_munca NUMBER NOT NULL,
    salariu_start NUMBER NOT NULL,
    ore_perioada_proba NUMBER,
    id_post NUMBER NOT NULL,
    id_departament NUMBER,
    PRIMARY KEY (id_contract, id_angajat),
    FOREIGN KEY (id_post) REFERENCES posturi(id_post),
    FOREIGN KEY (id_departament) REFERENCES departamente(id_departament)
);
--

-- TIPURI_CONTRACTE_ARTISTI --
CREATE TABLE tipuri_contracte_artisti(
    id_tip_contract_artist NUMBER PRIMARY KEY,
    titlu VARCHAR2(25) NOT NULL
);
--

-- CONTRACTE_ARTISTI --
CREATE TABLE contracte_artisti(
    id_contract NUMBER,
    id_locatie NUMBER NOT NULL,
    procent_casa NUMBER(2,2) NOT NULL,
    avans NUMBER,
    id_tip_contract_artist NUMBER NOT NULL,
    id_artist NUMBER NOT NULL,
    PRIMARY KEY (id_contract, id_artist),
    FOREIGN KEY (id_contract) REFERENCES contracte(id_contract),
    FOREIGN KEY (id_tip_contract_artist) REFERENCES tipuri_contracte_artisti(id_tip_contract_artist),
    FOREIGN KEY (id_artist) REFERENCES artisti(id_artist)
);
--

/*
CERINTA 5
Adăugați informații coerente în tabelele create (minim 5 înregistrări pentru fiecare entitate
independentă; minim 10 înregistrări pentru fiecare tabelă asociativă).

*/
-- JUDETE --
INSERT INTO judete (id_judet, nume) VALUES (1, 'București');
INSERT INTO judete (id_judet, nume) VALUES (2, 'Cluj');
INSERT INTO judete (id_judet, nume) VALUES (3, 'Timiș');
INSERT INTO judete (id_judet, nume) VALUES (4, 'Iași');
INSERT INTO judete (id_judet, nume) VALUES (5, 'Constanța');
--

-- ORASE --
INSERT INTO orase (id_oras, nume, populatie, id_judet) VALUES (1, 'Sector 1', 224764, 1);
INSERT INTO orase (id_oras, nume, populatie, id_judet) VALUES (2, 'Cluj-Napoca', 286598, 2);
INSERT INTO orase (id_oras, nume, populatie, id_judet) VALUES (3, 'Timișoara', 250849, 3);
INSERT INTO orase (id_oras, nume, populatie, id_judet) VALUES (4, 'Iași', 271692, 4);
INSERT INTO orase (id_oras, nume, populatie, id_judet) VALUES (5, 'Constanța', 263688, 5);
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
VALUES (1, 'Popescu', 'Andrei', 1, 1, '0745123456', 'andrei.popescu@yahoo.com', TO_DATE('1985-03-15', 'YYYY-MM-DD'), 5000);

INSERT INTO angajati (id_angajat, nume, prenume, id_post, id_departament, telefon, email, data_nastere, salariu) 
VALUES (2, 'Ionescu', 'Maria', 2, 2, '0745234567', 'maria.ionescu@yahoo.com', TO_DATE('1990-07-20', 'YYYY-MM-DD'), 4500);

INSERT INTO angajati (id_angajat, nume, prenume, id_post, id_departament, telefon, email, data_nastere, salariu) 
VALUES (3, 'Vasile', 'Ion', 3, 3, '0745345678', 'ion.vasile@yahoo.com', TO_DATE('1983-02-10', 'YYYY-MM-DD'), 5200);

INSERT INTO angajati (id_angajat, nume, prenume, id_post, id_departament, telefon, email, data_nastere, salariu) 
VALUES (4, 'Radu', 'Diana', 4, 4, '0745456789', 'diana.radu@yahoo.com', TO_DATE('1992-11-05', 'YYYY-MM-DD'), 3800);

INSERT INTO angajati (id_angajat, nume, prenume, id_post, id_departament, telefon, email, data_nastere, salariu) 
VALUES (5, 'Neagu', 'Alexandru', 5, 5, '0745567890', 'alexandru.neagu@yahoo.com', TO_DATE('1988-04-30', 'YYYY-MM-DD'), 4800);

INSERT INTO angajati (id_angajat, nume, prenume, id_post, id_departament, telefon, email, data_nastere, salariu) 
VALUES (6, 'Georgescu', 'Ionut', 6, 6, '0745678901', 'ionut.georgescu@yahoo.com', TO_DATE('1994-09-25', 'YYYY-MM-DD'), 3500);

INSERT INTO angajati (id_angajat, nume, prenume, id_post, id_departament, telefon, email, data_nastere, salariu) 
VALUES (7, 'Popa', 'Elena', 7, 7, '0745789012', 'elena.popa@yahoo.com', TO_DATE('1991-01-12', 'YYYY-MM-DD'), 4000);

INSERT INTO angajati (id_angajat, nume, prenume, id_post, id_departament, telefon, email, data_nastere, salariu) 
VALUES (8, 'Mihail', 'Gabriela', 8, 8, '0745890123', 'gabriela.mihail@yahoo.com', TO_DATE('1986-06-22', 'YYYY-MM-DD'), 4700);

INSERT INTO angajati (id_angajat, nume, prenume, id_post, id_departament, telefon, email, data_nastere, salariu) 
VALUES (9, 'Bălan', 'Victor', 9, 9, '0745901234', 'victor.balan@yahoo.com', TO_DATE('1984-08-17', 'YYYY-MM-DD'), 3500);

INSERT INTO angajati (id_angajat, nume, prenume, id_post, id_departament, telefon, email, data_nastere, salariu) 
VALUES (10, 'Marin', 'Ioana', 10, 10, '0746012345', 'ioana.marin@yahoo.com', TO_DATE('1995-05-03', 'YYYY-MM-DD'), 4300);

INSERT INTO angajati (id_angajat, nume, prenume, id_post, id_departament, telefon, email, data_nastere, salariu) 
VALUES (11, 'Dumitru', 'Stefan', 1, 6, '0746123456', 'stefan.dumitru@yahoo.com', TO_DATE('1980-12-18', 'YYYY-MM-DD'), 8000);

INSERT INTO angajati (id_angajat, nume, prenume, id_post, id_departament, telefon, email, data_nastere, salariu) 
VALUES (12, 'Petrescu', 'Cristina', 1, 6, '0746234567', 'cristina.petrescu@yahoo.com', TO_DATE('1993-03-25', 'YYYY-MM-DD'), 7500);

INSERT INTO angajati (id_angajat, nume, prenume, id_post, id_departament, telefon, email, data_nastere, salariu) 
VALUES (13, 'Barbu', 'Andreea', 1, 6, '0746345678', 'andreea.barbu@yahoo.com', TO_DATE('1987-09-06', 'YYYY-MM-DD'), 7800);

INSERT INTO angajati (id_angajat, nume, prenume, id_post, id_departament, telefon, email, data_nastere, salariu) 
VALUES (14, 'Munteanu', 'Florin', 2, 6, '0746456789', 'florin.munteanu@yahoo.com', TO_DATE('1982-05-14', 'YYYY-MM-DD'), 7000);

INSERT INTO angajati (id_angajat, nume, prenume, id_post, id_departament, telefon, email, data_nastere, salariu) 
VALUES (15, 'Ion', 'Adrian', 2, 6, '0746567890', 'adrian.ion@yahoo.com', TO_DATE('1989-11-21', 'YYYY-MM-DD'), 7200);

INSERT INTO angajati (id_angajat, nume, prenume, id_post, id_departament, telefon, email, data_nastere, salariu) 
VALUES (16, 'Stan', 'Ramona', 3, 1, '0746678901', 'ramona.stan@yahoo.com', TO_DATE('1990-10-12', 'YYYY-MM-DD'), 3800);

INSERT INTO angajati (id_angajat, nume, prenume, id_post, id_departament, telefon, email, data_nastere, salariu) 
VALUES (17, 'Neagu', 'Alina', 4, 2, '0746789012', 'alina.neagu@yahoo.com', TO_DATE('1992-07-29', 'YYYY-MM-DD'), 4200);

INSERT INTO angajati (id_angajat, nume, prenume, id_post, id_departament, telefon, email, data_nastere, salariu) 
VALUES (18, 'Cristescu', 'Mihai', 5, 3, '0746890123', 'mihai.cristescu@yahoo.com', TO_DATE('1983-01-03', 'YYYY-MM-DD'), 4500);

INSERT INTO angajati (id_angajat, nume, prenume, id_post, id_departament, telefon, email, data_nastere, salariu) 
VALUES (19, 'Sava', 'Larisa', 6, 4, '0746901234', 'larisa.sava@yahoo.com', TO_DATE('1994-02-19', 'YYYY-MM-DD'), 3300);

INSERT INTO angajati (id_angajat, nume, prenume, id_post, id_departament, telefon, email, data_nastere, salariu) 
VALUES (20, 'Vlaicu', 'Doru', 7, 5, '0747012345', 'doru.vlaicu@yahoo.com', TO_DATE('1990-12-05', 'YYYY-MM-DD'), 4600);

INSERT INTO angajati (id_angajat, nume, prenume, id_post, id_departament, telefon, email, data_nastere, salariu) 
VALUES (21, 'Dima', 'Stefan', 3, 1, '0747123456', 'stefan.dima@yahoo.com', TO_DATE('1984-08-23', 'YYYY-MM-DD'), 5900);

INSERT INTO angajati (id_angajat, nume, prenume, id_post, id_departament, telefon, email, data_nastere, salariu) 
VALUES (22, 'Pavel', 'Florin', 4, 2, '0747234567', 'florin.pavel@yahoo.com', TO_DATE('1986-11-10', 'YYYY-MM-DD'), 5200);

INSERT INTO angajati (id_angajat, nume, prenume, id_post, id_departament, telefon, email, data_nastere, salariu) 
VALUES (23, 'Tudor', 'Elena', 5, 3, '0747345678', 'elena.tudor@yahoo.com', TO_DATE('1987-07-15', 'YYYY-MM-DD'), 5500);

INSERT INTO angajati (id_angajat, nume, prenume, id_post, id_departament, telefon, email, data_nastere, salariu) 
VALUES (24, 'Bălan', 'Radu', 8, 4, '0747456789', 'radu.balan@yahoo.com', TO_DATE('1985-02-25', 'YYYY-MM-DD'), 5000);

INSERT INTO angajati (id_angajat, nume, prenume, id_post, id_departament, telefon, email, data_nastere, salariu) 
VALUES (25, 'Popa', 'Mihail', 9, 5, '0747567890', 'mihail.popa@yahoo.com', TO_DATE('1991-09-19', 'YYYY-MM-DD'), 5200);

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
VALUES (6, 'Danaila', 'Mihai', 'Imp0rt', TO_DATE('2005-01-22', 'YYYY-MM-DD'), '0771118281', 1, 1);
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

-- Aditionale

INSERT INTO artisti (id_artist, nume_scena, id_gen, nume, prenume, data_nastere, telefon, id_manager)
VALUES (7, 'Future', 3, 'Nayvadius', 'Wilburn', TO_DATE('1983-11-20', 'YYYY-MM-DD'), '1234567890', 1);

INSERT INTO contracte (id_contract, data_start)
VALUES (140, TO_DATE('2000-01-01', 'YYYY-MM-DD'));


INSERT INTO contracte_artisti (id_contract, id_locatie, procent_casa, avans, id_tip_contract_artist, id_artist) 
VALUES (140, 1, 0.22, 40000, 1, 7);

INSERT INTO coperte
VALUES (6, 1000, 1000, 'PNG');

INSERT INTO lansari (id_lansare, nume, id_tip_lansare, id_gen, id_coperta)
VALUES (6, 'Future Hndrxx Presents: The WIZRD', 1, 3, 6);

INSERT INTO asoc_lansari VALUES (7, 6);

INSERT INTO melodii
VALUES (6, 'Stick to the Models', 104654, 6, 3);

INSERT INTO artisti (id_artist, nume_scena, id_gen, nume, prenume, data_nastere, telefon, id_manager)
VALUES (8, 'Drake', 3, 'Aubrey', 'Graham', TO_DATE('1986-10-24', 'YYYY-MM-DD'), '9876543210', 1);

INSERT INTO contracte (id_contract, data_start)
VALUES (131, TO_DATE('2000-02-01', 'YYYY-MM-DD'));

INSERT INTO contracte_artisti (id_contract, id_locatie, procent_casa, avans, id_tip_contract_artist, id_artist) 
VALUES (131, 1, 0.22, 20000, 1, 8);

INSERT INTO coperte
VALUES (7, 1000, 1000, 'PNG');

INSERT INTO lansari (id_lansare, nume, id_tip_lansare, id_gen, id_coperta)
VALUES (7, 'What A Time To Be Alive', 1, 3, 7);

INSERT INTO asoc_lansari VALUES (8, 7);

INSERT INTO melodii
VALUES (7, 'Scholarships', 170719, 7, 3);

INSERT INTO coperte
VALUES (8, 1000, 1000, 'PNG');

INSERT INTO lansari (id_lansare, nume, id_tip_lansare, id_gen, id_coperta)
VALUES (8, 'FUTURE', 1, 3, 8);

INSERT INTO asoc_lansari VALUES (7, 8);

INSERT INTO melodii
VALUES (8, 'Poppin'' Tags', 268068, 8, 3);

INSERT INTO coperte
VALUES (9, 1000, 1000, 'PNG');

INSERT INTO lansari (id_lansare, nume, id_tip_lansare, id_gen, id_coperta)
VALUES (9, 'DS2 (Deluxe)', 1, 3, 9);

INSERT INTO asoc_lansari VALUES (7, 9);

INSERT INTO melodii
VALUES (9, 'Rotation', 435934, 9, 3);

INSERT INTO melodii
VALUES (10, 'Scrape', 300952, 8, 3);

INSERT INTO melodii
VALUES (11, 'Mask Off', 241383, 8, 3);

INSERT INTO coperte
VALUES (10, 1000, 1000, 'PNG');

INSERT INTO lansari (id_lansare, nume, id_tip_lansare, id_gen, id_coperta)
VALUES (10, 'EVOL', 1, 3, 10);

INSERT INTO asoc_lansari VALUES (7, 10);

INSERT INTO melodii
VALUES (12, 'In Her Mouth', 379295, 10, 3);

INSERT INTO melodii
VALUES (13, 'Faceshot', 143562, 6, 3);

INSERT INTO coperte
VALUES (11, 1000, 1000, 'PNG');

INSERT INTO lansari (id_lansare, nume, id_tip_lansare, id_gen, id_coperta)
VALUES (11, 'Monster', 1, 3, 11);

INSERT INTO asoc_lansari VALUES (7, 11);

INSERT INTO melodii
VALUES (14, 'Mad Luv', 414194, 11, 3);

INSERT INTO melodii
VALUES (15, 'Blow a Bag', 403930, 9, 3);

INSERT INTO melodii
VALUES (16, 'Slave Master', 217027, 9, 3);

INSERT INTO coperte
VALUES (12, 1000, 1000, 'PNG');

INSERT INTO lansari (id_lansare, nume, id_tip_lansare, id_gen, id_coperta)
VALUES (12, 'I NEVER LIKED YOU', 1, 3, 12);

INSERT INTO asoc_lansari VALUES (7, 12);

INSERT INTO melodii
VALUES (17, 'MASSAGING ME', 426590, 12, 3);

INSERT INTO coperte
VALUES (13, 1000, 1000, 'PNG');

INSERT INTO lansari (id_lansare, nume, id_tip_lansare, id_gen, id_coperta)
VALUES (13, 'High Off Life', 1, 3, 13);

INSERT INTO asoc_lansari VALUES (7, 13);

INSERT INTO melodii
VALUES (18, 'Hard To Choose One', 467024, 13, 3);

INSERT INTO artisti (id_artist, nume_scena, id_gen, nume, prenume, data_nastere, telefon, id_manager)
VALUES (9, '21 Savage', 3, 'Shéyaa', 'Bin Abraham-Joseph', TO_DATE('1992-10-22', 'YYYY-MM-DD'), '1122334455', 1);

INSERT INTO contracte (id_contract, data_start)
VALUES (132, TO_DATE('2000-03-01', 'YYYY-MM-DD'));

INSERT INTO contracte_artisti (id_contract, id_locatie, procent_casa, avans, id_tip_contract_artist, id_artist) 
VALUES (132, 3, 0.2, 80000, 1, 9);

INSERT INTO coperte
VALUES (14, 1000, 1000, 'PNG');

INSERT INTO lansari (id_lansare, nume, id_tip_lansare, id_gen, id_coperta)
VALUES (14, 'Savage Mode', 1, 3, 14);

INSERT INTO asoc_lansari VALUES (9, 14);
INSERT INTO asoc_lansari VALUES (7, 14);

INSERT INTO melodii
VALUES (19, 'X', 459626, 14, 3);

INSERT INTO coperte
VALUES (15, 1000, 1000, 'PNG');

INSERT INTO lansari (id_lansare, nume, id_tip_lansare, id_gen, id_coperta)
VALUES (15, 'Purple Reign', 1, 3, 15);

INSERT INTO asoc_lansari VALUES (7, 15);

INSERT INTO melodii
VALUES (20, 'Hater Shit', 360854, 15, 3);

INSERT INTO artisti (id_artist, nume_scena, id_gen, nume, prenume, data_nastere, telefon, id_manager)
VALUES (15, 'Young Thug', 3, 'Jeffery', 'Williams', TO_DATE('1991-08-16', 'YYYY-MM-DD'), '9988776655', 1);

INSERT INTO contracte (id_contract, data_start)
VALUES (133, TO_DATE('2000-04-01', 'YYYY-MM-DD'));

INSERT INTO contracte_artisti (id_contract, id_locatie, procent_casa, avans, id_tip_contract_artist, id_artist) 
VALUES (133, 5, 0.4, 100000, 1, 15);

INSERT INTO artisti (id_artist, nume_scena, id_gen, nume, prenume, data_nastere, telefon, id_manager)
VALUES (16, 'Gunna', 3, 'Sergio', 'Kitchens', TO_DATE('1993-06-14', 'YYYY-MM-DD'), '2233445566', 1);

INSERT INTO contracte (id_contract, data_start)
VALUES (134, TO_DATE('2000-05-01', 'YYYY-MM-DD'));

INSERT INTO contracte_artisti (id_contract, id_locatie, procent_casa, avans, id_tip_contract_artist, id_artist) 
VALUES (134, 2, 0.2, 60000, 1, 16);

INSERT INTO asoc_lansari VALUES (15, 6);
INSERT INTO asoc_lansari VALUES (16, 6);

INSERT INTO melodii
VALUES (21, 'Unicorn Purp', 380007, 6, 3);

INSERT INTO coperte
VALUES (16, 1000, 1000, 'PNG');

INSERT INTO lansari (id_lansare, nume, id_tip_lansare, id_gen, id_coperta)
VALUES (16, 'Zone', 1, 3, 16);

INSERT INTO asoc_lansari VALUES (7, 16);

INSERT INTO melodii
VALUES (22, 'All Shooters', 448731, 16, 3);

INSERT INTO melodii
VALUES (23, 'Check On Me', 207748, 16, 3);

INSERT INTO melodii
VALUES (24, 'Thought It Was a Drought', 315535, 9, 3);

INSERT INTO artisti (id_artist, nume_scena, id_gen, nume, prenume, data_nastere, telefon, id_manager)
VALUES (10, 'Uncle Murda', 3, 'Leonard', 'Grant', TO_DATE('1980-07-25', 'YYYY-MM-DD'), '6677889900', 1);

INSERT INTO contracte (id_contract, data_start)
VALUES (135, TO_DATE('2000-06-01', 'YYYY-MM-DD'));

INSERT INTO contracte_artisti (id_contract, id_locatie, procent_casa, avans, id_tip_contract_artist, id_artist) 
VALUES (135, 1, 0.5, 20000, 1, 10);

INSERT INTO coperte
VALUES (17, 1000, 1000, 'PNG');

INSERT INTO lansari (id_lansare, nume, id_tip_lansare, id_gen, id_coperta)
VALUES (17, 'Right Now', 1, 3, 17);

INSERT INTO asoc_lansari VALUES (10, 17);

INSERT INTO melodii
VALUES (25, 'Right Now', 429337, 17, 3);

INSERT INTO artisti (id_artist, nume_scena, id_gen, nume, prenume, data_nastere, telefon, id_manager)
VALUES (11, 'Lil Double 0', 3, 'Tyler', 'Jones', TO_DATE('1999-02-10', 'YYYY-MM-DD'), '4455667788', 1);

INSERT INTO contracte (id_contract, data_start)
VALUES (136, TO_DATE('2000-07-01', 'YYYY-MM-DD'));

INSERT INTO contracte_artisti (id_contract, id_locatie, procent_casa, avans, id_tip_contract_artist, id_artist) 
VALUES (136, 2, 0.2, 1000, 1, 11);

INSERT INTO coperte
VALUES (18, 1000, 1000, 'PNG');

INSERT INTO lansari (id_lansare, nume, id_tip_lansare, id_gen, id_coperta)
VALUES (18, 'Walk Down Gang (Deluxe)', 1, 3, 18);

INSERT INTO asoc_lansari VALUES (11, 18);

INSERT INTO melodii
VALUES (26, 'U Sellin Dope (with Future)', 315260, 18, 3);

INSERT INTO melodii
VALUES (27, 'Xanny Family', 487846, 10, 3);

INSERT INTO coperte
VALUES (19, 1000, 1000, 'PNG');

INSERT INTO lansari (id_lansare, nume, id_tip_lansare, id_gen, id_coperta)
VALUES (19, 'SUPER SLIMEY', 1, 3, 19);

INSERT INTO asoc_lansari VALUES (7, 19);

INSERT INTO melodii
VALUES (28, 'Three', 107998, 19, 3);

INSERT INTO artisti (id_artist, nume_scena, id_gen, nume, prenume, data_nastere, telefon, id_manager)
VALUES (12, 'Young Scooter', 3, 'Kenneth', 'Edward Bailey', TO_DATE('1986-03-28', 'YYYY-MM-DD'), '5566778899', 1);

INSERT INTO contracte (id_contract, data_start)
VALUES (137, TO_DATE('2000-08-01', 'YYYY-MM-DD'));

INSERT INTO contracte_artisti (id_contract, id_locatie, procent_casa, avans, id_tip_contract_artist, id_artist) 
VALUES (137, 3, 0.25, 40000, 1, 12);

INSERT INTO coperte
VALUES (20, 1000, 1000, 'PNG');

INSERT INTO lansari (id_lansare, nume, id_tip_lansare, id_gen, id_coperta)
VALUES (20, 'Hard To Handle', 1, 3, 20);

INSERT INTO asoc_lansari VALUES (12, 20);

INSERT INTO melodii
VALUES (29, 'Hard To Handle', 450414, 20, 3);

INSERT INTO artisti (id_artist, nume_scena, id_gen, nume, prenume, data_nastere, telefon, id_manager)
VALUES (13, 'Meek Mill', 3, 'Robert', 'Williams', TO_DATE('1987-05-06', 'YYYY-MM-DD'), '3344556677', 1);

INSERT INTO contracte (id_contract, data_start)
VALUES (138, TO_DATE('2000-09-01', 'YYYY-MM-DD'));

INSERT INTO contracte_artisti (id_contract, id_locatie, procent_casa, avans, id_tip_contract_artist, id_artist) 
VALUES (138, 1, 0.11, 23000, 1, 13);

INSERT INTO coperte
VALUES (21, 1000, 1000, 'PNG');

INSERT INTO lansari (id_lansare, nume, id_tip_lansare, id_gen, id_coperta)
VALUES (21, 'Dreams Worth More Than Money', 1, 3, 21);

INSERT INTO asoc_lansari VALUES (13, 21);

INSERT INTO melodii
VALUES (30, 'Jump Out the Face', 164269, 21, 3);

INSERT INTO coperte
VALUES (22, 1000, 1000, 'PNG');

INSERT INTO lansari (id_lansare, nume, id_tip_lansare, id_gen, id_coperta)
VALUES (22, 'WE STILL DON''T TRUST YOU', 1, 3, 22);

INSERT INTO asoc_lansari VALUES (7, 22);

INSERT INTO melodii
VALUES (31, 'Streets Made Me A King', 486824, 22, 3);

INSERT INTO melodii
VALUES (32, 'Crossed Out', 462875, 22, 3);

INSERT INTO melodii
VALUES (33, 'Crazy Clientele', 381327, 22, 3);

INSERT INTO artisti (id_artist, nume_scena, id_gen, nume, prenume, data_nastere, telefon, id_manager)
VALUES (14, 'Metro Boomin', 3, 'Leland', 'Wayne', TO_DATE('1993-09-16', 'YYYY-MM-DD'), '7788990011', 1);

INSERT INTO contracte (id_contract, data_start)
VALUES (139, TO_DATE('2000-10-01', 'YYYY-MM-DD'));

INSERT INTO contracte_artisti (id_contract, id_locatie, procent_casa, avans, id_tip_contract_artist, id_artist) 
VALUES (139, 5, 0.28, 230000, 1, 14);

INSERT INTO coperte
VALUES (23, 1000, 1000, 'PNG');

INSERT INTO lansari (id_lansare, nume, id_tip_lansare, id_gen, id_coperta)
VALUES (23, 'HEROES and VILLAINS', 1, 3, 23);

INSERT INTO asoc_lansari VALUES (14, 23);

INSERT INTO melodii
VALUES (34, 'I Can''t Save You (Interlude)', 182370, 23, 3);

INSERT INTO coperte
VALUES (24, 1000, 1000, 'PNG');

INSERT INTO lansari (id_lansare, nume, id_tip_lansare, id_gen, id_coperta)
VALUES (24, 'WE DON''T TRUST YOU', 1, 3, 24);

INSERT INTO asoc_lansari VALUES (7, 24);

INSERT INTO melodii
VALUES (35, 'GTA', 119268, 24, 3);

INSERT INTO melodii
VALUES (36, 'Fly Shit Only', 266394, 10, 3);

INSERT INTO coperte
VALUES (25, 1000, 1000, 'PNG');

INSERT INTO lansari (id_lansare, nume, id_tip_lansare, id_gen, id_coperta)
VALUES (25, 'MIXTAPE PLUTO', 1, 3, 25);

INSERT INTO asoc_lansari VALUES (7, 25);

INSERT INTO melodii
VALUES (37, 'MJ', 314433, 25, 3);

DECLARE
    v_dataLansare   lansari.data_lansare%TYPE;

    CURSOR c_lansari IS
        SELECT id_lansare
        FROM lansari
        WHERE TO_CHAR(data_lansare, 'dd-mm-yy') = TO_CHAR(SYSDATE, 'dd-mm-yy');
BEGIN
    FOR lansare in c_lansari LOOP
        v_dataLansare :=  TO_DATE(
                                TRUNC(
                                    DBMS_RANDOM.VALUE(
                                        TO_CHAR(DATE '2005-01-01', 'J'),
                                        TO_CHAR(SYSDATE, 'J')
                                    )
                                ),
                            'J');
        UPDATE lansari
        SET data_lansare = v_dataLansare
        WHERE id_lansare = lansare.id_lansare;
    END LOOP;
END;
/

INSERT INTO melodii
VALUES (38, 'KKK', 474535, 8, 3);

COMMIT;

/*
CERINTA 6
Formulați în limbaj natural o problemă pe care să o rezolvați folosind un subprogram stocat independent care să utilizeze toate cele 3 tipuri de colecții studiate. Apelați subprogramul.

Cerință Problemă
Stocați într-un tabel indexat vechimea fiecărui angajat.
Într-un tablou imbricat stocați angajații cu o vechime mai mare de 8 ani jumătate și acordati-le o mărire de salariu de 5%.
Într-un vector stocați toate locațiile sortate în ordinea mediei vechimii, descrescător, și afișați-le alaturi de media salariilor după măriri.
Restaurați apoi modificările făcute.


*/
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

/*
CERINTA 7

Formulați în limbaj natural o problemă pe care să o rezolvați folosind un subprogram stocat
independent care să utilizeze 2 tipuri diferite de cursoare studiate, unul dintre acestea fiind cursor
parametrizat, dependent de celălalt cursor. Apelați subprogramul.

Cerință problemă
Să se obțină producătorii produselor deținute în depozitele magazinelor destinate 
artiștilor cu un număr minim redari. Numărul minim de redări va fi citit de la tastatură.

*/
-- Sa se obtina producatorii produselor detinute in depozitele
-- magazinelor destinate artistilor cu un numar
-- minim de redari.
-- Numarul minim de redari va fi citit de la tastatura

CREATE OR REPLACE PROCEDURE proc_ex7 (
    arg_min_redari      melodii.REDARI%TYPE
) AS
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

BEGIN
    OPEN c_artisti(arg_min_redari);

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
        END IF;
        
        DBMS_OUTPUT.PUT_LINE('');
        
    END LOOP;

    CLOSE c_artisti;
END;
/

EXECUTE proc_ex7(&p_minredari);

/*
CERINTA 8

Formulați în limbaj natural o problemă pe care să o rezolvați folosind 
un subprogram stocat independent de tip funcție care să utilizeze într-o 
singură comandă SQL 3 dintre tabelele create. Tratați toate excepțiile care 
pot apărea, incluzând excepțiile predefinite NO_DATA_FOUND și TOO_MANY_ROWS. 
Apelați subprogramul astfel încât să evidențiați toate cazurile tratate.

Cerință Problemă
Să se definească o funcție stocată care întoarce luna (indiferent de an) 
în care s-au înregistrat cele mai multe încasări din redări pentru un gen 
de muzică dat ca parametru. Se mai dă ca parametru și platforma de muzică care este analizată.

*/

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
    IF v_luna IS NOT NULL THEN
        DBMS_OUTPUT.PUT_LINE('Luna cu cele mai mari incasari este ' || v_luna);
    END IF;

    v_luna := FUNC_EX8('SPOTIFY', 2);
    IF v_luna IS NOT NULL THEN
        DBMS_OUTPUT.PUT_LINE('Luna cu cele mai mari incasari este ' || v_luna);
    END IF;

    v_luna := FUNC_EX8('SPOTIFY', 3);
    IF v_luna IS NOT NULL THEN
        DBMS_OUTPUT.PUT_LINE('Luna cu cele mai mari incasari este ' || v_luna);
    END IF;
END;
/

/*
CERINTA 9

Formulați în limbaj natural o problemă pe care să o rezolvați folosind un subprogram stocat independent de tip procedură care să aibă minim 2 parametri și să utilizeze într-o singură comandă SQL 5 dintre tabelele create. Definiți minim 2 excepții proprii, altele decât cele predefinite la nivel de sistem. Apelați subprogramul astfel încât să evidențiați toate cazurile definite și tratate.

Cerință Problemă:
Pentru fiecare album lansat, fiecare artist are un concert de lansare al acestuia. Pentru a realiza o promovare eficientă, casa de discuri amplasează afișe promoționale în anumite locații.

Să se calculeze cât s-a cheltuit pe afișe într-un an dat, în funcție de un artist dat.

Afișele sunt puse în tot județul menționat în contractul încheiat de artist.

Știm că un om ascultă o melodie în medie de 5 ori. Echipa de marketing a venit cu o strategie de a pune nrPersoaneCareAuAscultat / nrPopulatieJudet afișe.

Prețul unui afiș se calculează în funcție de mărimea copertei și de formatul acesteia.

Costul de format este:
PNG 	10 RON
JPG 	5 RON
JPEG 	6 RON

Costul de mărime este:
Aria copertei / 100000 RON

Prețul total este suma celor două costuri.

Dacă numărul afișelor e mai mic de 10, atunci promovarea nu este profitabilă.

Dacă un an conține o promovare neprofitabilă, atunci să se declanșeze excepția AN_NEPROFITABIL.

Dacă pentru o lansare se folosesc mai mulți bani decât s-au produs din ascultări, atunci să se declanșeze excepția DEFICIT_BUGET.

Să se creeze un tabel exceptii_afise în care să se introducă date despre excepțiile declanșate.

Rezolvare SQL + PLSQL

*/

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

/*
CERINTA 10

Definiți un trigger de tip LMD la nivel de comandă. Declanșați trigger-ul.

Cerință Problemă
Creați un tabel melodii_log în care să se păstreze informații despre fiecare operație 
LMD efectuată pe tabelul melodii, plus evoluția redărilor totale. 
Actualizarea tabelului să fie făcută printr-un trigger.

*/
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

/*
CERINTA 11

Definiți un trigger de tip LMD la nivel de linie. Declanșați trigger-ul.

Cerință Problemă
De fiecare dată când o lansare este adăugată, să se creeze un nou produs care să reprezinte un album fizic pentru noua lansare.

 Produsul o sa aiba urmatoarele date:
      - ID_PRODUS			urmatorul id valabil
      - ID_PRODUCATOR   		3
      - PRET              			70
      - MARIME           			NULL

De fiecare dată când o lansare este asociată unui artist, să se introducă câte 10 produse în fiecare inventar al fiecărui depozit asociat magazinelor artistului.  

Dacă artistul nu are un magazin asociat, să se ridice excepția FARA_MAGAZIN.

*/

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

/*
CERINTA 12

Definiți un trigger de tip LDD. Declanșați trigger-ul.

Cerință problemă
Definiți un trigger de tip LDD care să insereze într-un tabel informații despre operatie și tabelele actuale din baza de date (din contextul proiectului).

*/

-- Definiți un trigger de tip LDD care să insereze într-un tabel
-- informații despre operatie și tabelele actuale din baza de date (din contextul proiectului).

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

-- Am impartit triggerul in doua pentru a fi mai usor de urmarit

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

/*
CERINTA 13

Formulați în limbaj natural o problemă pe care să o rezolvați folosind un pachet care să includă
tipuri de date complexe și obiecte necesare unui flux de acțiuni integrate, specifice bazei de date
definite (minim 2 tipuri de date, minim 2 funcții, minim 2 proceduri).

Cerință problemă
Casa de discuri vrea sa ofere artiștilor câteva statistici cu privire la activitatea lor în cadrul casei. 
Dezvoltați un pachet care să ofere statistici cu privire la veniturile generate de artiști pe gen, 
cele mai bune decenii ale artiștilor din punct de vedere al ascultărilor, categorii de vechime ai 
artiștilor și evoluția artiștilor din punct de vedere al încasărilor.

*/

-- Casa de discuri vrea sa ofere artiștilor câteva 
-- statistici cu privire la activitatea lor în cadrul casei.
-- Dezvoltați un pachet care să ofere statistici cu privire la veniturile
-- generate de artiști pe gen, cele mai bune decenii ale artiștilor
-- din punct de vedere al ascultărilor, categorii de vechime ai artiștilor 
-- și evoluția artiștilor din punct de vedere al încasărilor.

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