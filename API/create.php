<?php 
include "db.php";

if(isset($_POST["name"]) && isset($_POST["mobile"])) 
{
    $mobile = $_POST["mobile"];
    $name = $_POST["name"];

    $sql = "SELECT * FROM user WHERE mobile = '$mobile'";

    $run = $con->query($sql);

    if($run->num_rows>0)
    {
        echo "user already registered";
    }
    else
    {
        $query = "INSERT INTO user (name,mobile) VALUES ('$name','$mobile')";
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
}

?>