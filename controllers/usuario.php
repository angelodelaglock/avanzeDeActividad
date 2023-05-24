<?php
session_start();//Iniciamos session
require_once '../models/usuario.php';//le decimos que requerimos del archivo model usuario

//verifica si existe el parametro operacion en la solicitud get
//y si es asi, creamos una nueva instancia de la clase usuario
if (isset($_GET['operacion'])){

  $usuario = new Usuario();
  
  //si el valor del parametro operacion es destroy, se destruira
  //la session actual y se eliminara todas las variables de session
  if($_GET["operacion"] == "destroy"){
    session_destroy();//destruye la session actual
    session_unset();//elimina todas las variables
    header('Location:../index.html');//redirecciona al archivo index
  }

  //verificia si el parametro operacion en la solicitud get es igual a iniciar session
  if($_GET['operacion'] == 'iniciarSesion'){

    //si es asi inicializa un array llamado acceso
    $acceso = [
      "login"         => false,
      "nombreUsuario" => "",
      "mensaje"       => "",
    ];

    $data = $usuario->iniciarSesion($_GET['nombreUsuario']);
    //llama al metodo iniciar session de la clase usuario y se asigna el resultado a la variable data

    $claveIngresada = $_GET['password'];
    //obtiene la contraseña ingresada a traves de $_GET y se asigna a la variable clave ingresada

    if($data){ //verifica si se obtuvieron los datos de inicio
      if(password_verify($claveIngresada, $data["claveAcceso"])){ //verificamos si la contraseña ingresada coinciden
        $acceso["login"] = true; //le indicamos que el inicio de session fue exitoso
        $acceso["nombreUsuario"] = $data["nombreUsuario"];//se asigna el nombre de usuario obtenido a la propiedad "nombre usuario" en el array acceso
      }else{
        $acceso["mensaje"] = "Error en la contraseña";//si la contraseña no coinciden
        //se asigna un mensaje de error en la propiedad mensaje del array acceso
      }
    }else{
      $acceso["mensaje"] = "Usuario no encontrado";//si no se obtuvieron datos
      //se asigna un mensaje de error en la propiedad mensaje del array acceso
    }

    $_SESSION["seguridad"] = $acceso;
    // asigna el array acceso a la variable de session

    echo json_encode($acceso);
    //Convierte el array acceso a formato JSON 
  }
}