<?php
	include_once("log.php");
	
	
	function changeApplicationXmlVersions($file, $parent_url, $verstr)
	{
		$url = str_ireplace("\\", "/", $parent_url );

		$doc = new DOMDocument();
		$doc->load($file);
		
		$app = $doc->getElementsByTagName("app");
		foreach($app as $ai)
		{
			echo "上次更新时间：".$ai -> getAttribute("version")."<br>";
			$ai -> setAttribute("version", getTimeStringNow()." ".$verstr );
			echo "本次更新时间：".$ai -> getAttribute("version")."<br>";
		}

		$assests = $doc->getElementsByTagName("asset");

		$array = array();

		foreach($assests as $ai)
		{
			$src = $ai->getAttribute("src");
			$id = $ai->getAttribute("id");
			$src = "assets".substr($src, strrpos($src, "/" ));
			$file_url = $url.$src;
			if ( file_exists($file_url))
			{
				// 生成md5
				$md5_str = md5_file($file_url);
				$new_src = str_ireplace($id, $md5_str, $src);
				$new_name = str_ireplace($id, $md5_str, $file_url);

				// 修改配置
				$ai -> setAttribute("src", $new_src);
				// 重命名文件名
				rename($file_url, $new_name);

				$array[$md5_str] = 1;
			}
		}

		$doc->save($file);

		return $array;
	}

	function changeLocalVersionTime($file, $verstr)
	{
		$doc = new DOMDocument();
		$doc->load($file);
		
		$app = $doc->getElementsByTagName("app");
		foreach($app as $ai)
		{
			$ai -> setAttribute( "version", getTimeStringNow()." ".$verstr );
		}

		$doc->save($file);
	}

	function getTimeStringNow()
	{
		$ary = getdate(strtotime("now"));
		return $ary["year"]."-".getStr($ary["mon"])."-".getStr($ary["mday"])." ".getStr($ary["hours"]).":".getStr($ary["minutes"]).":".getStr($ary["seconds"]);
		//return date('Y-m-d H:m:s', strtotime("now"));
	}

	function getStr($time)
	{
		if ( $time < 10 ) {
			return "0".$time;
		}
		return $time;
	}

	
?>