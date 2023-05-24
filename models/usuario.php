<?php

require_once 'conexion.php'; //le decimos que requerimos del archivo conexion

class Usuario extends Conexion{ // creamos una clase llamada usuario que herede la clase Conexion

  private $acceso; //declaramos privada a la variable acceso

  //Constructor
  public function __CONSTRUCT(){ //creamos una funcion con el metodo construc (para que se ejecute automaticamente al crear una instancia de la clase)
    $this->acceso = parent::getConexion(); //llamamos al metodo get conexion de la clase padre (se asume que existe una clase paadre llama conexion)
  }

  public function iniciarSesion($nombreUsuario = ""){ //creamos una funcion llamada iniciar session donde le agregamos como parametros una variable vacia llamada nombreusuario
    try{ // con el try catch capturamos cualquier excepcion que ocurra durante la ejecucion de la consulta
      $consulta = $this->acceso->prepare("CALL spu_usuarios_login(?)"); //preparamos la consulta utilizando la sentencia sql, le agregamos el signo que es un marcador de posicion para el parametro nombreusuario 
      $consulta->execute(array($nombreUsuario)); //se ejecuta la consulta pasando el valor del parametro nombre usuario
                //execute(array($nombreUsuario)) ejecuta la consulta y obtiene los resultados 
      return $consulta->fetch(PDO::FETCH_ASSOC); //obtenemos una fila de resultados como un array asosiativo
      // el PDO::FETCH_ASSOC indica que se desea obtener el resultado como un array asosiativo
    }
    catch(Exception $e){
      die($e->getMessage());
      //En caso de que ocurra una excepcion, muestra el mensaje de error y detiene la ejecucion del script
    }
  }

}

?>