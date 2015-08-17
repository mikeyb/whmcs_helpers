  <div class="logincontainer">
    {include file="$template/includes/pageheader.tpl" title=$LANG.pwreset}
  {if $success}<!--1-->
    {include file="$template/includes/alert.tpl" type="success" msg=$LANG.pwresetvalidationsent textcenter=true}
    <p>{$LANG.pwresetvalidationcheckemail}</p>
  {else}<!--1 end-->

  {if $errormessage}<!--2-->
    {include file="$template/includes/alert.tpl" type="error" msg=$errormessage textcenter=true}
  {/if}<!--2 end-->

  {if $securityquestion}<!--2-->
    <p>{$LANG.pwresetsecurityquestionrequired}</p>
    <form method="post" action="pwreset.php"  class="form-stacked">
      <input type="hidden" name="action" value="reset">
      <input type="hidden" name="email" value="{$email}">
      <div class="form-group">
        <label for="inputAnswer">{$securityquestion}</label>
        <input type="text" name="answer" class="form-control" id="inputAnswer" autofocus>
      </div>
      <div class="form-group text-center">
        <button type="submit" class="btn btn-primary">{$LANG.pwresetsubmit}</button>
      </div>
    </form>
  {else}<!--2 else-->
    <p>{$LANG.pwresetemailneeded}</p>
    <form method="post" action="{$systemsslurl}pwreset.php" role="form">
      <input type="hidden" name="action" value="reset">
      <div class="form-group">
        <label for="inputEmail">{$LANG.loginemail}</label>
        <input type="email" name="email" class="form-control" id="inputEmail" placeholder="{$LANG.enteremail}" autofocus>
      </div>
      <div class="form-group text-center"><button type="submit" class="btn btn-primary">{$LANG.pwresetsubmit}</button></div>
    </form>
  {/if}<!--2 end-->
  {/if}<!--1 end-->
  </div>
