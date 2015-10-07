<?php

// Helper method to get a string description for an HTTP status code
function getStatusCodeMessage($status)
{
    $codes = Array(
        100 => 'Continue',
        101 => 'Switching Protocols',
        200 => 'OK',
        201 => 'Created',
        202 => 'Accepted',
        203 => 'Non-Authoritative Information',
        204 => 'No Content',
        205 => 'Reset Content',
        206 => 'Partial Content',
        300 => 'Multiple Choices',
        301 => 'Moved Permanently',
        302 => 'Found',
        303 => 'See Other',
        304 => 'Not Modified',
        305 => 'Use Proxy',
        306 => '(Unused)',
        307 => 'Temporary Redirect',
        400 => 'Bad Request',
        401 => 'Unauthorized',
        402 => 'Payment Required',
        403 => 'Forbidden',
        404 => 'Not Found',
        405 => 'Method Not Allowed',
        406 => 'Not Acceptable',
        407 => 'Proxy Authentication Required',
        408 => 'Request Timeout',
        409 => 'Conflict',
        410 => 'Gone',
        411 => 'Length Required',
        412 => 'Precondition Failed',
        413 => 'Request Entity Too Large',
        414 => 'Request-URI Too Long',
        415 => 'Unsupported Media Type',
        416 => 'Requested Range Not Satisfiable',
        417 => 'Expectation Failed',
        500 => 'Internal Server Error',
        501 => 'Not Implemented',
        502 => 'Bad Gateway',
        503 => 'Service Unavailable',
        504 => 'Gateway Timeout',
        505 => 'HTTP Version Not Supported'
    );

    return (isset($codes[$status])) ? $codes[$status] : '';
}

// Helper method to send a HTTP response code/message
function sendResponse($status = 200, $body = '', $content_type = 'text/html') {
    $status_header = 'HTTP/1.1 ' . $status . ' ' . getStatusCodeMessage($status);
    header($status_header);
    header('Content-type: ' . $content_type);
    echo $body;
}

// pasword hashing/verification functions
function pw_hash($p) {
    return md5("anjoui" . $p . "foods" . $p . "taste_better_with_salt");
}

function pw_verify($p, $hash) {
    if (pw_hash($p) == $hash) {
        return true;
    }
    return false;
}

// getting values from POST (set default if not there)
function getPost($key, $default) {
    if (isset($_POST[$key]))
        return $_POST[$key];
    return $default;
}

// sourced from https://github.com/tazotodua/useful-php-scripts/blob/master/get-remote-url-content-data.php
function get_remote_data($url, $post_paramtrs=false)    {
    $c = curl_init();
    curl_setopt($c, CURLOPT_URL, $url);
    curl_setopt($c, CURLOPT_RETURNTRANSFER, 1);
    //if parameters were passed to this function, then transform into POST method.. (if you need GET request, then simply change the passed URL)
    if ($post_paramtrs) {
        curl_setopt($c, CURLOPT_POST,TRUE);
        curl_setopt($c, CURLOPT_POSTFIELDS, $post_paramtrs );
    }
    curl_setopt($c, CURLOPT_SSL_VERIFYHOST,false);
    curl_setopt($c, CURLOPT_SSL_VERIFYPEER,false);
    curl_setopt($c, CURLOPT_USERAGENT, "Mozilla/5.0 (Windows NT 6.1; rv:33.0) Gecko/20100101 Firefox/33.0");
    curl_setopt($c, CURLOPT_COOKIE, 'CookieName1=Value;');
                    //We'd better to use the above command, because the following command gave some weird STATUS results..
                    //$header[0]= $user_agent="User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:33.0) Gecko/20100101 Firefox/33.0";  $header[]="Cookie:CookieName1=Value;"; $header[]="Accept: text/xml,application/xml,application/xhtml+xml,text/html;q=0.9,text/plain;q=0.8,image/png,*/*;q=0.5";  $header[]="Cache-Control: max-age=0"; $header[]="Connection: keep-alive"; $header[]="Keep-Alive: 300"; $header[]="Accept-Charset: ISO-8859-1,utf-8;q=0.7,*;q=0.7"; $header[] = "Accept-Language: en-us,en;q=0.5"; $header[] = "Pragma: ";  curl_setopt($c, CURLOPT_HEADER, true);     curl_setopt($c, CURLOPT_HTTPHEADER, $header);

    curl_setopt($c, CURLOPT_MAXREDIRS, 10);
    $follow_allowed = ( ini_get('open_basedir') || ini_get('safe_mode')) ? false:true;  if ($follow_allowed){curl_setopt($c, CURLOPT_FOLLOWLOCATION, 1);}
    curl_setopt($c, CURLOPT_CONNECTTIMEOUT, 9);
    curl_setopt($c, CURLOPT_REFERER, $url);
    curl_setopt($c, CURLOPT_TIMEOUT, 60);
    curl_setopt($c, CURLOPT_AUTOREFERER, true);
    curl_setopt($c, CURLOPT_ENCODING, 'gzip,deflate');
    $data = curl_exec($c);
    $status = curl_getinfo($c);
    curl_close($c);

    preg_match('/(http(|s)):\/\/(.*?)\/(.*\/|)/si',  $status['url'],$link);
    //correct assets URLs(i.e. retrieved url is: http://site.com/DIR/SUBDIR/page.html... then href="./image.JPG" becomes href="http://site.com/DIR/SUBDIR/image.JPG", but  href="/image.JPG" needs to become href="http://site.com/image.JPG")

    //inside all links(except starting with HTTP,javascript:,HTTPS,//,/ ) insert that current DIRECTORY url (href="./image.JPG" becomes href="http://site.com/DIR/SUBDIR/image.JPG")
    $data = preg_replace('/(src|href|action)=(\'|\")((?!(http|https|javascript:|\/\/|\/)).*?)(\'|\")/si','$1=$2'.$link[0].'$3$4$5', $data);
    //inside all links(except starting with HTTP,javascript:,HTTPS,//)    insert that DOMAIN url (href="/image.JPG" becomes href="http://site.com/image.JPG")
    $data = preg_replace('/(src|href|action)=(\'|\")((?!(http|https|javascript:|\/\/)).*?)(\'|\")/si','$1=$2'.$link[1].'://'.$link[3].'$3$4$5', $data);
    if ($status['http_code']==200) {
        return $data;
    } elseif ($status['http_code']==301 || $status['http_code']==302) {
        //if we FOLLOWLOCATION was not allowed, then re-get REDIRECTED URL
        //p.s. WE dont need "else", because if FOLLOWLOCATION was allowed, then we wouldnt have come to this place, because 301 could already auto-followed by curl  :)
        if (!$follow_allowed) {
            //if REDIRECT URL is found in HEADER
            if (empty($redirURL)) {
                if (!empty($status['redirect_url'])) {
                    $redirURL=$status['redirect_url'];
                }
            }
            //if REDIRECT URL is found in RESPONSE
            if (empty($redirURL)) {
                preg_match('/(Location:|URI:)(.*?)(\r|\n)/si', $data, $m);
                if (!empty($m[2])){
                    $redirURL=$m[2];
                }
            }
            //if REDIRECT URL is found in OUTPUT
            if (empty($redirURL)) {
                preg_match('/moved\s\<a(.*?)href\=\"(.*?)\"(.*?)here\<\/a\>/si',$data,$m);
                if (!empty($m[1])) {
                    $redirURL=$m[1];
                }
            }
            //if URL found, then re-use this function again, for the found url
            if (!empty($redirURL)) {
                $t=debug_backtrace();
                return call_user_func( $t[0]["function"], trim($redirURL), $post_paramtrs);
            }
        }
    }
    //if not met any return criteria above, then show error
    return "ERRORCODE22 with $url!!<br/>Last status codes:".json_encode($status)."<br/><br/>Last data got:$data";
}

// Start up database connection
$dbhost = 'mysql-instance.cchnutaumqj8.us-west-2.rds.amazonaws.com';
$dbport = '3306';
$dbname = 'mysql_db';

$dsn = "mysql:host={$dbhost};port={$dbport};dbname={$dbname}";
$username = 'mysql_test';
$password = 'GoTeamTBD6!';

$link = mysqli_connect($dbhost, $username, $password);
if (!$link) {
    // echo "Error: Unable to connect to MySQL." . PHP_EOL;
    // echo "Debugging errno: " . mysqli_connect_errno() . PHP_EOL;
    // echo "Debugging error: " . mysqli_connect_error() . PHP_EOL;
    // exit;

    sendResponse(503, 'Connection error.');
    exit;
}

$db_selected = mysqli_select_db($link, $dbname);
if (!$db_selected) {
    sendResponse(404, 'Database not found');
    die ('Can\'t use ' . $dbname . ': ' . mysql_error());
}


?>
