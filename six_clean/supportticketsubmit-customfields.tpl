{foreach from=$customfields item=customfield}
  <div class="form-group">
    <label for="customfield{$customfield.id}">{$customfield.name}</label>
    {$customfield.input}
  {if $customfield.description}<!--1-->
    <p class="help-block">{$customfield.description}</p>
  {/if}<!--1 end-->
  </div>
{/foreach}
