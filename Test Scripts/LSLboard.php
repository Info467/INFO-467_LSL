<!DOCTYPE html>
<html>
<head>
  <title></title>
</head>
<body>
<?php
  // this function tweak slightly urlencode to make it behave exactly like llEscapeURL in Second Life.
  function llEscapeURL($s)
  {
    $s=str_replace(
      array(" ","+","-",".","_"),
      array("%20","%20","%2D","%2E","%5F"),
      urlencode($s));
    return $s;
  }   
 
  // this my main SL page XML-RPC page
  function checkHash()
  {
    global $body;
    $hash=$_GET["hash"];
    $body="";
    $cpt=0;
    $SECRET_NUMBER=1596834957202357;
    $SECRET_STRING="iSchoolisSOcool";
 
    foreach ($_POST as $name => $value) {
      if ($cpt++>0) $body.="&";
      if (get_magic_quotes_gpc()) {
        // $name = stripslashes($name); not a good idea though 
        $value = stripslashes($value);
        $_POST[$name]=$value;
      }
      $body.=llEscapeURL($name)."=".llEscapeURL($value);
    }
    $calcHash=md5($body.$SECRET_STRING.':'.$SECRET_NUMBER);
    if ($hash!=$calcHash) 
    {
      sleep(2); // slow down the requests
      echo "result=FAIL\nMSG=Invalid request."; 
      die;
    }
  }
 
  //checkHash();
  // You can use the parameters here by simply using $_POST["parameter_name"] 
  $test = array();
  $name = $_POST["l"];
  array_push($test, $name);
  echo $test;
?>
<h1>LEADERBOARD</h1>
</body>
</html>