<?php
$c_http_host = 'cs406.iptime.org';
if(isset($_SERVER['HTTP_CF_CONNECTING_IP']))
{
	$_SERVER['REMOTE_ADDR'] = $_SERVER['HTTP_CF_CONNECTING_IP'];
}
if(/*isset($_SERVER['HTTP_HOST']) && $_SERVER['HTTP_HOST']==$c_http_host && */(is_array($_FILES) && isset($_FILES['image']) || isset($_REQUEST['d'])))
{
	$ip = ip2long($_SERVER['REMOTE_ADDR']);
	$path = "/mirc/$ip";
	if(isset($_REQUEST['d']))
	{
		$filename = str_ireplace('/', '', $_REQUEST['d']);
		if(file_exists(__DIR__ . "$path/$filename"))
		{
			@unlink(__DIR__ . "$path/$filename");
			die('Success: ' . __LINE__);
		}
		else
		{
			die('Error: ' . __LINE__);
		}
	}

	if(!preg_match('@^image/([a-z]+)@i', $_FILES['image']['type'], $matches))
	{
		die('Error: ' . __LINE__);
	}

	$ext = strtolower($matches[1]);
	if($ext=='jpeg')
	{
		$ext = 'jpg';
	}
	else if(!preg_match('/^(gif|png|jpg)$/', $ext))
	{
		die('Error: ' . __LINE__);
	}

	$time = time();
	if(!is_dir(__DIR__ . $path))
	{
		mkdir(__DIR__ . $path, 0707, TRUE);
	}
	while(file_exists(__DIR__ . ($filename = "$path/$time.$ext")))
	{
		$time++;
	}
	if(!move_uploaded_file($_FILES['image']['tmp_name'], __DIR__ . $filename))
	{
		die('Error: ' . __LINE__);
	}
	@chmod(__DIR__ . $filename, 0707);
	echo "http://$c_http_host$filename\r\nto delete: http://$c_http_host/?d=$time.$ext" ;
	exit;
}
