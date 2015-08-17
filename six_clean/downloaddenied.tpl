{if $reason eq "supportandupdates"}<!--1-->
  {include file="$template/includes/alert.tpl" type="error" msg="{$LANG.supportAndUpdatesExpiredLicense}{if $licensekey}: {$licensekey}{else}.{/if}" textcenter=true}
{/if}<!--1 end-->

{if $reason eq "supportandupdates"}<!--1-->
  <p>{$LANG.supportAndUpdatesRenewalRequired}</p>

  <form action="{$systemsslurl}cart.php?a=add" method="post">
    <input type="hidden" name="productid" value="{$serviceid}" />
    <input type="hidden" name="aid" value="{$addonid}" />
    <p align="center"><input type="submit" value="{$LANG.supportAndUpdatesClickHereToRenew} &raquo;" class="btn" /></p>
  </form>
{else}<!--1 else-->
    <p>{$LANG.downloadproductrequired}</p>
  {if $prodname}<!--2-->
    {include file="$template/includes/alert.tpl" type="info" msg=$prodname textcenter=true}
  {else}<!--2 else-->
    {include file="$template/includes/alert.tpl" type="info" msg=$addonname textcenter=true}
  {/if}<!--2 end-->

  {if $pid || $aid}<!--2-->
    <form action="{$systemsslurl}cart.php" method="post">
    {if $pid}<!--3-->
      <input type="hidden" name="a" value="add" />
      <input type="hidden" name="pid" value="{$pid}" />
    {elseif $aid}<!--3 else-->
      <input type="hidden" name="gid" value="addons" />
    {/if}<!--3 end-->
      <p align="center"><input type="submit" value="{$LANG.ordernowbutton} &raquo;" class="btn" /></p>
    </form>
{/if}<!--2 end-->
{/if}<!--1 end-->
