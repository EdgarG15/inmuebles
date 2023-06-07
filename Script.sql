SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS `Edificio`;
DROP TABLE IF EXISTS `Inmuebles`;
DROP TABLE IF EXISTS `InmuebleTipo`;
DROP TABLE IF EXISTS `Empresa`;
DROP TABLE IF EXISTS `Inquilino`;
DROP TABLE IF EXISTS `Inquilino Inmueble`;
DROP TABLE IF EXISTS `Recibo`;
DROP TABLE IF EXISTS `Movimientos`;
DROP TABLE IF EXISTS `MovimientoTipo`;
DROP TABLE IF EXISTS `Cuentas`;
SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE `Edificio` (
    `EdificioID` INTEGER NOT NULL,
    `EdificioNombre` VARCHAR NOT NULL,
    `Direccion` VARCHAR NOT NULL,
    `Numero` INTEGER NOT NULL,
    `CodigoPostal` INTEGER(5) NOT NULL,
    `EdificioDescripcion` VARCHAR NOT NULL,
    `EmpresaID` INTEGER NOT NULL,
    `Valido` BIT NOT NULL,
    PRIMARY KEY (`EdificioID`),
    UNIQUE (`EdificioNombre`)
);

CREATE TABLE `Inmuebles` (
    `InmuebleID` INTEGER NOT NULL,
    `InmuebleTipoID` INTEGER NOT NULL,
    `InmuebleNombre` VARCHAR NOT NULL,
    `EdificioID` INTEGER NOT NULL,
    `Planta` VARCHAR NOT NULL,
    `Letra` VARCHAR(1) NOT NULL,
    `EmpresaID` INTEGER NOT NULL,
    `Disponible` BIT NOT NULL,
    `Valido` BIT NOT NULL,
    PRIMARY KEY (`InmuebleID`),
    UNIQUE (`InmuebleNombre`)
);

CREATE TABLE `InmuebleTipo` (
    `InmuebleTipoID` INTEGER NOT NULL,
    `InmuebleTipoNombre` VARCHAR NOT NULL,
    `Valido` BIT NOT NULL,
    PRIMARY KEY (`InmuebleTipoID`),
    UNIQUE (`InmuebleTipoNombre`)
);

CREATE TABLE `Empresa` (
    `EmpresaID` INTEGER NOT NULL,
    `EmpresaNombre` VARCHAR NOT NULL,
    `Telefono` INTEGER(12) NOT NULL,
    `Email` VARCHAR NOT NULL,
    `Valido` INTEGER NOT NULL,
    PRIMARY KEY (`EmpresaID`),
    UNIQUE (`EmpresaNombre`)
);

CREATE TABLE `Inquilino` (
    `InquilinoID` INTEGER NOT NULL,
    `Nombre` VARCHAR NOT NULL,
    `Apellido1` VARCHAR NOT NULL,
    `Apellido2` VARCHAR NOT NULL,
    `RFC` VARCHAR(13) NOT NULL,
    `Edad` INTEGER(3) NOT NULL,
    `Sexo` VARCHAR(10) NOT NULL,
    `Fotografia` VARCHAR NOT NULL,
    `Usuario` VARCHAR NOT NULL,
    `Contraseña` CHAR NOT NULL,
    `Referencia` BIT NOT NULL,
    `Nomina` BIT NOT NULL,
    `Aval` BIT NOT NULL,
    `Contrato` BIT NOT NULL,
    PRIMARY KEY (`InquilinoID`),
    UNIQUE (`Usuario`)
);

CREATE TABLE `Inquilino Inmueble` (
    `InquilinoInmuebleID` INTEGER NOT NULL,
    `InquilinoID` INTEGER NOT NULL,
    `InmuebleID` INTEGER NOT NULL,
    `StartDate` DATE NOT NULL,
    `EnDate` DATE NOT NULL,
    PRIMARY KEY (`InquilinoInmuebleID`)
);

CREATE TABLE `Recibo` (
    `NumeroDeRecibo` INTEGER NOT NULL,
    `InmuebleID` INTEGER NOT NULL,
    `FechaEmision` DATETIME NOT NULL,
    `Renta` FLOAT NOT NULL,
    `Agua` FLOAT,
    `Luz` FLOAT,
    `ActualizacionDeIPCAnual` FLOAT,
    `IVA` FLOAT NOT NULL,
    PRIMARY KEY (`NumeroDeRecibo`)
);

CREATE TABLE `Movimientos` (
    `MovimientoID` INTEGER NOT NULL,
    `MovimientoTipoID` INTEGER NOT NULL,
    `CuentaID` INTEGER NOT NULL,
    `InmuebleID` INTEGER NOT NULL,
    `Concepto` VARCHAR NOT NULL,
    PRIMARY KEY (`MovimientoID`)
);

CREATE TABLE `MovimientoTipo` (
    `MovimientoTipoID` INTEGER NOT NULL,
    `MovimientoTipoNombre` VARCHAR NOT NULL,
    PRIMARY KEY (`MovimientoTipoID`),
    UNIQUE (`MovimientoTipoNombre`)
);

CREATE TABLE `Cuentas` (
    `CuentaID` INTEGER NOT NULL,
    `BancoNombre` VARCHAR NOT NULL,
    `Saldo` FLOAT NOT NULL,
    PRIMARY KEY (`CuentaID`)
);

ALTER TABLE `Edificio` ADD FOREIGN KEY (`EmpresaID`) REFERENCES `Empresa`(`EmpresaID`);
ALTER TABLE `Inmuebles` ADD FOREIGN KEY (`EdificioID`) REFERENCES `Edificio`(`EdificioID`);
ALTER TABLE `Inmuebles` ADD FOREIGN KEY (`EmpresaID`) REFERENCES `Empresa`(`EmpresaID`);
ALTER TABLE `Inmuebles` ADD FOREIGN KEY (`InmuebleTipoID`) REFERENCES `InmuebleTipo`(`InmuebleTipoID`);
ALTER TABLE `Inquilino Inmueble` ADD FOREIGN KEY (`InmuebleID`) REFERENCES `Inmuebles`(`InmuebleID`);
ALTER TABLE `Inquilino Inmueble` ADD FOREIGN KEY (`InquilinoID`) REFERENCES `Inquilino`(`InquilinoID`);
ALTER TABLE `Recibo` ADD FOREIGN KEY (`InmuebleID`) REFERENCES `Inmuebles`(`InmuebleID`);
ALTER TABLE `Movimientos` ADD FOREIGN KEY (`MovimientoTipoID`) REFERENCES `MovimientoTipo`(`MovimientoTipoID`);
ALTER TABLE `Movimientos` ADD FOREIGN KEY (`CuentaID`) REFERENCES `Cuentas`(`CuentaID`);
ALTER TABLE `Movimientos` ADD FOREIGN KEY (`InmuebleID`) REFERENCES `Inmuebles`(`InmuebleID`);