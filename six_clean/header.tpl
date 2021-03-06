<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="{$charset}">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>{if $kbarticle.title}{$kbarticle.title} - {/if}{$pagetitle} - {$companyname}</title>

  {include file="$template/includes/head.tpl"}

  {$headoutput}

</head>
<body>

  {$headeroutput}

  <section id="header">
    <div class="container">
      <!-- Top Bar -->
      <div id="top-nav">
        <!-- Language -->
      {if $languagechangeenabled && count($locales) > 1}<!--1-->
        <div class="pull-right nav">
          <a href="#" class="quick-nav" data-toggle="popover" id="languageChooser"><i class="fa fa-language"></i> {$LANG.chooselanguage} <span class="caret"></span></a>
            <div id="languageChooserContent" class="hidden">
              <ul>
              {foreach from=$locales item=locale}
                <li><a href="{$currentpagelinkback}language={$locale.language}">{$locale.localisedName}</a></li>
              {/foreach}
              </ul>
            </div>
          </div>
      {/if}<!--1 end-->

      <!-- Login/Account Notifications -->
      {if $loggedin}<!--1-->
        <div class="pull-right nav">
          <a href="#" class="quick-nav" data-toggle="popover" id="accountNotifications" data-placement="bottom" title="{lang key="notifications"}"><i class="fa fa-info"></i> {$LANG.notifications} ({$clientAlerts|count})</a>
          <div id="accountNotificationsContent" class="hidden">
          {foreach $clientAlerts as $alert}
            <div class="clientalert text-{$alert->getSeverity()}">{$alert->getMessage()}{if $alert->getLinkText()} <a href="{$alert->getLink()}" class="btn btn-xs btn-{$alert->getSeverity()}">{$alert->getLinkText()}</a>{/if}</div>
          {foreachelse}
            <div class="clientalert text-success"><i class="fa fa-check-square-o"></i> {$LANG.notificationsnone}</div>
          {/foreach}
          </div>
        </div>
      {else}<!--1 else-->
        <div class="pull-right nav">
          <a href="#" class="quick-nav" data-toggle="popover" id="loginOrRegister" data-placement="bottom"><i class="fa fa-user"></i> {$LANG.login}</a>
          <div id="loginOrRegisterContent" class="hidden">
            <form action="dologin.php" method="post" role="form">
              <div class="form-group"><input type="email" name="username" class="form-control" placeholder="{$LANG.clientareaemail}" required></div>
              <div class="form-group">
                <div class="input-group">
                  <input type="password" name="password" class="form-control" placeholder="{$LANG.loginpassword}" required>
                  <span class="input-group-btn"><input type="submit" class="btn btn-primary" value="{$LANG.login}"></span>
                </div>
              </div>
              <label class="checkbox-inline">
                <input type="checkbox" name="rememberme"> {$LANG.loginrememberme} &bull; <a href="pwreset.php">{$LANG.forgotpw}</a>
              </label>
            </form>
          {if $condlinks.allowClientRegistration}<!--2-->
            <hr>
            {$LANG.newcustomersignup|sprintf2:'<a href="register.php">':'</a>'}
          {/if}<!--2 end-->
          </div>
        </div>
      {/if}<!--1 end-->
        <!-- Shopping Cart -->
        <div class="pull-right nav">
          <a href="cart.php?a=view" class="quick-nav"><i class="fa fa-shopping-cart"></i> <span class="hidden-xs">{$LANG.viewcart} (</span><span id="cartItemCount">{$cartitemcount}</span><span class="hidden-xs">)</span></a>
        </div>

      {if $adminMasqueradingAsClient}<!--1-->
        <!-- Return to admin link -->
        <div class="alert alert-danger admin-masquerade-notice">
          {$LANG.adminmasqueradingasclient}
          <br>
          <a href="logout.php?returntoadmin=1" class="alert-link">{$LANG.logoutandreturntoadminarea}</a>
        </div>
      {elseif $adminLoggedIn}<!--1 elseif-->
        <!-- Return to admin link -->
        <div class="alert alert-danger admin-masquerade-notice">
          {$LANG.adminloggedin}
          <br>
          <a href="logout.php?returntoadmin=1" class="alert-link">{$LANG.returntoadminarea}</a>
        </div>
      {/if}<!--1 end-->
      </div>

      <a href="index.php"><img src="{$WEB_ROOT}/templates/{$template}/img/logo.png" alt="{$companyname}"></a>
    </div>
  </section>

  <section id="main-menu">
    <nav id="nav" class="navbar navbar-default navbar-main" role="navigation">
      <div class="container">
        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header">
          <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
        </div>

        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
          <ul class="nav navbar-nav">
            {include file="$template/includes/navbar.tpl" navbar=$primaryNavbar}
          </ul>
          <ul class="nav navbar-nav navbar-right">
            {include file="$template/includes/navbar.tpl" navbar=$secondaryNavbar}
          </ul>
        </div><!-- /.navbar-collapse -->
      </div>
    </nav>
  </section>

{if $templatefile == 'homepage'}<!--1-->
  <section id="home-banner">
    <div class="container text-center">
    {if $registerdomainenabled || $transferdomainenabled}<!--2-->
      <h2>{$LANG.homebegin}</h2>
      <form method="post" action="domainchecker.php">
        <div class="row">
          <div class="col-md-8 col-md-offset-2 col-sm-10 col-sm-offset-1">
            <div class="input-group input-group-lg">
              <input type="text" class="form-control" name="domain" placeholder="{$LANG.exampledomain}">
              <span class="input-group-btn">
              {if $registerdomainenabled}<!--3-->
                <input type="submit" class="btn btn-warning" value="Search">
              {/if}<!--3 end-->
              {if $transferdomainenabled}<!--3-->
                <input type="submit" name="transfer" class="btn btn-info" value="Transfer">
              {/if}
              </span>
            </div>
          </div>
        </div>
        {include file="$template/includes/captcha.tpl"}
      </form>
    {else}<!--2 else-->
      <h2>{$LANG.doToday}</h2>
    {/if}<!--2 end-->
    </div>
  </section>

  <div class="home-shortcuts">
    <div class="container">
      <div class="row">
        <div class="col-md-4 hidden-sm hidden-xs text-center">
          <p class="lead">{$LANG.howcanwehelp}</p>
        </div>
        <div class="col-sm-12 col-md-8">
          <ul>
          {if $registerdomainenabled || $transferdomainenabled}<!--2-->
            <li>
              <a id="btnBuyADomain" href="domainchecker.php">
                <i class="fa fa-globe"></i>
                <p>{$LANG.buyadomain} <span>&raquo;</span></p>
              </a>
            </li>
          {/if}<!--2 end-->
            <li>
              <a id="btnOrderHosting" href="cart.php">
                <i class="fa fa-hdd-o"></i>
                <p>{$LANG.orderhosting} <span>&raquo;</span></p>
              </a>
            </li>
            <li>
              <a id="btnMakePayment" href="clientarea.php">
                <i class="fa fa-credit-card"></i>
                <p>{$LANG.makepayment} <span>&raquo;</span></p>
              </a>
            </li>
            <li>
              <a id="btnGetSupport" href="submitticket.php">
                <i class="fa fa-envelope-o"></i>
                <p>{$LANG.getsupport} <span>&raquo;</span></p>
              </a>
            </li>
          </ul>
        </div>
      </div>
    </div>
  </div>
{/if}<!--1 end-->

  <section id="main-body" class="container">
    <div class="row">
    {if $primarySidebar->hasChildren() || $secondarySidebar->hasChildren()}<!--1-->
    {if $primarySidebar->hasChildren()}<!--2-->
      <div class="col-md-9 pull-md-right">{include file="$template/includes/pageheader.tpl" title=$displayTitle desc=$tagline showbreadcrumb=true}</div>
    {/if}<!--2 end-->
      <div class="col-md-3 pull-md-left sidebar">{include file="$template/includes/sidebar.tpl" sidebar=$primarySidebar}</div>
    {/if}<!--1 end-->
      <!-- Container for main page display content -->
      <div class="{if $primarySidebar->hasChildren() || $secondarySidebar->hasChildren()}col-md-9 pull-md-right{else}col-xs-12{/if} main-content">
        {if !$primarySidebar->hasChildren() && !$showingLoginPage && $templatefile != 'homepage'}<!--1-->
          {include file="$template/includes/pageheader.tpl" title=$displayTitle desc=$tagline showbreadcrumb=true}
        {/if}<!--1 end-->
