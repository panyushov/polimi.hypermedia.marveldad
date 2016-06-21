<?php
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
			$sqlSl = "SELECT * FROM ".TAB_SL." WHERE idSmartLife = {$sid}";
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
			
			$toJ = $sl;
			
		}
		
		
	}
	

	echo json_encode($toJ, JSON_NUMERIC_CHECK);

	//echo '<pre>',print_r($_GET,true),'</pre>';




?>