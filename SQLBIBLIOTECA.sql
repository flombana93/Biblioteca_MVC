create database DB_BIBLIOTECA

GO

USE DB_BIBLIOTECA

GO

CREATE TABLE AUTORES(
AutorID int primary key identity,
Nombre varchar(100)
)

CREATE TABLE LIBRO(
ID int primary key identity,
Titulo varchar(100),
AutorID int references AUTORES (AutorID)
)

--PROCEDIMIENTO PARA GUARDAR AUTORES
CREATE PROC sp_RegistrarAutor(
@Nombre varchar(100),
@Resultado bit output
)
as
begin
	SET @Resultado = 1
	IF NOT EXISTS (SELECT * FROM AUTORES WHERE Nombre = @Nombre)

		insert into AUTORES(Nombre) values (@Nombre)
	ELSE
		SET @Resultado = 0

end
go

--PROCEDIMIENTO PARA MODIFICAR AUTORES
create procedure sp_ModificarAutor(
@AutorID int,
@Nombre varchar(100),
@Resultado bit output
)
as
begin
	SET @Resultado = 1
	IF NOT EXISTS (SELECT * FROM AUTORES WHERE Nombre=@Nombre and AutorID != @AutorID)

		update AUTORES set
		Nombre=@Nombre
		where AutorID=@AutorID
	ELSE
		SET @Resultado=0
END

GO

--PROCEDIMIENTO PARA REGISTRAR LIBROS
create proc sp_RegistrarLibro(
@Titulo varchar(100),
@AutorID int,
@Resultado int output
)
as
begin
	SET @Resultado=0;
	IF NOT EXISTS (SELECT * FROM LIBRO WHERE Titulo=@Titulo)
	begin
		insert into LIBRO (Titulo, AutorID) values (@Titulo, @AutorID)
		SET @Resultado = SCOPE_IDENTITY()
	end
end

go

--PROCEDIMIENTO PARA MODIFICAR LIBROS
create procedure sp_ModificarLibro(
@ID int,
@Titulo varchar(100),
@AutorID int,
@Resultado bit output
)
as
begin
	SET @Resultado=0
	IF NOT EXISTS (SELECT * FROM LIBRO WHERE Titulo = @Titulo and ID != @ID)
	begin
		update LIBRO set
		Titulo = @Titulo,
		AutorID =@AutorID
		where ID=@ID
		SET @Resultado =1
	END
END
GO

