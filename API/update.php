<?php 
include "db.php";

if(isset($_POST["name"]) && isset($_POST["mobile"])) 
{
    $mobile = $_POST["mobile"];
    $name = $_POST["name"];
    $id = $_POST["id"];

    
        $query = "UPDATE user SET name='$name', mobile='$mobile' WHERE id='$id'";
        
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
else
{
    echo "Testing";
}

?>