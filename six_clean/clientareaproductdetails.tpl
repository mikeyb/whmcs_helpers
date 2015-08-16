{if $modulecustombuttonresult}<!--1-->
{if $modulecustombuttonresult == "success"}<!--2-->
  {include file="$template/includes/alert.tpl" type="success" msg=$moduleactionsuccess textcenter=true}
{else}<!--2 else-->
  {include file="$template/includes/alert.tpl" type="error" msg=$LANG.moduleactionfailed|cat:' ':$modulecustombuttonresult textcenter=true}
{/if}<!--2 end-->
{/if}<!--1 end-->

{if $pendingcancellation}<!--1-->
  {include file="$template/includes/alert.tpl" type="error" msg=$LANG.cancellationrequestedexplanation textcenter=true}
{/if}<!--1 end-->

  <div class="tab-content margin-bottom">
    <div class="tab-pane fade in active" id="tabOverview">

    {if $tplOverviewTabOutput}<!--1-->
      {$tplOverviewTabOutput}
    {else}<!--1 else-->
      <div class="product-details clearfix">
        <div class="row">
          <div class="col-md-6">
            <div class="product-status product-status-{$status|strtolower}">
              <div class="product-icon text-center">
                <span class="fa-stack fa-lg">
                  <i class="fa fa-circle fa-stack-2x"></i>
                  <i class="fa fa-{if $type eq "hostingaccount" || $type == "reselleraccount"}hdd-o{elseif $type eq "server"}database{else}archive{/if} fa-stack-1x fa-inverse"></i>
                </span>
                <h3>{$product}</h3>
                <h4>{$groupname}</h4>
              </div>
              <div class="product-status-text">{$status}</div>
            </div>

          {if $showcancelbutton || $packagesupgrade}<!--2-->
            <div class="row">
            {if $packagesupgrade}<!--3-->
              <div class="col-xs-6"><a href="upgrade.php?type=package&amp;id={$id}" class="btn btn-block btn-success">{$LANG.upgrade}</a></div>
              <div class="col-xs-6">
            {else}<!--3 else-->
              <div class="col-xs-12">
            {/if}<!--3 end-->
                <a href="clientarea.php?action=cancel&amp;id={$id}" class="btn btn-block btn-danger {if $pendingcancellation}disabled{/if}">
                {if $pendingcancellation}<!--3-->
                  {$LANG.cancellationrequested}
                {else}<!--3 else-->
                  {$LANG.cancel}
                {/if}<!--3 end-->
                </a>
              </div>
            </div>
          {/if}<!--2 end-->

          </div>
          <div class="col-md-6 text-center">
            <h4>{$LANG.clientareahostingregdate}</h4>
            {$regdate}

          {if $firstpaymentamount neq $recurringamount}<!--2-->
            <h4>{$LANG.firstpaymentamount}</h4>
            {$firstpaymentamount}
          {/if}<!--2 end-->

          {if $billingcycle != $LANG.orderpaymenttermonetime && $billingcycle != $LANG.orderfree}<!--2-->
            <h4>{$LANG.recurringamount}</h4>
            {$recurringamount}
          {/if}<!--2 end-->

            <h4>{$LANG.orderbillingcycle}</h4>
            {$billingcycle}

            <h4>{$LANG.clientareahostingnextduedate}</h4>
            {$nextduedate}

            <h4>{$LANG.orderpaymentmethod}</h4>
            {$paymentmethod}

          {if $suspendreason}<!--2-->
            <h4>{$LANG.suspendreason}</h4>
            {$suspendreason}
          {/if}<!--2 end-->

          </div>
        </div>

      </div>

    {foreach $hookOutput as $output}
      <div>{$output}</div>
    {/foreach}

    {if $domain || $moduleclientarea || $configurableoptions || $customfields || $lastupdate}<!--2-->
      <div class="row clearfix">
        <div class="col-xs-12">
          <ul class="nav nav-tabs nav-tabs-overflow">
          {if $domain}<!--3-->
            <li class="active">
              <a href="#domain" data-toggle="tab"><i class="fa fa-globe fa-fw"></i> {if $type eq "server"}{$LANG.sslserverinfo}{elseif ($type eq "hostingaccount" || $type eq "reselleraccount") && $serverdata}{$LANG.hostingInfo}{else}{$LANG.clientareahostingdomain}{/if}</a>
            </li>
          {elseif $moduleclientarea}<!--3 else-->
            <li class="active"><a href="#manage" data-toggle="tab"><i class="fa fa-globe fa-fw"></i> {$LANG.manage}</a></li>
          {/if}<!--3 end-->

          {if $configurableoptions}<!--3-->
            <li{if !$domain && !$moduleclientarea} class="active"{/if}>
              <a href="#configoptions" data-toggle="tab"><i class="fa fa-cubes fa-fw"></i> {$LANG.orderconfigpackage}</a>
            </li>
          {/if}<!--3 end-->

          {if $customfields}<!--3-->
            <li{if !$domain && !$moduleclientarea && !$configurableoptions} class="active"{/if}>
              <a href="#additionalinfo" data-toggle="tab"><i class="fa fa-info fa-fw"></i> {$LANG.additionalInfo}</a>
            </li>
          {/if}<!--3 end-->
          
          {if $lastupdate}<!--3-->
            <li{if !$domain && !$moduleclientarea && !$configurableoptions && !$customfields} class="active"{/if}>
              <a href="#resourceusage" data-toggle="tab"><i class="fa fa-inbox fa-fw"></i> {$LANG.resourceUsage}</a>
            </li>
          {/if}<!--3 end-->
          </ul>
        </div>
      </div>
 
      <div class="tab-content product-details-tab-container">
      {if $domain}<!--3-->
        <div class="tab-pane fade in active text-center" id="domain">
        {if $type eq "server"}<!--4-->
          <div class="row">
            <div class="col-sm-5 text-right"><strong>{$LANG.serverhostname}</strong></div>
            <div class="col-sm-7 text-left">{$domain}</div>
          </div>
        {if $dedicatedip}<!--5-->
          <div class="row">
            <div class="col-sm-5 text-right"><strong>{$LANG.primaryIP}</strong></div>
            <div class="col-sm-7 text-left">{$dedicatedip}</div>
          </div>
        {/if}<!--5 end-->

        {if $assignedips}<!--5-->
          <div class="row">
            <div class="col-sm-5 text-right"><strong>{$LANG.assignedIPs}</strong></div>
            <div class="col-sm-7 text-left">{$assignedips|nl2br}</div>
          </div>
        {/if}<!--5 end-->

        {if $ns1 || $ns2}<!--5-->
          <div class="row">
            <div class="col-sm-5 text-right"><strong>{$LANG.domainnameservers}</strong></div>
            <div class="col-sm-7 text-left">{$ns1}<br>{$ns2}</div>
          </div>
        {/if}<!--5 end-->
        {elseif ($type eq "hostingaccount" || $type eq "reselleraccount") && $serverdata}<!--4 elseif-->
        {if $domain}<!--5-->
          <div class="row">
            <div class="col-sm-5 text-right"><strong>{$LANG.orderdomain}</strong></div>
            <div class="col-sm-7 text-left">{$domain}&nbsp;<a href="http://{$domain}" target="_blank" class="btn btn-default btn-xs" >{$LANG.visitwebsite}</a></div>
          </div>
        {/if}<!--5 end-->
        {if $username}<!--5-->
          <div class="row">
            <div class="col-sm-5 text-right"><strong>{$LANG.serverusername}</strong></div>
            <div class="col-sm-7 text-left">{$username}</div>
          </div>
        {/if}<!--5 end-->
          <div class="row">
            <div class="col-sm-5 text-right"><strong>{$LANG.servername}</strong></div>
            <div class="col-sm-7 text-left">{$serverdata.hostname}</div>
          </div>

          <div class="row">
            <div class="col-sm-5 text-right"><strong>{$LANG.domainregisternsip}</strong></div>
            <div class="col-sm-7 text-left">{$serverdata.ipaddress}</div>
          </div>

        {if $serverdata.nameserver1 || $serverdata.nameserver2 || $serverdata.nameserver3 || $serverdata.nameserver4 || $serverdata.nameserver5}<!--5-->
          <div class="row">
            <div class="col-sm-5 text-right"><strong>{$LANG.domainnameservers}</strong></div>
            <div class="col-sm-7 text-left">
            {if $serverdata.nameserver1}<!--6-->
              {$serverdata.nameserver1} ({$serverdata.nameserver1ip})
              <br>
            {/if}<!--6 end-->
            {if $serverdata.nameserver2}<!--6-->
              {$serverdata.nameserver2} ({$serverdata.nameserver2ip})
              <br>
            {/if}<!--6 end-->
            {if $serverdata.nameserver3}<!--6-->
              {$serverdata.nameserver3} ({$serverdata.nameserver3ip})
              <br>
            {/if}<!--6 end-->
            {if $serverdata.nameserver4}<!--6-->
              {$serverdata.nameserver4} ({$serverdata.nameserver4ip})
              <br>
            {/if}<!--6 end-->
            {if $serverdata.nameserver5}<!--6-->
              {$serverdata.nameserver5} ({$serverdata.nameserver5ip})
              <br>
            {/if}<!--6 end-->
            </div>
          </div>
        {/if}<!--5 end-->
        {else}<!--4 else-->
          <p>{$domain}</p>
          <p>
            <a href="http://{$domain}" class="btn btn-default" target="_blank">{$LANG.visitwebsite}</a>
          {if $domainId}<!--5-->
            <a href="clientarea.php?action=domaindetails&id={$domainId}" class="btn btn-default" target="_blank">{$LANG.managedomain}</a>
          {/if}<!--5 end-->
            <input type="button" onclick="popupWindow('whois.php?domain={$domain}','whois',650,420);return false;" value="{$LANG.whoisinfo}" class="btn btn-default">
          </p>
        {/if}<!--4 end-->

        {if $moduleclientarea}<!--4-->
          <div class="text-center module-client-area">{$moduleclientarea}</div>
        {/if}<!--4 end-->
        </div>

      {elseif $moduleclientarea}<!--3 elseif-->
        <div class="tab-pane fade{if !$domain} in active{/if} text-center" id="manage">
        {if $moduleclientarea}<!--4-->
          <div class="text-center module-client-area">{$moduleclientarea}</div>
        {/if}<!--4 end-->
        </div>
      {/if}<!--3 end-->

      {if $configurableoptions}<!--3-->
        <div class="tab-pane fade{if !$domain && !$moduleclientarea} in active{/if} text-center" id="configoptions">
        {foreach from=$configurableoptions item=configoption}
          <div class="row">
            <div class="col-sm-5"><strong>{$configoption.optionname}</strong></div>
            <div class="col-sm-7 text-left">
            {if $configoption.optiontype eq 3}<!--4-->
            {if $configoption.selectedqty}<!--5-->
              {$LANG.yes}
            {else}<!--5 else-->
              {$LANG.no}
            {/if}<!--5 end-->
            {elseif $configoption.optiontype eq 4}<!--4 elseif-->
              {$configoption.selectedqty} x {$configoption.selectedoption}
            {else}<!--4 else-->
              {$configoption.selectedoption}
            {/if}<!--4 end-->
            </div>
          </div>
        {/foreach}
        </div>
      {/if}<!--3 end-->

      {if $customfields}<!--3-->
        <div class="tab-pane fade{if !$domain && !$moduleclientarea && !$configurableoptions} in active{/if} text-center" id="additionalinfo">
        {foreach from=$customfields item=field}
          <div class="row">
            <div class="col-sm-5"><strong>{$field.name}</strong></div>
            <div class="col-sm-7 text-left">{$field.value}</div>
          </div>
        {/foreach}
        </div>
      {/if}<!--3 end-->

      {if $lastupdate}<!--3-->
        <div class="tab-pane fade text-center" id="resourceusage">
          <div class="col-sm-10 col-sm-offset-1">

            <div class="col-sm-6">
              <h4>{$LANG.diskSpace}</h4>
              <input type="text" value="{$diskpercent|substr:0:-1}" class="dial-usage" data-width="100" data-height="100" data-min="0" data-readOnly="true">
              <p>{$diskusage}MB / {$disklimit}MB</p>
            </div>

            <div class="col-sm-6">
              <h4>{$LANG.bandwidth}</h4>
              <input type="text" value="{$bwpercent|substr:0:-1}" class="dial-usage" data-width="100" data-height="100" data-min="0" data-readOnly="true">
              <p>{$bwusage}MB / {$bwlimit}MB</p>
            </div>

          </div>

          <div class="clearfix"></div>
          <p class="text-muted">{$LANG.clientarealastupdated}: {$lastupdate}</p>

          <script src="{$BASE_PATH_JS}/jquery.knob.js"></script>
          <script type="text/javascript">
            jQuery(function() {ldelim}
            jQuery(".dial-usage").knob({ldelim}'format':function (v) {ldelim} alert(v); {rdelim}{rdelim});
            {rdelim});
          </script>
        </div>
      {/if}<!--3 end-->
      </div>
    {/if}<!--2 end-->
      <script src="{$BASE_PATH_JS}/bootstrap-tabdrop.js"></script>
      <script type="text/javascript">jQuery('.nav-tabs-overflow').tabdrop();</script>
  {/if}<!--1 end-->

    </div>
 
    <div class="tab-pane fade in" id="tabDownloads">

      <h3>{$LANG.downloadstitle}</h3>
      {include file="$template/includes/alert.tpl" type="info" msg="{lang key="clientAreaProductDownloadsAvailable"}" textcenter=true}
      <div class="row">
      {foreach from=$downloads item=download}
        <div class="col-xs-10 col-xs-offset-1">
          <h4>{$download.title}</h4>
          <p>{$download.description}</p>
          <p><a href="{$download.link}" class="btn btn-default"><i class="fa fa-download"></i> {$LANG.downloadname}</a></p>
        </div>
      {/foreach}
      </div>

    </div>

    <div class="tab-pane fade in" id="tabAddons">

      <h3>{$LANG.clientareahostingaddons}</h3>
    {if $addonsavailable}<!--1-->
      {include file="$template/includes/alert.tpl" type="info" msg="{lang key="clientAreaProductAddonsAvailable"}" textcenter=true}
    {/if}<!--1 end-->

      <div class="row">
      {foreach from=$addons item=addon}
        <div class="col-xs-10 col-xs-offset-1">
          <h4>{$addon.name}</h4>
          <p>{$addon.pricing}</p>
          <p>{$LANG.registered}: {$addon.regdate}</p>
          <p>{$LANG.clientareahostingnextduedate}: {$addon.nextduedate}</p>
          <p><span class="label status-{$addon.status|strtolower}">{$addon.status}</span></p>
        </div>
      {/foreach}
      </div>

    </div>

    <div class="tab-pane fade in" id="tabChangepw">

      <h3>{$LANG.serverchangepassword}</h3>

    {if $modulechangepwresult}<!--1-->
    {if $modulechangepwresult == "success"}<!--2-->
      {include file="$template/includes/alert.tpl" type="success" msg=$serverchangepasswordsuccessful textcenter=true}
    {elseif $modulechangepwresult == "error"}<!--2 else-->
      {include file="$template/includes/alert.tpl" type="error" msg=$modulechangepasswordmessage|strip_tags textcenter=true}
    {/if}<!--2 end-->
    {/if}<!--1 end-->
    
      <form class="form-horizontal using-password-strength" method="post" action="{$smarty.server.PHP_SELF}?action=productdetails#tabChangepw" role="form">
        <input type="hidden" name="id" value="{$id}">
        <input type="hidden" name="modulechangepassword" value="true">

        <div id="newPassword1" class="form-group has-feedback">
          <label for="inputNewPassword1" class="col-sm-5 control-label">{$LANG.newpassword}</label>
          <div class="col-sm-6">
            <input type="password" class="form-control" id="inputNewPassword1" name="newpw">
            <span class="form-control-feedback glyphicon"></span>
            {include file="$template/includes/pwstrength.tpl"}
          </div>
        </div>
 
        <div id="newPassword2" class="form-group has-feedback">
          <label for="inputNewPassword2" class="col-sm-5 control-label">{$LANG.confirmnewpassword}</label>
          <div class="col-sm-6">
            <input type="password" class="form-control" id="inputNewPassword2" name="confirmpw">
            <span class="form-control-feedback glyphicon"></span>
            <div id="inputNewPassword2Msg"></div>
          </div>
        </div>

        <div class="form-group">
          <div class="col-sm-offset-6 col-sm-6">
            <input class="btn btn-primary" type="submit" value="{$LANG.clientareasavechanges}">
            <input class="btn" type="reset" value="{$LANG.cancel}">
          </div>
        </div>
  
      </form>

    </div>
  </div>
