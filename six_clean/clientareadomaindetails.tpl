{if $registrarcustombuttonresult=="success"}<!--1-->
  {include file="$template/includes/alert.tpl" type="success" msg=$LANG.moduleactionsuccess textcenter=true}
{elseif $registrarcustombuttonresult}<!--1 elseif-->
  {include file="$template/includes/alert.tpl" type="error" msg=$LANG.moduleactionfailed textcenter=true}
{/if}<!--1 end-->

  <div class="tab-content margin-bottom">
    <div class="tab-pane fade in active" id="tabOverview">

    {if $systemStatus != 'Active'}<!--1-->
      <div class="alert alert-warning text-center" role="alert">{$LANG.domainCannotBeManagedUnlessActive}</div>
    {/if}<!--1 end-->

      <h3>{$LANG.overview}</h3>

    {if $lockstatus eq "unlocked"}<!--1-->
      {capture name="domainUnlockedMsg"}<strong>{$LANG.domaincurrentlyunlocked}</strong><br>{$LANG.domaincurrentlyunlockedexp}{/capture}
      {include file="$template/includes/alert.tpl" type="error" msg=$smarty.capture.domainUnlockedMsg}
    {/if}<!--1 end-->

      <div class="row">
        <div class="col-sm-offset-1 col-sm-5">
          <h4><strong>{$LANG.clientareahostingdomain}:</strong></h4> <a href="http://{$domain}" target="_blank">{$domain}</a>
        </div>
        <div class="col-sm-5">
          <h4><strong>{$LANG.firstpaymentamount}:</strong></h4> <span>{$firstpaymentamount}</span>
        </div>
      </div>

      <div class="row">
        <div class="col-sm-offset-1 col-sm-5">
          <h4><strong>{$LANG.clientareahostingregdate}:</strong></h4> <span>{$registrationdate}</span>
        </div>
        <div class="col-sm-6">
          <h4><strong>{$LANG.recurringamount}:</strong></h4> {$recurringamount} {$LANG.every} {$registrationperiod} {$LANG.orderyears}
        </div>
      </div>

      <div class="row">
        <div class="col-sm-offset-1 col-sm-5">
          <h4><strong>{$LANG.clientareahostingnextduedate}:</strong></h4> {$nextduedate}
        </div>
        <div class="col-sm-6">
          <h4><strong>{$LANG.orderpaymentmethod}:</strong></h4> {$paymentmethod}
        </div>
      </div>

      <div class="row">
        <div class="col-sm-offset-1 col-sm-5">
          <h4><strong>{$LANG.clientareastatus}:</strong></h4> {$status}
        </div>
      </div>

    {if $registrarclientarea}<!--1-->
      <div class="moduleoutput">{$registrarclientarea|replace:'modulebutton':'btn'}</div>
    {/if}<!--1 end-->

    {foreach $hookOutput as $output}
      <div>{$output}</div>
    {/foreach}

      <br>

    {if $systemStatus == 'Active'}<!--1-->
      <h4>{$LANG.doToday}</h4>
      <ul>
      {if $managementoptions.nameservers}<!--2-->
        <li><a class="tabControlLink" href="#tabNameservers">{$LANG.changeDomainNS}</a></li>
      {/if}<!--2 end-->

      {if $managementoptions.contacts}<!--2-->
        <li><a href="clientarea.php?action=domaincontacts&domainid={$domainid}">{$LANG.updateWhoisContact}</a></li>
      {/if}<!--2 end-->

      {if $managementoptions.locking}<!--2-->
        <li><a class="tabControlLink" href="#tabReglock">{$LANG.changeRegLock}</a></li>
      {/if}<!--2 end-->

        <li><a href="cart.php?gid=renewals">{$LANG.renewYourDomain}</a></li>
      </ul>
    {/if}<!--1 end-->

    </div>

    <div class="tab-pane fade" id="tabAutorenew">
      <h3>{$LANG.domainsautorenew}</h3>
    {if $changeAutoRenewStatusSuccessful}<!--1-->
      {include file="$template/includes/alert.tpl" type="success" msg=$LANG.changessavedsuccessfully textcenter=true}
    {/if}<!--1 end-->

      {include file="$template/includes/alert.tpl" type="info" msg=$LANG.domainrenewexp}
      <br>
      <h2 class="text-center">
        {$LANG.domainautorenewstatus}: 
        <span class="label label-{if $autorenew}success{else}danger{/if}">
        {if $autorenew}<!--1-->
          {$LANG.domainsautorenewenabled}{else}{$LANG.domainsautorenewdisabled}
        {/if}<!--1 end-->
        </span>
      </h2>
      <br>
      <br>

      <form method="post" action="{$smarty.server.PHP_SELF}?action=domaindetails#tabAutorenew">
        <input type="hidden" name="id" value="{$domainid}">
        <input type="hidden" name="sub" value="autorenew">
      {if $autorenew}<!--1-->
        <input type="hidden" name="autorenew" value="disable">
        <p class="text-center"><input type="submit" class="btn btn-lg btn-danger" value="{$LANG.domainsautorenewdisable}"></p>
      {else}<!--1 else-->
        <input type="hidden" name="autorenew" value="enable">
        <p class="text-center"><input type="submit" class="btn btn-lg btn-success" value="{$LANG.domainsautorenewenable}"></p>
      {/if}<!--1 end-->
      </form>

    </div>

    <div class="tab-pane fade" id="tabNameservers">

      <h3>Nameservers</h3>

    {if $nameservererror}<!--1-->
      {include file="$template/includes/alert.tpl" type="error" msg=$nameservererror textcenter=true}
    {/if}<!--1 end-->
    {if $subaction eq "savens"}<!--1-->
    {if $updatesuccess}<!--2-->
      {include file="$template/includes/alert.tpl" type="success" msg=$LANG.changessavedsuccessfully textcenter=true}
    {elseif $error}<!--2 elseif-->
      {include file="$template/includes/alert.tpl" type="error" msg=$error textcenter=true}
    {/if}<!--2 end-->
    {/if}<!--1 end-->

      {include file="$template/includes/alert.tpl" type="info" msg=$LANG.domainnsexp}

      <form class="form-horizontal" role="form" method="post" action="{$smarty.server.PHP_SELF}?action=domaindetails#tabNameservers">
        <input type="hidden" name="id" value="{$domainid}">
        <input type="hidden" name="sub" value="savens">

        <div class="radio">
          <label>
            <input type="radio" name="nschoice" value="default" onclick="disableFields('domnsinputs',true)"{if $defaultns} checked{/if}> {$LANG.nschoicedefault}
          </label>
        </div>

        <div class="radio">
          <label>
            <input type="radio" name="nschoice" value="custom" onclick="disableFields('domnsinputs',false)"{if !$defaultns} checked{/if}> {$LANG.nschoicecustom}
          </label>
        </div>
        <br>
      {for $num=1 to 5}
        <div class="form-group">
          <label for="inputNs{$num}" class="col-sm-4 control-label">{$LANG.clientareanameserver} {$num}</label>
          <div class="col-sm-7">
            <input type="text" name="ns{$num}" class="form-control domnsinputs" id="inputNs{$num}" value="{$nameservers[$num].value}">
          </div>
        </div>
      {/for}
        <p class="text-center"><input type="submit" class="btn btn-primary" value="{$LANG.changenameservers}"></p>
      </form>

    </div>

    <div class="tab-pane fade" id="tabReglock">

      <h3>{$LANG.domainregistrarlock}</h3>

    {if $subaction eq "savereglock"}<!--1-->
    {if $updatesuccess}<!--2-->
      {include file="$template/includes/alert.tpl" type="success" msg=$LANG.changessavedsuccessfully textcenter=true}
    {elseif $error}<!--2 elseif-->
      {include file="$template/includes/alert.tpl" type="error" msg=$error textcenter=true}
    {/if}<!--2 end-->
    {/if}<!--1 end-->

      {include file="$template/includes/alert.tpl" type="info" msg=$LANG.domainlockingexp}

      <br>

      <h2 class="text-center">
      {$LANG.domainreglockstatus}: 
        <span class="label label-{if $lockstatus == "locked"}success{else}danger{/if}">
        {if $lockstatus == "locked"}<!--1-->
          {$LANG.domainsautorenewenabled}
        {else}<!--1 else-->
          {$LANG.domainsautorenewdisabled}
        {/if}<!--1 end-->
        </span>
      </h2>

      <br>
      <br>

      <form method="post" action="{$smarty.server.PHP_SELF}?action=domaindetails#tabReglock">
        <input type="hidden" name="id" value="{$domainid}">
        <input type="hidden" name="sub" value="savereglock">
      {if $lockstatus=="locked"}<!--1-->
        <p class="text-center"><input type="submit" class="btn btn-lg btn-danger" value="{$LANG.domainreglockdisable}"></p>
      {else}<!--1 else-->
        <input type="hidden" name="autorenew" value="enable">
        <p class="text-center"><input type="submit" class="btn btn-lg btn-success" name="reglock" value="{$LANG.domainreglockenable}"></p>
      {/if}<!--1 end-->
      </form>

    </div>

    <div class="tab-pane fade" id="tabRelease">

      <h3>{$LANG.domainrelease}</h3>

      {include file="$template/includes/alert.tpl" type="info" msg=$LANG.domainreleasedescription}

      <form class="form-horizontal" role="form" method="post" action="{$smarty.server.PHP_SELF}?action=domaindetails">
        <input type="hidden" name="sub" value="releasedomain">
        <input type="hidden" name="id" value="{$domainid}">

        <div class="form-group">
          <label for="inputReleaseTag" class="col-xs-4 control-label">{$LANG.domainreleasetag}</label>
          <div class="col-xs-6 col-sm-5">
            <input type="text" class="form-control" id="inputReleaseTag" name="transtag">
          </div>
        </div>

        <p class="text-center"><input type="submit" value="{$LANG.domainrelease}" class="btn btn-primary"></p>
      </form>

    </div>

    <div class="tab-pane fade" id="tabAddons">

      <h3>{$LANG.domainaddons}</h3>

      <p>{$LANG.domainaddonsinfo}</p>

    {if $addons.idprotection}<!--1-->
      <div class="row margin-bottom">
        <div class="col-xs-3 col-md-2 text-center"><i class="fa fa-shield fa-3x"></i></div>
        <div class="col-xs-9 col-md-10">
          <strong>{$LANG.domainidprotection}</strong>
          <br>
          {$LANG.domainaddonsidprotectioninfo}
          <br>
        {if $addonstatus.idprotection}<!--2-->
          <a href="clientarea.php?action=domainaddons&id={$domainid}&disable=idprotect&token={$token}">{$LANG.disable}</a>
        {else}<!--2 else-->
          <a href="clientarea.php?action=domainaddons&id={$domainid}&buy=idprotect&token={$token}">{$LANG.domainaddonsbuynow} {$addonspricing.idprotection}</a>
        {/if}<!--2 end-->
        </div>
      </div>
    {/if}<!--1 end-->

    {if $addons.dnsmanagement}<!--1-->
      <div class="row margin-bottom">
        <div class="col-xs-3 col-md-2 text-center"><i class="fa fa-cloud fa-3x"></i></div>
        <div class="col-xs-9 col-md-10">
          <strong>{$LANG.domainaddonsdnsmanagement}</strong>
          <br>
          {$LANG.domainaddonsdnsmanagementinfo}
          <br>
        {if $addonstatus.dnsmanagement}<!--2-->
          <a href="clientarea.php?action=domaindns&domainid={$domainid}">{$LANG.manage}</a> | <a href="clientarea.php?action=domainaddons&id={$domainid}&disable=dnsmanagement&token={$token}">{$LANG.disable}</a>
        {else}<!--2 else-->
          <a href="clientarea.php?action=domainaddons&id={$domainid}&buy=dnsmanagement&token={$token}">{$LANG.domainaddonsbuynow} {$addonspricing.dnsmanagement}</a>
        {/if}<!--2 end-->
        </div>
      </div>
    {/if}<!--1 end-->

    {if $addons.emailforwarding}<!--1-->
      <div class="row margin-bottom">
        <div class="col-xs-3 col-md-2 text-center"><i class="fa fa-envelope fa-3x">&nbsp;</i><i class="fa fa-mail-forward fa-2x"></i></div>
        <div class="col-xs-9 col-md-10">
          <strong>{$LANG.domainemailforwarding}</strong>
          <br>
          {$LANG.domainaddonsemailforwardinginfo}
          <br>
        {if $addonstatus.emailforwarding}<!--2-->
          <a href="clientarea.php?action=domainemailforwarding&domainid={$domainid}">{$LANG.manage}</a> | <a href="clientarea.php?action=domainaddons&id={$domainid}&disable=emailfwd&token={$token}">{$LANG.disable}</a>
        {else}<!--2 else-->
          <a href="clientarea.php?action=domainaddons&id={$domainid}&buy=emailfwd&token={$token}">{$LANG.domainaddonsbuynow} {$addonspricing.emailforwarding}</a>
        {/if}<!--2 end-->
        </div>
      </div>
    {/if}<!--1 end-->

    </div>
  </div>
