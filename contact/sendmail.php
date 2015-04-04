<?php
//*****************************************************************************
//
// MICRO MAILER  -  Version: 1.0
//
// You may use this code or any modified version of it on your website.
//
// NO WARRANTY
// This code is provided "as is" without warranty of any kind, either
// expressed or implied, including, but not limited to, the implied warranties
// of merchantability and fitness for a particular purpose. You expressly
// acknowledge and agree that use of this code is at your own risk.
//
// USAGE
// For usage information see the attached example.php file.
//
// Last modifiaction: 2007-05-16
//
//***************************************************************************** 

class MicroMailer{
  var $to         = "";
  var $subject    = "";
  var $message    = "";
  var $fromName   = "";
  var $fromEmail  = "";
  var $replyEmail = "";
  var $header     = "";
  var $type       = "text/plain";
  var $characterSet = "iso-8859-1";
   
  function send(){
    $this->createHeader();
    if (@mail($this->to,$this->subject,$this->message,$this->header)){
      return true;
    } else {
      return false;
    }
  }
  
  /**
   * This function creates the email header information from the class variables.
   *
   * @return String: The complete mail header string
   */
  function createHeader(){
    $from   = "From: $this->fromName <$this->fromEmail>\r\n";
    $replay = "Reply-To: $this->replyEmail\r\n";  
    $params = "MIME-Version: 1.0\r\n";
    $params .= "Content-type: $this->type; charset=$this->characterSet\r\n";
    
    $this->header = $from.$replay.$params;
    return $this->header;
  }
}

$mailer = new MicroMailer();

$body  = "Nom    : ".(isset($_POST['nom']) ? $_POST['nom'] : "{pas de nom}");
$body .= "\nE-mail : ".(isset($_POST['email']) ? $_POST['email'] : "{pas d'email}");
$body .= "\nURL    : ".(isset($_POST['url']) ? $_POST['url'] : "{pas d'URL}");
$body .= "\n\n".(isset($_POST['message']) ? $_POST['message'] : "{pas de message}");

$mailer->characterSet = "utf-8";
$mailer->to           = "contact@plugfr.org";
// $mailer->to           = "jeremy.lecour@gmail.com";
$mailer->fromName     = isset($_POST['nom']) ? $_POST['nom'] : "Site web";
$mailer->fromEmail    = (isset($_POST['email']) && $_POST['email'] != "") ? $_POST['email'] : "contact@plugfr.org";
if ( isset($_POST['email']) && $_POST['email'] != "" ) {
  $mailer->replyEmail = $_POST['email'];
}
$mailer->subject      = "[PLUG] Contact par le site";
$mailer->message      = $body;
      
if ($mailer->send()) {
  header('Location: /contact/ok/');
} else {
  header('Location: /contact/error/');
}
?>