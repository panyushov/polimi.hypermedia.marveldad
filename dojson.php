<?php
	// Phonegap stuff
	header('Access-Control-Allow-Origin: *');
	
	function query($db,$sql,$resType = MYSQLI_ASSOC){
		$query = $db->query($sql);
		if(!$query)
			die($db->error);
		return $query->fetch_all($resType);
	}
/*
	function unTag($i){
		if(is_array($i))
			foreach($i as $k=>$v)
				$i[$k] = unTag($v);
		return htmlspecialchars("<b>ciao</b>");
	}

*/
	if($_SERVER['HTTP_HOST'] != 'www.marveldad.altervista.org'){
		define('DEVELOPMENT',true);
		define('ROOT',realpath($_SERVER['DOCUMENT_ROOT']).'/hypermedia/');
	}
	else{
		define('DEVELOPMENT',false);
		define('ROOT',realpath($_SERVER['DOCUMENT_ROOT']).'/');
	}
	require_once ROOT.'core/connect.php';
	
	// doJson.php?get=prodotti
	// doJson.php?get=singleproduct&pid=
	
	
	define('TAB_PRODOTTI','devices');
	define('TAB_IMMAGINI','immagini');
	define('TAB_IMGPROD','imagesindevices');
	define('TAB_SL','smartlife');
	define('TAB_FAQ_SL','faqsmartlife');
	define('TAB_DEV_IN_SL','devicesinsl');
	define('TAB_CATEGORIES','categories');
	
	
	
	$toJ = "";
	foreach($_GET as $k=>$v){
		$_GET[$k] = $db->real_escape_string($v);
	}
	foreach($_POST as $k=>$v){
		$_GET[$k] = $db->real_escape_string($v);
	}
	if(isset($_GET['get'])){
		if( $_GET['get'] == 'prodotti'){
			
			$sql = "SELECT * FROM devices";
			
			$query = $db->query($sql);
			$telefoni = $query->fetch_all(MYSQLI_ASSOC);
			$toJ = $telefoni;
			//echo '<pre>',print_r($telefoni,true),'</pre>';
		}elseif($_GET['get'] == 'singleproduct'){
			
			$pid = $db->real_escape_string($_GET['pid']);
			$sql = "SELECT * FROM ".TAB_PRODOTTI." WHERE idProdotto = ".$pid;
			
			$query = $db->query($sql);
			$telefoni = $query->fetch_all(MYSQLI_ASSOC);
			if(empty($telefoni))
				die(json_encode('No devices found', JSON_NUMERIC_CHECK));
			$sqlImmagini = "SELECT src FROM ".TAB_IMMAGINI." i LEFT JOIN ".TAB_IMGPROD." pi ON pi.rifImage = i.idImmagine WHERE pi.rifDevice = ".$pid;
			$queryImmagini = $db->query($sqlImmagini);
			$immagini = $queryImmagini->fetch_all(MYSQLI_ASSOC);
			
			$ret = $telefoni[0];
			$ret['immagini'] = $immagini;
			
			
			if(isset($_GET['getpromo'])){
				$sqlPromo = "SELECT idProdotto FROM ".TAB_PRODOTTI." WHERE ( 
					idProdotto = IFNULL((SELECT MIN(idProdotto) FROM ".TAB_PRODOTTI." WHERE idProdotto > {$pid} AND inPromo = 1),0) 
					OR idProdotto = IFNULL((SELECT MAX(idProdotto) FROM ".TAB_PRODOTTI." WHERE idProdotto < {$pid} AND inPromo = 1),0)
					)";
				//$sqlPromo = "SELECT a.idProdotto AS nextPromo,  b.idProdotto AS prevPromo FROM ".TAB_PRODOTTI." a, ".TAB_PRODOTTI." b WHERE a.inPromo =1 AND b.inPromo = 1 AND ({$pid}<a.idProdotto) AND ({$pid}>b.idProdotto)";
				$queryPromo = $db->query($sqlPromo);
				$promo = $queryPromo->fetch_all(MYSQLI_NUM);
				if(isset($promo[0]) && isset($promo[1])){
					$ret['promoPrev'] = $promo[0][0];
					$ret['promoNext'] = $promo[1][0];
				}elseif(!isset($promo[1])){
					if($promo[0][0] > $pid)
						$ret['promoNext'] = $promo[0][0];
					else
						$ret['promoPrev'] = $promo[0][0];
				}
			}
			
			// Get prev & next device of same cat
			$sqlCat = "SELECT idProdotto FROM ".TAB_PRODOTTI." WHERE ( 
					idProdotto = IFNULL((SELECT MIN(idProdotto) FROM ".TAB_PRODOTTI." WHERE idProdotto > {$pid} AND rifCategoria = ".$db->real_escape_string($ret['rifCategoria'])."),0) 
					OR idProdotto = IFNULL((SELECT MAX(idProdotto) FROM ".TAB_PRODOTTI." WHERE idProdotto < {$pid} AND rifCategoria = ".$db->real_escape_string($ret['rifCategoria'])."),0)
					)";
			$queryCat = $db->query($sqlCat);
			$cat = $queryCat->fetch_all(MYSQLI_NUM);
			if(isset($cat[0]) && isset($cat[1])){
					$ret['prevInCat'] = $cat[0][0];
					$ret['nextInCat'] = $cat[1][0];
			}elseif(!isset($cat[1])){
				if($cat[0][0] > $pid)
					$ret['nextInCat'] = $cat[0][0];
				else
					$ret['prevInCat'] = $cat[0][0];
			}
			
			$toJ = $ret;
			
		}elseif($_GET['get'] == 'promo'){
			// SIMPLE JOIN: there must be an image for a device in promotion
			$sql = "SELECT * FROM ".TAB_PRODOTTI." p JOIN ".TAB_IMGPROD." pi ON pi.rifDevice = p.idProdotto LEFT JOIN ".TAB_IMMAGINI." i ON pi.rifImage = i.idImmagine WHERE inPromo = 1 GROUP BY idProdotto";
			$query = $db->query($sql);
			if(!$query)
				die($db->error);
			$promo = $query->fetch_all(MYSQLI_ASSOC);
			$toJ = $promo;
		
		}elseif($_GET['get'] == 'singlesl'){
			
			$sid =$_GET['sid'];
			$sqlSl = "SELECT * FROM ".TAB_SL." JOIN ".TAB_CATEGORIES." ON rifCategoria = idCategoria WHERE idSmartLife = {$sid}";
			$querySl = $db->query($sqlSl);
			if(!$querySl)
				die($db->error);
			$sl = $querySl->fetch_all(MYSQLI_ASSOC)[0];
			
			$sqlFaq = "SELECT * FROM ".TAB_FAQ_SL." WHERE rifSmartLife = {$sid}";
			$queryFaq = $db->query($sqlFaq);
			if(!$queryFaq)
				die($db->error);
			$faq = $queryFaq->fetch_all(MYSQLI_ASSOC);
			
			$sl['faq'] = $faq;
			
			// Get the devices associated 
			
			$sqlDevInSl = "SELECT d.*,i.src as image FROM ".TAB_PRODOTTI." d JOIN ".TAB_DEV_IN_SL." dis ON dis.rifDevice = d.idProdotto JOIN ".TAB_SL." s ON dis.rifSmartLife = s.idSmartLife JOIN ".TAB_IMGPROD." id ON id.rifDevice = d.idProdotto JOIN ".TAB_IMMAGINI." i ON i.idImmagine = id.rifImage WHERE s.idSmartLife = {$sid} GROUP BY idProdotto";
			$queryDevInSl = $db->query($sqlDevInSl);
			if(!$queryDevInSl)
				die($db->error);
			$devInSl = $queryDevInSl->fetch_all(MYSQLI_ASSOC);
			
			$sl['assDevices'] = $devInSl;
			
			
			// Get prev & next SL of same cat
			$sqlPNCat = "SELECT idSmartLife FROM ".TAB_SL." WHERE ( 
					idSmartLife = IFNULL((SELECT MIN(idSmartLife) FROM ".TAB_SL." WHERE idSmartLife > {$sid} AND rifCategoria = ".$db->real_escape_string($sl['rifCategoria'])."),0) 
					OR idSmartLife = IFNULL((SELECT MAX(idSmartLife) FROM ".TAB_SL." WHERE idSmartLife < {$sid} AND rifCategoria = ".$db->real_escape_string($sl['rifCategoria'])."),0)
					)";
			$cat = query($db,$sqlPNCat,MYSQLI_NUM);
			if(isset($cat[0]) && isset($cat[1])){
					$sl['prevInCat'] = $cat[0][0];
					$sl['nextInCat'] = $cat[1][0];
			}elseif(!isset($cat[1])){
				if($cat[0][0] > $sid)
					$sl['nextInCat'] = $cat[0][0];
				else
					$sl['prevInCat'] = $cat[0][0];
			}
			
			$toJ = $sl;
			
		}elseif($_GET['get'] == 'slbycat' && isset($_GET['catid'])){
			
			$idCat = $_GET['catid'];
			$resCat = query($db,"SELECT categoria AS nomeCategoria FROM ".TAB_CATEGORIES." WHERE idCategoria = {$idCat} AND tipo = 's' LIMIT 1");
			$toJ['categoria'] = $resCat[0];
			$sqlSLByCat = "SELECT idSmartLife,nome,abstract,image,categoria FROM ".TAB_SL." JOIN ".TAB_CATEGORIES." ON rifCategoria = idCategoria WHERE rifCategoria = {$idCat}";
			$resSLByCat = query($db,$sqlSLByCat);
			
			$toJ['sls'] = $resSLByCat;
			
			
			
		}
		
		
	}
	
	if(isset($_GET['pre']))
		echo '<pre>',print_r($toJ,true),'</pre>';
	echo json_encode($toJ, JSON_NUMERIC_CHECK);
	
	//echo '<pre>',print_r($_GET,true),'</pre>';




?>