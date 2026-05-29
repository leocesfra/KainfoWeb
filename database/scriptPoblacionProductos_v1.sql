USE Kainfo;

INSERT INTO products (name, description, price, stock, sku, category_id, brand_id, specifications) VALUES 
(
    'AMD Ryzen 5 7600X', 
    'El AMD Ryzen™ 5 7600X tiene seis núcleos de CPU y una velocidad de reloj base de 4,7 GHz.', 
    170.65, 
    4, 
    'CPUAMD-7000-01', 
    11, 
    2, 
    '{
	"socket": "AM5", 
	"gen": "Ryzen 7000", 
	"modelo": "Ryzen 5", 
	"núcleos": 6, 
	"hercios": 4.7, 
	"gpu_integrada":true
	}'
),
(
    'AMD Ryzen 7 7800X3D', 
    'Junto con la tecnología AMD 3D V-Cache, el excelente procesador para la experiencia de juego te permite disfrutar de un mejor rendimiento en cada título que juegues', 
    399.99, 
    7, 
    'CPUAMD-7000-02', 
    11, 
    2, 
    '{
	"socket": "AM5", 
	"gen": "Ryzen 7000", 
	"modelo": "Ryzen 7", 
	"núcleos": 8, 
	"hercios": 4.2, 
	"gpu_integrada":true
	}'
),
(
    'Intel Core Ultra 5 245KF', 
    'El Intel Core Ultra 5 245KF con la tecnología Intel Core Ultra Serie 2, diseñada para el desempeño y la eficiencia, es compatible con todo, desde la productividad diaria hasta el trabajo creativo y la experiencia de gaming.', 
    196.70, 
    8, 
    'CPUINTUC-2-01', 
    11, 
    1, 
    '{
	"socket": "FCLGA 1851", 
	"gen": "Serie 2 - Arrow Lake", 
	"modelo": "Intel Core Ultra 5", 
	"núcleos": 14, 
	"hercios": 4.2, 
	"gpu_integrada":false
	}'
),
(
    'Intel Core i9-13900KS', 
    'Saca todo el potencial del procesador con los nuevos nucleos eficientes Raptor Cove permitiendo un equlibrio entre rendimiento y eficencia fuera de lo comun', 
    537.80, 
    3, 
    'CPUINTC-13-01', 
    11, 
    1, 
    '{
	"socket": "FCLGA 1700", 
	"gen": "13ª - Raptor Lake", 
	"modelo": "Intel Core 9", 
	"núcleos": 24, 
	"hercios": 3.2, 
	"gpu_integrada":true
	}'
),
(
    'MPG 272QRF X36', 
    'Diseñado para jugadores que exigen un gran rendimiento y un diseño elegante. Este monitor cuenta con un panel Rapid IPS de 27 pulgadas con una frecuencia de actualización de 360 Hz y un tiempo de respuesta de 0,5 ms (GtG, mín.). Incluye NVIDIA G-SYNC', 
    640.90, 
    11, 
    'MSIMON-01', 
    31, 
    17, 
    '{
	"pulgadas": 27, 
	"resolucion": "2560x1440 (WQHD)", 
	"panel": "IPS", 
	"hercios": 360, 
	"respuesta": 0.5,
	"curvo": false,
    "ajustable_altura": true,
    "sincronizacion_vertical": "G-Sync",
    "tactil": false 
	}'
),
(
    'MO32U Gaming Monitor', 
    'Adéntrate en un mundo de realismo sin igual con el GIGABYTE MO32U. Diseñado para potenciar tu ventaja competitiva gracias a la tecnología QD-OLED, ofrece un rendimiento revolucionario y unas imágenes impresionantes que te dejarán sin palabras.' , 
    800.90, 
    2, 
    'GIGMON-01', 
    31, 
    12, 
    '{
	"pulgadas": 32, 
	"resolucion": "3840 x 2160 (4K)", 
	"panel": "OLED", 
	"hercios": 165, 
	"respuesta": 0.03,
	"curvo": false,
    "ajustable_altura": true,
    "sincronizacion_vertical": "FreeSync",
    "tactil": false 
	}'
);

INSERT INTO product_images (product_id, image_url, is_primary) VALUES
(1, 'https://res.cloudinary.com/dttbykl0c/image/upload/v1779916979/ryzen-7-7800x3d_box_pk0sdo.webp', true),
(1, 'https://res.cloudinary.com/dttbykl0c/image/upload/v1779916979/ryzen-7-7800x3d_gacyx0.webp', false),
(2, 'https://res.cloudinary.com/dttbykl0c/image/upload/v1779916980/ryzen-9-9950x_box_o8ycvc.webp', true),
(2, 'https://res.cloudinary.com/dttbykl0c/image/upload/v1779916979/ryzen-9-9950x_qlewsu.webp', false),
(3, 'https://res.cloudinary.com/dttbykl0c/image/upload/v1779916979/ryzen-5-8600g_box_dvqnsg.webp', true),
(3, 'https://res.cloudinary.com/dttbykl0c/image/upload/v1779916978/ryzen-5-8600g_dk7lfv.webp', false),
(4, 'https://res.cloudinary.com/dttbykl0c/image/upload/v1779916979/ryzen-7-7800x3d_box_pk0sdo.webp', true),
(4, 'https://res.cloudinary.com/dttbykl0c/image/upload/v1779916979/ryzen-7-7800x3d_gacyx0.webp', false),
(5, 'https://res.cloudinary.com/dttbykl0c/image/upload/v1779916980/ryzen-9-9950x_box_o8ycvc.webp', true),
(5, 'https://res.cloudinary.com/dttbykl0c/image/upload/v1779916979/ryzen-9-9950x_qlewsu.webp', false),
(6, 'https://res.cloudinary.com/dttbykl0c/image/upload/v1779916979/ryzen-5-8600g_box_dvqnsg.webp', true),
(6, 'https://res.cloudinary.com/dttbykl0c/image/upload/v1779916978/ryzen-5-8600g_dk7lfv.webp', false),
(7, 'https://res.cloudinary.com/dttbykl0c/image/upload/v1779916979/ryzen-7-7800x3d_box_pk0sdo.webp', true),
(7, 'https://res.cloudinary.com/dttbykl0c/image/upload/v1779916979/ryzen-7-7800x3d_gacyx0.webp', false),
(8, 'https://res.cloudinary.com/dttbykl0c/image/upload/v1779916980/ryzen-9-9950x_box_o8ycvc.webp', true),
(8, 'https://res.cloudinary.com/dttbykl0c/image/upload/v1779916979/ryzen-9-9950x_qlewsu.webp', false),
(9, 'https://res.cloudinary.com/dttbykl0c/image/upload/v1779916979/ryzen-5-8600g_box_dvqnsg.webp', true),
(9, 'https://res.cloudinary.com/dttbykl0c/image/upload/v1779916978/ryzen-5-8600g_dk7lfv.webp', false);

select * from product_images;


