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

INSERT IGNORE INTO brands (name) VALUES 
('INTEL'),
('AMD'),
('ADATA'),
('CRUCIAL'),
('CORSAIR'),
('KINGSTON'),
('TEAM GROUP'),
('G.SKILL'),
('PATRIOT'),
('NVIDIA'),
('ASUS'),
('GIGABYTE'),
('PNY'),
('SAPHIRE'),
('ZOTAC'),
('ASROCK'),
('MSI'),
('POWERCOLOR'),
('XFX'),
('BIOSTAR'),
('KIOXIA'),
('SAMSUNG'),
('SEAGATE'),
('WESTERN DIGITAL'),
('SANDISK'),
('DEEPCOOL'),
('BE QUIET!'),
('LIAN LI'),
('FRACTAL DESIGN'),
('THERMALRIGHT'),
('SEASONIC'),
('NZXT');

SELECT * FROM categories;

SELECT * FROM brands;

INSERT INTO products (name, description, price, stock, sku, category_id, brand_id, specifications) VALUES 
(
    'AMD Ryzen 5 7600X', 
    'El AMD Ryzen™ 5 7600X tiene seis núcleos de CPU y una velocidad de reloj base de 4,7 GHz.', 
    170.65, 
    4, 
    'CPUAMD-7000-01', 
    11, 
    2, 
    '{"socket": "AM5", "gen": "Ryzen 7000", "modelo": "Ryzen 5", "núcleos": 6, "hercios": 4.7, "gpu_integrada":true}'
),
(
    'AMD Ryzen 7 7800X3D', 
    'Junto con la tecnología AMD 3D V-Cache, el excelente procesador para la experiencia de juego te permite disfrutar de un mejor rendimiento en cada título que juegues', 
    399.99, 
    7, 
    'CPUAMD-7000-02', 
    11, 
    2, 
    '{"socket": "AM5", "gen": "Ryzen 7000", "modelo": "Ryzen 7", "núcleos": 8, "hercios": 4.2, "gpu_integrada":true}'
),
(
    'Intel Core Ultra 5 245KF ', 
    'Junto con la tecnología AMD 3D V-Cache, el excelente procesador para la experiencia de juego te permite disfrutar de un mejor rendimiento en cada título que juegues', 
    196.70, 
    8, 
    'CPUINTUC-2-01', 
    11, 
    1, 
    '{"socket": "FCLGA 1851", "gen": "Serie 2 - Arrow Lake", "modelo": "Inte Core Ultra 5", "núcleos": 14, "hercios": 4.2, "gpu_integrada":true}'
),
