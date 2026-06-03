USE Kainfo;

INSERT INTO products (name, description, price, stock, sku, category_id, brand_id, specifications) VALUES 
-- PROCESADORES AMD (Brand_id: 3)
(
    'AMD Ryzen 7 7800X3D', 
    'El rey indiscutible del gaming. Cuenta con la tecnología AMD 3D V-Cache de segunda generación para ofrecer tasas de frames masivas y estables.', 
    360.65, 
    8, 
    'CPUAMD-001', 
    11, 
    3, 
    '{"socket": "AM5", "gen": "Ryzen 7000", "modelo": "Ryzen 7", "núcleos": 8, "hilos": 16, "gpu_integrada": true}'
),
(
    'AMD Ryzen 5 7600', 
    'Excelente procesador de entrada a la plataforma AM5. Rendimiento eficiente, bajo consumo y disipador Wraith Stealth incluido.', 
    199.00, 
    22, 
    'CPUAMD-002', 
    11, 
    3, 
    '{"socket": "AM5", "gen": "Ryzen 7000", "modelo": "Ryzen 5", "núcleos": 6, "hilos": 12, "gpu_integrada": true}'
),
(
    'AMD Ryzen 9 7950X', 
    'Bestia de rendimiento multitarea diseñada para creadores de contenido, renderizado 3D complejo y entornos de desarrollo exigentes.', 
    515.50, 
    6, 
    'CPUAMD-003', 
    11, 
    3, 
    '{"socket": "AM5", "gen": "Ryzen 7000", "modelo": "Ryzen 9", "núcleos": 16, "hilos": 32, "gpu_integrada": true}'
),
(
    'AMD Ryzen 5 5600X', 
    'El clásico de la plataforma AM4 que sigue ofreciendo una relación rendimiento-precio insuperable para presupuestos ajustados.', 
    129.99, 
    35, 
    'CPUAMD-004', 
    11, 
    3, 
    '{"socket": "AM4", "gen": "Ryzen 5000", "modelo": "Ryzen 5", "núcleos": 6, "hilos": 12, "gpu_integrada": false}'
),
(
    'AMD Ryzen 7 5700X3D', 
    'La actualización definitiva para exprimir la plataforma AM4. Añade memoria caché vertical para revivir tu setup gaming sin cambiar de placa base.', 
    204.50, 
    14, 
    'CPUAMD-005', 
    11, 
    3, 
    '{"socket": "AM4", "gen": "Ryzen 5000", "modelo": "Ryzen 7", "núcleos": 8, "hilos": 16, "gpu_integrada": false}'
),
(
    'AMD Ryzen 9 9950X', 
    'Arquitectura Zen 5 de última generación. Ofrece el máximo rendimiento absoluto en computación de escritorio y tareas de inteligencia artificial local.', 
    649.00, 
    5, 
    'CPUAMD-006', 
    11, 
    3, 
    '{"socket": "AM5", "gen": "Ryzen 9000", "modelo": "Ryzen 9", "núcleos": 16, "hilos": 32, "gpu_integrada": true}'
),
(
    'AMD Ryzen 7 9700X', 
    'Eficiencia energética revolucionaria basada en Zen 5. Gran rendimiento mononúcleo con un TDP sorprendentemente bajo.', 
    379.00, 
    11, 
    'CPUAMD-007', 
    11, 
    3, 
    '{"socket": "AM5", "gen": "Ryzen 9000", "modelo": "Ryzen 7", "núcleos": 8, "hilos": 16, "gpu_integrada": true}'
),
(
    'AMD Ryzen 5 8600G', 
    'Procesador con los gráficos integrados Radeon 760M más potentes del mercado, ideal para jugar a títulos competitivos sin tarjeta gráfica dedicada.', 
    229.00, 
    16, 
    'CPUAMD-008', 
    11, 
    3, 
    '{"socket": "AM5", "gen": "Ryzen 8000", "modelo": "Ryzen 5", "núcleos": 6, "hilos": 12, "gpu_integrada": true, "modelo_gpu": "Radeon 760M"}'
),
(
    'AMD Ryzen 9 7900X3D', 
    'El equilibrio perfecto para quienes necesitan potencia bruta de cálculo con sus 12 núcleos y el empuje gaming de la tecnología 3D V-Cache.', 
    439.99, 
    9, 
    'CPUAMD-009', 
    11, 
    3, 
    '{"socket": "AM5", "gen": "Ryzen 7000", "modelo": "Ryzen 9", "núcleos": 12, "hilos": 24, "gpu_integrada": true}'
),

-- PROCESADORES INTEL (Brand_id: 23)
(
    'Intel Core i9-14900K', 
    'Frecuencias de fábrica descomunales que alcanzan los 6.0 GHz. Arquitectura híbrida optimizada para el streaming y el gaming profesional.', 
    549.99, 
    12, 
    'CPUINTEL-001', 
    11, 
    23, 
    '{"socket": "LGA1700", "gen": "14a Gen", "modelo": "Core i9", "núcleos": 24, "p_cores": 8, "e_cores": 16, "gpu_integrada": true}'
),
(
    'Intel Core i7-14700K', 
    'El procesador más equilibrado de la 14ª generación gracias al incremento de núcleos eficientes respecto a su predecesor.', 
    389.00, 
    18, 
    'CPUINTEL-002', 
    11, 
    23, 
    '{"socket": "LGA1700", "gen": "14a Gen", "modelo": "Core i7", "núcleos": 20, "p_cores": 8, "e_cores": 12, "gpu_integrada": true}'
),
(
    'Intel Core i5-14600K', 
    'La opción predilecta para la gama media de entusiastas. Gran capacidad de overclocking y rendimiento sobresaliente en cualquier juego.', 
    299.95, 
    20, 
    'CPUINTEL-003', 
    11, 
    23, 
    '{"socket": "LGA1700", "gen": "14a Gen", "modelo": "Core i5", "núcleos": 14, "p_cores": 6, "e_cores": 8, "gpu_integrada": true}'
),
(
    'Intel Core i5-12400F', 
    'Sin gráficos integrados para abaratar costes. Es el rey de la economía, ofreciendo 6 núcleos de puro rendimiento gaming.', 
    115.00, 
    40, 
    'CPUINTEL-004', 
    11, 
    23, 
    '{"socket": "LGA1700", "gen": "12a Gen", "modelo": "Core i5", "núcleos": 6, "p_cores": 6, "e_cores": 0, "gpu_integrada": false}'
),
(
    'Intel Core i7-13700K', 
    'Procesador de la 13ª generación que sigue plantando cara a lo más moderno gracias a su excelente rendimiento mononúcleo.', 
    339.00, 
    15, 
    'CPUINTEL-005', 
    11, 
    23, 
    '{"socket": "LGA1700", "gen": "13a Gen", "modelo": "Core i7", "núcleos": 16, "p_cores": 8, "e_cores": 8, "gpu_integrada": true}'
),
(
    'Intel Core Ultra 9 285K', 
    'Nueva arquitectura Arrow Lake con un enfoque radical en la eficiencia térmica y rendimiento masivo por vatio, estrenando socket.', 
    589.00, 
    4, 
    'CPUINTEL-006', 
    11, 
    23, 
    '{"socket": "LGA1851", "gen": "Core Ultra Ser 2", "modelo": "Core Ultra 9", "núcleos": 24, "npu_ia": true, "gpu_integrada": true}'
),
(
    'Intel Core Ultra 7 265K', 
    'Excelente procesador de gama alta para la nueva plataforma LGA1851, equipado con unidad de procesamiento neuronal (NPU) para IA.', 
    399.00, 
    8, 
    'CPUINTEL-007', 
    11, 
    23, 
    '{"socket": "LGA1851", "gen": "Core Ultra Ser 2", "modelo": "Core Ultra 7", "núcleos": 20, "npu_ia": true, "gpu_integrada": true}'
),
(
    'Intel Core i3-14100', 
    'Procesador de entrada ideal para equipos de oficina avanzados, puntos de venta o servidores multimedia domésticos de bajo consumo.', 
    119.00, 
    25, 
    'CPUINTEL-008', 
    11, 
    23, 
    '{"socket": "LGA1700", "gen": "14a Gen", "modelo": "Core i3", "núcleos": 4, "p_cores": 4, "e_cores": 0, "gpu_integrada": true}'
),
(
    'Intel Core i9-13900KS', 
    'Edición especial limitada y seleccionada de fábrica para romper récords de velocidad de reloj directamente al salir de la caja.', 
    610.00, 
    2, 
    'CPUINTEL-009', 
    11, 
    23, 
    '{"socket": "LGA1700", "gen": "13a Gen", "modelo": "Core i9", "núcleos": 24, "p_cores": 8, "e_cores": 16, "gpu_integrada": true}'
);

INSERT INTO products (name, description, price, stock, sku, category_id, brand_id, specifications) VALUES 
-- PLACAS BASE MSI (Brand_id: 31)
(
    'MSI B850M GAMING PLUS WIFI', 
    'Diseñada para ofrecer una amplia conectividad, herramientas versátiles y una solución Wi-Fi premium para los jugadores que buscan una experiencia completa.', 
    190.46, 
    3, 
    'MOBOMSI-001', 
    12, 
    31, 
    '{"socket": "AM5", "chipset": "B850", "factor_forma": "Micro ATX", "wifi": "7", "lan": "5"}'
),
(
    'MSI MAG Z890 TOMAHAWK WIFI', 
    'Placa base de gama alta lista para los procesadores Intel Core Ultra, con un diseño térmico optimizado y ranuras PCIe 5.0 ultrarrápidas.', 
    319.99, 
    7, 
    'MOBOMSI-002', 
    12, 
    31, 
    '{"socket": "LGA1851", "chipset": "Z890", "factor_forma": "ATX", "wifi": "7", "lan": "2.5"}'
),
(
    'MSI PRO B760M-P DDR4', 
    'La solución ideal para configuraciones profesionales y de oficina económicas, combinando estabilidad corporativa y memorias DDR4 maduras.', 
    99.95, 
    20, 
    'MOBOMSI-003', 
    12, 
    31, 
    '{"socket": "LGA1700", "chipset": "B760", "factor_forma": "Micro ATX", "wifi": "No", "lan": "1"}'
),
(
    'MSI MPG X870E CARBON WIFI', 
    'Estética oscura premium con iluminación RGB integrada y la máxima entrega de energía para overclocking extremo en procesadores AMD Ryzen.', 
    449.00, 
    4, 
    'MOBOMSI-004', 
    12, 
    31, 
    '{"socket": "AM5", "chipset": "X870E", "factor_forma": "ATX", "wifi": "7", "lan": "5"}'
),

-- PLACAS BASE ASUS (Brand_id: 8)
(
    'ASUS ROG STRIX X870-A GAMING WIFI', 
    'Llamativa estética con disipadores plateados y blancos, ideal para builds de temática clara, armada con tecnologías exclusivas de IA.', 
    379.99, 
    6, 
    'MOBOASUS-001', 
    12, 
    8, 
    '{"socket": "AM5", "chipset": "X870", "factor_forma": "ATX", "wifi": "7", "lan": "2.5"}'
),
(
    'ASUS TUF GAMING B760-PLUS WIFI', 
    'Toma todos los elementos esenciales de los últimos procesadores de Intel y los combina con características listas para jugar y una durabilidad probada.', 
    165.50, 
    12, 
    'MOBOASUS-002', 
    12, 
    8, 
    '{"socket": "LGA1700", "chipset": "B760", "factor_forma": "ATX", "wifi": "6E", "lan": "2.5"}'
),
(
    'ASUS PRIME B650M-A II', 
    'Placa base comercial de formato compacto, diseñada con controles de energía robustos y conectividad flexible para el día a día.', 
    115.00, 
    18, 
    'MOBOASUS-003', 
    12, 
    8, 
    '{"socket": "AM5", "chipset": "B650", "factor_forma": "Micro ATX", "wifi": "No", "lan": "2.5"}'
),
(
    'ASUS ROG MAXIMUS Z890 HERO', 
    'Una obra de arte de la ingeniería de hardware. Ofrece un rendimiento devastador, refrigeración masiva y conectividad de vanguardia absoluta.', 
    649.00, 
    2, 
    'MOBOASUS-004', 
    12, 
    8, 
    '{"socket": "LGA1851", "chipset": "Z890", "factor_forma": "ATX", "wifi": "7", "lan": "5"}'
),

-- PLACAS BASE GIGABYTE (Brand_id: 20)
(
    'Gigabyte B650 GAMING X AX', 
    'Excelente propuesta calidad-precio para dar el salto a la memoria DDR5 y exprimir los procesadores Ryzen con Wi-Fi integrado de alta velocidad.', 
    179.99, 
    14, 
    'MOBOGIGABYTE-001', 
    12, 
    20, 
    '{"socket": "AM5", "chipset": "B650", "factor_forma": "ATX", "wifi": "6E", "lan": "2.5"}'
),
(
    'Gigabyte Z790 AORUS ELITE AX', 
    'Con una entrega de energía digital directa y disipadores térmicos de cobertura total, tu sistema se mantendrá fresco y estable bajo carga extrema.', 
    249.00, 
    9, 
    'MOBOGIGABYTE-002', 
    12, 
    20, 
    '{"socket": "LGA1700", "chipset": "Z790", "factor_forma": "ATX", "wifi": "6E", "lan": "2.5"}'
),
(
    'Gigabyte X870 AORUS ELITE AX ICE', 
    'Edición totalmente blanca (ICE) optimizada para la última arquitectura de AMD, con conectores de liberación rápida para M.2 y gráficas.', 
    299.95, 
    5, 
    'MOBOGIGABYTE-003', 
    12, 
    20, 
    '{"socket": "AM5", "chipset": "X870", "factor_forma": "ATX", "wifi": "7", "lan": "2.5"}'
),
(
    'Gigabyte B860M AORUS ELITE AX', 
    'El factor de forma compacto se une a las prestaciones premium en esta placa base perfecta para equipos potentes pero contenidos en tamaño.', 
    159.00, 
    11, 
    'MOBOGIGABYTE-004', 
    12, 
    20, 
    '{"socket": "LGA1851", "chipset": "B860", "factor_forma": "Micro ATX", "wifi": "6E", "lan": "2.5"}'
),

-- PLACAS BASE ASROCK (Brand_id: 7)
(
    'ASRock B650M Pro RS', 
    'Estética limpia y futurista con un sólido rendimiento en sus fases de alimentación, ideal para PCs de salón o escritorios modernos.', 
    134.99, 
    15, 
    'MOBOASROCK-001', 
    12, 
    7, 
    '{"socket": "AM5", "chipset": "B650", "factor_forma": "Micro ATX", "wifi": "No", "lan": "2.5"}'
),
(
    'ASRock Z890 Taichi', 
    'El buque insignia de ASRock con su icónico diseño de engranajes metálicos, disipación activa y los componentes electrónicos más longevos del mercado.', 
    499.00, 
    3, 
    'MOBOASROCK-002', 
    12, 
    7, 
    '{"socket": "LGA1851", "chipset": "Z890", "factor_forma": "ATX", "wifi": "7", "lan": "5"}'
),
(
    'ASRock B550M Pro4', 
    'La vieja confiable para presupuestos ajustados que buscan armar un PC equilibrado con procesadores de sockets anteriores pero muy vigentes.', 
    94.50, 
    22, 
    'MOBOASROCK-003', 
    12, 
    7, 
    '{"socket": "AM4", "chipset": "B550", "factor_forma": "Micro ATX", "wifi": "No", "lan": "1"}'
),
(
    'ASRock X870 Pro RS WIFI', 
    'Excelente balance de conexiones de nueva hornada que incluye USB4 de alta velocidad y soporte impecable para almacenamiento PCIe Gen5.', 
    219.00, 
    8, 
    'MOBOASROCK-004', 
    12, 
    7, 
    '{"socket": "AM5", "chipset": "X870", "factor_forma": "ATX", "wifi": "7", "lan": "2.5"}'
),

-- PLACAS BASE BIOSTAR (Brand_id: 11)
(
    'Biostar B650MT', 
    'Placa base de gama de entrada ultra-minimalista, orientada a setups funcionales que buscan la máxima economía sin sacrificar la plataforma actual.', 
    85.00, 
    25, 
    'MOBOBIOSTAR-001', 
    12, 
    11, 
    '{"socket": "AM5", "chipset": "B650", "factor_forma": "Micro ATX", "wifi": "No", "lan": "1"}'
),
(
    'Biostar VALKYRIE Z890', 
    'La serie premium Valkyrie despliega su armadura completa para proteger las líneas de datos de los nuevos procesadores de alta gama.', 
    259.90, 
    5, 
    'MOBOBIOSTAR-002', 
    12, 
    11, 
    '{"socket": "LGA1851", "chipset": "Z890", "factor_forma": "ATX", "wifi": "7", "lan": "2.5"}'
);

INSERT INTO products (name, description, price, stock, sku, category_id, brand_id, specifications) VALUES 
-- TARJETAS GRÁFICAS NVIDIA (Series 40 y 50)
(
    'PNY GeForce RTX 5080 VERTO OC', 
    'Prepárate para vivir experiencias revolucionarias con la NVIDIA GeForce RTX™ 5080 y la tecnología DLSS 4 basada en IA. Diseñada con la arquitectura NVIDIA® Blackwell y equipada con una memoria GDDR7 ultrarrápida, te permite ejecutar los juegos y las aplicaciones creativas más exigentes a nivel gráfico.', 
    1400.37, 
    10, 
    'GPUPNY-001', 
    13, 
    36, 
    '{"ensamblador": "NVIDIA", "serie": "RTX serie 50", "modelo": "RTX 5080", "memoria": 16, "num_ventiladores": 3}'
),
(
    'ASUS ROG Strix GeForce RTX 5090', 
    'El coloso absoluto del rendimiento gráfico. Disipador masivo de triple ranura, componentes de grado militar y una cantidad ingente de memoria de vídeo de nueva generación para resoluciones superiores a 4K.', 
    2299.99, 
    3, 
    'GPUASUS-001', 
    13, 
    8, 
    '{"ensamblador": "NVIDIA", "serie": "RTX serie 50", "modelo": "RTX 5090", "memoria": 32, "num_ventiladores": 3}'
),
(
    'MSI GeForce RTX 5070 Gaming X Slim', 
    'Rendimiento sobresaliente con trazado de rayos de última generación y DLSS 4. Su formato Slim optimiza el espacio interior de la torre sin penalizar las frecuencias ni las temperaturas bajo carga.', 
    699.99, 
    8, 
    'GPUMSI-001', 
    13, 
    31, 
    '{"ensamblador": "NVIDIA", "serie": "RTX serie 50", "modelo": "RTX 5070", "memoria": 12, "num_ventiladores": 3}'
),
(
    'Zotac Gaming GeForce RTX 5060 Solo', 
    'La solución ideal para setups Mini-ITX. Diseño compacto de un solo ventilador que ofrece toda la potencia de la arquitectura Blackwell en un formato de bolsillo.', 
    399.99, 
    15, 
    'GPUZOTAC-001', 
    13, 
    49, 
    '{"ensamblador": "NVIDIA", "serie": "RTX serie 50", "modelo": "RTX 5060", "memoria": 8, "num_ventiladores": 1}'
),
(
    'Gigabyte GeForce RTX 4060 EAGLE OC', 
    'Excelente tarjeta gráfica para exprimir la resolución Full HD a altas tasas de refresco con un consumo energético bajísimo y refrigeración Windforce.', 
    325.50, 
    22, 
    'GPUGIGABYTE-001', 
    13, 
    20, 
    '{"ensamblador": "NVIDIA", "serie": "RTX serie 40", "modelo": "RTX 4060", "memoria": 8, "num_ventiladores": 3}'
),
(
    'Zotac Gaming GeForce RTX 4070 SUPER Twin Edge', 
    'Actualización masiva de rendimiento con la serie Super. Factor de forma optimizado de doble ventilador ideal para cajas medianas y gaming a 1440p fluido.', 
    619.00, 
    11, 
    'GPUZOTAC-002', 
    13, 
    49, 
    '{"ensamblador": "NVIDIA", "serie": "RTX serie 40", "modelo": "RTX 4070 SUPER", "memoria": 12, "num_ventiladores": 2}'
),
(
    'ASUS TUF Gaming GeForce RTX 4080 SUPER', 
    'Armadura metálica de alta resistencia que protege una bestia del renderizado. Su gran flujo de aire garantiza horas de juego silencioso en calidad Ultra.', 
    1049.50, 
    6, 
    'GPUASUS-002', 
    13, 
    8, 
    '{"ensamblador": "NVIDIA", "serie": "RTX serie 40", "modelo": "RTX 4080 SUPER", "memoria": 16, "num_ventiladores": 3}'
),
(
    'MSI GeForce RTX 4060 Ti VENTUS 3X OC', 
    'Equipada con tres ventiladores Torx Fan para un rendimiento térmico impecable y un buffer expandido de memoria ideal para cargas de trabajo creativas.', 
    469.99, 
    14, 
    'GPUMSI-002', 
    13, 
    31, 
    '{"ensamblador": "NVIDIA", "serie": "RTX serie 40", "modelo": "RTX 4060 Ti", "memoria": 16, "num_ventiladores": 3}'
),
(
    'PNY GeForce RTX 4070 Ti SUPER XLR8', 
    'Iluminación RGB espectacular integrada en un sistema de disipación de triple ranura. Brinda la velocidad ideal para pantallas competitivas.', 
    859.90, 
    5, 
    'GPUPNY-002', 
    13, 
    36, 
    '{"ensamblador": "NVIDIA", "serie": "RTX serie 40", "modelo": "RTX 4070 Ti SUPER", "memoria": 16, "num_ventiladores": 3}'
),
(
    'Gigabyte GeForce RTX 3050 EAGLE', 
    'Entrada económica al ecosistema de NVIDIA con núcleos Tensor para disfrutar de DLSS en configuraciones de presupuestos muy ajustados.', 
    189.00, 
    30, 
    'GPUGIGABYTE-002', 
    13, 
    20, 
    '{"ensamblador": "NVIDIA", "serie": "RTX serie 30", "modelo": "RTX 3050", "memoria": 6, "num_ventiladores": 2}'
),

-- TARJETAS GRÁFICAS AMD (Series 6000 y 7000)
(
    'Sapphire NITRO+ AMD Radeon RX 7800 XT', 
    'Una de las mejores implementaciones de la arquitectura RDNA 3. Ofrece una robusta placa trasera de aluminio, iluminación ARGB y un rendimiento brutal en rasterización.', 
    549.00, 
    12, 
    'GPUSAPPHIRE-001', 
    13, 
    41, 
    '{"ensamblador": "AMD", "serie": "RX serie 7000", "modelo": "RX 7800 XT", "memoria": 16, "num_ventiladores": 3}'
),
(
    'XFX Speedster MERC 310 Radeon RX 7900 XTX', 
    'El buque insignia de AMD llevado al límite por XFX. Dispone de un enorme ecosistema de disipación y 24 GB de memoria VRAM para ignorar por completo las texturas pesadas.', 
    949.99, 
    4, 
    'GPUXFX-001', 
    13, 
    48, 
    '{"ensamblador": "AMD", "serie": "RX serie 7000", "modelo": "RX 7900 XTX", "memoria": 24, "num_ventiladores": 3}'
),
(
    'PowerColor Hellhound AMD Radeon RX 7600 XT', 
    'Gráfica muy versátil que duplica la memoria de vídeo estándar del segmento medio para asegurar una longevidad excelente en los próximos años de lanzamientos.', 
    349.99, 
    16, 
    'GPUPOWERCOLOR-001', 
    13, 
    37, 
    '{"ensamblador": "AMD", "serie": "RX serie 7000", "modelo": "RX 7600 XT", "memoria": 16, "num_ventiladores": 2}'
),
(
    'ASRock Radeon RX 7700 XT Challenger', 
    'Solución compacta de doble ventilador que ofrece un gran rendimiento por euro invertido para exprimir juegos modernos a resolución 2K con altas tasas de refresco.', 
    429.00, 
    9, 
    'GPUASROCK-001', 
    13, 
    7, 
    '{"ensamblador": "AMD", "serie": "RX serie 7000", "modelo": "RX 7700 XT", "memoria": 12, "num_ventiladores": 2}'
),
(
    'XFX Speedster MERC 310 Radeon RX 7900 XT', 
    'Su gran ancho de banda de memoria y su arquitectura eficiente hacen de este modelo una opción de gama alta perfecta para simulación y realidad virtual.', 
    769.00, 
    7, 
    'GPUXFX-002', 
    13, 
    48, 
    '{"ensamblador": "AMD", "serie": "RX serie 7000", "modelo": "RX 7900 XT", "memoria": 20, "num_ventiladores": 3}'
),
(
    'PowerColor Red Devil AMD Radeon RX 7800 XT', 
    'La joya de la corona de PowerColor. Fases de alimentación premium reforzadas ideales para overclocking manual estable y la estética demoníaca icónica de la marca.', 
    569.00, 
    5, 
    'GPUPOWERCOLOR-002', 
    13, 
    37, 
    '{"ensamblador": "AMD", "serie": "RX serie 7000", "modelo": "RX 7800 XT", "memoria": 16, "num_ventiladores": 3}'
),
(
    'Sapphire PULSE AMD Radeon RX 6600', 
    'La reina indiscutible de la gama de entrada económica. Rendimiento silencioso y fluido en 1080p con un consumo de energía extremadamente comedido.', 
    215.00, 
    25, 
    'GPUSAPPHIRE-002', 
    13, 
    41, 
    '{"ensamblador": "AMD", "serie": "RX serie 6000", "modelo": "RX 6600", "memoria": 8, "num_ventiladores": 2}'
),
(
    'ASRock AMD Radeon RX 7900 GRE Steel Legend', 
    'Edición especial Steel Legend con un acabado blanco níveo de alta fidelidad estética y ventiladores con iluminación LED RGB sincronizable.', 
    599.00, 
    8, 
    'GPUASROCK-002', 
    13, 
    7, 
    '{"ensamblador": "AMD", "serie": "RX serie 7000", "modelo": "RX 7900 GRE", "memoria": 16, "num_ventiladores": 3}'
);

INSERT INTO products (name, description, price, stock, sku, category_id, brand_id, specifications) VALUES 
-- MEMORIAS RAM CORSAIR (Brand_id: 14)
(
    'Corsair Vengeance DDR5', 
    'En la era de los múltiples núcleos, la velocidad sin precedentes de la DDR5 garantiza que su CPU de alta gama pueda recibir datos rápidamente y con facilidad. Ya sea para jugar, crear contenido, abrir 100 pestañas o realizar múltiples tareas a la vez, su PC para juegos sacará adelante las tareas complejas más rápido que nunca.', 
    212.76, 
    30, 
    'RAMCORSAIR-001', 
    14, 
    14, 
    '{"familia": "DDR5", "formato": "DIMM", "cantidad": 16, "kits": "2 x 8", "velocidad": 5200, "latencia": "CL34"}'
),
(
    'Corsair Vengeance RGB DDR5', 
    'Rendimiento DDR5 optimizado para placas base Intel con una iluminación RGB dinámica de diez zonas totalmente personalizable y controlable mediante el software iCUE.', 
    129.99, 
    15, 
    'RAMCORSAIR-002', 
    14, 
    14, 
    '{"familia": "DDR5", "formato": "DIMM", "cantidad": 32, "kits": "2 x 16", "velocidad": 6000, "latencia": "CL30"}'
),
(
    'Corsair Vengeance LPX DDR4', 
    'Diseñada para overclocking de alto rendimiento. El disipador de aluminio puro permite una disipación térmica más rápida; el circuito impreso de ocho capas administra el calor.', 
    45.50, 
    40, 
    'RAMCORSAIR-003', 
    14, 
    14, 
    '{"familia": "DDR4", "formato": "DIMM", "cantidad": 16, "kits": "2 x 8", "velocidad": 3200, "latencia": "CL16"}'
),

-- MEMORIAS RAM KINGSTON (Brand_id: 24)
(
    'Kingston FURY Beast DDR5', 
    'Aporta la tecnología más avanzada para las plataformas de juego de nueva generación. Llevando la velocidad, la capacidad y la fiabilidad aún más lejos.', 
    108.90, 
    25, 
    'RAMKINGSTON-001', 
    14, 
    24, 
    '{"familia": "DDR5", "formato": "DIMM", "cantidad": 32, "kits": "2 x 16", "velocidad": 5600, "latencia": "CL40"}'
),
(
    'Kingston FURY Renegade DDR5 RGB', 
    'Diseñada para un rendimiento extremo en plataformas de última generación. Cuenta con un disipador de aluminio negro y plata y una barra de luz LED fluida.', 
    154.00, 
    12, 
    'RAMKINGSTON-002', 
    14, 
    24, 
    '{"familia": "DDR5", "formato": "DIMM", "cantidad": 32, "kits": "2 x 16", "velocidad": 6400, "latencia": "CL32"}'
),
(
    'Kingston FURY Beast DDR4 RGB', 
    'Una actualización potente y con estilo para sistemas basados en Intel o AMD que busquen un empuje de rendimiento y una estética gaming clásica.', 
    52.00, 
    35, 
    'RAMKINGSTON-003', 
    14, 
    24, 
    '{"familia": "DDR4", "formato": "DIMM", "cantidad": 16, "kits": "2 x 8", "velocidad": 3600, "latencia": "CL18"}'
),

-- MEMORIAS RAM G.SKILL (Brand_id: 19)
(
    'G.Skill Trident Z5 Neo RGB DDR5', 
    'Creada para procesadores AMD Ryzen con soporte para perfiles AMD EXPO. Ofrece un diseño de disipador elegante inspirado en los coches deportivos.', 
    139.50, 
    18, 
    'RAMG.SKILL-001', 
    14, 
    19, 
    '{"familia": "DDR5", "formato": "DIMM", "cantidad": 32, "kits": "2 x 16", "velocidad": 6000, "latencia": "CL30"}'
),
(
    'G.Skill Ripjaws S5 DDR5', 
    'Memoria de perfil bajo ideal para sistemas compactos o disipadores de CPU de gran tamaño, sin renunciar a las altas frecuencias estables.', 
    112.00, 
    20, 
    'RAMG.SKILL-002', 
    14, 
    19, 
    '{"familia": "DDR5", "formato": "DIMM", "cantidad": 32, "kits": "2 x 16", "velocidad": 5600, "latencia": "CL36"}'
),
(
    'G.Skill Trident Z RGB DDR4', 
    'Con una barra de luz completamente expuesta con LEDs RGB vibrantes, combinada con el galardonado disipador de calor Trident Z.', 
    89.00, 14, 
    'RAMG.SKILL-003', 
    14, 
    19, 
    '{"familia": "DDR4", "formato": "DIMM", "cantidad": 32, "kits": "2 x 16", "velocidad": 3200, "latencia": "CL16"}'
),

-- MEMORIAS RAM CRUCIAL (Brand_id: 15)
(
    'Crucial Pro DDR5', 
    'Diseño sobrio sin luces diseñado para profesionales y entusiastas que buscan estabilidad absoluta las 24 horas y soporte para perfiles Intel XMP 3.0.', 
    95.99, 
    22, 
    'RAMCRUCIAL-001', 
    14, 
    15, 
    '{"familia": "DDR5", "formato": "DIMM", "cantidad": 32, "kits": "2 x 16", "velocidad": 5600, "latencia": "CL46"}'
),
(
    'Crucial Classic Desktop DDR5', 
    'Módulo de memoria sin disipador, directo y funcional. Perfecto para integradores de sistemas OEM y ordenadores de oficina de alto rendimiento.', 
    49.00, 
    50, 
    'RAMCRUCIAL-002', 
    14, 
    15, 
    '{"familia": "DDR5", "formato": "DIMM", "cantidad": 16, "kits": "1 x 16", "velocidad": 4800, "latencia": "CL40"}'
),

-- MEMORIAS RAM TEAM GROUP (Brand_id: 44)
(
    'Team Group T-Force Delta RGB DDR5', 
    'Inspirada en un avión furtivo, presenta una iluminación de ángulo ultra amplio de 120° y compatibilidad con los principales softwares de placas base.', 
    124.50, 
    16, 
    'RAMTEAM GROUP-001', 
    14, 
    44, 
    '{"familia": "DDR5", "formato": "DIMM", "cantidad": 32, "kits": "2 x 16", "velocidad": 6000, "latencia": "CL38"}'
),
(
    'Team Group T-Create Expert DDR5', 
    'Construida para creadores de contenido. Cuenta con una cubierta superior ventilada y un condensador personalizado resistente a altas temperaturas.', 
    119.00, 
    11, 
    'RAMTEAM GROUP-002', 
    14, 
    44, 
    '{"familia": "DDR5", "formato": "DIMM", "cantidad": 32, "kits": "2 x 16", "velocidad": 6000, "latencia": "CL30"}'
),

-- MEMORIAS RAM ADATA (Brand_id: 2)
(
    'ADATA XPG Lancer RGB DDR5', 
    'Establece el listón en cuanto a iluminación gaming con sutiles efectos geométricos y circuitos integrados de gestión de energía (PMIC) mejorados.', 
    135.00, 
    9, 
    'RAMADATA-001', 
    14, 
    2, 
    '{"familia": "DDR5", "formato": "DIMM", "cantidad": 32, "kits": "2 x 16", "velocidad": 6000, "latencia": "CL40"}'
),
(
    'ADATA XPG Spectrix D50 DDR4', 
    'Alcanza velocidades asombrosas bajo un disipador de metal macizo con un grosor de 1.95 mm que le otorga una construcción formidable.', 
    48.90, 
    28, 
    'RAMADATA-002', 
    14, 
    2, 
    '{"familia": "DDR4", "formato": "DIMM", "cantidad": 16, "kits": "2 x 8", "velocidad": 3200, "latencia": "CL16"}'
),

-- MEMORIAS RAM PATRIOT (Brand_id: 35)
(
    'Patriot Viper Venom DDR5', 
    'Ofrece la velocidad agresiva que necesitan los jugadores competitivos, respaldada por disipadores de protección térmica de calidad aeronáutica.', 
    128.00, 
    13, 
    'RAMPATRIOT-001', 
    14, 
    35, 
    '{"familia": "DDR5", "formato": "DIMM", "cantidad": 32, "kits": "2 x 16", "velocidad": 6400, "latencia": "CL32"}'
),
(
    'Patriot Viper Steel DDR4', 
    'Diseñada para las plataformas Intel y AMD más recientes, la serie Viper Steel proporciona el mejor rendimiento y estabilidad en entornos exigentes.', 
    42.00, 
    30, 
    'RAMPATRIOT-002', 
    14, 
    35, 
    '{"familia": "DDR4", "formato": "DIMM", "cantidad": 16, "kits": "2 x 8", "velocidad": 3600, "latencia": "CL18"}'
),
(
    'Patriot Viper Elite II DDR4', 
    'Desarrollada con mejoras radicales en sus perfiles térmicos para brindar un rendimiento óptimo sin estrangulamiento bajo cargas multitarea intensas.', 
    76.50, 
    15, 
    'RAMPATRIOT-003', 
    14, 
    35, 
    '{"familia": "DDR4", "formato": "DIMM", "cantidad": 32, "kits": "2 x 16", "velocidad": 3200, "latencia": "CL18"}'
);

INSERT INTO products (name, description, price, stock, sku, category_id, brand_id, specifications) VALUES 
-- DISCOS KINGSTON (Brand_id: 24)
(
    'SSD Kingston SSDNow A400', 
    'La unidad de estado sólido A400 de Kingston es diez veces más rápida que un disco duro estándar, con tiempos de arranque, carga y transferencia limpios. La duradera resistencia a impactos y vibraciones del A400 hace que sea perfecto para portátiles y otros ordenadores móviles.', 
    67.86, 
    40, 
    'DISKINGSTON-001', 
    15, 
    24, 
    '{"formato": "SSD Sata", "tamaño": "2.5", "capacidad": 1}'
),
(
    'Kingston NV2 NVMe PCIe 4.0 2TB', 
    'Una solución de almacenamiento sustancial de última generación que ofrece velocidades de lectura/escritura de hasta 3500/2800 MB/s, optimizando el rendimiento general del sistema.', 
    115.00, 
    25, 
    'DISKINGSTON-002', 
    15, 
    24, 
    '{"formato": "SSD NVMe M.2", "tamaño": "M.2 2280", "capacidad": 2}'
),
(
    'Kingston KC3000 PCIe 4.0 1TB', 
    'Ofrece un rendimiento de nivel superior gracias al controlador NVMe Gen 4x4 más avanzado, alcanzando velocidades extremas de hasta 7000 MB/s para cargas de trabajo pesadas.', 
    92.00, 
    18, 
    'DISKINGSTON-003', 
    15, 
    24, 
    '{"formato": "SSD NVMe M.2", "tamaño": "M.2 2280", "capacidad": 1}'
),

-- DISCOS SAMSUNG (Brand_id: 39)
(
    'Samsung 990 PRO NVMe M.2 2TB', 
    'El SSD definitivo para entusiastas del rendimiento. Maximiza el ancho de banda de la interfaz PCIe 4.0 ofreciendo una eficiencia energética óptima y un control térmico inteligente.', 
    169.90, 
    15, 
    'DISSAMSUNG-001', 
    15, 
    39, 
    '{"formato": "SSD NVMe M.2", "tamaño": "M.2 2280", "capacidad": 2}'
),
(
    'Samsung 870 EVO SATA III 1TB', 
    'El estándar de oro de los SSD SATA. Logra el límite máximo de la interfaz de hasta 560 MB/s de lectura secuencial, ideal tanto para creadores de contenido como para uso diario.', 
    89.99, 
    30, 
    'DISSAMSUNG-002', 
    15, 
    39, 
    '{"formato": "SSD Sata", "tamaño": "2.5", "capacidad": 1}'
),

-- DISCOS CRUCIAL (Brand_id: 15)
(
    'Crucial BX500 SATA3 1TB', 
    'La forma más sencilla de conseguir la velocidad de un ordenador nuevo sin pagar su precio. Arranca más rápido, carga archivos en segundos y mejora la respuesta general del sistema.', 
    64.00, 
    35, 
    'DISCRUCIAL-001', 
    15, 
    15, 
    '{"formato": "SSD Sata", "tamaño": "2.5", "capacidad": 1}'
),
(
    'Crucial T500 PCIe 4.0 NVMe 2TB', 
    'Alimenta tu sistema con un rendimiento impecable. Este disco optimiza la carga de juegos de nueva generación y acelera las aplicaciones de edición de vídeo intensiva.', 
    145.00, 
    12, 
    'DISCRUCIAL-002', 
    15, 
    15, 
    '{"formato": "SSD NVMe M.2", "tamaño": "M.2 2280", "capacidad": 2}'
),

-- DISCOS WESTERN DIGITAL (Brand_id: 47)
(
    'WD Black SN850X NVMe 2TB', 
    'Destroza los tiempos de carga de tus videojuegos favoritos. Este disco para gaming incluye tecnologías de disipación avanzadas y un modo de juego dedicado para evitar tirones.', 
    159.00, 
    10, 
    'DISWESTERN DIGITAL-001', 
    15, 
    47, 
    '{"formato": "SSD NVMe M.2", "tamaño": "M.2 2280", "capacidad": 2}'
),
(
    'WD Blue SN580 NVMe 1TB', 
    'Estimula tu creatividad con una unidad de almacenamiento eficiente y fiable que utiliza la arquitectura PCIe Gen4 para mantener flujos de trabajo ágiles de manera constante.', 
    68.00, 
    22, 
    'DISWESTERN DIGITAL-002', 
    15, 
    47, 
    '{"formato": "SSD NVMe M.2", "tamaño": "M.2 2280", "capacidad": 1}'
),
(
    'WD Blue SA510 SATA 500GB', 
    'Dale una nueva vida a tu viejo PC de sobremesa. Su bajo consumo de energía prolonga la vida útil de los componentes y minimiza las vibraciones del chasis.', 
    42.50, 
    28, 
    'DISWESTERN DIGITAL-003', 
    15, 
    47, 
    '{"formato": "SSD Sata", "tamaño": "2.5", "capacidad": 0.5}'
),

-- DISCOS SEAGATE (Brand_id: 42)
(
    'Seagate BarraCuda 3.5 2TB', 
    'Disco duro mecánico clásico de alta fiabilidad. Una solución económica y robusta perfecta para almacenar copias de seguridad masivas, películas, música y documentos pesados.', 
    59.99, 
    20, 
    'DISSEAGATE-001', 
    15, 
    42, 
    '{"formato": "HDD Mecánico", "tamaño": "3.5", "capacidad": 2}'
),
(
    'Seagate IronWolf 3.5 4TB', 
    'Diseñado específicamente para entornos de almacenamiento en red (NAS). Soporta cargas de trabajo constantes las 24 horas del día gracias a su tecnología de equilibrio ágil.', 
    109.00, 
    8, 
    'DISSEAGATE-002', 
    15, 
    42, 
    '{"formato": "HDD Mecánico", "tamaño": "3.5", "capacidad": 4}'
),

-- DISCOS KIOXIA (Brand_id: 25)
(
    'Kioxia Exceria Plus G3 NVMe 1TB', 
    'Construido con la prestigiosa memoria BiCS FLASH 3D de Toshiba, este disco ofrece una excelente estabilidad de datos y una relación calidad-precio excepcional.', 
    62.50, 
    24, 
    'DISKIOXIA-001', 
    15, 
    25, 
    '{"formato": "SSD NVMe M.2", "tamaño": "M.2 2280", "capacidad": 1}'
),

-- DISCOS SANDISK (Brand_id: 40)
(
    'SanDisk SSD Plus SATA III 1TB', 
    'Al ser más silenciosa y generar menos calor que un disco duro tradicional, esta unidad SATA reduce la fatiga de los portátiles mejorando los tiempos de respuesta del sistema.', 
    65.00, 
    19, 
    'DISSANDISK-001', 
    15, 
    40, 
    '{"formato": "SSD Sata", "tamaño": "2.5", "capacidad": 1}'
),

-- DISCOS ADATA (Brand_id: 2)
(
    'ADATA Legend 800 PCIe 4.0 1TB', 
    'Soporta los últimos estándares de Intel y AMD. Su elegante disipador de aluminio anodizado reduce la temperatura de funcionamiento para mantener un rendimiento lineal.', 
    66.00, 
    15, 
    'DISADATA-001', 
    15, 
    2, 
    '{"formato": "SSD NVMe M.2", "tamaño": "M.2 2280", "capacidad": 1}'
),

-- DISCOS PNY (Brand_id: 36)
(
    'PNY CS900 SATA III 1TB', 
    'Una actualización excelente y muy rentable desde un disco mecánico (HDD) tradicional, ideal para acelerar el inicio de sistemas operativos antiguos.', 
    58.00, 
    33, 
    'DISPNY-001', 
    15, 
    36, 
    '{"formato": "SSD Sata", "tamaño": "2.5", "capacidad": 1}'
),
(
    'PNY XLR8 CS3140 NVMe 2TB', 
    'Diseñado para entusiastas del PC y gamers extremos que exigen el máximo rendimiento absoluto en disipación pasiva y transferencia pura de datos.', 
    175.00, 
    6, 
    'DISPNY-002', 
    15, 
    36, 
    '{"formato": "SSD NVMe M.2", "tamaño": "M.2 2280", "capacidad": 2}'
),
(
    'PNY CS2241 NVMe M.2 500GB', 
    'Unidad ideal de almacenamiento secundario o principal compacto para presupuestos medidos que buscan arrancar aplicaciones en milisegundos.', 
    38.90, 
    40, 
    'DISPNY-003', 
    15, 
    36, 
    '{"formato": "SSD NVMe M.2", "tamaño": "M.2 2280", "capacidad": 0.5}'
);

INSERT INTO products (name, description, price, stock, sku, category_id, brand_id, specifications) VALUES 
-- FUENTES DE ALIMENTACIÓN CORSAIR (Brand_id: 14)
(
    'Corsair RM750i', 
    'Las fuentes alimentación RMi Series™ ofrecen un control del voltaje extremadamente preciso, un funcionamiento prácticamente silencioso y un conjunto de cables totalmente modulares.', 
    80.76, 
    35, 
    'PSUCORSAIR-001', 
    16, 
    14, 
    '{"potencia": 750, "eficiencia": "80 Plus Gold", "modularidad": "Modular", "formato": "ATX"}'
),
(
    'Corsair RM850x Shift', 
    'Revolucionario diseño con panel de conectores lateral para un acceso ultracómodo y una gestión de cables impecable, compatible con ATX 3.0.', 
    159.90, 
    14, 
    'PSUCORSAIR-002', 
    16, 
    14, 
    '{"potencia": 850, "eficiencia": "80 Plus Gold", "modularidad": "Modular", "formato": "ATX"}'
),
(
    'Corsair CX650', 
    'Alimentación fiable de bajo ruido con certificación de eficiencia 80 Plus Bronze, ideal para sistemas de escritorio económicos y de consumo comedido.', 
    64.50, 
    25, 
    'PSUCORSAIR-003', 
    16, 
    14, 
    '{"potencia": 650, "eficiencia": "80 Plus Bronze", "modularidad": "No Modular", "formato": "ATX"}'
),

-- FUENTES DE ALIMENTACIÓN SEASONIC (Brand_id: 43)
(
    'Seasonic Focus GX-750', 
    'La serie FOCUS de Seasonic destaca por su tamaño compacto, estabilidad de voltajes envidiable y la legendaria durabilidad de sus componentes.', 
    115.50, 
    18, 
    'PSUSEASONIC-001', 
    16, 
    43, 
    '{"potencia": 750, "eficiencia": "80 Plus Gold", "modularidad": "Modular", "formato": "ATX"}'
),
(
    'Seasonic Prime TX-1000', 
    'El buque insignia de la marca. Ofrece niveles de eficiencia Titanium inigualables y una tolerancia de regulación de voltaje microajustada para setups extremos.', 
    299.00, 
    5, 
    'PSUSEASONIC-002', 
    16, 
    43, 
    '{"potencia": 1000, "eficiencia": "80 Plus Titanium", "modularidad": "Modular", "formato": "ATX"}'
),

-- FUENTES DE ALIMENTACIÓN BE QUIET! (Brand_id: 9)
(
    'be quiet! Pure Power 12 M 650W', 
    'Silencio excepcional combinado con prestaciones de gama alta. Totalmente compatible con tarjetas gráficas de nueva generación gracias al conector PCIe 5.0.', 
    94.90, 
    20, 
    'PSUBE QUIET!-001', 
    16, 
    9, 
    '{"potencia": 650, "eficiencia": "80 Plus Gold", "modularidad": "Modular", "formato": "ATX"}'
),
(
    'be quiet! Straight Power 12 850W', 
    'Eficiencia de nivel Platinum con cableado modular y un ventilador Silent Wings prácticamente inaudible que disipa el calor de forma óptima.', 
    169.00, 
    11, 
    'PSUBE QUIET!-002', 
    16, 
    9, 
    '{"potencia": 850, "eficiencia": "80 Plus Platinum", "modularidad": "Modular", "formato": "ATX"}'
),

-- FUENTES DE ALIMENTACIÓN MSI (Brand_id: 31)
(
    'MSI MAG A850GL PCIe5', 
    'Diseñada con un factor de forma compacto y el estándar ATX 3.0 para alimentar las GPU de la serie RTX 40 y 50 de forma segura mediante un cable nativo.', 
    124.99, 
    16, 
    'PSUMSI-001', 
    16, 
    31, 
    '{"potencia": 850, "eficiencia": "80 Plus Gold", "modularidad": "Modular", "formato": "ATX"}'
),
(
    'MSI MPG A1000G', 
    'Fuente de alimentación masiva preparada para soportar los picos de potencia más exigentes de sistemas gaming de nivel entusiasta.', 
    179.00, 
    8, 
    'PSUMSI-002', 
    16, 
    31, 
    '{"potencia": 1000, "eficiencia": "80 Plus Gold", "modularidad": "Modular", "formato": "ATX"}'
),

-- FUENTES DE ALIMENTACIÓN ASUS (Brand_id: 8)
(
    'ASUS ROG Thor 1000W Platinum II', 
    'Cuenta con una pantalla OLED lateral integrada para monitorizar el consumo en tiempo real, disipadores ROG masivos y componentes premium.', 
    285.00, 
    4, 
    'PSUASUS-001', 
    16, 
    8, 
    '{"potencia": 1000, "eficiencia": "80 Plus Platinum", "modularidad": "Modular", "formato": "ATX"}'
),
(
    'ASUS TUF Gaming 750W Gold', 
    'Durabilidad de grado militar con rodamientos de doble bola en el ventilador y recubrimiento protector de la placa de circuito contra el polvo.', 
    119.00, 
    15, 
    'PSUASUS-002', 
    16, 
    8, 
    '{"potencia": 750, "eficiencia": "80 Plus Gold", "modularidad": "Modular", "formato": "ATX"}'
),

-- FUENTES DE ALIMENTACIÓN GIGABYTE (Brand_id: 20)
(
    'Gigabyte UD750GM', 
    'Hereda el diseño Ultra Durable de Gigabyte, introduciendo condensadores japoneses de alta calidad para garantizar un funcionamiento seguro a largo plazo.', 
    89.99, 
    22, 
    'PSUGIGABYTE-001', 
    16, 
    20, 
    '{"potencia": 750, "eficiencia": "80 Plus Gold", "modularidad": "Modular", "formato": "ATX"}'
),
(
    'Gigabyte P650B', 
    'Proporciona una gran estabilidad energética a un coste contenido, siendo una opción clásica muy equilibrada para configuraciones intermedias.', 
    54.00, 
    30, 
    'PSUGIGABYTE-002', 
    16, 
    20, 
    '{"potencia": 650, "eficiencia": "80 Plus Bronze", "modularidad": "No Modular", "formato": "ATX"}'
),

-- FUENTES DE ALIMENTACIÓN DEEPCOOL (Brand_id: 16)
(
    'DeepCool PX850G WH', 
    'Edición totalmente blanca que cumple con el estándar ATX 3.0, garantizando una entrega de energía limpia y constante para hardware de alto rendimiento.', 
    139.00, 
    9, 
    'PSUDEEPCOOL-001', 
    16, 
    16, 
    '{"potencia": 850, "eficiencia": "80 Plus Gold", "modularidad": "Modular", "formato": "ATX"}'
),
(
    'DeepCool PK650D', 
    'Certificación 80 Plus Bronze muy eficiente que mantiene la generación de calor al mínimo al tiempo que proporciona energía estable al equipo.', 
    52.50, 
    27, 
    'PSUDEEPCOOL-002', 
    16, 
    16, 
    '{"potencia": 650, "eficiencia": "80 Plus Bronze", "modularidad": "No Modular", "formato": "ATX"}'
),

-- FUENTES DE ALIMENTACIÓN NZXT (Brand_id: 34)
(
    'NZXT C850 Gold', 
    'Ofrece energía limpia y segura para setups multitarjeta o procesadores demandantes, respaldada por un modo Zero Fan para un silencio absoluto a baja carga.', 
    129.90, 
    13, 
    'PSUNZXT-001', 
    16, 
    34, 
    '{"potencia": 850, "eficiencia": "80 Plus Gold", "modularidad": "Modular", "formato": "ATX"}'
),

-- FUENTES DE ALIMENTACIÓN COOLER MASTER (Brand_id: 13)
(
    'Cooler Master MWE Gold 750 V2', 
    'Solución de alimentación altamente eficiente con cables planos negros para mejorar el flujo de aire interno de la torre y facilitar el montaje.', 
    92.00, 
    19, 
    'PSUCOOLER MASTER-001', 
    16, 
    13, 
    '{"potencia": 750, "eficiencia": "80 Plus Gold", "modularidad": "Modular", "formato": "ATX"}'
),

-- FUENTES DE ALIMENTACIÓN NOX (Brand_id: 33)
(
    'Nox Urano VX 650W', 
    'La opción económica por excelencia del mercado para configuraciones sencillas. Cuenta con un ventilador de 120 mm regulado por control PWM.', 
    39.95, 
    45, 
    'PSUNOX-001', 
    16, 
    33, 
    '{"potencia": 650, "eficiencia": "80 Plus Bronze", "modularidad": "No Modular", "formato": "ATX"}'
);

INSERT INTO products (name, description, price, stock, sku, category_id, brand_id, specifications) VALUES 
-- CAJAS Y TORRES DE PC (Categoría 17)
(
    'BitFenix Apollo',
    'Consigue un flujo de aire excepcional y lucidez extrema para tus componentes con la BitFenix Apollo, fusionando diseño avanzado y refrigeración superior para equipos gaming exigentes.',
    80.76,
    35,
    'CASEBITFENIX-001',
    17,
    12,
    '{"formato": "ATX", "color": "Negro", "num_ventiladores_incluidos": 4, "fuente_incluida": false}'
),
(
    'Corsair 4000D Airflow',
    'Chasis ATX semitorre optimizado para un elevado flujo de aire con un panel frontal calado que garantiza una ventilación masiva hacia tus componentes.',
    89.90,
    14,
    'CASECORSAIR-001',
    17,
    14,
    '{"formato": "ATX", "color": "Negro", "num_ventiladores_incluidos": 2, "fuente_incluida": false}'
),
(
    'NZXT H9 Flow',
    'Diseño de doble cámara con paneles de cristal templado continuos que ofrecen una vista panorámica espectacular del hardware sin obstruir el flujo de aire.',
    169.90,
    8,
    'CASENZXT-001',
    17,
    34,
    '{"formato": "ATX", "color": "Blanco", "num_ventiladores_incluidos": 4, "fuente_incluida": false}'
),
(
    'Lian Li O11 Dynamic EVO',
    'La caja modular por excelencia para los entusiastas de las refrigeraciones líquidas personalizadas, permitiendo orientar el montaje de forma inversa.',
    149.50,
    10,
    'CASELIAN LI-001',
    17,
    29,
    '{"formato": "ATX", "color": "Negro", "num_ventiladores_incluidos": 0, "fuente_incluida": false}'
),
(
    'Fractal Design North',
    'Reinventa el espacio de juego introduciendo materiales naturales como la madera de nogal auténtica en el frontal, combinando elegancia y sofisticación.',
    139.99,
    6,
    'CASEFRACTAL DESIGN-001',
    17,
    18,
    '{"formato": "ATX", "color": "Negro/Madera", "num_ventiladores_incluidos": 2, "fuente_incluida": false}'
),
(
    'MSI MAG FORGE 112R',
    'Caja gaming accesible con un panel lateral de cristal templado de fácil apertura y cuatro ventiladores ARGB incluidos controlables mediante botón dedicado.',
    64.99,
    20,
    'CASEMSI-001',
    17,
    31,
    '{"formato": "ATX", "color": "Negro", "num_ventiladores_incluidos": 4, "fuente_incluida": false}'
),
(
    'Cooler Master MasterBox TD500 Mesh V2',
    'Presenta una fachada con contornos geométricos tridimensionales que, además de otorgar una estética rompedora, maximiza la entrada de aire fresco.',
    99.00,
    11,
    'CASECOOLER MASTER-001',
    17,
    13,
    '{"formato": "ATX", "color": "Blanco", "num_ventiladores_incluidos": 3, "fuente_incluida": false}'
),
(
    'DeepCool CH560 Digital',
    'Chasis moderno de alto flujo que incorpora una innovadora pantalla digital lateral para monitorizar las temperaturas de la CPU y la GPU en tiempo real.',
    119.90,
    9,
    'CASEDEEPCOOL-001',
    17,
    16,
    '{"formato": "ATX", "color": "Negro", "num_ventiladores_incluidos": 4, "fuente_incluida": false}'
),
(
    'Nox Hummer Astra',
    'Torre con estética de pecera de doble cámara, perfecta para configuraciones limpias donde los cables quedan completamente ocultos en la zona posterior.',
    74.50,
    18,
    'CASENOX-001',
    17,
    33,
    '{"formato": "ATX", "color": "Negro", "num_ventiladores_incluidos": 4, "fuente_incluida": false}'
),
(
    'ASUS TUF Gaming GT301',
    'Caja compacta equipada con un panel frontal de nido de abeja perforado, correas de transporte superiores y un gancho integrado para auriculares.',
    85.00,
    15,
    'CASEASUS-001',
    17,
    8,
    '{"formato": "ATX", "color": "Negro", "num_ventiladores_incluidos": 4, "fuente_incluida": false}'
);

INSERT INTO products (name, description, price, stock, sku, category_id, brand_id, specifications) VALUES 
-- VENTILADORES (Categoría 19)
(
    'NF-A12x25 G2 chromax.black',
    'Rendimiento de refrigeración silencioso de última generación para cajas de PC y radiadores de refrigeración por agua, en un elegante diseño totalmente negro: la versión chromax.black del galardonado ventilador NF-A12x25 G2 de 120 mm.',
    24.00,
    9,
    'FANNOCTUA-001',
    19,
    32,
    '{"tamaño": 120, "conexion": "4 pines"}'
),
(
    'Arctic P12 PWM PST',
    'Ventilador de 120 mm optimizado para presión estática con tecnología de gama alta compartida (PST) para conectar varios ventiladores en serie de forma simple.',
    9.95,
    45,
    'FANARCTIC-001',
    19,
    6,
    '{"tamaño": 120, "conexion": "4 pines"}'
),
(
    'Corsair LL120 RGB LED',
    'Creado para aquellos que buscan un flujo de aire excelente, un funcionamiento silencioso y una iluminación RGB de doble bucle espectacular.',
    29.90,
    15,
    'FANCORSAIR-001',
    19,
    14,
    '{"tamaño": 120, "conexion": "4 pines"}'
),
(
    'be quiet! Silent Wings 4 PWM',
    'Rendimiento de vanguardia inaudible. Ofrece una distancia mínima entre las aspas y el armazón para una presión de aire máxima.',
    22.50,
    20,
    'FANBE QUIET!-001',
    19,
    9,
    '{"tamaño": 120, "conexion": "4 pines"}'
),
(
    'Lian Li UNI FAN SL120 V2',
    'Revolucionario ventilador modular con sistema de encaje por contacto físico que reduce drásticamente el desorden de cables en el chasis.',
    27.99,
    12,
    'FANLIAN LI-001',
    19,
    29,
    '{"tamaño": 120, "conexion": "4 pines"}'
),
(
    'Noctua NF-A14 PWM',
    'Ventilador premium de 140 mm con un marco cuadrado estándar que cumple con las estrictas normas de refrigeración industrial de Noctua.',
    21.90,
    14,
    'FANNOCTUA-002',
    19,
    32,
    '{"tamaño": 140, "conexion": "4 pines"}'
),
(
    'NZXT F120 RGB Core',
    'Ofrece una iluminación brillante con un diseño de aspas optimizado para mejorar el flujo de aire estático y dinámico dentro de la torre.',
    19.99,
    18,
    'FANNZXT-001',
    19,
    34,
    '{"tamaño": 120, "conexion": "4 pines"}'
),
(
    'Thermalright TL-C12C-S',
    'Ventilador económico con un gran equilibrio térmico, gomas antivibración integradas en las esquinas e iluminación ARGB de 5V.',
    7.90,
    50,
    'FANTHERMALRIGHT-001',
    19,
    45,
    '{"tamaño": 120, "conexion": "4 pines"}'
),
(
    'DeepCool FK120',
    'Ventilador de alto rendimiento diseñado meticulosamente para una disipación eficiente en disipadores por aire pesados o radiadores de agua.',
    11.99,
    25,
    'FANDEEPCOOL-001',
    19,
    16,
    '{"tamaño": 120, "conexion": "4 pines"}'
),
(
    'Arctic P14 PWM PST',
    'La versión de 140 mm optimizada para una presión estática ideal. Garantiza una refrigeración extremadamente eficiente incluso con resistencia de aire.',
    11.50,
    30,
    'FANARCTIC-002',
    19,
    6,
    '{"tamaño": 140, "conexion": "4 pines"}'
);

INSERT INTO products (name, description, price, stock, sku, category_id, brand_id, specifications) VALUES 
-- MONITORES (Categoría 31)
(
    'AOC 24B36X',
    'El 24B36X está diseñado para transiciones fluidas entre productividad y entretenimiento. Su pantalla FHD de 24" ofrece imágenes fluidas con una frecuencia de actualización de 144 Hz y un MPRT ultrarrápido de 0,5 ms.',
    190.76,
    15,
    'SCRAOC-001',
    31,
    4,
    '{"tamaño": 23.8, "resolucion": "1920x1080", "panel": "IPS", "max_hercios": 144, "respuesta": 0.5, "sincronizacion_vertical": "Ambos", "curvo": false, "ajustable_altura": true, "táctil": false}'
),
(
    'LG UltraGear 27GR75Q-B',
    'Monitor gaming con panel IPS que ofrece una velocidad ultrarrápida y una inmersión total para disfrutar de tus videojuegos con la máxima fluidez cromática y de movimiento.',
    249.00,
    12,
    'SCRLG-001',
    31,
    28,
    '{"tamaño": 27.0, "resolucion": "2560x1440", "panel": "IPS", "max_hercios": 165, "respuesta": 1.0, "sincronizacion_vertical": "Ambos", "curvo": false, "ajustable_altura": true, "táctil": false}'
),
(
    'Samsung Odyssey G5 G55C',
    'Experimenta un nivel de juego que te hará vibrar. Su curvatura óptima 1000R envuelve por completo tu campo de visión para meterte de lleno en la piel del personaje.',
    279.50,
    8,
    'SCRSAMSUNG-001',
    31,
    39,
    '{"tamaño": 32.0, "resolucion": "2560x1440", "panel": "VA", "max_hercios": 165, "respuesta": 1.0, "sincronizacion_vertical": "FreeSync", "curvo": true, "ajustable_altura": false, "táctil": false}'
),
(
    'ASUS TUF Gaming VG249Q1A',
    'Monitor de 23.8 pulgadas con panel IPS y una frecuencia de refresco fluida diseñado para jugadores profesionales que buscan una ventaja competitiva.',
    159.00,
    20,
    'SCRASUS-001',
    31,
    8,
    '{"tamaño": 23.8, "resolucion": "1920x1080", "panel": "IPS", "max_hercios": 165, "respuesta": 1.0, "sincronizacion_vertical": "FreeSync", "curvo": false, "ajustable_altura": false, "táctil": false}'
),
(
    'BenQ ZOWIE XL2546K',
    'El monitor preferido por los jugadores profesionales de eSports. Incluye tecnología DyAc+ exclusiva para reducir drásticamente el desenfoque de movimiento.',
    429.00,
    6,
    'SCRBENQ-001',
    31,
    10,
    '{"tamaño": 24.5, "resolucion": "1920x1080", "panel": "TN", "max_hercios": 240, "respuesta": 0.5, "sincronizacion_vertical": "Ninguno", "curvo": false, "ajustable_altura": true, "táctil": false}'
),
(
    'Gigabyte M27Q Rev 2.0',
    'El primer monitor gaming del mundo con conmutador KVM integrado, lo que te permite controlar múltiples dispositivos a través de un solo teclado y ratón.',
    269.99,
    14,
    'SCRGIGABYTE-001',
    31,
    20,
    '{"tamaño": 27.0, "resolucion": "2560x1440", "panel": "SS IPS", "max_hercios": 170, "respuesta": 1.0, "sincronizacion_vertical": "Ambos", "curvo": false, "ajustable_altura": true, "táctil": false}'
),
(
    'MSI MAG 274QRFW',
    'Visualiza tu victoria con el monitor para juegos MSI MAG. Equipado con una hermosa estética blanca y un panel Rapid IPS de excelente fidelidad.',
    259.00,
    11,
    'SCRMSI-001',
    31,
    31,
    '{"tamaño": 27.0, "resolucion": "2560x1440", "panel": "Rapid IPS", "max_hercios": 180, "respuesta": 1.0, "sincronizacion_vertical": "Ambos", "curvo": false, "ajustable_altura": true, "táctil": false}'
),
(
    'Acer Nitro KG272 M3',
    'Disfruta de una jugabilidad óptima con un diseño ZeroFrame de bordes ultradelgados que maximiza la visibilidad de tus partidas competitivas.',
    149.50,
    18,
    'SCRACER-001',
    31,
    1,
    '{"tamaño": 27.0, "resolucion": "1920x1080", "panel": "IPS", "max_hercios": 180, "respuesta": 0.5, "sincronizacion_vertical": "FreeSync", "curvo": false, "ajustable_altura": false, "táctil": false}'
),
(
    'Dell SE2422H',
    'Monitor elegante y compacto diseñado para la productividad diaria en la oficina o el hogar, minimizando la fatiga visual mediante ComfortView.',
    99.00,
    25,
    'SCRDELL-001',
    31,
    17,
    '{"tamaño": 23.8, "resolucion": "1920x1080", "panel": "VA", "max_hercios": 75, "respuesta": 4.0, "sincronizacion_vertical": "FreeSync", "curvo": false, "ajustable_altura": false, "táctil": false}'
),
(
    'ASUS ZenScreen Portable',
    'Monitor portátil ultraligero con conexión híbrida USB tipo C, diseñado para profesionales que necesitan expandir su espacio de trabajo en cualquier lugar.',
    189.00,
    7,
    'SCRASUS-002',
    31,
    8,
    '{"tamaño": 15.6, "resolucion": "1920x1080", "panel": "IPS", "max_hercios": 60, "respuesta": 5.0, "sincronizacion_vertical": "Ninguno", "curvo": false, "ajustable_altura": false, "táctil": true}'
);

INSERT INTO products (name, description, price, stock, sku, category_id, brand_id, specifications) VALUES 
-- MONITORES (Categoría 31)
(
    'AOC 24B36X',
    'El 24B36X está diseñado para transiciones fluidas entre productividad y entretenimiento. Su pantalla FHD de 24" ofrece imágenes fluidas con una frecuencia de actualización de 144 Hz y un MPRT ultrarrápido de 0,5 ms.',
    190.76,
    15,
    'SCRAOC-001',
    31,
    4,
    '{"tamaño": 23.8, "resolucion": "1920x1080", "panel": "IPS", "max_hercios": 144, "respuesta": 0.5, "sincronizacion_vertical": "Ambos", "curvo": false, "ajustable_altura": true, "táctil": false}'
),
(
    'LG UltraGear 27GR75Q-B',
    'Monitor gaming con panel IPS que ofrece una velocidad ultrarrápida y una inmersión total para disfrutar de tus videojuegos con la máxima fluidez cromática y de movimiento.',
    249.00,
    12,
    'SCRLG-001',
    31,
    28,
    '{"tamaño": 27.0, "resolucion": "2560x1440", "panel": "IPS", "max_hercios": 165, "respuesta": 1.0, "sincronizacion_vertical": "Ambos", "curvo": false, "ajustable_altura": true, "táctil": false}'
),
(
    'Samsung Odyssey G5 G55C',
    'Experimenta un nivel de juego que te hará vibrar. Su curvatura óptima 1000R envuelve por completo tu campo de visión para meterte de lleno en la piel del personaje.',
    279.50,
    8,
    'SCRSAMSUNG-001',
    31,
    39,
    '{"tamaño": 32.0, "resolucion": "2560x1440", "panel": "VA", "max_hercios": 165, "respuesta": 1.0, "sincronizacion_vertical": "FreeSync", "curvo": true, "ajustable_altura": false, "táctil": false}'
),
(
    'ASUS TUF Gaming VG249Q1A',
    'Monitor de 23.8 pulgadas con panel IPS y una frecuencia de refresco fluida diseñado para jugadores profesionales que buscan una ventaja competitiva.',
    159.00,
    20,
    'SCRASUS-001',
    31,
    8,
    '{"tamaño": 23.8, "resolucion": "1920x1080", "panel": "IPS", "max_hercios": 165, "respuesta": 1.0, "sincronizacion_vertical": "FreeSync", "curvo": false, "ajustable_altura": false, "táctil": false}'
),
(
    'BenQ ZOWIE XL2546K',
    'El monitor preferido por los jugadores profesionales de eSports. Incluye tecnología DyAc+ exclusiva para reducir drásticamente el desenfoque de movimiento.',
    429.00,
    6,
    'SCRBENQ-001',
    31,
    10,
    '{"tamaño": 24.5, "resolucion": "1920x1080", "panel": "TN", "max_hercios": 240, "respuesta": 0.5, "sincronizacion_vertical": "Ninguno", "curvo": false, "ajustable_altura": true, "táctil": false}'
),
(
    'Gigabyte M27Q Rev 2.0',
    'El primer monitor gaming del mundo con conmutador KVM integrado, lo que te permite controlar múltiples dispositivos a través de un solo teclado y ratón.',
    269.99,
    14,
    'SCRGIGABYTE-001',
    31,
    20,
    '{"tamaño": 27.0, "resolucion": "2560x1440", "panel": "SS IPS", "max_hercios": 170, "respuesta": 1.0, "sincronizacion_vertical": "Ambos", "curvo": false, "ajustable_altura": true, "táctil": false}'
),
(
    'MSI MAG 274QRFW',
    'Visualiza tu victoria con el monitor para juegos MSI MAG. Equipado con una hermosa estética blanca y un panel Rapid IPS de excelente fidelidad.',
    259.00,
    11,
    'SCRMSI-001',
    31,
    31,
    '{"tamaño": 27.0, "resolucion": "2560x1440", "panel": "Rapid IPS", "max_hercios": 180, "respuesta": 1.0, "sincronizacion_vertical": "Ambos", "curvo": false, "ajustable_altura": true, "táctil": false}'
),
(
    'Acer Nitro KG272 M3',
    'Disfruta de una jugabilidad óptima con un diseño ZeroFrame de bordes ultradelgados que maximiza la visibilidad de tus partidas competitivas.',
    149.50,
    18,
    'SCRACER-001',
    31,
    1,
    '{"tamaño": 27.0, "resolucion": "1920x1080", "panel": "IPS", "max_hercios": 180, "respuesta": 0.5, "sincronizacion_vertical": "FreeSync", "curvo": false, "ajustable_altura": false, "táctil": false}'
),
(
    'Dell SE2422H',
    'Monitor elegante y compacto diseñado para la productividad diaria en la oficina o el hogar, minimizando la fatiga visual mediante ComfortView.',
    99.00,
    25,
    'SCRDELL-001',
    31,
    17,
    '{"tamaño": 23.8, "resolucion": "1920x1080", "panel": "VA", "max_hercios": 75, "respuesta": 4.0, "sincronizacion_vertical": "FreeSync", "curvo": false, "ajustable_altura": false, "táctil": false}'
),
(
    'ASUS ZenScreen Portable',
    'Monitor portátil ultraligero con conexión híbrida USB tipo C, diseñado para profesionales que necesitan expandir su espacio de trabajo en cualquier lugar.',
    189.00,
    7,
    'SCRASUS-002',
    31,
    8,
    '{"tamaño": 15.6, "resolucion": "1920x1080", "panel": "IPS", "max_hercios": 60, "respuesta": 5.0, "sincronizacion_vertical": "Ninguno", "curvo": false, "ajustable_altura": false, "táctil": true}'
);

INSERT INTO products (name, description, price, stock, sku, category_id, brand_id, specifications) VALUES 
-- TECLADOS (Categoría 32)
(
    'HyperX Alloy Rise 75',
    'HyperX Alloy Rise 75, el teclado mecánico gaming más personalizable del mundo y sin necesidad de herramientas que existe en el mercado, mejora aún más la personalización.',
    50.76,
    15,
    'KEYHYPERX-001',
    32,
    22,
    '{"formato": "75%", "tipo": "Mecánico", "switches": "Linear", "conexión": "USB-C"}'
),
(
    'Logitech G Pro X TKL',
    'Teclado para juegos diseñado con la colaboración de los mejores jugadores de eSports del mundo. Cuenta con tecnología inalámbrica Lightspeed de alto rendimiento.',
    139.99,
    12,
    'KEYLOGITECH-001',
    32,
    30,
    '{"formato": "TKL (80%)", "tipo": "Mecánico", "switches": "Tactile Brown", "conexión": "Inalámbrico/USB-C"}'
),
(
    'Corsair K70 RGB PRO',
    'Mantiene los elementos icónicos del galardonado K70 con una estructura de aluminio duradera, interruptores Cherry MX y la tecnología de hiperprocesamiento AXON.',
    169.90,
    10,
    'KEYCORSAIR-001',
    32,
    14,
    '{"formato": "Completo (100%)", "tipo": "Mecánico", "switches": "Linear Red", "conexión": "USB-C"}'
),
(
    'Red Dragon K552 Kumara RGB',
    'Teclado mecánico compacto TKL super robusto, construido en ABS y acero, resistente a las salpicaduras de líquidos y dotado de switches de alta velocidad.',
    42.50,
    25,
    'KEYRED DRAGON-001',
    32,
    38,
    '{"formato": "TKL (80%)", "tipo": "Mecánico", "switches": "Clicky Blue", "conexión": "USB"}'
),
(
    'Krom Kernel TKL',
    'Teclado mecánico sin teclado numérico que optimiza el espacio en tu escritorio para movimientos rápidos del ratón, con retroiluminación RGB de 16.8 millones de colores.',
    49.90,
    18,
    'KEYKROM-001',
    32,
    26,
    '{"formato": "TKL (80%)", "tipo": "Mecánico", "switches": "Linear Red", "conexión": "USB"}'
),
(
    'ASUS ROG Strix Scope II 96',
    'Distribución eficiente del 96% que conserva todas las teclas de función y numéricas en un diseño compacto, con espumas amortiguadoras integradas.',
    145.00,
    7,
    'KEYASUS-001',
    32,
    8,
    '{"formato": "96%", "tipo": "Mecánico", "switches": "Linear NX Storm", "conexión": "Inalámbrico/USB-C"}'
),
(
    'MSI Vigor GK30 RGB',
    'Equipado con interruptores mecánicos de tipo Plunger que ofrecen una experiencia de pulsación nítida y una base de teclado extremadamente estable.',
    39.99,
    30,
    'KEYMSI-001',
    32,
    31,
    '{"formato": "Completo (100%)", "tipo": "Plunger (Híbrido)", "switches": "No aplica", "conexión": "USB"}'
),
(
    'Logitech MX Keys Advanced',
    'Teclado inalámbrico premium optimizado para programadores y diseñadores. Cuenta con teclas esféricas cóncavas que se adaptan a la forma de las yemas de tus dedos.',
    115.00,
    14,
    'KEYLOGITECH-002',
    32,
    30,
    '{"formato": "Completo (100%)", "tipo": "Membrana", "switches": "No aplica", "conexión": "Bluetooth/USB-C"}'
),
(
    'HyperX Alloy Origins Core',
    'Teclado ultracompacto y resistente con interruptores mecánicos personalizados HyperX expuestos para una iluminación LED RGB más brillante.',
    99.99,
    20,
    'KEYHYPERX-002',
    32,
    22,
    '{"formato": "TKL (80%)", "tipo": "Mecánico", "switches": "Tactile Aqua", "conexión": "USB-C"}'
),
(
    'Corsair K65 PRO Mini',
    'Factor de forma compacto del 65% que cabe en los escritorios más pequeños, equipado con interruptores óptico-mecánicos para una actuación instantánea.',
    124.99,
    9,
    'KEYCORSAIR-002',
    32,
    14,
    '{"formato": "65%", "tipo": "Óptico-Mecánico", "switches": "Linear OPX", "conexión": "USB-C"}'
);
