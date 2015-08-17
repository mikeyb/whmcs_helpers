{if $overdueinvoice}<!--1-->
  {include file="$template/includes/alert.tpl" type="warning" msg=$LANG.upgradeerroroverdueinvoice}
{elseif $existingupgradeinvoice}<!--1 elseif-->
  {include file="$template/includes/alert.tpl" type="warning" msg=$LANG.upgradeexistingupgradeinvoice}
{elseif $upgradenotavailable}<!--1 elseif-->
  {include file="$template/includes/alert.tpl" type="warning" msg=$LANG.upgradeNotPossible textcenter=true}
{/if}<!--1 end-->

{if $overdueinvoice}<!--1-->
    <p><a href="clientarea.php?action=productdetails&id={$id}" class="btn btn-default">{$LANG.clientareabacklink}</a></p>
{elseif $existingupgradeinvoice}<!--1 elseif-->
    <p>
      <a href="clientarea.php?action=productdetails&id={$id}" class="btn btn-default btn-lg">{$LANG.clientareabacklink}</a>
      <a href="submitticket.php" class="btn btn-default btn-lg">{$LANG.submitticketdescription}</a>
    </p>
{elseif $upgradenotavailable}<!--1 elseif-->
    <p>
      <a href="clientarea.php?action=productdetails&id={$id}" class="btn btn-default btn-lg">{$LANG.clientareabacklink}</a>
      <a href="submitticket.php" class="btn btn-default btn-lg">{$LANG.submitticketdescription}</a>
    </p>
{else}<!--1 else-->
  {if $type eq "package"}<!--2-->
    <p>{$LANG.upgradechoosepackage}</p>
    <p>{$LANG.upgradecurrentconfig}:<br/><strong>{$groupname} - {$productname}</strong>{if $domain} ({$domain}){/if}</p>
    <p>{$LANG.upgradenewconfig}:</p>
    <table class="table table-striped">
    {foreach key=num item=upgradepackage from=$upgradepackages}
      <tr>
        <td>
          <strong>{$upgradepackage.groupname} - {$upgradepackage.name}</strong>
          <br>
          {$upgradepackage.description}
        </td>
        <td width="300" class="text-center">
          <form method="post" action="{$smarty.server.PHP_SELF}">
            <input type="hidden" name="step" value="2">
            <input type="hidden" name="type" value="{$type}">
            <input type="hidden" name="id" value="{$id}">
            <input type="hidden" name="pid" value="{$upgradepackage.pid}">
            <div class="form-group">
            {if $upgradepackage.pricing.type eq "free"}<!--3-->
              {$LANG.orderfree}
              <br>
              <input type="hidden" name="billingcycle" value="free">
            {elseif $upgradepackage.pricing.type eq "onetime"}<!--3 elseif-->
              {$upgradepackage.pricing.onetime} {$LANG.orderpaymenttermonetime}
              <input type="hidden" name="billingcycle" value="onetime">
            {elseif $upgradepackage.pricing.type eq "recurring"}<!--3 elseif-->
              <select name="billingcycle" class="form-control">

              {if $upgradepackage.pricing.monthly}<!--4-->
                <option value="monthly">{$upgradepackage.pricing.monthly}</option>
              {/if}<!--4 end-->

              {if $upgradepackage.pricing.quarterly}<!--4-->
                <option value="quarterly">{$upgradepackage.pricing.quarterly}</option>
              {/if}<!--4 end-->

              {if $upgradepackage.pricing.semiannually}<!--4-->
                <option value="semiannually">{$upgradepackage.pricing.semiannually}</option>
              {/if}<!--4 end-->

              {if $upgradepackage.pricing.annually}<!--4-->
                <option value="annually">{$upgradepackage.pricing.annually}</option>
              {/if}<!--4 end-->
                                        
              {if $upgradepackage.pricing.biennially}<!--4-->
                <option value="biennially">{$upgradepackage.pricing.biennially}</option>
              {/if}<!--4 end-->
                                        
              {if $upgradepackage.pricing.triennially}<!--4-->
                <option value="triennially">{$upgradepackage.pricing.triennially}</option>
              {/if}<!--4 end-->

              </select>
            {/if}<!--3 end-->
            </div>
            <input type="submit" value="{$LANG.upgradedowngradechooseproduct}" class="btn btn-primary btn-block">
          </form>
        </td>
      </tr>
    {/foreach}
    </table>
  {elseif $type eq "configoptions"}<!--2 elseif-->
    <p>{$LANG.upgradechooseconfigoptions}</p>
  {if $errormessage}<!--3-->
    {include file="$template/includes/alert.tpl" type="error" errorshtml=$errormessage}
  {/if}<!--3 end-->
 `  <form method="post" action="{$smarty.server.PHP_SELF}">
      <input type="hidden" name="step" value="2">
      <input type="hidden" name="type" value="{$type}">
      <input type="hidden" name="id" value="{$id}">
      <table class="table table-striped">
        <thead>
          <tr>
            <th></th>
            <th>{$LANG.upgradecurrentconfig}</th>
            <th></th>
            <th>{$LANG.upgradenewconfig}</th>
          </tr>
        </thead>
        <tbody>
        {foreach key=num item=configoption from=$configoptions}
          <tr>
            <td>{$configoption.optionname}</td>
            <td>
            {if $configoption.optiontype eq 1 || $configoption.optiontype eq 2}<!--3-->
              {$configoption.selectedname}
            {elseif $configoption.optiontype eq 3}<!--3 elseif-->
            {if $configoption.selectedqty}<!--4-->
              {$LANG.yes}
            {else}<!--4 else-->
              {$LANG.no}
            {/if}<!--4 end-->
            {elseif $configoption.optiontype eq 4}<!--2 elseif-->
              {$configoption.selectedqty} x {$configoption.options.0.name}
            {/if}<!--3 end-->
            </td>
            <td>=></td>
            <td>
            {if $configoption.optiontype eq 1 || $configoption.optiontype eq 2}<!--3-->
              <select name="configoption[{$configoption.id}]">
              {foreach key=num item=option from=$configoption.options}
              {if $option.selected}<!--4-->
                <option value="{$option.id}" selected>{$LANG.upgradenochange}</option>
              {else}<!--4 else-->
                <option value="{$option.id}">{$option.nameonly} {$option.price}
              {/if}<!--4 end-->
                </option>
              {/foreach}
              </select>
            {elseif $configoption.optiontype eq 3}<!--3 elseif-->
              <input type="checkbox" name="configoption[{$configoption.id}]" value="1"{if $configoption.selectedqty} checked{/if}> {$configoption.options.0.name}
            {elseif $configoption.optiontype eq 4}<!--3 elseif-->
              <input type="text" name="configoption[{$configoption.id}]" value="{$configoption.selectedqty}" size="5"> x {$configoption.options.0.name}
            {/if}<!--3 end-->
            </td>
          </tr>
        {/foreach}
        </tbody>
      </table>
      <p class="text-center"><input type="submit" value="{$LANG.ordercontinuebutton}" class="btn btn-primary"></p>
    </form>
  {/if}<!--2 end-->
{/if}<!--1 end-->
