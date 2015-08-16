  <h3>{$LANG.domaingeteppcode}</h3>

  <p>{$LANG.domaingeteppcodeexplanation}</p>

  <br>

{if $error}<!--1-->
  {include file="$template/includes/alert.tpl" type="error" msg=$LANG.domaingeteppcodefailure|cat:" $error"}
{elseif $eppcode}<!--1 elseif-->
  {include file="$template/includes/alert.tpl" type="warning" msg=$LANG.domaingeteppcodeis|cat:" $eppcode"}
{else}<!--1 else-->
  {include file="$template/includes/alert.tpl" type="warning" msg=$LANG.domaingeteppcodeemailconfirmation}
{/if}<!--1 end-->
