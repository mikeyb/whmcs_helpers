{if $remoteupdatecode}<!--1-->
  <div align="center">{$remoteupdatecode}</div>
{else}<!--1 else-->
  <div class="credit-card">

    <div class="card-icon pull-right">
      <b class="fa fa-2x
      {if $cardtype eq "American Express"}<!--2-->
        fa-cc-amex logo-amex
      {elseif $cardtype eq "Visa"}<!--2 elseif-->
        fa-cc-visa logo-visa
      {elseif $cardtype eq "MasterCard"}<!--2 elseif-->
        fa-cc-mastercard logo-mastercard
      {elseif $cardtype eq "Discover"}<!--2 elseif-->
        fa-cc-discover logo-discover
      {else}<!--2 else-->
        fa-credit-card
      {/if}<!--2 end-->
      ">
        &nbsp;
      </b>
    </div>

    <div class="card-type">
    {if $cardtype neq "American Express" && $cardtype neq "Visa" && $cardtype neq "MasterCard" && $cardtype neq "Discover"}<!--2-->
      {$cardtype}
    {/if}<!--2 end-->
    </div>

    <div class="card-number">
    {if $cardlastfour}<!--2-->
      xxxx xxxx xxxx {$cardlastfour}
    {else}<!--2 else-->
      {$LANG.creditcardnonestored}
    {/if}<!--2 end-->
    </div>

    <div class="card-start">
    {if $cardstart}<!--2-->
      Start: {$cardstart}
    {/if}<!--2 end-->
    </div>

    <div class="card-expiry">
    {if $cardexp}<!--2-->
      Expires: {$cardexp}
    {/if}<!--2 end-->
    </div>

    <div class="end"></div>
  </div>

{if $allowcustomerdelete && $cardtype}<!--2-->
  <form method="post" action="clientarea.php?action=creditcard">
    <input type="hidden" name="remove" value="1">
    <p class="text-center">
      <button type="submit" class="btn btn-danger">{$LANG.creditcarddelete}</button>
    </p>
  </form>
{/if}<!--2 end-->

  <h3>{$LANG.creditcardenternewcard}</h3>

{if $successful}<!--2-->
  {include file="$template/includes/alert.tpl" type="success" msg=$LANG.changessavedsuccessfully textcenter=true}
{/if}<!--2 end-->

{if $errormessage}<!--2-->
  {include file="$template/includes/alert.tpl" type="error" errorshtml=$errormessage}
{/if}<!--2 end-->

  <form class="form-horizontal" role="form" method="post" action="{$smarty.server.PHP_SELF}?action=creditcard">
    <div class="form-group">
      <label for="inputCardType" class="col-sm-4 control-label">{$LANG.creditcardcardtype}</label>
      <div class="col-sm-4">

        <select name="cctype" id="inputCardType" class="form-control">
        {foreach from=$acceptedcctypes item=fieldcardtype}
          <option {if $fieldcardtype eq $cardtype}selected{/if}>{$fieldcardtype}</option>
        {/foreach}
        </select>

      </div>
    </div>

    <div class="form-group">
      <label for="inputCardNumber" class="col-sm-4 control-label">{$LANG.creditcardcardnumber}</label>
      <div class="col-sm-6">
        <input type="number" class="form-control" id="inputCardNumber" name="ccnumber" autocomplete="off">
      </div>
    </div>

  {if $showccissuestart}<!--2-->
    <div class="form-group">
      <label for="inputCardStart" class="col-sm-4 control-label">{$LANG.creditcardcardstart}</label>
      <div class="col-sm-6">

        <select name="ccstartmonth" id="inputCardStart" class="form-control select-inline">
        {foreach from=$months item=month}
          <option{if $ccstartmonth eq $month} selected{/if}>{$month}</option>
        {/foreach}
        </select>

        <select name="ccstartyear" class="form-control select-inline">
        {foreach from=$startyears item=year}
          <option{if $ccstartyear eq $year} selected{/if}>{$year}</option>
        {/foreach}
        </select>

      </div>
    </div>
  {/if}<!--2 end-->

    <div class="form-group">
      <label for="inputCardExpiry" class="col-sm-4 control-label">{$LANG.creditcardcardexpires}</label>
      <div class="col-sm-6">

        <select name="ccexpirymonth" id="inputCardExpiry" class="form-control select-inline">
        {foreach from=$months item=month}
          <option{if $ccstartmonth eq $month} selected{/if}>{$month}</option>
        {/foreach}
        </select>

        <select name="ccexpiryyear" class="form-control select-inline">
        {foreach from=$expiryyears item=year}
          <option{if $ccstartyear eq $year} selected{/if}>{$year}</option>
        {/foreach}
        </select>

      </div>
    </div>

  {if $showccissuestart}<!--2-->
    <div class="form-group">
      <label for="inputCardIssue" class="col-sm-4 col-xs-12 control-label">{$LANG.creditcardcardissuenum}</label>
      <div class="col-sm-2 col-xs-4">
        <input type="number" class="form-control" id="inputCardIssue" name="ccissuenum" autocomplete="off">
      </div>
    </div>
  {/if}<!--2 end-->

    <div class="form-group">
      <label for="inputCardCVV" class="col-sm-4 col-xs-12 control-label">{$LANG.creditcardcvvnumber}</label>
      <div class="col-sm-7">
        <input type="number" class="form-control input-inline input-inline-100" id="inputCardCVV" name="cardcvv" autocomplete="off">
        <button type="button" class="btn btn-link" data-toggle="popover" data-content="<img src='{$BASE_PATH_IMG}/ccv.gif' width='210'>">
          {$LANG.creditcardcvvwhere}
        </button>
      </div>
    </div>

    <div class="form-group">
      <div class="text-center">
        <input class="btn btn-primary" type="submit" name="submit" value="{$LANG.clientareasavechanges}">
        <input class="btn btn-default" type="reset" value="{$LANG.cancel}">
      </div>
    </div>

  </form>
{/if}<!--1 end-->
