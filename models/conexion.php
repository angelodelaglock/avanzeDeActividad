<?php

class Conexion{

  protected $pdo;

  private function Conectar(){
    $cn = new PDO("mysql:host=localhost;port=3306;dbname=matriculas;charset=UTF8","root","");
    return $cn;
  }

  public function getConexion(){
    try{
      $pdo = $this->Conectar();
      $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
      return $pdo;
    }catch(Exception $e){
      die($e->getMessage());
    }
  }
} //fin de la clase

?>