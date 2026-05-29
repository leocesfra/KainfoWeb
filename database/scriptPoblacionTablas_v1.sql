USE Kainfo;

INSERT IGNORE INTO categories (name, parent_id) VALUES 
('Componentes', NULL),
('Periféricos', NULL),
('Portátiles', NULL);

INSERT IGNORE INTO categories (id, name, parent_id) VALUES 
(11, 'Procesadores', 1),
(12, 'RAM', 1),
(13, 'Gráficas', 1),
(14, 'Placas Base', 1),
(15, 'Discos duros', 1),
(16, 'Fuentes de alimentación', 1),
(17, 'Cajas y torres de PC', 1),
(18, 'Disipadores', 1),
(19, 'Ventiladores', 1),
(20, 'Tarjetas PCI', 1),
(31, 'Monitores', 2),
(32, 'Teclados', 2),
(33, 'Ratones', 2),
(34, 'Auriculares', 2);
