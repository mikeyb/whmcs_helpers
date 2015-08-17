{if $promoerror}<!--1-->
  {include file="$template/includes/alert.tpl" type="error" msg=$promoerror textcenter=true}
{/if}<!--1 end-->

{if $promorecurring}<!--1-->
  {include file="$template/includes/alert.tpl" type="info" msg=$LANG.recurringpromodesc|sprintf2:$promorecurring textcenter=true}
{/if}<!--1 end-->

  <div class="alert alert-block alert-info text-center">
    {$LANG.upgradecurrentconfig}: <strong>{$groupname} - {$productname}</strong>{if $domain} ({$domain}){/if}
  </div>

  <table class="table table-striped">
    <thead>
      <tr>
        <th width="60%">{$LANG.orderdesc}</th>
        <th width="40%" class="text-center">{$LANG.orderprice}</th>
      </tr>
    </thead>
    <tbody>
    {foreach key=num item=upgrade from=$upgrades}
    {if $type eq "package"}<!--1-->
      <tr>
        <td><input type="hidden" name="pid" value="{$upgrade.newproductid}"><input type="hidden" name="billingcycle" value="{$upgrade.newproductbillingcycle}">{$upgrade.oldproductname} => {$upgrade.newproductname}</td>
        <td class="text-center">{$upgrade.price}</td>
      </tr>
    {elseif $type eq "configoptions"}<!--1 elseif-->
      <tr>
        <td>{$upgrade.configname}: {$upgrade.originalvalue} => {$upgrade.newvalue}</td>
        <td class="text-center">{$upgrade.price}</td>
      </tr>
    {/if}<!--1 end-->
    {/foreach}
      <tr class="masspay-total">
        <td class="text-right">{$LANG.ordersubtotal}:</td>
        <td class="text-center">{$subtotal}</td>
      </tr>

    {if $promodesc}<!--1-->
      <tr class="masspay-total">
        <td class="text-right">{$promodesc}:</td>
        <td class="text-center">{$discount}</td>
      </tr>
    {/if}<!--1 end-->
    
    {if $taxrate}<!--1-->
      <tr class="masspay-total">
        <td class="text-right">{$taxname} @ {$taxrate}%:</td>
        <td class="text-center">{$tax}</td>
      </tr>
    {/if}<!--1 end-->

    {if $taxrate2}<!--1-->
      <tr class="masspay-total">
        <td class="text-right">{$taxname2} @ {$taxrate2}%:</td>
        <td class="text-center">{$tax2}</td>
      </tr>
    {/if}<!--1 end-->
    
      <tr class="masspay-total">
        <td class="text-right">{$LANG.ordertotalduetoday}:</td>
        <td class="text-center">{$total}</td>
      </tr>
    </tbody>
  </table>

{if $type eq "package"}<!--1-->
  {include file="$template/includes/alert.tpl" type="warning" msg=$LANG.upgradeproductlogic|cat:' ('|cat:$upgrade.daysuntilrenewal|cat:' '|cat:$LANG.days|cat:')' textcenter=true}
{/if}<!--1 end-->

  <div class="row">
    <div class="col-sm-6">
      <form method="post" action="{$smarty.server.PHP_SELF}" role="form">
        <input type="hidden" name="step" value="2">
        <input type="hidden" name="type" value="{$type}">
        <input type="hidden" name="id" value="{$id}">
      {if $type eq "package"}<!--1-->
        <input type="hidden" name="pid" value="{$upgrades.0.newproductid}">
        <input type="hidden" name="billingcycle" value="{$upgrades.0.newproductbillingcycle}">
      {/if}<!--1 end-->
        {include file="$template/includes/subheader.tpl" title=$LANG.orderpromotioncode}
      {foreach from=$configoptions key=cid item=value}
        <input type="hidden" name="configoption[{$cid}]" value="{$value}">
      {/foreach}
        <div class="input-group">
          <input class="form-control" type="text" name="promocode" placeholder="{$LANG.orderpromotioncode}" width="40" {if $promocode}value="{$promocode} - {$promodesc}" disabled="disabled"{/if}>
        {if $promocode}<!--1-->
          <span class="input-group-btn">
            <input type="submit" name="removepromo" value="{$LANG.orderdontusepromo}" class="btn btn-danger btn-block">
          </span>
        {else}<!--1 else-->
          <span class="input-group-btn"><input type="submit" value="{$LANG.orderpromovalidatebutton}" class="btn btn-success btn-block"></span>
        {/if}<!--1 end-->
        </div>
      </form>
    </div>

    <div class="col-sm-6">
      <form method="post" action="{$smarty.server.PHP_SELF}">
        <input type="hidden" name="step" value="3">
        <input type="hidden" name="type" value="{$type}">
        <input type="hidden" name="id" value="{$id}">
      {if $type eq "package"}<!--1-->
        <input type="hidden" name="pid" value="{$upgrades.0.newproductid}">
        <input type="hidden" name="billingcycle" value="{$upgrades.0.newproductbillingcycle}">
      {/if}<!--1 end-->
      {foreach from=$configoptions key=cid item=value}
        <input type="hidden" name="configoption[{$cid}]" value="{$value}">
      {/foreach}
      {if $promocode}<!--1-->
        <input type="hidden" name="promocode" value="{$promocode}">
      {/if}<!--1 end-->
        {include file="$template/includes/subheader.tpl" title=$LANG.orderpaymentmethod}
        <div class="form-group">
          <select name="paymentmethod" id="inputPaymentMethod" class="form-control">
            <option value="none">{$LANG.paymentmethoddefault}</option>
          {foreach key=num item=gateway from=$gateways}
            <option value="{$gateway.sysname}"{if $gateway.sysname eq $selectedgateway} selected="selected"{/if}>{$gateway.name}</option>
          {/foreach}
          </select>
        </div>
      </div>
    </div>

    <div class="form-group text-center"><input type="submit" value="{$LANG.ordercontinuebutton}" class="btn btn-primary"></div>
  </form>
