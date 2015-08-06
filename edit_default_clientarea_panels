<?php                                                                          

if (!defined("WHMCS"))                                                        
    die("This file cannot be accessed directly");                              

use WHMCS\User\Client;                                                        
use WHMCS\View\Menu\Item;                                                      

add_hook('ClientAreaHomepagePanels', 1, function($homePagePanels) {            

  $currentUser        = Client::find( $_SESSION['uid'] );
  $values['clientid'] = $currentUser->id;
  $results            = localAPI('getclientsproducts',$values,'AdminUserName');

  $html = '<ul>';
  foreach ( $results['products'] as $products ) {
    foreach ( $products as $product ) {
      $pname = strlen( $product['name'] ) > 24 ? substr( $product['name'],0,24) . "..." : $product['name'];
      if ( $product['status'] === 'Active' ) {
        $html .= '<li><a href="/clients/clientarea.php?action=productdetails&id=' . $product['id'] . '">' . $pname . '</a></li>';
      }
    }
  }
  $html .= '</ul>';
  $panel = $homePagePanels->addChild(
    'Active Products/Services',
    array(
      'name'     => 'Active Products/Services',
      'label'    => 'Your Active Products/Services',
      'icon'     => 'fa-cube',
      'order'    => '100',
      'bodyHtml' => $html,
      'extras'   => array(
        'color'    => 'orange',
        'btn-link' => 'https://example.com/clients/clientarea.php?action=services',
        'btn-text' => Lang::trans('View All'),
        'btn-icon' => 'fa-plus',
      ),
    )
  );
  /*
  $panel->addChild(
    'unique-css-name-id1',
    array(
      'label' => 'Panel Row Text Goes Here',
      'uri' => 'index.php?m=yourmodule',
      'order' => 10,
    )
  );
  */
});
