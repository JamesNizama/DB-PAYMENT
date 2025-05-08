CREATE DATABASE [PAYMENTS_DB]
GO
USE [PAYMENTS_DB]
GO
/****** Object:  Table [dbo].[Usuario]    Script Date: 8/05/2025 12:42:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuario](
	[ID_Usuario] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[Apellido] [varchar](50) NOT NULL,
	[Direccion] [varchar](255) NOT NULL,
	[Correo_Electronico] [varchar](100) NOT NULL,
	[Telefono] [varchar](15) NULL,
	[Fecha_Contratacion] [date] NOT NULL,
	[Cargo] [varchar](100) NULL,
	[ID_Area] [tinyint] NULL,
	[Estado] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_Usuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Actividad]    Script Date: 8/05/2025 12:42:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Actividad](
	[ID_Actividad] [int] IDENTITY(1,1) NOT NULL,
	[ID_Usuario] [int] NULL,
	[Titulo] [varchar](50) NOT NULL,
	[Descripcion] [varchar](255) NOT NULL,
	[Fecha_Inicio] [date] NOT NULL,
	[Fecha_Fin] [date] NOT NULL,
	[Estado] [nvarchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_Actividad] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Vista_Actividades_Por_Usuario]    Script Date: 8/05/2025 12:42:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--Vista de Actividades por Usuario

CREATE VIEW [dbo].[Vista_Actividades_Por_Usuario] AS
SELECT 
    U.ID_Usuario,
    U.Nombre,
    U.Apellido,
    A.ID_Actividad,
    A.Titulo,
    A.Descripcion,
    A.Fecha_Inicio,
    A.Fecha_Fin,
    A.Estado
FROM 
    Usuario U
JOIN 
    Actividad A ON U.ID_Usuario = A.ID_Usuario;
GO
/****** Object:  View [dbo].[Vista_Actividades_Pendientes]    Script Date: 8/05/2025 12:42:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--Vista de Actividades Pendientes
CREATE VIEW [dbo].[Vista_Actividades_Pendientes] AS
SELECT 
    A.ID_Actividad,
    A.Titulo,
    A.Descripcion,
    A.Fecha_Inicio,
    A.Fecha_Fin,
    A.Estado,
    U.Nombre AS Nombre_Usuario,
    U.Apellido AS Apellido_Usuario
FROM 
    Actividad A
JOIN 
    Usuario U ON A.ID_Usuario = U.ID_Usuario
WHERE 
    A.Estado IN ('Programada', 'Progreso');
GO
/****** Object:  Table [dbo].[Solicitud_Tiempo_Libre]    Script Date: 8/05/2025 12:42:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Solicitud_Tiempo_Libre](
	[ID_Solicitud] [int] IDENTITY(1,1) NOT NULL,
	[ID_Usuario] [int] NULL,
	[Tipo_Tiempo_Libre] [varchar](50) NOT NULL,
	[Fecha_Inicio] [date] NOT NULL,
	[Fecha_Fin] [date] NOT NULL,
	[Estado] [nvarchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_Solicitud] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Vista_Solicitudes_Tiempo_Libre]    Script Date: 8/05/2025 12:42:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--Vista de Solicitudes de Tiempo Libre
CREATE VIEW [dbo].[Vista_Solicitudes_Tiempo_Libre] AS
SELECT 
    S.ID_Solicitud,
    U.Nombre,
    U.Apellido,
    S.Tipo_Tiempo_Libre,
    S.Fecha_Inicio,
    S.Fecha_Fin,
    S.Estado
FROM 
    Solicitud_Tiempo_Libre S
JOIN 
    Usuario U ON S.ID_Usuario = U.ID_Usuario;
GO
/****** Object:  View [dbo].[Vista_Actividades_Completadas]    Script Date: 8/05/2025 12:42:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--Vista de Actividades Completadas

CREATE VIEW [dbo].[Vista_Actividades_Completadas] AS
SELECT 
    A.ID_Actividad,
    A.Titulo,
    A.Fecha_Inicio,
    A.Fecha_Fin,
    U.Nombre AS Nombre_Usuario,
    U.Apellido AS Apellido_Usuario
FROM 
    Actividad A
JOIN 
    Usuario U ON A.ID_Usuario = U.ID_Usuario
WHERE 
    A.Estado = 'Completada';
GO
/****** Object:  Table [dbo].[Area]    Script Date: 8/05/2025 12:42:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Area](
	[ID_Area] [tinyint] NOT NULL,
	[Nombre] [varchar](100) NOT NULL,
	[Descripcion] [varchar](255) NULL,
	[ID_Empresa] [tinyint] NULL,
	[Estado] [bit] NULL,
 CONSTRAINT [PK__Area__42A5C44CCB0F2A69] PRIMARY KEY CLUSTERED 
(
	[ID_Area] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Vista_Actividades_Por_Area]    Script Date: 8/05/2025 12:42:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--Vista de Actividades por Área

CREATE VIEW [dbo].[Vista_Actividades_Por_Area] AS
SELECT 
    A.ID_Actividad,
    A.Titulo,
    A.Descripcion,
    A.Fecha_Inicio,
    A.Fecha_Fin,
    A.Estado,
    Ar.Nombre AS Nombre_Area
FROM 
    Actividad A
JOIN 
    Usuario U ON A.ID_Usuario = U.ID_Usuario
JOIN 
    Area Ar ON U.ID_Area = Ar.ID_Area;
GO
/****** Object:  Table [dbo].[Documento]    Script Date: 8/05/2025 12:42:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Documento](
	[ID_Documento] [int] IDENTITY(1,1) NOT NULL,
	[Titulo] [varchar](100) NOT NULL,
	[Descripcion] [varchar](255) NULL,
	[Tipo] [varchar](50) NOT NULL,
	[Fecha_Creacion] [date] NOT NULL,
	[Fecha_Ultima_Modificacion] [date] NULL,
	[Autor] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_Documento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Empresa]    Script Date: 8/05/2025 12:42:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Empresa](
	[ID_Empresa] [tinyint] NOT NULL,
	[Nombre] [varchar](100) NOT NULL,
	[RUC] [varchar](15) NOT NULL,
	[Descripcion] [varchar](255) NULL,
	[Estado] [bit] NULL,
 CONSTRAINT [PK__Empresa__F4BB603974B0D6EA] PRIMARY KEY CLUSTERED 
(
	[ID_Empresa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[items_proyecto]    Script Date: 8/05/2025 12:42:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[items_proyecto](
	[ID_ITEMS] [int] IDENTITY(1,1) NOT NULL,
	[ID_PROYECTO] [int] NOT NULL,
	[descripcion] [varchar](max) NOT NULL,
	[estado] [varchar](20) NOT NULL,
	[fecha_creacion] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_ITEMS] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Proyecto]    Script Date: 8/05/2025 12:42:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Proyecto](
	[ID_PROYECTO] [int] IDENTITY(1,1) NOT NULL,
	[titulo] [varchar](100) NOT NULL,
	[descripcion] [varchar](max) NULL,
	[fecha_limite] [date] NOT NULL,
	[estado] [varchar](20) NOT NULL,
	[ID_Usuario] [int] NOT NULL,
	[progreso] [int] NULL,
	[fecha_creacion] [datetime] NULL,
	[fecha_actualizacion] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_PROYECTO] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Rol]    Script Date: 8/05/2025 12:42:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rol](
	[ID_Rol] [tinyint] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](100) NOT NULL,
	[Descripcion] [varchar](255) NULL,
	[Estado] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_Rol] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Rol_Usuario]    Script Date: 8/05/2025 12:42:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rol_Usuario](
	[ID_Rol] [tinyint] NOT NULL,
	[ID_Usuario] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID_Rol] ASC,
	[ID_Usuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Actividad] ON 
GO
INSERT [dbo].[Actividad] ([ID_Actividad], [ID_Usuario], [Titulo], [Descripcion], [Fecha_Inicio], [Fecha_Fin], [Estado]) VALUES (1, 1, N'Revisión de Requerimientos ', N'Revisión y validación de los requerimientos del sistema.', CAST(N'2023-03-01' AS Date), CAST(N'2025-05-05' AS Date), N'En progreso')
GO
INSERT [dbo].[Actividad] ([ID_Actividad], [ID_Usuario], [Titulo], [Descripcion], [Fecha_Inicio], [Fecha_Fin], [Estado]) VALUES (2, 2, N'Análisis de Datos', N'Análisis de los datos recolectados para la implementación de la solución.', CAST(N'2023-03-06' AS Date), CAST(N'2023-03-10' AS Date), N'En progreso')
GO
INSERT [dbo].[Actividad] ([ID_Actividad], [ID_Usuario], [Titulo], [Descripcion], [Fecha_Inicio], [Fecha_Fin], [Estado]) VALUES (3, 3, N'Diseño de la Base de Datos', N'Crear el esquema de base de datos para el sistema.', CAST(N'2023-03-02' AS Date), CAST(N'2023-03-08' AS Date), N'Completado')
GO
INSERT [dbo].[Actividad] ([ID_Actividad], [ID_Usuario], [Titulo], [Descripcion], [Fecha_Inicio], [Fecha_Fin], [Estado]) VALUES (4, 4, N'Prueba 1', N'Prueba 1 Jesus', CAST(N'2025-04-30' AS Date), CAST(N'2025-04-30' AS Date), N'Completado')
GO
INSERT [dbo].[Actividad] ([ID_Actividad], [ID_Usuario], [Titulo], [Descripcion], [Fecha_Inicio], [Fecha_Fin], [Estado]) VALUES (6, 1, N'Documentación Técnica', N'	Elaborar la documentación técnica del sistema desarrollado.', CAST(N'2023-03-01' AS Date), CAST(N'2023-03-05' AS Date), N'En progreso')
GO
INSERT [dbo].[Actividad] ([ID_Actividad], [ID_Usuario], [Titulo], [Descripcion], [Fecha_Inicio], [Fecha_Fin], [Estado]) VALUES (7, 2, N'Entrenamiento al Usuario', N'Capacitar a los usuarios finales sobre el uso del sistema.', CAST(N'2023-03-06' AS Date), CAST(N'2023-03-10' AS Date), N'Completado')
GO
INSERT [dbo].[Actividad] ([ID_Actividad], [ID_Usuario], [Titulo], [Descripcion], [Fecha_Inicio], [Fecha_Fin], [Estado]) VALUES (8, 3, N'Implementación en Producción', N'Desplegar el sistema en el entorno de producción.', CAST(N'2023-03-02' AS Date), CAST(N'2023-03-08' AS Date), N'Cancelado')
GO
INSERT [dbo].[Actividad] ([ID_Actividad], [ID_Usuario], [Titulo], [Descripcion], [Fecha_Inicio], [Fecha_Fin], [Estado]) VALUES (9, 4, N'Monitoreo Post-Implementación', N'Realizar seguimiento al sistema en producción para detectar posibles fallos.', CAST(N'2023-03-11' AS Date), CAST(N'2023-03-15' AS Date), N'Cancelado')
GO
INSERT [dbo].[Actividad] ([ID_Actividad], [ID_Usuario], [Titulo], [Descripcion], [Fecha_Inicio], [Fecha_Fin], [Estado]) VALUES (10, 5, N'Mantenimiento del Sistema', N'Realizar tareas de mantenimiento preventivo y correctivo del sistema.', CAST(N'2023-03-12' AS Date), CAST(N'2023-03-16' AS Date), N'Cancelado')
GO
INSERT [dbo].[Actividad] ([ID_Actividad], [ID_Usuario], [Titulo], [Descripcion], [Fecha_Inicio], [Fecha_Fin], [Estado]) VALUES (11, 23, N'Compra de cacao', N'Compra y venta', CAST(N'2025-04-30' AS Date), CAST(N'2025-05-05' AS Date), N'Pendiente')
GO
INSERT [dbo].[Actividad] ([ID_Actividad], [ID_Usuario], [Titulo], [Descripcion], [Fecha_Inicio], [Fecha_Fin], [Estado]) VALUES (12, 22, N'Cambio 1MK', N'Tipo de cambio preferencial', CAST(N'2025-04-30' AS Date), CAST(N'2025-05-05' AS Date), N'Pendiente')
GO
INSERT [dbo].[Actividad] ([ID_Actividad], [ID_Usuario], [Titulo], [Descripcion], [Fecha_Inicio], [Fecha_Fin], [Estado]) VALUES (13, 21, N'PAGO PRESTAMO MAGOCASH', N'PAGOS VARIOS', CAST(N'2025-04-30' AS Date), CAST(N'2025-05-05' AS Date), N'Pendiente')
GO
INSERT [dbo].[Actividad] ([ID_Actividad], [ID_Usuario], [Titulo], [Descripcion], [Fecha_Inicio], [Fecha_Fin], [Estado]) VALUES (14, 1, N'Revisión de Requerimientos ', N'Revisión y validación de los requerimientos del sistema.', CAST(N'2025-04-30' AS Date), CAST(N'2025-04-30' AS Date), N'Pendiente')
GO
INSERT [dbo].[Actividad] ([ID_Actividad], [ID_Usuario], [Titulo], [Descripcion], [Fecha_Inicio], [Fecha_Fin], [Estado]) VALUES (15, 21, N'PAGO PRESTAMO MAGOCASH', N'PAGOS VARIOS', CAST(N'2025-04-30' AS Date), CAST(N'2025-05-05' AS Date), N'En progreso')
GO
INSERT [dbo].[Actividad] ([ID_Actividad], [ID_Usuario], [Titulo], [Descripcion], [Fecha_Inicio], [Fecha_Fin], [Estado]) VALUES (23, 21, N'PAGO PRESTAMO MAGOCASH Jesus', N'PAGO PRESTAMO MAGOCASH Jesus', CAST(N'2025-04-30' AS Date), CAST(N'2025-05-10' AS Date), N'En progreso')
GO
INSERT [dbo].[Actividad] ([ID_Actividad], [ID_Usuario], [Titulo], [Descripcion], [Fecha_Inicio], [Fecha_Fin], [Estado]) VALUES (24, 22, N'Pago a Fabian', N'el otro año ', CAST(N'2025-04-30' AS Date), CAST(N'2025-05-05' AS Date), N'Completado')
GO
INSERT [dbo].[Actividad] ([ID_Actividad], [ID_Usuario], [Titulo], [Descripcion], [Fecha_Inicio], [Fecha_Fin], [Estado]) VALUES (26, 22, N'Analisis de prueba', N'Debera realizar un análisis del sistema.', CAST(N'2025-04-30' AS Date), CAST(N'2025-04-30' AS Date), N'Pendiente')
GO
SET IDENTITY_INSERT [dbo].[Actividad] OFF
GO
INSERT [dbo].[Area] ([ID_Area], [Nombre], [Descripcion], [ID_Empresa], [Estado]) VALUES (1, N'Área de contabilidad', N'Gestión integral de registros financieros, análisis de estados contables y cumplimiento', 1, 1)
GO
INSERT [dbo].[Area] ([ID_Area], [Nombre], [Descripcion], [ID_Empresa], [Estado]) VALUES (2, N'Área de finanzas', N'Optimización de recursos económicos, planeación estratégica de inversiones y gestión de riesgos financieros', 1, 1)
GO
INSERT [dbo].[Area] ([ID_Area], [Nombre], [Descripcion], [ID_Empresa], [Estado]) VALUES (3, N'Área de soporte', N'Asistencia técnica especializada a usuarios internos, gestión de incidencias y soporte en campo', 1, 1)
GO
INSERT [dbo].[Area] ([ID_Area], [Nombre], [Descripcion], [ID_Empresa], [Estado]) VALUES (4, N'Área de sistemas', N'Administración de infraestructura tecnológica y desarrollo de software corporativo.', 1, 1)
GO
INSERT [dbo].[Area] ([ID_Area], [Nombre], [Descripcion], [ID_Empresa], [Estado]) VALUES (5, N'Área de tesorería', N'Gestión de flujos de efectivo, control de liquidez y estrategias de financiamiento corporativo', 1, 1)
GO
INSERT [dbo].[Area] ([ID_Area], [Nombre], [Descripcion], [ID_Empresa], [Estado]) VALUES (6, N'Área de Comercial', N'Desarrollo de estrategias de mercado, gestión de clientes clave y ejecución de planes de ventas estratégicas', 1, 1)
GO
INSERT [dbo].[Area] ([ID_Area], [Nombre], [Descripcion], [ID_Empresa], [Estado]) VALUES (7, N'Área de Operaciones', N'Supervisión de procesos productivos, logística integral y mejora continua de la cadena de valor', 1, 1)
GO
SET IDENTITY_INSERT [dbo].[Documento] ON 
GO
INSERT [dbo].[Documento] ([ID_Documento], [Titulo], [Descripcion], [Tipo], [Fecha_Creacion], [Fecha_Ultima_Modificacion], [Autor]) VALUES (1, N'Documento 1', N'Descripción del documento 1', N'Tipo A', CAST(N'2025-04-15' AS Date), CAST(N'2025-04-15' AS Date), 1)
GO
INSERT [dbo].[Documento] ([ID_Documento], [Titulo], [Descripcion], [Tipo], [Fecha_Creacion], [Fecha_Ultima_Modificacion], [Autor]) VALUES (2, N'Documento 2', N'Descripción del documento 2', N'Tipo B', CAST(N'2025-04-15' AS Date), CAST(N'2025-04-15' AS Date), 2)
GO
INSERT [dbo].[Documento] ([ID_Documento], [Titulo], [Descripcion], [Tipo], [Fecha_Creacion], [Fecha_Ultima_Modificacion], [Autor]) VALUES (3, N'Documento 1', N'Descripción del documento 1', N'Tipo A', CAST(N'2025-04-15' AS Date), CAST(N'2025-04-15' AS Date), 1)
GO
INSERT [dbo].[Documento] ([ID_Documento], [Titulo], [Descripcion], [Tipo], [Fecha_Creacion], [Fecha_Ultima_Modificacion], [Autor]) VALUES (4, N'Documento 2', N'Descripción del documento 2', N'Tipo B', CAST(N'2025-04-15' AS Date), CAST(N'2025-04-15' AS Date), 2)
GO
SET IDENTITY_INSERT [dbo].[Documento] OFF
GO
INSERT [dbo].[Empresa] ([ID_Empresa], [Nombre], [RUC], [Descripcion], [Estado]) VALUES (1, N'Payments Latam S.a.C.', N'20603630506', N'En nuestra plataforma ofrecemos soluciones de Payouts & Payins para Latinoamérica, permitiendo a nuestros clientes automatizar sus pagos y cobros, reducir costos y ampliar su alcance en la región.', 1)
GO
INSERT [dbo].[Empresa] ([ID_Empresa], [Nombre], [RUC], [Descripcion], [Estado]) VALUES (2, N'Inkacao del Peru S.a.C.', N'20557532880', N'Somos una empresa agrícola peruana especializada en cacao', 1)
GO
INSERT [dbo].[Empresa] ([ID_Empresa], [Nombre], [RUC], [Descripcion], [Estado]) VALUES (3, N'Kambista S.a.C.', N'20601708141', N'Divisa', 1)
GO
SET IDENTITY_INSERT [dbo].[items_proyecto] ON 
GO
INSERT [dbo].[items_proyecto] ([ID_ITEMS], [ID_PROYECTO], [descripcion], [estado], [fecha_creacion]) VALUES (1, 1, N'Inicio', N'No Iniciado', CAST(N'2025-05-02T10:11:54.103' AS DateTime))
GO
INSERT [dbo].[items_proyecto] ([ID_ITEMS], [ID_PROYECTO], [descripcion], [estado], [fecha_creacion]) VALUES (2, 1, N'Planificación', N'No Iniciado', CAST(N'2025-05-02T10:11:54.103' AS DateTime))
GO
INSERT [dbo].[items_proyecto] ([ID_ITEMS], [ID_PROYECTO], [descripcion], [estado], [fecha_creacion]) VALUES (3, 1, N'Ejecución', N'No Iniciado', CAST(N'2025-05-02T10:11:54.103' AS DateTime))
GO
INSERT [dbo].[items_proyecto] ([ID_ITEMS], [ID_PROYECTO], [descripcion], [estado], [fecha_creacion]) VALUES (4, 1, N'Monitoreo y Control', N'No Iniciado', CAST(N'2025-05-02T10:11:54.103' AS DateTime))
GO
INSERT [dbo].[items_proyecto] ([ID_ITEMS], [ID_PROYECTO], [descripcion], [estado], [fecha_creacion]) VALUES (5, 1, N'Cierre', N'No Iniciado', CAST(N'2025-05-02T10:11:54.103' AS DateTime))
GO
INSERT [dbo].[items_proyecto] ([ID_ITEMS], [ID_PROYECTO], [descripcion], [estado], [fecha_creacion]) VALUES (6, 2, N'Requerimientos', N'No Iniciado', CAST(N'2025-05-02T11:55:50.483' AS DateTime))
GO
INSERT [dbo].[items_proyecto] ([ID_ITEMS], [ID_PROYECTO], [descripcion], [estado], [fecha_creacion]) VALUES (7, 2, N'Desarrollo', N'No Iniciado', CAST(N'2025-05-02T11:55:50.483' AS DateTime))
GO
INSERT [dbo].[items_proyecto] ([ID_ITEMS], [ID_PROYECTO], [descripcion], [estado], [fecha_creacion]) VALUES (8, 2, N'Pruebas', N'No Iniciado', CAST(N'2025-05-02T11:55:50.483' AS DateTime))
GO
INSERT [dbo].[items_proyecto] ([ID_ITEMS], [ID_PROYECTO], [descripcion], [estado], [fecha_creacion]) VALUES (9, 3, N'Evaluación de Requerimientos', N'No Iniciado', CAST(N'2025-05-02T11:56:01.977' AS DateTime))
GO
INSERT [dbo].[items_proyecto] ([ID_ITEMS], [ID_PROYECTO], [descripcion], [estado], [fecha_creacion]) VALUES (10, 3, N'Selección de Plataforma', N'No Iniciado', CAST(N'2025-05-02T11:56:01.977' AS DateTime))
GO
INSERT [dbo].[items_proyecto] ([ID_ITEMS], [ID_PROYECTO], [descripcion], [estado], [fecha_creacion]) VALUES (11, 3, N'Migración de Datos', N'No Iniciado', CAST(N'2025-05-02T11:56:01.977' AS DateTime))
GO
INSERT [dbo].[items_proyecto] ([ID_ITEMS], [ID_PROYECTO], [descripcion], [estado], [fecha_creacion]) VALUES (12, 3, N'Pruebas y Validación', N'No Iniciado', CAST(N'2025-05-02T11:56:01.977' AS DateTime))
GO
INSERT [dbo].[items_proyecto] ([ID_ITEMS], [ID_PROYECTO], [descripcion], [estado], [fecha_creacion]) VALUES (13, 4, N'Análisis de Procesos', N'No Iniciado', CAST(N'2025-05-02T12:35:28.893' AS DateTime))
GO
INSERT [dbo].[items_proyecto] ([ID_ITEMS], [ID_PROYECTO], [descripcion], [estado], [fecha_creacion]) VALUES (14, 4, N'Diseño de Solución RPA', N'No Iniciado', CAST(N'2025-05-02T12:35:28.893' AS DateTime))
GO
INSERT [dbo].[items_proyecto] ([ID_ITEMS], [ID_PROYECTO], [descripcion], [estado], [fecha_creacion]) VALUES (15, 4, N'Implementación de Bots', N'No Iniciado', CAST(N'2025-05-02T12:35:28.893' AS DateTime))
GO
INSERT [dbo].[items_proyecto] ([ID_ITEMS], [ID_PROYECTO], [descripcion], [estado], [fecha_creacion]) VALUES (16, 4, N'Pruebas y Optimización', N'No Iniciado', CAST(N'2025-05-02T12:35:28.893' AS DateTime))
GO
INSERT [dbo].[items_proyecto] ([ID_ITEMS], [ID_PROYECTO], [descripcion], [estado], [fecha_creacion]) VALUES (17, 5, N'Investigación de Mercado', N'No Iniciado', CAST(N'2025-05-02T12:35:38.353' AS DateTime))
GO
INSERT [dbo].[items_proyecto] ([ID_ITEMS], [ID_PROYECTO], [descripcion], [estado], [fecha_creacion]) VALUES (18, 5, N'Desarrollo de Plataforma', N'No Iniciado', CAST(N'2025-05-02T12:35:38.353' AS DateTime))
GO
INSERT [dbo].[items_proyecto] ([ID_ITEMS], [ID_PROYECTO], [descripcion], [estado], [fecha_creacion]) VALUES (19, 5, N'Integración de Pagos', N'No Iniciado', CAST(N'2025-05-02T12:35:38.353' AS DateTime))
GO
INSERT [dbo].[items_proyecto] ([ID_ITEMS], [ID_PROYECTO], [descripcion], [estado], [fecha_creacion]) VALUES (20, 5, N'Pruebas y Lanzamiento', N'No Iniciado', CAST(N'2025-05-02T12:35:38.353' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[items_proyecto] OFF
GO
SET IDENTITY_INSERT [dbo].[Proyecto] ON 
GO
INSERT [dbo].[Proyecto] ([ID_PROYECTO], [titulo], [descripcion], [fecha_limite], [estado], [ID_Usuario], [progreso], [fecha_creacion], [fecha_actualizacion]) VALUES (1, N'Implementación de Sistema de Gestión', N'Proyecto para implementar un sistema integral de gestión empresarial.', CAST(N'2025-09-30' AS Date), N'No Iniciado', 1, 0, CAST(N'2025-05-02T10:09:24.420' AS DateTime), CAST(N'2025-05-08T12:35:32.537' AS DateTime))
GO
INSERT [dbo].[Proyecto] ([ID_PROYECTO], [titulo], [descripcion], [fecha_limite], [estado], [ID_Usuario], [progreso], [fecha_creacion], [fecha_actualizacion]) VALUES (2, N'Desarrollo de Aplicación Web', N'Proyecto para desarrollar una aplicación web para la gestión de clientes.', CAST(N'2025-10-15' AS Date), N'No Iniciado', 2, 0, CAST(N'2025-05-02T11:55:50.480' AS DateTime), CAST(N'2025-05-02T11:55:50.480' AS DateTime))
GO
INSERT [dbo].[Proyecto] ([ID_PROYECTO], [titulo], [descripcion], [fecha_limite], [estado], [ID_Usuario], [progreso], [fecha_creacion], [fecha_actualizacion]) VALUES (3, N'Migración a la Nube', N'Proyecto para migrar los sistemas existentes a la nube.', CAST(N'2025-12-20' AS Date), N'No Iniciado', 3, 0, CAST(N'2025-05-02T11:56:01.973' AS DateTime), CAST(N'2025-05-02T11:56:01.973' AS DateTime))
GO
INSERT [dbo].[Proyecto] ([ID_PROYECTO], [titulo], [descripcion], [fecha_limite], [estado], [ID_Usuario], [progreso], [fecha_creacion], [fecha_actualizacion]) VALUES (4, N'Automatización de Procesos Empresariales', N'Proyecto para automatizar los procesos internos de la empresa utilizando RPA (Robotic Process Automation).', CAST(N'2025-11-15' AS Date), N'No Iniciado', 4, 0, CAST(N'2025-05-02T12:35:22.150' AS DateTime), CAST(N'2025-05-08T12:34:40.403' AS DateTime))
GO
INSERT [dbo].[Proyecto] ([ID_PROYECTO], [titulo], [descripcion], [fecha_limite], [estado], [ID_Usuario], [progreso], [fecha_creacion], [fecha_actualizacion]) VALUES (5, N'Desarrollo de Plataforma de E-commerce', N'Proyecto para crear una plataforma de comercio electrónico para ventas de productos en línea.', CAST(N'2026-01-10' AS Date), N'No Iniciado', 5, 0, CAST(N'2025-05-02T12:35:32.740' AS DateTime), CAST(N'2025-05-02T12:35:32.740' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[Proyecto] OFF
GO
SET IDENTITY_INSERT [dbo].[Rol] ON 
GO
INSERT [dbo].[Rol] ([ID_Rol], [Nombre], [Descripcion], [Estado]) VALUES (1, N'Administrador', N'Rol de administrador', 1)
GO
INSERT [dbo].[Rol] ([ID_Rol], [Nombre], [Descripcion], [Estado]) VALUES (2, N'Usuario', N'Rol de usuario normal', 1)
GO
INSERT [dbo].[Rol] ([ID_Rol], [Nombre], [Descripcion], [Estado]) VALUES (3, N'Administrador', N'Rol de administrador', 1)
GO
INSERT [dbo].[Rol] ([ID_Rol], [Nombre], [Descripcion], [Estado]) VALUES (4, N'Usuario', N'Rol de usuario normal', 1)
GO
SET IDENTITY_INSERT [dbo].[Rol] OFF
GO
SET IDENTITY_INSERT [dbo].[Solicitud_Tiempo_Libre] ON 
GO
INSERT [dbo].[Solicitud_Tiempo_Libre] ([ID_Solicitud], [ID_Usuario], [Tipo_Tiempo_Libre], [Fecha_Inicio], [Fecha_Fin], [Estado]) VALUES (1, 1, N'Vacaciones', CAST(N'2023-04-01' AS Date), CAST(N'2023-04-10' AS Date), N'Pendiente')
GO
INSERT [dbo].[Solicitud_Tiempo_Libre] ([ID_Solicitud], [ID_Usuario], [Tipo_Tiempo_Libre], [Fecha_Inicio], [Fecha_Fin], [Estado]) VALUES (2, 2, N'Día Personal', CAST(N'2023-04-05' AS Date), CAST(N'2023-04-05' AS Date), N'Aprobada')
GO
INSERT [dbo].[Solicitud_Tiempo_Libre] ([ID_Solicitud], [ID_Usuario], [Tipo_Tiempo_Libre], [Fecha_Inicio], [Fecha_Fin], [Estado]) VALUES (3, 1, N'Vacaciones', CAST(N'2023-04-01' AS Date), CAST(N'2023-04-10' AS Date), N'Pendiente')
GO
INSERT [dbo].[Solicitud_Tiempo_Libre] ([ID_Solicitud], [ID_Usuario], [Tipo_Tiempo_Libre], [Fecha_Inicio], [Fecha_Fin], [Estado]) VALUES (4, 2, N'Día Personal', CAST(N'2023-04-05' AS Date), CAST(N'2023-04-05' AS Date), N'Aprobada')
GO
SET IDENTITY_INSERT [dbo].[Solicitud_Tiempo_Libre] OFF
GO
SET IDENTITY_INSERT [dbo].[Usuario] ON 
GO
INSERT [dbo].[Usuario] ([ID_Usuario], [Nombre], [Apellido], [Direccion], [Correo_Electronico], [Telefono], [Fecha_Contratacion], [Cargo], [ID_Area], [Estado]) VALUES (1, N'ANGIE LEONELA', N'BORJA MENESES', N'', N'', N'', CAST(N'2024-04-01' AS Date), N'', 1, 1)
GO
INSERT [dbo].[Usuario] ([ID_Usuario], [Nombre], [Apellido], [Direccion], [Correo_Electronico], [Telefono], [Fecha_Contratacion], [Cargo], [ID_Area], [Estado]) VALUES (2, N'JHON ANDERSON', N'SIESQUEN GARCIA', N'', N'', N'', CAST(N'2024-04-08' AS Date), N'', 1, 1)
GO
INSERT [dbo].[Usuario] ([ID_Usuario], [Nombre], [Apellido], [Direccion], [Correo_Electronico], [Telefono], [Fecha_Contratacion], [Cargo], [ID_Area], [Estado]) VALUES (3, N'CESAR AUGUSTO', N'VELORIO TRUCIOS', N'', N'', N'', CAST(N'2023-11-01' AS Date), N'', 1, 1)
GO
INSERT [dbo].[Usuario] ([ID_Usuario], [Nombre], [Apellido], [Direccion], [Correo_Electronico], [Telefono], [Fecha_Contratacion], [Cargo], [ID_Area], [Estado]) VALUES (4, N'CELESTINO', N'CHAUCA KIMBERLY', N'', N'', N'', CAST(N'2024-04-08' AS Date), N'', 1, 1)
GO
INSERT [dbo].[Usuario] ([ID_Usuario], [Nombre], [Apellido], [Direccion], [Correo_Electronico], [Telefono], [Fecha_Contratacion], [Cargo], [ID_Area], [Estado]) VALUES (5, N'HAROLD JEFERSON', N'SOTOMAYOR SALAZAR', N'', N'', N'', CAST(N'2024-09-01' AS Date), N'', 1, 1)
GO
INSERT [dbo].[Usuario] ([ID_Usuario], [Nombre], [Apellido], [Direccion], [Correo_Electronico], [Telefono], [Fecha_Contratacion], [Cargo], [ID_Area], [Estado]) VALUES (6, N'EMILETH CAROLINA', N'CASTIBLANCO CAICEDO', N'', N'', N'', CAST(N'2024-09-01' AS Date), N'', 1, 1)
GO
INSERT [dbo].[Usuario] ([ID_Usuario], [Nombre], [Apellido], [Direccion], [Correo_Electronico], [Telefono], [Fecha_Contratacion], [Cargo], [ID_Area], [Estado]) VALUES (7, N'KATIA PAOLA', N'VERGARA VERGARA', N'', N'', N'', CAST(N'2024-11-01' AS Date), N'', 1, 1)
GO
INSERT [dbo].[Usuario] ([ID_Usuario], [Nombre], [Apellido], [Direccion], [Correo_Electronico], [Telefono], [Fecha_Contratacion], [Cargo], [ID_Area], [Estado]) VALUES (8, N'SHEILA', N'ARIZA ROBLES', N'', N'', N'', CAST(N'2025-04-01' AS Date), N'', 1, 1)
GO
INSERT [dbo].[Usuario] ([ID_Usuario], [Nombre], [Apellido], [Direccion], [Correo_Electronico], [Telefono], [Fecha_Contratacion], [Cargo], [ID_Area], [Estado]) VALUES (9, N'KATHERINE ALEXANDRA', N'HORNA CARRANZA', N'', N'', N'', CAST(N'2024-03-01' AS Date), N'', 2, 1)
GO
INSERT [dbo].[Usuario] ([ID_Usuario], [Nombre], [Apellido], [Direccion], [Correo_Electronico], [Telefono], [Fecha_Contratacion], [Cargo], [ID_Area], [Estado]) VALUES (10, N'LUCIA YSABEL', N'CHAVEZ RIVERA', N'', N'', N'', CAST(N'2024-03-01' AS Date), N'', 2, 1)
GO
INSERT [dbo].[Usuario] ([ID_Usuario], [Nombre], [Apellido], [Direccion], [Correo_Electronico], [Telefono], [Fecha_Contratacion], [Cargo], [ID_Area], [Estado]) VALUES (11, N'KENLLY', N'FASABI AMASIFUEN', N'', N'', N'', CAST(N'2024-05-01' AS Date), N'', 2, 1)
GO
INSERT [dbo].[Usuario] ([ID_Usuario], [Nombre], [Apellido], [Direccion], [Correo_Electronico], [Telefono], [Fecha_Contratacion], [Cargo], [ID_Area], [Estado]) VALUES (12, N'EMMA JOHANA', N'SANCHEZ SANGAMA', N'', N'', N'', CAST(N'2024-06-01' AS Date), N'', 2, 1)
GO
INSERT [dbo].[Usuario] ([ID_Usuario], [Nombre], [Apellido], [Direccion], [Correo_Electronico], [Telefono], [Fecha_Contratacion], [Cargo], [ID_Area], [Estado]) VALUES (13, N'ALEX', N'CAMPOS RUIZ', N'', N'', N'', CAST(N'2024-06-01' AS Date), N'', 2, 1)
GO
INSERT [dbo].[Usuario] ([ID_Usuario], [Nombre], [Apellido], [Direccion], [Correo_Electronico], [Telefono], [Fecha_Contratacion], [Cargo], [ID_Area], [Estado]) VALUES (14, N'MARYAN DIHAMELIZ', N'HERNANDEZ ARAUJO', N'', N'', N'', CAST(N'2021-02-01' AS Date), N'', 2, 1)
GO
INSERT [dbo].[Usuario] ([ID_Usuario], [Nombre], [Apellido], [Direccion], [Correo_Electronico], [Telefono], [Fecha_Contratacion], [Cargo], [ID_Area], [Estado]) VALUES (15, N'ROSA ASUNCIÓN', N'CHAUCA RUIZ', N'', N'', N'', CAST(N'2021-10-01' AS Date), N'', 2, 1)
GO
INSERT [dbo].[Usuario] ([ID_Usuario], [Nombre], [Apellido], [Direccion], [Correo_Electronico], [Telefono], [Fecha_Contratacion], [Cargo], [ID_Area], [Estado]) VALUES (16, N'YEFRI ANDRUAR', N'CELESTINO CHAUCA', N'', N'', N'', CAST(N'2020-11-01' AS Date), N'', 2, 1)
GO
INSERT [dbo].[Usuario] ([ID_Usuario], [Nombre], [Apellido], [Direccion], [Correo_Electronico], [Telefono], [Fecha_Contratacion], [Cargo], [ID_Area], [Estado]) VALUES (17, N'LUCIANO', N'SOLANO GAMONAL', N'', N'', N'', CAST(N'2022-06-01' AS Date), N'', 2, 1)
GO
INSERT [dbo].[Usuario] ([ID_Usuario], [Nombre], [Apellido], [Direccion], [Correo_Electronico], [Telefono], [Fecha_Contratacion], [Cargo], [ID_Area], [Estado]) VALUES (18, N'ROXANA', N'SANCHEZ IRENE', N'', N'', N'', CAST(N'2022-06-01' AS Date), N'', 2, 1)
GO
INSERT [dbo].[Usuario] ([ID_Usuario], [Nombre], [Apellido], [Direccion], [Correo_Electronico], [Telefono], [Fecha_Contratacion], [Cargo], [ID_Area], [Estado]) VALUES (19, N'ALEXIA LUCIA', N'LOPEZ INCA', N'', N'', N'', CAST(N'2024-12-01' AS Date), N'', 3, 1)
GO
INSERT [dbo].[Usuario] ([ID_Usuario], [Nombre], [Apellido], [Direccion], [Correo_Electronico], [Telefono], [Fecha_Contratacion], [Cargo], [ID_Area], [Estado]) VALUES (20, N'JAIME', N'NIZAMA CARRAZA', N'', N'', N'', CAST(N'2025-04-07' AS Date), N'', 1, 1)
GO
INSERT [dbo].[Usuario] ([ID_Usuario], [Nombre], [Apellido], [Direccion], [Correo_Electronico], [Telefono], [Fecha_Contratacion], [Cargo], [ID_Area], [Estado]) VALUES (21, N'JESUS CHRTOFER', N'ZELADA ORTIZ', N'', N'', N'', CAST(N'2025-04-08' AS Date), N'', 1, 1)
GO
INSERT [dbo].[Usuario] ([ID_Usuario], [Nombre], [Apellido], [Direccion], [Correo_Electronico], [Telefono], [Fecha_Contratacion], [Cargo], [ID_Area], [Estado]) VALUES (22, N'FABIAN DEL PIERO', N'DOLORIER AÑAZCO', N'', N'', N'', CAST(N'2025-04-09' AS Date), N'', 1, 1)
GO
INSERT [dbo].[Usuario] ([ID_Usuario], [Nombre], [Apellido], [Direccion], [Correo_Electronico], [Telefono], [Fecha_Contratacion], [Cargo], [ID_Area], [Estado]) VALUES (23, N'SEBASTIAN MARTIN', N'DONGO QUEZADA', N'', N'', N'', CAST(N'2025-04-10' AS Date), N'', 1, 1)
GO
SET IDENTITY_INSERT [dbo].[Usuario] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Empresa__CAF3326B3160D2C2]    Script Date: 8/05/2025 12:42:18 ******/
ALTER TABLE [dbo].[Empresa] ADD  CONSTRAINT [UQ__Empresa__CAF3326B3160D2C2] UNIQUE NONCLUSTERED 
(
	[RUC] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Documento] ADD  DEFAULT (getdate()) FOR [Fecha_Creacion]
GO
ALTER TABLE [dbo].[Documento] ADD  DEFAULT (getdate()) FOR [Fecha_Ultima_Modificacion]
GO
ALTER TABLE [dbo].[items_proyecto] ADD  DEFAULT ('No Iniciado') FOR [estado]
GO
ALTER TABLE [dbo].[items_proyecto] ADD  DEFAULT (getdate()) FOR [fecha_creacion]
GO
ALTER TABLE [dbo].[Proyecto] ADD  DEFAULT ('No Iniciado') FOR [estado]
GO
ALTER TABLE [dbo].[Proyecto] ADD  DEFAULT ((0)) FOR [progreso]
GO
ALTER TABLE [dbo].[Proyecto] ADD  DEFAULT (getdate()) FOR [fecha_creacion]
GO
ALTER TABLE [dbo].[Proyecto] ADD  DEFAULT (getdate()) FOR [fecha_actualizacion]
GO
ALTER TABLE [dbo].[Actividad]  WITH CHECK ADD FOREIGN KEY([ID_Usuario])
REFERENCES [dbo].[Usuario] ([ID_Usuario])
GO
ALTER TABLE [dbo].[Area]  WITH CHECK ADD  CONSTRAINT [FK__Area__ID_Empresa__276EDEB3] FOREIGN KEY([ID_Empresa])
REFERENCES [dbo].[Empresa] ([ID_Empresa])
GO
ALTER TABLE [dbo].[Area] CHECK CONSTRAINT [FK__Area__ID_Empresa__276EDEB3]
GO
ALTER TABLE [dbo].[Documento]  WITH CHECK ADD FOREIGN KEY([Autor])
REFERENCES [dbo].[Usuario] ([ID_Usuario])
GO
ALTER TABLE [dbo].[items_proyecto]  WITH CHECK ADD  CONSTRAINT [FK_items_proyecto_Proyecto] FOREIGN KEY([ID_PROYECTO])
REFERENCES [dbo].[Proyecto] ([ID_PROYECTO])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[items_proyecto] CHECK CONSTRAINT [FK_items_proyecto_Proyecto]
GO
ALTER TABLE [dbo].[Proyecto]  WITH CHECK ADD  CONSTRAINT [FK_Proyecto_Usuario] FOREIGN KEY([ID_Usuario])
REFERENCES [dbo].[Usuario] ([ID_Usuario])
GO
ALTER TABLE [dbo].[Proyecto] CHECK CONSTRAINT [FK_Proyecto_Usuario]
GO
ALTER TABLE [dbo].[Rol_Usuario]  WITH CHECK ADD FOREIGN KEY([ID_Rol])
REFERENCES [dbo].[Rol] ([ID_Rol])
GO
ALTER TABLE [dbo].[Rol_Usuario]  WITH CHECK ADD FOREIGN KEY([ID_Usuario])
REFERENCES [dbo].[Usuario] ([ID_Usuario])
GO
ALTER TABLE [dbo].[Solicitud_Tiempo_Libre]  WITH CHECK ADD FOREIGN KEY([ID_Usuario])
REFERENCES [dbo].[Usuario] ([ID_Usuario])
GO
ALTER TABLE [dbo].[Usuario]  WITH CHECK ADD  CONSTRAINT [FK__Usuario__ID_Area__2B3F6F97] FOREIGN KEY([ID_Area])
REFERENCES [dbo].[Area] ([ID_Area])
GO
ALTER TABLE [dbo].[Usuario] CHECK CONSTRAINT [FK__Usuario__ID_Area__2B3F6F97]
GO
ALTER TABLE [dbo].[Actividad]  WITH CHECK ADD  CONSTRAINT [CK_Actividad_Estado] CHECK  (([Estado]='Cancelado' OR [Estado]='Completado' OR [Estado]='En progreso' OR [Estado]='Pendiente'))
GO
ALTER TABLE [dbo].[Actividad] CHECK CONSTRAINT [CK_Actividad_Estado]
GO
ALTER TABLE [dbo].[items_proyecto]  WITH CHECK ADD  CONSTRAINT [CK_Items_Estado] CHECK  (([estado]='Completado' OR [estado]='En Proceso' OR [estado]='Iniciado' OR [estado]='No Iniciado'))
GO
ALTER TABLE [dbo].[items_proyecto] CHECK CONSTRAINT [CK_Items_Estado]
GO
ALTER TABLE [dbo].[Proyecto]  WITH CHECK ADD  CONSTRAINT [CK_Proyecto_Estado] CHECK  (([estado]='Cancelado' OR [estado]='Completado' OR [estado]='En Proceso' OR [estado]='Iniciado' OR [estado]='No Iniciado'))
GO
ALTER TABLE [dbo].[Proyecto] CHECK CONSTRAINT [CK_Proyecto_Estado]
GO
ALTER TABLE [dbo].[Solicitud_Tiempo_Libre]  WITH CHECK ADD CHECK  (([Estado]='Rechazada' OR [Estado]='Aprobada' OR [Estado]='Pendiente'))
GO
/****** Object:  StoredProcedure [dbo].[Listar_Actividad_Por_ID]    Script Date: 8/05/2025 12:42:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Listar_Actividad_Por_ID]
    @ID_Actividad INT
AS
BEGIN
    SELECT * FROM Actividad
    WHERE ID_Actividad = @ID_Actividad;
END;
GO
/****** Object:  StoredProcedure [dbo].[Listar_Actividad_Por_Titulo]    Script Date: 8/05/2025 12:42:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Listar_Actividad_Por_Titulo]
    @Titulo VARCHAR(50)
AS
BEGIN
    SELECT * FROM Actividad
    WHERE Titulo LIKE '%' + @Titulo + '%';
END;
GO
/****** Object:  StoredProcedure [dbo].[Listar_Area_Por_ID]    Script Date: 8/05/2025 12:42:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Listar_Area_Por_ID]
    @ID_Area TINYINT
AS
BEGIN
    SELECT * FROM Area
    WHERE ID_Area = @ID_Area;
END;
GO
/****** Object:  StoredProcedure [dbo].[Listar_Area_Por_Nombre]    Script Date: 8/05/2025 12:42:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Listar_Area_Por_Nombre]
    @Nombre VARCHAR(100)
AS
BEGIN
    SELECT * FROM Area
    WHERE Nombre LIKE '%' + @Nombre + '%';
END;
GO
/****** Object:  StoredProcedure [dbo].[Listar_Documento_Por_ID]    Script Date: 8/05/2025 12:42:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Listar_Documento_Por_ID]
    @ID_Documento INT
AS
BEGIN
    SELECT * FROM Documento
    WHERE ID_Documento = @ID_Documento;
END;
GO
/****** Object:  StoredProcedure [dbo].[Listar_Documento_Por_Titulo]    Script Date: 8/05/2025 12:42:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Listar_Documento_Por_Titulo]
    @Titulo VARCHAR(100)
AS
BEGIN
    SELECT * FROM Documento
    WHERE Titulo LIKE '%' + @Titulo + '%';
END;
GO
/****** Object:  StoredProcedure [dbo].[Listar_Empresa_Por_ID]    Script Date: 8/05/2025 12:42:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Listar_Empresa_Por_ID]
    @ID_Empresa TINYINT
AS
BEGIN
    SELECT * FROM Empresa
    WHERE ID_Empresa = @ID_Empresa;
END;
GO
/****** Object:  StoredProcedure [dbo].[Listar_Empresa_Por_Nombre]    Script Date: 8/05/2025 12:42:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Listar_Empresa_Por_Nombre]
    @Nombre VARCHAR(100)
AS
BEGIN
    SELECT * FROM Empresa
    WHERE Nombre LIKE '%' + @Nombre + '%';
END;
GO
/****** Object:  StoredProcedure [dbo].[Listar_Usuario_Por_ID]    Script Date: 8/05/2025 12:42:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Listar_Usuario_Por_ID]
    @ID_Usuario INT
AS
BEGIN
    SELECT *
    FROM Usuario
    WHERE ID_Usuario = @ID_Usuario;
END;
GO
/****** Object:  StoredProcedure [dbo].[Listar_Usuario_Por_Nombre]    Script Date: 8/05/2025 12:42:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Listar_Usuario_Por_Nombre]
    @Nombre VARCHAR(50)
AS
BEGIN
    SELECT *
    FROM Usuario
    WHERE Nombre LIKE '%' + @Nombre + '%';
END;
GO
/****** Object:  StoredProcedure [dbo].[ListarProyectosConItems]    Script Date: 8/05/2025 12:42:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Procedimiento para listar proyectos e items_proyecto
CREATE PROCEDURE [dbo].[ListarProyectosConItems]
AS
BEGIN
    SELECT 
        p.id_proyecto,
        p.titulo,
        p.descripcion AS proyecto_descripcion,
        p.fecha_limite,
        p.estado AS proyecto_estado,
        p.progreso,
        p.fecha_creacion AS proyecto_fecha_creacion,
        p.fecha_actualizacion AS proyecto_fecha_actualizacion,
        i.ID_ITEMS,
        i.descripcion AS item_descripcion,
        i.estado AS item_estado,
        i.fecha_creacion AS item_fecha_creacion
    FROM 
        Proyecto p
    LEFT JOIN 
        items_proyecto i ON p.id_proyecto = i.ID_PROYECTO
    ORDER BY 
        p.id_proyecto, i.ID_ITEMS;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_Actualizar_Actividad]    Script Date: 8/05/2025 12:42:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--Actualizar
CREATE PROCEDURE [dbo].[sp_Actualizar_Actividad]
    @ID_Actividad INT,
    @Titulo VARCHAR(50),
    @Descripcion VARCHAR(255),
    @Fecha_Inicio DATE,
    @Fecha_Fin DATE,
    @Estado NVARCHAR(20)
AS
BEGIN
    UPDATE Actividad
    SET Titulo = @Titulo, Descripcion = @Descripcion, 
        Fecha_Inicio = @Fecha_Inicio, Fecha_Fin = @Fecha_Fin, Estado = @Estado
    WHERE ID_Actividad = @ID_Actividad;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_Actualizar_Area]    Script Date: 8/05/2025 12:42:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--Actualizar
CREATE PROCEDURE [dbo].[sp_Actualizar_Area]
    @ID_Area TINYINT,
    @Nombre VARCHAR(100),
    @Descripcion VARCHAR(255),
    @Estado BIT
AS
BEGIN
    UPDATE Area
    SET Nombre = @Nombre, Descripcion = @Descripcion, Estado = @Estado
    WHERE ID_Area = @ID_Area;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_Actualizar_Documento]    Script Date: 8/05/2025 12:42:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--Actualizar
CREATE PROCEDURE [dbo].[sp_Actualizar_Documento]
    @ID_Documento INT,
    @Titulo VARCHAR(100),
    @Descripcion VARCHAR(255),
    @Tipo VARCHAR(50)
AS
BEGIN
    UPDATE Documento
    SET Titulo = @Titulo, Descripcion = @Descripcion, Tipo = @Tipo
    WHERE ID_Documento = @ID_Documento;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_Actualizar_Empresa]    Script Date: 8/05/2025 12:42:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Actualizar Empresa incluyendo RUC
CREATE PROCEDURE [dbo].[sp_Actualizar_Empresa]
    @ID_Empresa TINYINT,
    @Nombre VARCHAR(100),
    @RUC VARCHAR(11),
    @Descripcion VARCHAR(255),
    @Estado BIT
AS
BEGIN
    UPDATE Empresa
    SET 
        Nombre = @Nombre, 
        RUC = @RUC,
        Descripcion = @Descripcion, 
        Estado = @Estado
    WHERE ID_Empresa = @ID_Empresa;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_Actualizar_Estado_ItemsProyecto]    Script Date: 8/05/2025 12:42:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Actualizar_Estado_ItemsProyecto]
    @ID_PROYECTO INT,
    @ID_ITEMS INT,
    @NuevoEstado NVARCHAR(50)
AS
BEGIN
    UPDATE [PAYMENTS_DB].[dbo].[items_proyecto]
    SET estado = @NuevoEstado
    WHERE ID_PROYECTO = @ID_PROYECTO AND ID_ITEMS = @ID_ITEMS;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_Actualizar_Proyecto]    Script Date: 8/05/2025 12:42:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Actualizar_Proyecto]
    @id_proyecto INT,
    @titulo VARCHAR(100),
    @descripcion VARCHAR(MAX),
    @fecha_limite DATE,
    @id_usuario INT,
    @progreso INT,
    @estado VARCHAR(20)
AS
BEGIN
    UPDATE Proyecto
    SET
        titulo = @titulo,
        descripcion = @descripcion,
        fecha_limite = @fecha_limite,
        id_usuario = @id_usuario,
        progreso = @progreso,
        estado = @estado,
        fecha_actualizacion = GETDATE()
    WHERE id_proyecto = @id_proyecto;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_Actualizar_Solicitud_Tiempo_Libre]    Script Date: 8/05/2025 12:42:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--Actualizar
CREATE PROCEDURE [dbo].[sp_Actualizar_Solicitud_Tiempo_Libre]
    @ID_Solicitud INT,
    @Tipo_Tiempo_Libre VARCHAR(50),
    @Fecha_Inicio DATE,
    @Fecha_Fin DATE,
    @Estado NVARCHAR(20)
AS
BEGIN
    UPDATE Solicitud_Tiempo_Libre
    SET Tipo_Tiempo_Libre = @Tipo_Tiempo_Libre, 
        Fecha_Inicio = @Fecha_Inicio, Fecha_Fin = @Fecha_Fin, Estado = @Estado
    WHERE ID_Solicitud = @ID_Solicitud;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_Actualizar_Usuario]    Script Date: 8/05/2025 12:42:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--Actualizar
CREATE PROCEDURE [dbo].[sp_Actualizar_Usuario]
    @ID_Usuario INT,
    @Nombre VARCHAR(50),
    @Apellido VARCHAR(50),
    @Direccion VARCHAR(255),
    @Correo_Electronico VARCHAR(100),
    @Telefono VARCHAR(15),
    @Fecha_Contratacion DATE,
    @Cargo VARCHAR(100),
    @Estado BIT
AS
BEGIN
    UPDATE Usuario
    SET Nombre = @Nombre, Apellido = @Apellido, Direccion = @Direccion, 
        Correo_Electronico = @Correo_Electronico, Telefono = @Telefono, 
        Fecha_Contratacion = @Fecha_Contratacion, Cargo = @Cargo, Estado = @Estado
    WHERE ID_Usuario = @ID_Usuario;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_Eliminar_Actividad]    Script Date: 8/05/2025 12:42:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--Eliminar
CREATE PROCEDURE [dbo].[sp_Eliminar_Actividad]
    @ID_Actividad INT
AS
BEGIN
    DELETE FROM Actividad
    WHERE ID_Actividad = @ID_Actividad;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_Eliminar_Area]    Script Date: 8/05/2025 12:42:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--Eliminar
CREATE PROCEDURE [dbo].[sp_Eliminar_Area]
    @ID_Area TINYINT
AS
BEGIN
    DELETE FROM Area
    WHERE ID_Area = @ID_Area;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_Eliminar_Documento]    Script Date: 8/05/2025 12:42:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--Eliminar
CREATE PROCEDURE [dbo].[sp_Eliminar_Documento]
    @ID_Documento INT
AS
BEGIN
    DELETE FROM Documento
    WHERE ID_Documento = @ID_Documento;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_Eliminar_Empresa]    Script Date: 8/05/2025 12:42:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--Eliminar
CREATE PROCEDURE [dbo].[sp_Eliminar_Empresa]
    @ID_Empresa TINYINT
AS
BEGIN
    DELETE FROM Empresa
    WHERE ID_Empresa = @ID_Empresa;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_Eliminar_ItemsProyecto]    Script Date: 8/05/2025 12:42:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Eliminar_ItemsProyecto]
    @ID_PROYECTO INT
AS
BEGIN
    DELETE FROM [PAYMENTS_DB].[dbo].[items_proyecto]
    WHERE ID_PROYECTO = @ID_PROYECTO;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_Eliminar_Solicitud_Tiempo_Libre]    Script Date: 8/05/2025 12:42:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--Eliminar
CREATE PROCEDURE [dbo].[sp_Eliminar_Solicitud_Tiempo_Libre]
    @ID_Solicitud INT
AS
BEGIN
    DELETE FROM Solicitud_Tiempo_Libre
    WHERE ID_Solicitud = @ID_Solicitud;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_Eliminar_Usuario]    Script Date: 8/05/2025 12:42:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--Eliminar
CREATE PROCEDURE [dbo].[sp_Eliminar_Usuario]
    @ID_Usuario INT
AS
BEGIN
    DELETE FROM Usuario
    WHERE ID_Usuario = @ID_Usuario;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_Insertar_Actividad]    Script Date: 8/05/2025 12:42:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--Insertar
CREATE PROCEDURE [dbo].[sp_Insertar_Actividad]
    @ID_Usuario INT,
    @Titulo VARCHAR(50),
    @Descripcion VARCHAR(255),
    @Fecha_Inicio DATE,
    @Fecha_Fin DATE,
    @Estado NVARCHAR(20)
AS
BEGIN
    INSERT INTO Actividad (ID_Usuario, Titulo, Descripcion, Fecha_Inicio, Fecha_Fin, Estado)
    VALUES (@ID_Usuario, @Titulo, @Descripcion, @Fecha_Inicio, @Fecha_Fin, @Estado);
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_Insertar_Area]    Script Date: 8/05/2025 12:42:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--Insertar
CREATE PROCEDURE [dbo].[sp_Insertar_Area]
    @Nombre VARCHAR(100),
    @Descripcion VARCHAR(255),
    @ID_Empresa TINYINT,
    @Estado BIT
AS
BEGIN
    INSERT INTO Area (Nombre, Descripcion, ID_Empresa, Estado)
    VALUES (@Nombre, @Descripcion, @ID_Empresa, @Estado);
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_Insertar_Documento]    Script Date: 8/05/2025 12:42:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--Insertar
CREATE PROCEDURE [dbo].[sp_Insertar_Documento]
    @Titulo VARCHAR(100),
    @Descripcion VARCHAR(255),
    @Tipo VARCHAR(50),
    @Autor INT
AS
BEGIN
    INSERT INTO Documento (Titulo, Descripcion, Tipo, Autor)
    VALUES (@Titulo, @Descripcion, @Tipo, @Autor);
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_Insertar_Empresa]    Script Date: 8/05/2025 12:42:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Insertar
CREATE PROCEDURE [dbo].[sp_Insertar_Empresa]
    @Nombre VARCHAR(100),
    @RUC VARCHAR(15),
    @Descripcion VARCHAR(255),
    @Estado BIT
AS
BEGIN
    INSERT INTO Empresa (Nombre, RUC, Descripcion, Estado)
    VALUES (@Nombre, @RUC, @Descripcion, @Estado);
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_Insertar_ItemProyecto]    Script Date: 8/05/2025 12:42:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_Insertar_ItemProyecto]
    @id_proyecto INT,
    @descripcion VARCHAR(MAX),
    @estado VARCHAR(20) = 'No Iniciado'
AS
BEGIN
    INSERT INTO items_proyecto (ID_PROYECTO, descripcion, estado)
    VALUES (@id_proyecto, @descripcion, @estado);

    SELECT SCOPE_IDENTITY() AS id_item;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_Insertar_Proyecto]    Script Date: 8/05/2025 12:42:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Procedimiento almacenado para agregar un nuevo proyecto
CREATE PROCEDURE [dbo].[sp_Insertar_Proyecto]
    @titulo VARCHAR(100),
    @descripcion VARCHAR(MAX),
    @fecha_limite DATE,
    @id_usuario INT,
    @progreso INT = 0, -- Valor por defecto es 0
    @estado VARCHAR(20) = 'No Iniciado' -- Valor por defecto es 'No Iniciado'
AS
BEGIN
    -- Insertar un nuevo proyecto en la tabla Proyecto
    INSERT INTO Proyecto (titulo, descripcion, fecha_limite, id_usuario, progreso, estado)
    VALUES (@titulo, @descripcion, @fecha_limite, @id_usuario, @progreso, @estado);

    -- Puedes devolver el ID del proyecto recién insertado si es necesario
    SELECT SCOPE_IDENTITY() AS id_proyecto;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_Insertar_Solicitud_Tiempo_Libre]    Script Date: 8/05/2025 12:42:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--Insertar
CREATE PROCEDURE [dbo].[sp_Insertar_Solicitud_Tiempo_Libre]
    @ID_Usuario INT,
    @Tipo_Tiempo_Libre VARCHAR(50),
    @Fecha_Inicio DATE,
    @Fecha_Fin DATE,
    @Estado NVARCHAR(20)
AS
BEGIN
    INSERT INTO Solicitud_Tiempo_Libre (ID_Usuario, Tipo_Tiempo_Libre, Fecha_Inicio, Fecha_Fin, Estado)
    VALUES (@ID_Usuario, @Tipo_Tiempo_Libre, @Fecha_Inicio, @Fecha_Fin, @Estado);
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_Insertar_Usuario]    Script Date: 8/05/2025 12:42:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--Insertar
CREATE PROCEDURE [dbo].[sp_Insertar_Usuario]
    @Nombre VARCHAR(50),
    @Apellido VARCHAR(50),
    @Direccion VARCHAR(255),
    @Correo_Electronico VARCHAR(100),
    @Telefono VARCHAR(15),
    @Fecha_Contratacion DATE,
    @Cargo VARCHAR(100),
    @ID_Area TINYINT,
    @Estado BIT
AS
BEGIN
    INSERT INTO Usuario (Nombre, Apellido, Direccion, Correo_Electronico, Telefono, Fecha_Contratacion, Cargo, ID_Area, Estado)
    VALUES (@Nombre, @Apellido, @Direccion, @Correo_Electronico, @Telefono, @Fecha_Contratacion, @Cargo, @ID_Area, @Estado);
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_Listar_Actividad]    Script Date: 8/05/2025 12:42:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--Procedimientos para la Tabla Actividad
--Listar
CREATE PROCEDURE [dbo].[sp_Listar_Actividad]
AS
BEGIN
    SELECT * FROM Actividad;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_Listar_Area]    Script Date: 8/05/2025 12:42:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--Procedimientos para la Tabla Area
--Listar
CREATE PROCEDURE [dbo].[sp_Listar_Area]
AS
BEGIN
    SELECT * FROM Area;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_Listar_Documento]    Script Date: 8/05/2025 12:42:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--Procedimientos para la Tabla Documento
--Listar
CREATE PROCEDURE [dbo].[sp_Listar_Documento]
AS
BEGIN
    SELECT * FROM Documento;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_Listar_Empresa]    Script Date: 8/05/2025 12:42:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- Procedimientos para la Tabla Empresa
--Listar
CREATE PROCEDURE [dbo].[sp_Listar_Empresa]
AS
BEGIN
    SELECT * FROM Empresa;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_Listar_items_proyecto]    Script Date: 8/05/2025 12:42:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Listar_items_proyecto]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        ID_ITEMS,
        ID_PROYECTO,
        descripcion,
        estado,
        fecha_creacion
    FROM items_proyecto;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_Listar_items_proyecto_por_id]    Script Date: 8/05/2025 12:42:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Listar_items_proyecto_por_id]
    @ID_PROYECTO INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        ID_ITEMS,
        ID_PROYECTO,
        descripcion,
        estado,
        fecha_creacion
    FROM items_proyecto
    WHERE ID_PROYECTO = @ID_PROYECTO;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_Listar_Proyecto]    Script Date: 8/05/2025 12:42:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_Listar_Proyecto]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        id_proyecto,
        titulo,
        descripcion,
        fecha_limite,
        estado,
        id_usuario,
        progreso,
        fecha_creacion,
        fecha_actualizacion
    FROM Proyecto;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_Listar_Solicitud_Tiempo_Libre]    Script Date: 8/05/2025 12:42:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--Procedimientos para la Tabla Solicitud_Tiempo_Libre
--Listar
CREATE PROCEDURE [dbo].[sp_Listar_Solicitud_Tiempo_Libre]
AS
BEGIN
    SELECT * FROM Solicitud_Tiempo_Libre;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_Listar_Usuario]    Script Date: 8/05/2025 12:42:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--Procedimientos para la Tabla Usuario
--Listar
CREATE PROCEDURE [dbo].[sp_Listar_Usuario]
AS
BEGIN
    SELECT * FROM Usuario;
END;
GO
