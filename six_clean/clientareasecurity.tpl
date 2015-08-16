{if $twofaavailable}<!--1-->
{if $twofaactivation}<!--2-->
  <div id="twofaactivation">{$twofaactivation}</div>
{else}<!--2 else-->
  <h2>{$LANG.twofactorauth}</h2>
  {include file="$template/includes/alert.tpl" type="warning" msg="{lang key="clientAreaSecurityTwoFactorAuthRecommendation"}"}
  <p>{$LANG.twofaactivationintro}</p>

  <br>

  <form method="post" action="clientarea.php?action=security">
    <input type="hidden" name="2fasetup" value="1">
    <p align="center">
    {if $twofastatus}<!--3-->
      <input type="submit" value="{$LANG.twofadisableclickhere}" class="btn btn-danger">
    {else}<!--3 else-->
      <input type="submit" value="{$LANG.twofaenableclickhere}" class="btn btn-success">
    {/if}<!--3 end-->
    </p>
  </form>

  <br>
  <br>

{/if}<!--2 end-->
{/if}<!--1 end-->

{if $securityquestionsenabled && !$twofaactivation}<!--1-->
  <h2>{$LANG.clientareanavsecurityquestions}</h2>

{if $successful}<!--2-->
  {include file="$template/includes/alert.tpl" type="success" msg=$LANG.changessavedsuccessfully textcenter=true}
{elseif $errormessage}<!--2 elseif-->
  {include file="$template/includes/alert.tpl" type="error" errorshtml=$errormessage}
{elseif $nocurrent}<!--2 elseif-->
  {include file="$template/includes/alert.tpl" type="info" msg="{lang key="clientAreaSecurityNoSecurityQuestions"}"}
{else}<!--2 else-->
  {include file="$template/includes/alert.tpl" type="info" msg="{lang key="clientAreaSecuritySecurityQuestionOtherError"}"}
{/if}<!--2 end-->

  <form role="form" method="post" action="{$smarty.server.PHP_SELF}?action=security">
  {if !$nocurrent}<!--2-->
    <div class="form-group">
      <label for="inputCurrentAns" class="control-label">{$currentquestion}</label>
      <input type="password" name="currentsecurityqans" id="inputCurrentAns" class="form-control">
    </div>
  {/if}<!--2 end-->

    <div class="form-group">
      <label for="inputSecurityQid" class="control-label">{$LANG.clientareasecurityquestion}</label>
      <select name="securityqid" id="inputSecurityQid" class="form-control">
      {foreach key=num item=question from=$securityquestions}
        <option value={$question.id}>{$question.question}</option>
      {/foreach}
      </select>
    </div>

    <div class="row">

      <div class="col-md-6">
        <div class="form-group">
          <label for="inputSecurityAns1" class="control-label">{$LANG.clientareasecurityanswer}</label>
          <input type="password" name="securityqans" id="inputSecurityAns1" class="form-control">
        </div>
      </div>

      <div class="col-md-6">
        <div class="form-group">
          <label for="inputSecurityAns2" class="control-label">{$LANG.clientareasecurityconfanswer}</label>
          <input type="password" name="securityqans2" id="inputSecurityAns2" class="form-control">
        </div>
      </div>

    </div>

    <p class="text-center">
      <input class="btn btn-primary" type="submit" name="submit" value="{$LANG.clientareasavechanges}">
      <input class="btn btn-default" type="reset" value="{$LANG.cancel}">
    </p>

  </form>
{/if}<!--1 end-->
