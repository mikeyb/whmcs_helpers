  <form method="post" action="{$smarty.server.PHP_SELF}?action=domainaddons" class="form-horizontal">
    <input type="hidden" name="{$action}" value="{$addon}">
    <input type="hidden" name="id" value="{$domainid}">
    <input type="hidden" name="confirm" value="1">
    <input type="hidden" name="token" value="{$token}">

  {if $action eq "buy"}<!--1-->
    <input type="hidden" name="buy" value="{$addon}">
  {if $addon eq "dnsmanagement"}<!--2-->
    {include file="$template/includes/pageheader.tpl" title=$LANG.domainaddonsdnsmanagement}
    {include file="$template/includes/alert.tpl" type="info" msg="Domain: <strong>{$domain}</strong>" textcenter=true}

    <p>{$LANG.domainaddonsdnsmanagementinfo}</p>
    <p align="center">
      <input type="submit" name="enable" value="{$LANG.domainaddonsbuynow} {$addonspricing.dnsmanagement}{$LANG.domainaddonsperyear}" class="btn btn-success btn-lg" />
    </p>
  {elseif $addon eq "emailfwd"}<!--2 elseif-->
    {include file="$template/includes/pageheader.tpl" title=$LANG.domainemailforwarding}
    {include file="$template/includes/alert.tpl" type="info" msg="Domain: <strong>{$domain}</strong>" textcenter=true}

    <p>{$LANG.domainaddonsemailforwardinginfo}</p>
    <p align="center">
      <input type="submit" name="enable" value="{$LANG.domainaddonsbuynow} {$addonspricing.emailforwarding}{$LANG.domainaddonsperyear}" class="btn btn-success btn-lg" />
    </p>
  {elseif $addon eq "idprotect"}<!--2 elseif-->
    {include file="$template/includes/pageheader.tpl" title=$LANG.domainidprotection}
    {include file="$template/includes/alert.tpl" type="info" msg="Domain: <strong>{$domain}</strong>" textcenter=true}

    <p>{$LANG.domainaddonsidprotectioninfo}</p>
    <p align="center">
      <input type="submit" name="enable" value="{$LANG.domainaddonsbuynow} {$addonspricing.idprotection}{$LANG.domainaddonsperyear}" class="btn btn-success btn-lg" />
    </p>
  {/if}<!--2 end-->

  {elseif $action eq "disable"}<!--1 elseif-->
    <input type="hidden" name="disable" value="{$addon}">
  {if $addon eq "dnsmanagement"}<!--2-->
    {include file="$template/includes/pageheader.tpl" title=$LANG.domainaddonsdnsmanagement}
  {elseif $addon eq "emailfwd"}<!--2 elseif-->
    {include file="$template/includes/pageheader.tpl" title=$LANG.domainemailforwarding}
  {elseif $addon eq "idprotect"}<!--2 elseif-->
    {include file="$template/includes/pageheader.tpl" title=$LANG.domainidprotection}
  {/if}<!--2 end-->

    {include file="$template/includes/alert.tpl" type="info" msg="Domain: <strong>{$domain}</strong>" textcenter=true}

  {if $success}<!--2-->
    {include file="$template/includes/alert.tpl" type="success" msg=$LANG.domainaddonscancelsuccess textcenter=true}
  {elseif $error}<!--2 elseif-->
    {include file="$template/includes/alert.tpl" type="error" msg=$LANG.domainaddonscancelfailed textcenter=true}
  {else}<!--2 else-->
    <p class="text-center">{$LANG.domainaddonscancelareyousure}</p>
    <p class="text-center">
      <input type="submit" name="enable" value="{$LANG.domainaddonsconfirm}" class="btn btn-danger btn-lg" />
    </p>
  {/if}<!--2 end-->

  {/if}<!--1 end-->

    <p><a href="clientarea.php?action=domaindetails&id={$domainid}" class="btn btn-default">{$LANG.clientareabacklink}</a></p>
  </form>
