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
    nume VARCHAR2(30) NOT NULL,
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
    nume VARCHAR2(15) NOT NULL,
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
    id_contract NUMBER PRIMARY KEY,
    id_locatie NUMBER NOT NULL,
    procent_casa NUMBER(2,2) NOT NULL,
    avans NUMBER,
    id_tip_contract_artist NUMBER NOT NULL,
    id_artist NUMBER NOT NULL,
    FOREIGN KEY (id_contract) REFERENCES contracte(id_contract),
    FOREIGN KEY (id_tip_contract_artist) REFERENCES tipuri_contracte_artisti(id_tip_contract_artist),
    FOREIGN KEY (id_artist) REFERENCES artisti(id_artist)
);
--