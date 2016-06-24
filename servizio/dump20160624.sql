-- phpMyAdmin SQL Dump
-- version 4.3.10
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Giu 24, 2016 alle 13:17
-- Versione del server: 5.6.20
-- PHP Version: 5.5.15

SET FOREIGN_KEY_CHECKS=0;
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `hypermedia09`
--
DROP DATABASE `hypermedia09`;
CREATE DATABASE IF NOT EXISTS `hypermedia09` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `hypermedia09`;

-- --------------------------------------------------------

--
-- Struttura della tabella `asisstenza`
--
-- Creazione: Giu 03, 2016 alle 10:43
--

CREATE TABLE IF NOT EXISTS `asisstenza` (
  `idAssistenza` int(11) NOT NULL,
  `nome` int(11) NOT NULL,
  `descrizione` int(11) NOT NULL,
  `rifCategoria` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struttura della tabella `categories`
--
-- Creazione: Giu 03, 2016 alle 10:36
--

CREATE TABLE IF NOT EXISTS `categories` (
  `idCategoria` int(11) NOT NULL,
  `categoria` varchar(64) NOT NULL,
  `tipo` varchar(1) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

--
-- Dump dei dati per la tabella `categories`
--

INSERT INTO `categories` (`idCategoria`, `categoria`, `tipo`) VALUES
(1, 'Smartphone e Telefoni', 'd'),
(2, 'Tablet e Computer', 'd'),
(3, 'Wearable e SmartGadget', 'd'),
(4, 'Decoder e SmartTV', 'd'),
(5, 'Offerte e Occasioni', 'd'),
(6, 'TV e Intrattenimento', 's'),
(7, 'Casa e Famiglia', 's'),
(8, 'Salute e Benessere', 's'),
(9, 'Servizi alla Persona', 's'),
(10, 'Offerte e Occasioni', 's'),
(11, 'FAQ', 'a'),
(12, 'Gestione Linea', 'a'),
(13, 'Controllo Costi e Pagamenti', 'a'),
(14, 'Supporto Tecnico', 'a'),
(15, 'Servizi Smart Life', 'a');

-- --------------------------------------------------------

--
-- Struttura della tabella `devices`
--
-- Creazione: Giu 19, 2016 alle 12:44
--

CREATE TABLE IF NOT EXISTS `devices` (
  `idProdotto` int(11) NOT NULL,
  `nome` varchar(64) NOT NULL,
  `prezzo` float NOT NULL,
  `descrizione` text,
  `schedaTecnica` text,
  `marca` varchar(64) NOT NULL,
  `rifCategoria` int(11) NOT NULL,
  `inPromo` tinyint(1) NOT NULL DEFAULT '0',
  `spec1` varchar(255) DEFAULT NULL,
  `spec2` varchar(255) DEFAULT NULL,
  `spec3` varchar(255) DEFAULT NULL,
  `spec4` varchar(255) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

--
-- Dump dei dati per la tabella `devices`
--

INSERT INTO `devices` (`idProdotto`, `nome`, `prezzo`, `descrizione`, `schedaTecnica`, `marca`, `rifCategoria`, `inPromo`, `spec1`, `spec2`, `spec3`, `spec4`) VALUES
(1, 'LG Nexus 5', 329.99, '<p><b>LG Nexus 5</b> è un smartphone <b>Android</b> di buon livello, fortemente votato all''imaging, in grado di soddisfare anche l''utente più esigente.</p>\r\n<p>Dispone di un grande display <b>Touchscreen</b> da <b>5 pollici</b> con una risoluzione di <b>1920x1080</b> pixel. Sul versante delle funzionalità a questo LG Nexus 5 non manca davvero nulla. A cominciare dal modulo <b>LTE 4G</b> che permette un trasferimento dati e una navigazione in internet eccellente, passando per la connettività Wi-fi e il GPS. </p>\r\n<p>Ottima la fotocamera da <b>8 megapixel</b> che permette al LG Nexus 5 di scattare foto con una risoluzione di <b>3264x2448</b> pixel e di registrare video in <b>fullHD</b> alla risoluzione di <b>1920x1080</b> pixel.</p>\r\n<p>Lo spessore di <b>8.6mm</b> è contenuto e rende questo LG Nexus 5 molto interessante. \r\nPensato fin dal principio per sfruttare tutto il potenziale del sistema operativo più popolare al mondo, Nexus 5 ti offre l''esperienza Android definitiva. Sarai sempre fra i primi a ricevere gli <b>aggiornamenti software</b> e potrai divertirti fin da subito con l''ultima versione, <b>Android 6.0 Marshmallow.</b></p>', 'funziona benissimo!', 'LG', 1, 0, 'Android 6', 'Display 5 ''''', 'QuadCore 2.3 GHz', '4G LTE'),
(2, 'iPhone 5s 16GB', 479.9, 'bellissimo telefono!', 'funziona benissimo!', 'Apple', 1, 1, 'Display 4 pollici', 'iOS 10', 'Solo 112 grammi', 'It''s an iPhone!'),
(3, 'Sony XPERIA X', 629.9, 'bellissimo telefono!', 'funziona benissimo!', 'Sony', 1, 0, NULL, NULL, NULL, NULL),
(4, 'Huawei P9', 599.9, 'bellissimo telefono!', 'funziona benissimo!', 'Huawei', 1, 1, 'Display 5.2 pollici', 'Memoria 32GB espandibile', 'Processore 2.2GHz', 'Fotocamera 12Mpx');

-- --------------------------------------------------------

--
-- Struttura della tabella `devicesinassistenza`
--
-- Creazione: Giu 03, 2016 alle 10:44
--

CREATE TABLE IF NOT EXISTS `devicesinassistenza` (
  `rifDevice` int(11) NOT NULL,
  `rifAssistenza` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Struttura della tabella `devicesinsl`
--
-- Creazione: Giu 03, 2016 alle 10:45
--

CREATE TABLE IF NOT EXISTS `devicesinsl` (
  `rifDevice` int(11) NOT NULL,
  `rifSmartLife` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dump dei dati per la tabella `devicesinsl`
--

INSERT INTO `devicesinsl` (`rifDevice`, `rifSmartLife`) VALUES
(2, 1),
(4, 1);

-- --------------------------------------------------------

--
-- Struttura della tabella `faqsmartlife`
--
-- Creazione: Giu 21, 2016 alle 19:36
--

CREATE TABLE IF NOT EXISTS `faqsmartlife` (
  `idFaq` int(11) NOT NULL,
  `rifSmartLife` int(11) NOT NULL,
  `domanda` text NOT NULL,
  `risposta` text NOT NULL,
  `ordine` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

--
-- Dump dei dati per la tabella `faqsmartlife`
--

INSERT INTO `faqsmartlife` (`idFaq`, `rifSmartLife`, `domanda`, `risposta`, `ordine`) VALUES
(1, 1, 'Cosa trovo nella vetrina servizi trasporti?', 'Nella vetrina servizi trasporti puoi acquistare il biglietto dell''autobus e della metro in numerose città italiane e pagare con il tuo credito telefonico.', 1),
(2, 1, 'Quanto costa acquistare un biglietto?', 'L''utilizzo di TIM Wallet comporta il consumo di traffico Internet, per il quale si applica il tuo piano tariffario. Ti verranno inoltre addebitati il costo del biglietto più il costo dell’SMS di richiesta (19,90 €cent IVA inclusa). Il costo totale verrà scalato dal tuo credito telefonico (se sei un Cliente Ricaricabile) o con addebito in bolletta (se sei un Cliente con Abbonamento).', 2),
(3, 1, 'Che tipo di biglietti è possibile acquistare?', 'È possibile acquistare i biglietti dei trasporti pubblici per le tratte urbane ed extraurbane in numerose città italiane.', 3),
(4, 1, 'Dove posso utilizzare il servizio?', 'Per acquistare un biglietto accedi alla vetrina servizi trasporti, seleziona la città desiderata, scegli il biglietto elettronico e clicca “Acquista”. Riceverai un SMS di riepilogo, il biglietto sarà valido da quel momento senza necessità di ulteriori convalide.', 4);

-- --------------------------------------------------------

--
-- Struttura della tabella `imagesindevices`
--
-- Creazione: Giu 13, 2016 alle 09:21
--

CREATE TABLE IF NOT EXISTS `imagesindevices` (
  `rifImage` int(11) NOT NULL,
  `rifDevice` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dump dei dati per la tabella `imagesindevices`
--

INSERT INTO `imagesindevices` (`rifImage`, `rifDevice`) VALUES
(1, 2),
(2, 2),
(3, 4);

-- --------------------------------------------------------

--
-- Struttura della tabella `immagini`
--
-- Creazione: Giu 13, 2016 alle 08:47
--

CREATE TABLE IF NOT EXISTS `immagini` (
  `idImmagine` int(11) NOT NULL,
  `src` varchar(64) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

--
-- Dump dei dati per la tabella `immagini`
--

INSERT INTO `immagini` (`idImmagine`, `src`) VALUES
(1, 'APPLE_OIPHONE_SE_spacegrey_01.jpg'),
(2, 'APPLE_OIPHONE_SE_spacegrey_02.jpg'),
(3, 'huawei-p9-grey-01.jpg');

-- --------------------------------------------------------

--
-- Struttura della tabella `smartlife`
--
-- Creazione: Giu 24, 2016 alle 10:13
--

CREATE TABLE IF NOT EXISTS `smartlife` (
  `idSmartLife` int(11) NOT NULL,
  `nome` varchar(64) NOT NULL,
  `abstract` text,
  `descrizione` text,
  `attivazioneRegolamento` text,
  `rifCategoria` int(11) NOT NULL,
  `image` varchar(255) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

--
-- Dump dei dati per la tabella `smartlife`
--

INSERT INTO `smartlife` (`idSmartLife`, `nome`, `abstract`, `descrizione`, `attivazioneRegolamento`, `rifCategoria`, `image`) VALUES
(1, 'TIM Trasporti', NULL, 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam sit amet mauris risus. Duis convallis rhoncus rutrum. Suspendisse et auctor sapien. Vestibulum nec sagittis est, aliquet vehicula urna. Sed id nibh id lectus ultricies iaculis eget in tellus. Praesent a pellentesque magna. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean sollicitudin dui eu orci maximus, et efficitur velit imperdiet. Vivamus odio tortor, egestas ac tempus vel, molestie sed lectus. Etiam nec egestas velit. Integer tempor pharetra nisl, eu sodales nulla scelerisque sit amet.\r\n\r\nMauris vitae blandit arcu. Aenean enim mi, vestibulum quis porta ac, fermentum eu dolor. Sed porta volutpat tortor sed varius. Mauris quis eros ut elit pellentesque accumsan. Phasellus a mollis est. Donec accumsan urna non gravida accumsan. Morbi sed justo nec nisl feugiat lobortis. Ut gravida sapien at mi pretium, eu cursus leo tempus. Duis placerat semper neque, at laoreet elit aliquam sit amet. Maecenas ante metus, porttitor eu efficitur egestas, posuere quis eros. Proin in nisl in dolor feugiat tincidunt. Aenean aliquet erat sapien, in fermentum quam venenatis quis. Vivamus a odio blandit sapien dapibus condimentum.\r\nInteger accumsan leo accumsan tellus finibus imperdiet quis ornare neque. Integer molestie auctor sapien, a egestas sapien bibendum ut. Nulla facilisi. Maecenas tincidunt, tortor sit amet vestibulum ullamcorper, quam ipsum volutpat turpis, eget fermentum tellus nisl vitae augue. Duis id ante pretium nibh pharetra mattis. Nunc ut cursus sapien. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec elementum, enim id pharetra venenatis, tortor lectus efficitur eros, sed venenatis tellus orci non massa. Etiam nibh odio, malesuada a nisl eu, fermentum ornare eros. Quisque feugiat ullamcorper euismod. Suspendisse ac viverra elit, non porta justo. Aliquam vitae sem ultricies, pellentesque lectus sed, consectetur est.', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam sit amet mauris risus. Duis convallis rhoncus rutrum. Suspendisse et auctor sapien. Vestibulum nec sagittis est, aliquet vehicula urna. Sed id nibh id lectus ultricies iaculis eget in tellus. Praesent a pellentesque magna. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean sollicitudin dui eu orci maximus, et efficitur velit imperdiet. Vivamus odio tortor, egestas ac tempus vel, molestie sed lectus. Etiam nec egestas velit. Integer tempor pharetra nisl, eu sodales nulla scelerisque sit amet.\r\n\r\nMauris vitae blandit arcu. Aenean enim mi, vestibulum quis porta ac, fermentum eu dolor. Sed porta volutpat tortor sed varius. Mauris quis eros ut elit pellentesque accumsan. Phasellus a mollis est. Donec accumsan urna non gravida accumsan. Morbi sed justo nec nisl feugiat lobortis. Ut gravida sapien at mi pretium, eu cursus leo tempus. Duis placerat semper neque, at laoreet elit aliquam sit amet. Maecenas ante metus, porttitor eu efficitur egestas, posuere quis eros. Proin in nisl in dolor feugiat tincidunt. Aenean aliquet erat sapien, in fermentum quam venenatis quis. Vivamus a odio blandit sapien dapibus condimentum.\r\nInteger accumsan leo accumsan tellus finibus imperdiet quis ornare neque. Integer molestie auctor sapien, a egestas sapien bibendum ut. Nulla facilisi. Maecenas tincidunt, tortor sit amet vestibulum ullamcorper, quam ipsum volutpat turpis, eget fermentum tellus nisl vitae augue. Duis id ante pretium nibh pharetra mattis. Nunc ut cursus sapien. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Donec elementum, enim id pharetra venenatis, tortor lectus efficitur eros, sed venenatis tellus orci non massa. Etiam nibh odio, malesuada a nisl eu, fermentum ornare eros. Quisque feugiat ullamcorper euismod. Suspendisse ac viverra elit, non porta justo. Aliquam vitae sem ultricies, pellentesque lectus sed, consectetur est.', 9, 'placeholder.png'),
(2, 'SL Test', NULL, 'Just a test', 'It''s a test!!!', 9, 'placeholder.png'),
(3, 'Tim Vision', 'Cartoni, cinema, serie tv, documentari e concerti sempre on demand per creare il tuo palinsesto senza pubblicità. Più di 8.000 titoli in un abbonamento, senza vincoli di durata, anche in HD', '<p>TIMvision è la TV sempre on demand di TIM che non ti abbandona mai, senza pubblicità e anche da più dispositivi contemporaneamente. Vedi i tuoi programmi preferiti direttamente su Web e TV Anche su Smartphone e Tablet senza consumare Giga</p>\r\n<p><b>Accomodati e goditi il grande cinema</b>\r\nUna ricca proposta di film con le anteprime più attese, i grandi claassici, inediti, film d’azione, thriller, animazione e commedie per tutta la famiglia.In più l’HD, per rendere ogni immagine spettacolare e non perdere neanche un particolare</p>', NULL, 9, 'placeholder.png'),
(4, 'Tim Sky', 'Solo la nostra fibra e l’ADSL veloce ti portano SKY, senza parabola. TIM SKY, la prima offerta che ti dà chiamate, internet senza limiti e ti porta a casa lo spettacolo di SKY, senza parabola', '<p>Sei già cliente ADSL/Fibra di TIM?\r\nPer te il grande spettacolo e l’innovazione di Sky a partire da soli 14 €/mese in più per i primi 18 mesi.</p>\r\n<p>Se aderisci a TIM Sky entro il 3 luglio 2016 puoi avere:\r\n<ul><li>My Sky per vedere la TV come e quando vuoi e Sky On Demand, una videoteca con migliaia di titoli sempre a tua disposizione.\r\nSky TV con 38 canali di intrattenimento esclusivo a soli 14 €/mese per i primi 18 mesi, oppure Sky TV + un pacchetto a scelta tra Sky Cinema, Sky Sport o Sky Calcio a 26,90 €/mese per i primi 18 mesi. Puoi aggiungere all''offerta anche Sky Famiglia + Sky HD a 5€/mese per i primi 18 mesi anzichè 11€.</li>\r\n<li>Sky Box Sets è la novità di Sky che ti offre le migliori serie TV, stagione dopo stagione, tutte su My Sky.</li></p>', NULL, 9, 'placeholder.png'),
(5, 'Netflix', 'Serie Tv e film a partire da 7,99 €/mese,dove vuoi e quando vuoi, anche il decoder TIMvision', 'Scopri nuove storie\r\n\r\nSerie originali, commedie, drammi e programmi per bambini, puoi guardare le tue serie TV e film preferiti in streaming istantaneo sul dispositivo che preferisci. L''offerta TV che aspettavamo da tempo per la grande varietà dei contenuti, da vedere quando e dove vuoi con qualità della Rete TIM e senza vincoli, disponibile direttamente sulla TV di casa anche attraverso il decoder TIMvision con la qualità HD.', NULL, 9, 'placeholder.png');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `asisstenza`
--
ALTER TABLE `asisstenza`
  ADD PRIMARY KEY (`idAssistenza`), ADD KEY `rifCategoria` (`rifCategoria`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`idCategoria`);

--
-- Indexes for table `devices`
--
ALTER TABLE `devices`
  ADD PRIMARY KEY (`idProdotto`), ADD UNIQUE KEY `nome` (`nome`), ADD KEY `rifCategoria` (`rifCategoria`);

--
-- Indexes for table `devicesinassistenza`
--
ALTER TABLE `devicesinassistenza`
  ADD PRIMARY KEY (`rifDevice`,`rifAssistenza`), ADD KEY `rifAssistenza` (`rifAssistenza`);

--
-- Indexes for table `devicesinsl`
--
ALTER TABLE `devicesinsl`
  ADD PRIMARY KEY (`rifDevice`,`rifSmartLife`), ADD KEY `rifSmartLife` (`rifSmartLife`);

--
-- Indexes for table `faqsmartlife`
--
ALTER TABLE `faqsmartlife`
  ADD PRIMARY KEY (`idFaq`), ADD KEY `rifSmartLife` (`rifSmartLife`);

--
-- Indexes for table `imagesindevices`
--
ALTER TABLE `imagesindevices`
  ADD PRIMARY KEY (`rifImage`,`rifDevice`), ADD KEY `rifDevice` (`rifDevice`);

--
-- Indexes for table `immagini`
--
ALTER TABLE `immagini`
  ADD PRIMARY KEY (`idImmagine`), ADD UNIQUE KEY `src` (`src`);

--
-- Indexes for table `smartlife`
--
ALTER TABLE `smartlife`
  ADD PRIMARY KEY (`idSmartLife`), ADD KEY `rifCategoria` (`rifCategoria`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `asisstenza`
--
ALTER TABLE `asisstenza`
  MODIFY `idAssistenza` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `idCategoria` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=16;
--
-- AUTO_INCREMENT for table `devices`
--
ALTER TABLE `devices`
  MODIFY `idProdotto` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `faqsmartlife`
--
ALTER TABLE `faqsmartlife`
  MODIFY `idFaq` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=5;
--
-- AUTO_INCREMENT for table `immagini`
--
ALTER TABLE `immagini`
  MODIFY `idImmagine` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT for table `smartlife`
--
ALTER TABLE `smartlife`
  MODIFY `idSmartLife` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=6;
--
-- Limiti per le tabelle scaricate
--

--
-- Limiti per la tabella `devices`
--
ALTER TABLE `devices`
ADD CONSTRAINT `devices_ibfk_1` FOREIGN KEY (`rifCategoria`) REFERENCES `categories` (`idCategoria`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limiti per la tabella `devicesinassistenza`
--
ALTER TABLE `devicesinassistenza`
ADD CONSTRAINT `devicesinassistenza_ibfk_1` FOREIGN KEY (`rifDevice`) REFERENCES `devices` (`idProdotto`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `devicesinassistenza_ibfk_2` FOREIGN KEY (`rifAssistenza`) REFERENCES `asisstenza` (`idAssistenza`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limiti per la tabella `devicesinsl`
--
ALTER TABLE `devicesinsl`
ADD CONSTRAINT `devicesinsl_ibfk_1` FOREIGN KEY (`rifDevice`) REFERENCES `devices` (`idProdotto`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `devicesinsl_ibfk_2` FOREIGN KEY (`rifSmartLife`) REFERENCES `smartlife` (`idSmartLife`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limiti per la tabella `faqsmartlife`
--
ALTER TABLE `faqsmartlife`
ADD CONSTRAINT `faqsmartlife_ibfk_1` FOREIGN KEY (`rifSmartLife`) REFERENCES `smartlife` (`idSmartLife`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Limiti per la tabella `imagesindevices`
--
ALTER TABLE `imagesindevices`
ADD CONSTRAINT `imagesindevices_ibfk_2` FOREIGN KEY (`rifDevice`) REFERENCES `devices` (`idProdotto`) ON DELETE CASCADE ON UPDATE CASCADE,
ADD CONSTRAINT `imagesindevices_ibfk_3` FOREIGN KEY (`rifImage`) REFERENCES `immagini` (`idImmagine`);
SET FOREIGN_KEY_CHECKS=1;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;