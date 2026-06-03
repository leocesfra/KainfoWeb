<div align="center">
  <img src="frontend/front/assets/images/logo.png" alt="KainfoWeb Logo" width="200">
  
  # KainfoWeb
</div>

**KainfoWeb** Aplicación web e-commerce desarrollada como Trabajo de Fin de Grado (TFG). Consiste en una plataforma completa para gestión de productos, categorías, marcas y pedidos, con interfaces de cliente y administrador.

## 📋 Descripción del Proyecto

KainfoWeb es un sistema de gestión de e-commerce que permite:
- **Gestión de Catálogo**: Productos, categorías jerarquizadas y marcas
- **Gestión de Pedidos**: Crear, consultar y actualizar estados de órdenes
- **Gestión de Usuarios**: Autenticación y autorización con roles
- **Interfaces Multi-plataforma**: Aplicación web responsive con Flutter

## 🏗️ Estructura del Proyecto

```
KainfoWeb/
├── backend/                     # API REST - Spring Boot
│   ├── src/
│   │   ├── main/
│   │   │   ├── java/leo/        # Código fuente Java
│   │   │   └── resources/       # Configuración y propiedades
│   │   └── test/               # Tests unitarios
│   ├── pom.xml                 # Dependencias Maven
│   ├── mvnw                    # Maven wrapper
│   └── target/                 # Artefactos compilados
│
├── frontend/
│   └── front/                  # Cliente Flutter
│       ├── lib/                # Código Dart
│       │   ├── main.dart       # Punto de entrada
│       │   ├── core/           # Constantes, rutas, networking
│       │   ├── data/           # Modelos y repositorios
│       │   ├── viewmodels/     # Lógica de negocio
│       │   └── views/          # Pantallas y widgets
│       ├── assets/             # Recursos (imágenes, fonts)
│       ├── pubspec.yaml        # Dependencias Flutter/Dart
│       ├── android/            # Configuración Android
│       ├── ios/                # Configuración iOS
│       ├── web/                # Configuración Web
│       ├── windows/            # Configuración Windows
│       ├── macos/              # Configuración macOS
│       └── linux/              # Configuración Linux
│
└── database/                    # Scripts SQL
    ├── scriptCreacionTablas_v*.sql     # Creación de tablas
    └── scriptPoblacion*.sql            # Datos iniciales
```

## 🗄️ Esquema de Base de Datos

La base de datos `Kainfo` contiene las siguientes tablas:

### **categories**
Tabla de categorías con soporte para jerarquía padre-hijo.
```sql
- id (PK): BIGINT AUTO_INCREMENT
- name: VARCHAR(255) NOT NULL
- parent_id (FK): BIGINT (referencia a categories.id)
```

### **brands**
Tabla de marcas de productos.
```sql
- id (PK): BIGINT AUTO_INCREMENT
- name: VARCHAR(255) NOT NULL
```

### **products**
Tabla principal de productos con información detallada.
```sql
- id (PK): BIGINT AUTO_INCREMENT
- name: VARCHAR(255) NOT NULL
- description: TEXT NOT NULL
- price: DECIMAL(10,2) NOT NULL
- stock: INT
- created_at: TIMESTAMP DEFAULT CURRENT_TIMESTAMP
- SKU: VARCHAR(255) NOT NULL
- category_id (FK): BIGINT → categories(id)
- brand_id (FK): BIGINT → brands(id)
- specifications: JSON NOT NULL
```

### **product_images**
Tabla de imágenes de productos.
```sql
- id (PK): BIGINT AUTO_INCREMENT
- product_id (FK): BIGINT → products(id)
- image_url: TEXT NOT NULL
- is_primary: BOOLEAN NOT NULL
```

### **users**
Tabla de usuarios con autenticación.
```sql
- id (PK): BIGINT AUTO_INCREMENT
- email: VARCHAR(255) NOT NULL
- password: VARCHAR(100) NOT NULL
- rol: VARCHAR(50) NOT NULL
```

### **orders**
Tabla de pedidos de clientes.
```sql
- id (PK): BIGINT AUTO_INCREMENT
- date: DATETIME NOT NULL
- client_name: VARCHAR(100) NOT NULL
- email_client: VARCHAR(255) NOT NULL
- address: VARCHAR(255) NOT NULL
- amount: DECIMAL(10,2) NOT NULL
- state: VARCHAR(50) NOT NULL
```

### **orders_line**
Tabla de detalles de líneas de pedidos.
```sql
- id (PK): BIGINT AUTO_INCREMENT
- quantity: INT NOT NULL
- unitary_price: DECIMAL(10,2) NOT NULL
- order_id (FK): BIGINT → orders(id) ON DELETE CASCADE
- product_id (FK): BIGINT → products(id)
```

**Diagrama de relaciones:**
```
categories (1) ──── (M) products
brands (1) ──── (M) products
products (1) ──── (M) product_images
products (1) ──── (M) orders_line
orders (1) ──── (M) orders_line
```

## 🛠️ Tecnologías Utilizadas

### **Backend**
- **Framework**: Spring Boot 4.0.5
- **Lenguaje**: Java 21
- **Persistencia**: Spring Data JPA + Hibernate
- **Base de Datos**: MariaDB
- **Seguridad**: Spring Security 7.0.5
- **Build**: Maven
- **Librerías adicionales**:
  - Lombok (anotaciones de código boilerplate)
  - Jackson (serialización JSON)
  - HikariCP (pool de conexiones)

### **Frontend**
- **Framework**: Flutter 3.12+
- **Lenguaje**: Dart
- **Arquitectura**: MVVM con Provider
- **HTTP**: http 1.6.0
- **UI**: Material Design + Google Fonts
- **Internacionalización**: intl 0.20.2
- **Plataformas soportadas**: 
  - Web (Chrome, Firefox, Safari)
  - Android


### **Base de Datos**
- **DBMS**: MariaDB 10.5+
- **Versión SQL**: SQL 2003+

## 📋 Requisitos Previos

### **Para Backend**
- JDK Adoptium 21
- Maven 3.8+
- MariaDB 10.5+

### **Para Frontend**
- Flutter 3.12+
- Dart 3.12+
- Android Studio (para desarrollo Android)


### **General**
- Git
- Un navegador web moderno basado en chrominium

## 👨‍💻 Equipo de Desarrollo

Desarrollado por Leo Ces Fragoso

## 📄 Licencia

Este proyecto está bajo licencia privada. Se prohíbe la distribución sin consentimiento.

---

**Última actualización**: Junio 2026
