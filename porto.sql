-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Creato il: Mar 21, 2025 alle 11:21
-- Versione del server: 10.4.28-MariaDB
-- Versione PHP: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `porto`
--
CREATE DATABASE IF NOT EXISTS `porto` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `porto`;

DELIMITER $$
--
-- Procedure
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `ArrivoNave` (IN `p_nome` VARCHAR(100), IN `p_data_arrivo` DATETIME, IN `p_data_partenza_prevista` DATETIME)   BEGIN
    INSERT INTO Navi(nome, data_arrivo, data_partenza_prevista)
    VALUES(p_nome, p_data_arrivo, p_data_partenza_prevista);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `PartenzaNave` (IN `p_id_nave` INT, IN `p_data_partenza_effettiva` DATETIME)   BEGIN
    UPDATE Navi
    SET data_partenza_effettiva = p_data_partenza_effettiva
    WHERE id = p_id_nave;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `RegistraOperazione` (IN `p_id_nave` INT, IN `p_id_prodotto` INT, IN `p_tipo` ENUM('carico','scarico'), IN `p_quantita` INT)   BEGIN
    INSERT INTO Operazioni(id_nave, id_prodotto, tipo, quantita)
    VALUES(p_id_nave, p_id_prodotto, p_tipo, p_quantita);

    IF p_tipo = 'scarico' THEN
        UPDATE Magazzino
        SET quantita = quantita + p_quantita
        WHERE id_prodotto = p_id_prodotto;

        IF ROW_COUNT() = 0 THEN
            INSERT INTO Magazzino(id_prodotto, quantita)
            VALUES(p_id_prodotto, p_quantita);
        END IF;
    ELSE
        UPDATE Magazzino
        SET quantita = quantita - p_quantita
        WHERE id_prodotto = p_id_prodotto;
    END IF;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Struttura della tabella `magazzino`
--

CREATE TABLE `magazzino` (
  `id_prodotto` int(11) NOT NULL,
  `quantita` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `magazzino`
--

INSERT INTO `magazzino` (`id_prodotto`, `quantita`) VALUES
(1, 10000),
(2, 5400),
(3, 8000),
(4, 3000),
(5, 7000),
(6, 6000),
(7, 4000),
(8, 2000);

-- --------------------------------------------------------

--
-- Struttura della tabella `navi`
--

CREATE TABLE `navi` (
  `id` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `data_arrivo` datetime NOT NULL,
  `data_partenza_prevista` datetime NOT NULL,
  `data_partenza_effettiva` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struttura della tabella `operazioni`
--

CREATE TABLE `operazioni` (
  `id` int(11) NOT NULL,
  `id_nave` int(11) NOT NULL,
  `id_prodotto` int(11) NOT NULL,
  `tipo` enum('carico','scarico') NOT NULL,
  `quantita` int(11) NOT NULL,
  `data_operazione` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struttura della tabella `prodotti`
--

CREATE TABLE `prodotti` (
  `id` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `prodotti`
--

INSERT INTO `prodotti` (`id`, `nome`) VALUES
(1, 'Grano'),
(2, 'Olio d\'oliva'),
(3, 'Vino'),
(4, 'Acciaio'),
(5, 'Cemento'),
(6, 'Legname'),
(7, 'Carbone'),
(8, 'Fertilizzante');

--
-- Indici per le tabelle scaricate
--

--
-- Indici per le tabelle `magazzino`
--
ALTER TABLE `magazzino`
  ADD PRIMARY KEY (`id_prodotto`);

--
-- Indici per le tabelle `navi`
--
ALTER TABLE `navi`
  ADD PRIMARY KEY (`id`);

--
-- Indici per le tabelle `operazioni`
--
ALTER TABLE `operazioni`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_nave` (`id_nave`),
  ADD KEY `id_prodotto` (`id_prodotto`);

--
-- Indici per le tabelle `prodotti`
--
ALTER TABLE `prodotti`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT per le tabelle scaricate
--

--
-- AUTO_INCREMENT per la tabella `navi`
--
ALTER TABLE `navi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT per la tabella `operazioni`
--
ALTER TABLE `operazioni`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT per la tabella `prodotti`
--
ALTER TABLE `prodotti`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Limiti per le tabelle scaricate
--

--
-- Limiti per la tabella `magazzino`
--
ALTER TABLE `magazzino`
  ADD CONSTRAINT `magazzino_ibfk_1` FOREIGN KEY (`id_prodotto`) REFERENCES `prodotti` (`id`);

--
-- Limiti per la tabella `operazioni`
--
ALTER TABLE `operazioni`
  ADD CONSTRAINT `operazioni_ibfk_1` FOREIGN KEY (`id_nave`) REFERENCES `navi` (`id`),
  ADD CONSTRAINT `operazioni_ibfk_2` FOREIGN KEY (`id_prodotto`) REFERENCES `prodotti` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
