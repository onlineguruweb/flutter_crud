<?php 
include "db.php";

if(isset($_POST["id"]))
{
    $id = $_POST["id"];

    $query = "DELETE FROM user WHERE id=$id";

    $res = $con->query($query);

    if($res)
    {
        echo "true";
    }
    else
    {
        echo "false";
    }
}